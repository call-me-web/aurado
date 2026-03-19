-- ============================================================
-- AURADO — Edge-Driven Learning Engine (Supabase Schema)
-- Description: This script sets up the storage for summarized data only.
-- Calculations are performed Natively on the Student's Device.
-- ============================================================

-- 1. ENUMS (Used for Type Safety)
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'bookmark_type') THEN
        CREATE TYPE public.bookmark_type AS ENUM ('lesson', 'pdf', 'mcq', 'cq', 'exam');
    END IF;
END $$;

-- 2. CORE STUDENT TABLE (Clean Identity)
CREATE TABLE IF NOT EXISTS public.students (
  id UUID PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  education_level TEXT,
  language_preference TEXT DEFAULT 'bn',
  country TEXT DEFAULT 'Bangladesh',
  streak_count INTEGER DEFAULT 0,
  last_active_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. SUMMARIZED LESSON MASTERY (No Raw Logs)
-- App calls public.sync_lesson_mastery() to update this
CREATE TABLE IF NOT EXISTS public.lesson_mastery (
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  lesson_id UUID REFERENCES public.lessons(id) ON DELETE CASCADE,
  tenant_id UUID REFERENCES public.tenants(id) ON DELETE CASCADE,
  
  watch_percentage INTEGER DEFAULT 0,      -- 0-100
  last_position_sec INTEGER DEFAULT 0,     -- resume point
  struggle_score NUMERIC DEFAULT 0,        -- Calculated Natively
  mastery_score NUMERIC DEFAULT 0,         -- Calculated Natively
  
  is_completed BOOLEAN DEFAULT FALSE,
  completed_at TIMESTAMPTZ,
  last_accessed_at TIMESTAMPTZ DEFAULT NOW(),
  
  PRIMARY KEY (student_id, lesson_id)
);

-- 4. SUMMARIZED WEAK POINTS
CREATE TABLE IF NOT EXISTS public.student_weak_points (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  tenant_id UUID REFERENCES public.tenants(id) ON DELETE CASCADE,
  subject_tag TEXT NOT NULL,
  weak_score NUMERIC DEFAULT 0,            -- Calculated Natively
  last_wrong_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, subject_tag, tenant_id)
);

-- 5. SPACED REPETITION QUEUE
CREATE TABLE IF NOT EXISTS public.student_review_queue (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  content_type public.bookmark_type NOT NULL,
  content_id UUID NOT NULL,
  next_review_at TIMESTAMPTZ NOT NULL,
  interval_days INTEGER DEFAULT 1,
  ease_factor NUMERIC DEFAULT 2.5,
  review_count INTEGER DEFAULT 0,
  UNIQUE(student_id, content_type, content_id)
);

-- 6. DAILY ACTIVITY STREAKS
CREATE TABLE IF NOT EXISTS public.student_streaks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  streak_date DATE NOT NULL,
  lessons_watched INTEGER DEFAULT 0,
  minutes_studied INTEGER DEFAULT 0,
  UNIQUE(student_id, streak_date)
);

-- 7. YEARLY SUMMARIES (Long-term Archival)
CREATE TABLE IF NOT EXISTS public.student_yearly_summaries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  academic_year INTEGER NOT NULL,
  total_minutes_studied INTEGER DEFAULT 0,
  total_lessons_watched INTEGER DEFAULT 0,
  avg_accuracy NUMERIC DEFAULT 0,
  top_subjects TEXT[],
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, academic_year)
);

