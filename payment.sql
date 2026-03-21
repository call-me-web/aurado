-- ==========================================
-- AURADO MATURE PAYMENT & LEDGER SYSTEM
-- ==========================================
-- This schema implements a double-entry ledger, VAT readiness, 
-- and automated course enrollment. 

-- 0. CLEAN UP (Optional: Run this to delete old schema if replacing)
-- WARNING: This will delete existing transaction/ledger data.
DROP VIEW IF EXISTS tenant_balance_summary CASCADE;
DROP TABLE IF EXISTS ledger CASCADE;
DROP TABLE IF EXISTS payout_requests CASCADE;
DROP TABLE IF EXISTS student_course_access CASCADE;
DROP TABLE IF EXISTS tenant_subscriptions CASCADE;
DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS agent_bank_details CASCADE;

-- 1. ENUMS
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'transaction_status') THEN
        CREATE TYPE transaction_status AS ENUM ('pending', 'completed', 'failed', 'refunded', 'needs_review');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'currency') THEN
        CREATE TYPE currency AS ENUM ('BDT', 'USD', 'PKR', 'NPR', 'INR', 'EUR', 'GBP');
    END IF;
END $$;

-- 2. CORE TABLES

-- Transactions Table (The Entry Point)
CREATE TABLE IF NOT EXISTS transactions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id),
  tenant_id UUID REFERENCES tenants(id),
  amount DECIMAL(15,2) NOT NULL,
  currency currency DEFAULT 'BDT',
  vat_amount DECIMAL(15,2) DEFAULT 0.00,
  platform_fee DECIMAL(15,2) DEFAULT 0.00,
  net_amount DECIMAL(15,2) GENERATED ALWAYS AS (amount - vat_amount) STORED,
  provider TEXT NOT NULL, -- 'bkash', 'sslcommerz', 'jazzcash', etc.
  provider_tx_id TEXT UNIQUE,
  idempotency_key TEXT UNIQUE,
  type TEXT NOT NULL, -- 'subscription', 'course_purchase', 'payout'
  status transaction_status DEFAULT 'pending',
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Ledger Table (The Source of Truth - Audit Proof)
CREATE TABLE IF NOT EXISTS ledger (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  transaction_id UUID REFERENCES transactions(id) ON DELETE CASCADE,
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
  amount DECIMAL(15,2) NOT NULL,
  currency currency DEFAULT 'BDT', -- Tracking currency in ledger is critical
  type TEXT NOT NULL, -- 'credit' (money in), 'debit' (money out)
  purpose TEXT NOT NULL, -- 'course_sale', 'subscription_fee', 'payout', 'refund'
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tenant Subscriptions
CREATE TABLE IF NOT EXISTS tenant_subscriptions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE NOT NULL UNIQUE,
  plan_type TEXT DEFAULT 'free', -- 'free', 'basic', 'pro'
  status TEXT DEFAULT 'active',
  last_billing_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  next_billing_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Student Course Access
CREATE TABLE IF NOT EXISTS student_course_access (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE NOT NULL,
  transaction_id UUID REFERENCES transactions(id),
  access_granted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  expires_at TIMESTAMP WITH TIME ZONE,
  is_active BOOLEAN DEFAULT TRUE,
  UNIQUE(user_id, course_id)
);

-- Bank & Payouts
CREATE TABLE IF NOT EXISTS agent_bank_details (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE NOT NULL UNIQUE,
  account_name TEXT NOT NULL,
  bank_name TEXT, 
  account_number TEXT NOT NULL,
  routing_number TEXT,
  branch_name TEXT,
  mobile_banking_type TEXT, 
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS payout_requests (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE NOT NULL,
  amount DECIMAL(15,2) NOT NULL,
  status TEXT DEFAULT 'pending', -- 'pending', 'processing', 'completed', 'rejected'
  admin_notes TEXT,
  transaction_id UUID REFERENCES transactions(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. AUTOMATION LOGIC (Functions & Triggers)

-- Function: Process Success Payment (The Heart of the System)
CREATE OR REPLACE FUNCTION process_payment_logic()
RETURNS TRIGGER AS $$
BEGIN
  -- Only trigger when a transaction moves to 'completed'
  IF (OLD.status IS DISTINCT FROM NEW.status AND NEW.status = 'completed') THEN
    
    -- A. Handle Course Purchase
    IF NEW.type = 'course_purchase' THEN
      -- 1. Grant Access
      INSERT INTO student_course_access (user_id, course_id, transaction_id)
      VALUES (NEW.user_id, (NEW.metadata->>'course_id')::UUID, NEW.id)
      ON CONFLICT (user_id, course_id) DO UPDATE SET is_active = TRUE;

      -- 2. Record in Ledger (Credit to Tenant)
      -- Note: Here we subtract platform fee if applicable
      INSERT INTO ledger (transaction_id, tenant_id, amount, currency, type, purpose)
      VALUES (NEW.id, NEW.tenant_id, (NEW.amount - NEW.platform_fee), NEW.currency, 'credit', 'course_sale');
    
    -- B. Handle Subscription
    ELSIF NEW.type = 'subscription' THEN
      INSERT INTO tenant_subscriptions (tenant_id, plan_type, status, last_billing_at, next_billing_at)
      VALUES (NEW.tenant_id, COALESCE(NEW.metadata->>'plan_type', 'pro'), 'active', NOW(), NOW() + interval '30 days')
      ON CONFLICT (tenant_id) DO UPDATE SET 
        plan_type = EXCLUDED.plan_type,
        status = 'active',
        last_billing_at = NOW(),
        next_billing_at = NOW() + interval '30 days';
    
    -- C. Handle Payout
    ELSIF NEW.type = 'payout' THEN
      -- Record in Ledger (Debit from Tenant)
      INSERT INTO ledger (transaction_id, tenant_id, amount, currency, type, purpose)
      VALUES (NEW.id, NEW.tenant_id, NEW.amount, NEW.currency, 'debit', 'payout');
    END IF;

  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger: Execute Logic on Transaction Update
DROP TRIGGER IF EXISTS trg_process_payment ON transactions;
CREATE TRIGGER trg_process_payment
  AFTER UPDATE ON transactions
  FOR EACH ROW EXECUTE PROCEDURE process_payment_logic();

-- RPC: Enroll in Free Course ($0 Access)
CREATE OR REPLACE FUNCTION enroll_in_free_course(p_course_id UUID, p_user_id UUID DEFAULT NULL)
RETURNS VOID AS $$
DECLARE
  v_user_id UUID := COALESCE(p_user_id, auth.uid());
  v_price DECIMAL;
BEGIN
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Not authenticated'; END IF;
  
  SELECT price INTO v_price FROM courses WHERE id = p_course_id;
  IF v_price > 0 THEN RAISE EXCEPTION 'Course is not free'; END IF;

  INSERT INTO student_course_access (user_id, course_id)
  VALUES (v_user_id, p_course_id)
  ON CONFLICT DO NOTHING;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. VIEWS
CREATE OR REPLACE VIEW tenant_balance_summary AS
SELECT 
  tenant_id,
  currency, -- Keep balances grouped by currency
  SUM(CASE WHEN type = 'credit' THEN amount ELSE 0 END) as total_earnings,
  SUM(CASE WHEN type = 'debit' THEN amount ELSE 0 END) as total_withdrawn,
  (SUM(CASE WHEN type = 'credit' THEN amount ELSE 0 END) - 
   SUM(CASE WHEN type = 'debit' THEN amount ELSE 0 END)) as available_balance
FROM ledger
GROUP BY tenant_id, currency;

-- 5. SECURITY (RLS Policies)
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE ledger ENABLE ROW LEVEL SECURITY;
ALTER TABLE tenant_subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE student_course_access ENABLE ROW LEVEL SECURITY;
ALTER TABLE agent_bank_details ENABLE ROW LEVEL SECURITY;
ALTER TABLE payout_requests ENABLE ROW LEVEL SECURITY;

-- Transaction/Ledger: Own records only
CREATE POLICY "Users view own transactions" ON transactions FOR SELECT USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM tenants WHERE id = transactions.tenant_id AND owner_id = auth.uid()));
CREATE POLICY "Users view own ledger" ON ledger FOR SELECT USING (EXISTS (SELECT 1 FROM tenants WHERE id = ledger.tenant_id AND owner_id = auth.uid()));

-- Bank/Payout: Owner only
CREATE POLICY "Owner manages bank details" ON agent_bank_details FOR ALL USING (EXISTS (SELECT 1 FROM tenants WHERE id = agent_bank_details.tenant_id AND owner_id = auth.uid()));
CREATE POLICY "Owner manages payout requests" ON payout_requests FOR ALL USING (EXISTS (SELECT 1 FROM tenants WHERE id = payout_requests.tenant_id AND owner_id = auth.uid()));

-- Student Access: Own access
CREATE POLICY "Students view own access" ON student_course_access FOR SELECT USING (auth.uid() = user_id);




-- 1. Create the course access table (if not already exists)
CREATE TABLE IF NOT EXISTS student_course_access (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE NOT NULL,
  transaction_id UUID, -- Optional, for paid courses
  access_granted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  expires_at TIMESTAMP WITH TIME ZONE, -- NULL means permanent members
  is_active BOOLEAN DEFAULT TRUE,
  UNIQUE(user_id, course_id)
);

-- 2. Add an index for fast lookups on the "My Courses" page
CREATE INDEX IF NOT EXISTS idx_course_access_user ON student_course_access(user_id);

-- 3. Update the enrollment function
CREATE OR REPLACE FUNCTION enroll_in_free_course(p_course_id UUID, p_user_id UUID DEFAULT NULL)
RETURNS VOID AS $$
DECLARE
  v_user_id UUID := COALESCE(p_user_id, auth.uid());
BEGIN
  -- Basic validation
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Not authenticated'; END IF;
  
  -- Verify course is free ($0)
  IF NOT EXISTS (SELECT 1 FROM courses WHERE id = p_course_id AND price <= 0) THEN
    RAISE EXCEPTION 'Course is not free';
  END IF;

  -- Grant permanent access (expires_at is NULL by default)
  INSERT INTO student_course_access (user_id, course_id)
  VALUES (v_user_id, p_course_id)
  ON CONFLICT (user_id, course_id) DO UPDATE SET is_active = TRUE;
  
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