-- 8. SYNC FUNCTION (Minimal RTT, High Speed)
CREATE OR REPLACE FUNCTION public.sync_lesson_mastery(
  p_student_id     UUID,
  p_lesson_id      UUID,
  p_tenant_id      UUID,
  p_watch_pct      INTEGER,
  p_struggle_score NUMERIC,
  p_mastery_score  NUMERIC,
  p_session_time   INTEGER DEFAULT 0
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO public.lesson_mastery (
    student_id, lesson_id, tenant_id,
    watch_percentage, struggle_score, mastery_score,
    last_accessed_at, is_completed
  ) VALUES (
    p_student_id, p_lesson_id, p_tenant_id,
    p_watch_pct, p_struggle_score, p_mastery_score,
    NOW(), (p_watch_pct >= 90)
  )
  ON CONFLICT (student_id, lesson_id) DO UPDATE SET
    watch_percentage = GREATEST(lesson_mastery.watch_percentage, p_watch_pct),
    struggle_score   = p_struggle_score,
    mastery_score    = p_mastery_score,
    last_accessed_at = NOW(),
    is_completed     = (lesson_mastery.is_completed OR (p_watch_pct >= 90));
END;
$$;

-- 9. INDEXES
CREATE INDEX IF NOT EXISTS idx_lesson_mastery_student ON public.lesson_mastery(student_id);
CREATE INDEX IF NOT EXISTS idx_review_queue_due ON public.student_review_queue(student_id, next_review_at);
CREATE INDEX IF NOT EXISTS idx_streaks_student ON public.student_streaks(student_id, streak_date DESC);



-- ১. 'backups' নামে একটি প্রাইভেট বাকেট তৈরি করা
insert into storage.buckets (id, name, public)
values ('backups', 'backups', false)
on conflict (id) do nothing;

-- ২. ইউজারের নিজের ব্যাকআপ ফাইল আপলোডের অনুমতি (Insert/Update)
create policy "Users can upload their own backup"
on storage.objects for insert
with check (
  bucket_id = 'backups' AND
  (storage.foldername(name))[1] = auth.uid()::text
);

-- ৩. ইউজারের নিজের ব্যাকআপ ফাইল পড়ার অনুমতি (Select)
create policy "Users can view their own backup"
on storage.objects for select
using (
  bucket_id = 'backups' AND
  (storage.foldername(name))[1] = auth.uid()::text
);

-- ৪. পুরনো ব্যাকআপ ফাইল ডিলিট বা ওভাররাইট করার অনুমতি (Delete)
create policy "Users can update/delete their own backup"
on storage.objects for delete
using (
  bucket_id = 'backups' AND
  (storage.foldername(name))[1] = auth.uid()::text
);






-- 1. Proctoring Logs (Anti-Cheating)
-- Ties into your existing `exam_attempts` table safely
CREATE TABLE public.proctoring_logs (
  id uuid not null default extensions.uuid_generate_v4 (),
  attempt_id uuid not null,
  event_type text not null,
  metadata text null,
  timestamp timestamp with time zone null default now(),
  created_at timestamp with time zone null default now(),
  constraint proctoring_logs_pkey primary key (id),
  constraint proctoring_logs_attempt_id_fkey foreign KEY (attempt_id) references exam_attempts (id) on delete CASCADE
) TABLESPACE pg_default;

create index IF not exists idx_proctoring_logs_attempt_id on public.proctoring_logs using btree (attempt_id) TABLESPACE pg_default;


-- 2. Add Unique Constraint to your existing question_responses table
-- This is necessary for the upsert logic to work cleanly without creating duplicate rows
ALTER TABLE public.question_responses 
  ADD CONSTRAINT unique_attempt_question UNIQUE (attempt_id, question_id);


-- 3. The FUTURE-PROOF RPC Function (Idempotent approach)
-- Safe for mobile devices on flaky networks.
CREATE OR REPLACE FUNCTION upsert_exam_engagement(
    p_attempt_id UUID,
    p_question_id UUID,
    p_total_time_spent_ms INT
) RETURNS void AS $$
BEGIN
    INSERT INTO public.question_responses (attempt_id, question_id, time_spent_ms)
    VALUES (p_attempt_id, p_question_id, p_total_time_spent_ms)
    ON CONFLICT (attempt_id, question_id) 
    DO UPDATE SET 
      -- Only update if the incoming total time is greater than what already exists in the DB
      time_spent_ms = GREATEST(public.question_responses.time_spent_ms, p_total_time_spent_ms),
      updated_at = now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
