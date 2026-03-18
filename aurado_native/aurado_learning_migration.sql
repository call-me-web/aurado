-- ============================================================
-- AURADO — Learning Intelligence System Migration
-- File: aurado_learning_migration.sql
-- 
-- RUN ORDER:
--   Step 1 → Existing schema already deployed (database_v2.sql +
--             payment_payout_migration.sql + youtube_integrations.sql)
--   Step 2 → Run THIS file once in Supabase SQL Editor
--
-- SAFE TO RUN: Uses IF NOT EXISTS everywhere.
--              Will NOT break existing tables or data.
-- ============================================================


-- ============================================================
-- BLOCK 1: NEW ENUM TYPES
-- (existing enums already in database_v2.sql — এগুলো নতুন)
-- ============================================================

DO $$
BEGIN
  -- Learning event types
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'learning_event_type') THEN
    CREATE TYPE public.learning_event_type AS ENUM (
      'video_play',
      'video_pause',
      'video_seek',
      'video_speed_change',
      'video_replay_segment',
      'video_completed',
      'pdf_open',
      'pdf_page_view',
      'pdf_completed',
      'note_taken',
      'bookmark_added',
      'question_asked',
      'video_rewatched',
      'lesson_abandoned',
      'exam_time_exceeded',
      'hint_requested'
    );
  END IF;

  -- Bookmark / content types
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'bookmark_type') THEN
    CREATE TYPE public.bookmark_type AS ENUM (
      'lesson',
      'pdf',
      'mcq',
      'cq',
      'exam'
    );
  END IF;

END $$;


-- ============================================================
-- BLOCK 2: ALTER EXISTING TABLES
-- (নতুন columns যোগ হবে — existing data নষ্ট হবে না)
-- ============================================================

-- lessons table-এ নতুন fields
ALTER TABLE public.lessons
  ADD COLUMN IF NOT EXISTS lesson_type       TEXT DEFAULT 'video',
  -- 'video' | 'live' | 'pdf' | 'text'
  ADD COLUMN IF NOT EXISTS duration_sec      INTEGER,
  ADD COLUMN IF NOT EXISTS is_free           BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS status            TEXT DEFAULT 'draft',
  -- 'draft' | 'published'
  ADD COLUMN IF NOT EXISTS is_recorded_live  BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS live_scheduled_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS live_ended_at     TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS updated_at        TIMESTAMPTZ DEFAULT NOW();

-- courses table-এ sharing link
ALTER TABLE public.courses
  ADD COLUMN IF NOT EXISTS sharing_link TEXT;

-- profiles table-এ student preference fields
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS education_level      TEXT,
  -- 'SSC' | 'HSC' | 'Admission' | 'Degree' | 'Skills'
  ADD COLUMN IF NOT EXISTS language_preference  TEXT DEFAULT 'bn',
  -- 'bn' | 'en'
  ADD COLUMN IF NOT EXISTS country              TEXT DEFAULT 'Bangladesh',
  ADD COLUMN IF NOT EXISTS streak_count         INTEGER DEFAULT 0;

-- branding table-এ full color system
ALTER TABLE public.branding
  ADD COLUMN IF NOT EXISTS primary_color    TEXT DEFAULT '#2C3E50',
  ADD COLUMN IF NOT EXISTS secondary_color  TEXT DEFAULT '#5B9EA0';

-- tenant_subscriptions-এ storage provider
-- (payment_payout_migration.sql এ আছে, শুধু নতুন columns)
ALTER TABLE public.tenant_subscriptions
  ADD COLUMN IF NOT EXISTS storage_provider TEXT DEFAULT 'bunny',
  -- 'youtube' | 'bunny' | 'r2'
  ADD COLUMN IF NOT EXISTS max_courses      INTEGER DEFAULT 10,
  ADD COLUMN IF NOT EXISTS max_students     INTEGER DEFAULT 500;


-- ============================================================
-- BLOCK 3: NEW CORE TABLES
-- (dependency order মেনে — references আগে, dependent পরে)
-- ============================================================

-- 3a. Storage Configs (depends on: tenants)
CREATE TABLE IF NOT EXISTS public.storage_configs (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id    UUID REFERENCES public.tenants(id) ON DELETE CASCADE UNIQUE,
  provider     TEXT NOT NULL DEFAULT 'bunny',
  -- 'youtube' | 'bunny' | 'r2'

  -- Bunny Stream
  bunny_api_key         TEXT,
  bunny_library_id      TEXT,
  bunny_cdn_hostname    TEXT,

  -- Cloudflare R2
  r2_account_id    TEXT,
  r2_access_key    TEXT,
  r2_secret_key    TEXT,
  r2_bucket_name   TEXT,
  r2_public_url    TEXT,

  -- YouTube (OAuth)
  yt_refresh_token  TEXT,
  yt_access_token   TEXT,
  yt_token_expiry   BIGINT,
  yt_channel_id     TEXT,

  created_at   TIMESTAMPTZ DEFAULT NOW(),
  updated_at   TIMESTAMPTZ DEFAULT NOW()
);

-- 3b. Offline Downloads (depends on: profiles, lessons, tenants)
CREATE TABLE IF NOT EXISTS public.offline_downloads (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id      UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  lesson_id       UUID REFERENCES public.lessons(id) ON DELETE CASCADE,
  tenant_id       UUID REFERENCES public.tenants(id) ON DELETE CASCADE,

  device_file_key TEXT NOT NULL,
  -- App-এর local encrypted file-এর identifier

  play_token      TEXT,
  -- HMAC-SHA256 signed token (Edge Function থেকে আসবে)
  -- NULL মানে revoked

  expires_at      TIMESTAMPTZ NOT NULL,
  day_counter     INTEGER DEFAULT 0,
  -- প্রতিদিন app open-এ increment হবে। >7 হলে expired।

  status          TEXT DEFAULT 'active',
  -- 'active' | 'expired' | 'revoked'

  created_at      TIMESTAMPTZ DEFAULT NOW(),

  UNIQUE(student_id, lesson_id, device_file_key)
);

-- 3c. Live Stream Sessions — updated version
-- (youtube_integrations.sql এ basic version আছে, এটা replace করে)
-- Note: DROP করছি না। নতুন columns add করছি।
ALTER TABLE public.live_stream_sessions
  ADD COLUMN IF NOT EXISTS livekit_room_name  TEXT,
  ADD COLUMN IF NOT EXISTS recording_url      TEXT,
  ADD COLUMN IF NOT EXISTS provider           TEXT DEFAULT 'youtube';
  -- 'youtube' | 'livekit'


-- ============================================================
-- BLOCK 4: LEARNING INTELLIGENCE TABLES
-- (সব নতুন — dependency order)
-- ============================================================

-- 4a. Raw Event Log (depends on: profiles, lessons, tenants)
CREATE TABLE IF NOT EXISTS public.learning_events (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id   UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  lesson_id    UUID REFERENCES public.lessons(id) ON DELETE CASCADE,
  tenant_id    UUID REFERENCES public.tenants(id) ON DELETE CASCADE,
  event_type   public.learning_event_type NOT NULL,

  position_sec  INTEGER,
  -- video-র কোন second-এ ঘটেছে
  duration_sec  INTEGER,
  -- কতক্ষণ ছিল এই state-এ
  metadata      JSONB DEFAULT '{}',
  -- {"speed": 1.5, "from_sec": 45, "to_sec": 30}

  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- 4b. Lesson Mastery (depends on: profiles, lessons, tenants)
CREATE TABLE IF NOT EXISTS public.lesson_mastery (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id   UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  lesson_id    UUID REFERENCES public.lessons(id) ON DELETE CASCADE,
  tenant_id    UUID REFERENCES public.tenants(id) ON DELETE CASCADE,

  -- Progress
  watch_percentage       INTEGER DEFAULT 0,
  last_position_sec      INTEGER DEFAULT 0,
  total_watch_time_sec   INTEGER DEFAULT 0,
  watch_count            INTEGER DEFAULT 0,

  -- Struggle signals
  rewatch_segments  JSONB DEFAULT '[]',
  -- [{"from": 45, "to": 80, "count": 3}, ...]

  struggle_score  NUMERIC DEFAULT 0,
  -- 0 = no struggle → 1 = maximum struggle

  mastery_score   NUMERIC DEFAULT 0,
  -- 0 = not started → 1 = fully mastered

  mastery_level TEXT GENERATED ALWAYS AS (
    CASE
      WHEN mastery_score >= 0.85 THEN 'Mastered'
      WHEN mastery_score >= 0.60 THEN 'Proficient'
      WHEN mastery_score >= 0.35 THEN 'Developing'
      WHEN mastery_score >  0   THEN 'Struggling'
      ELSE 'Not Started'
    END
  ) STORED,

  is_completed   BOOLEAN DEFAULT FALSE,
  completed_at   TIMESTAMPTZ,
  last_accessed_at TIMESTAMPTZ DEFAULT NOW(),

  UNIQUE(student_id, lesson_id)
);

-- 4c. Topic Mastery — subject + chapter + lesson level
-- (depends on: profiles, tenants)
CREATE TABLE IF NOT EXISTS public.topic_mastery (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id   UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  tenant_id    UUID REFERENCES public.tenants(id) ON DELETE CASCADE,

  topic_type   TEXT NOT NULL,
  -- 'subject' | 'chapter' | 'lesson' | 'concept'
  topic_id     UUID NOT NULL,
  -- subject_id / chapter_id / lesson_id
  topic_tag    TEXT NOT NULL,
  -- "Newton's Laws", "Quadratic Equations"

  -- Raw counts
  total_attempts    INTEGER DEFAULT 0,
  correct_attempts  INTEGER DEFAULT 0,
  avg_time_per_question_sec NUMERIC,

  -- Auto-calculated accuracy
  accuracy_score NUMERIC GENERATED ALWAYS AS (
    correct_attempts::NUMERIC / NULLIF(total_attempts, 0)
  ) STORED,

  speed_score    NUMERIC DEFAULT 0,
  -- দ্রুত সঠিক উত্তর = বেশি mastery
  -- App থেকে calculate করে পাঠাবে

  mastery_score  NUMERIC DEFAULT 0,
  -- accuracy * 0.7 + speed_score * 0.3
  -- update_topic_mastery() function update করবে

  weakness_level TEXT GENERATED ALWAYS AS (
    CASE
      WHEN mastery_score >= 0.80 THEN 'Strong'
      WHEN mastery_score >= 0.60 THEN 'Average'
      WHEN mastery_score >= 0.40 THEN 'Weak'
      ELSE 'Critical'
    END
  ) STORED,

  -- Trend tracking
  previous_mastery_score NUMERIC,
  trend TEXT GENERATED ALWAYS AS (
    CASE
      WHEN mastery_score > COALESCE(previous_mastery_score, 0) + 0.05
        THEN 'Improving'
      WHEN mastery_score < COALESCE(previous_mastery_score, 0) - 0.05
        THEN 'Declining'
      ELSE 'Stable'
    END
  ) STORED,

  last_attempted_at TIMESTAMPTZ,
  UNIQUE(student_id, topic_type, topic_id)
);

-- 4d. Daily Learning Summary (depends on: profiles)
CREATE TABLE IF NOT EXISTS public.daily_learning_summary (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id   UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  summary_date DATE NOT NULL,

  -- Quantity
  lessons_watched     INTEGER DEFAULT 0,
  lessons_completed   INTEGER DEFAULT 0,
  questions_attempted INTEGER DEFAULT 0,
  minutes_studied     INTEGER DEFAULT 0,

  -- Quality
  accuracy_today         NUMERIC DEFAULT 0,
  new_topics_explored    INTEGER DEFAULT 0,
  reviews_completed      INTEGER DEFAULT 0,
  mastery_improvements   INTEGER DEFAULT 0,
  -- কতটা topic-এ mastery score বেড়েছে

  quality_score NUMERIC DEFAULT 0,
  -- 0-100। এই দিনটা কতটা productive ছিল।
  -- Formula: completion*40 + accuracy*30 + review*20 + new_topic*10

  streak_maintained BOOLEAN DEFAULT FALSE,
  -- quality_score >= 30 হলেই streak count হবে

  UNIQUE(student_id, summary_date)
);

-- 4e. Yearly Student Summaries (Archival Layer)
CREATE TABLE IF NOT EXISTS public.student_yearly_summaries (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id   UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  academic_year INTEGER NOT NULL, -- e.g. 2026
  
  -- Aggregated KPIs
  total_minutes_studied  INTEGER DEFAULT 0,
  total_lessons_watched  INTEGER DEFAULT 0,
  avg_accuracy           NUMERIC DEFAULT 0,
  top_subjects          TEXT[], -- ["Physics", "History"]
  
  archive_metadata      JSONB, -- Metadata about the sync/purge
  created_at            TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, academic_year)
);

-- 4e. Smart Review Queue (depends on: profiles, exams)
CREATE TABLE IF NOT EXISTS public.smart_review_queue (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id   UUID REFERENCES public.profiles(id) ON DELETE CASCADE,

  content_type TEXT NOT NULL,
  -- 'lesson' | 'mcq' | 'cq' | 'pdf'
  content_id   UUID NOT NULL,
  topic_tag    TEXT,

  -- SM-2 Spaced Repetition
  interval_days  INTEGER DEFAULT 1,
  ease_factor    NUMERIC DEFAULT 2.5,
  review_count   INTEGER DEFAULT 0,
  next_review_at TIMESTAMPTZ NOT NULL,

  -- Priority Score
  priority_score NUMERIC DEFAULT 0,
  -- weakness_score*0.5 + time_decay*0.3 + exam_proximity*0.2

  -- Exam-aware boosting
  upcoming_exam_id UUID REFERENCES public.exams(id) ON DELETE SET NULL,
  exam_date        TIMESTAMPTZ,

  last_reviewed_at TIMESTAMPTZ,

  UNIQUE(student_id, content_type, content_id)
);

-- 4f. Student Bookmarks (depends on: profiles, tenants)
CREATE TABLE IF NOT EXISTS public.student_bookmarks (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id   UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  tenant_id    UUID REFERENCES public.tenants(id) ON DELETE CASCADE,

  content_type public.bookmark_type NOT NULL,
  content_id   UUID NOT NULL,
  note         TEXT,
  -- Student নিজে লেখা personal note

  created_at   TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, content_type, content_id)
);

-- 4g. Student Notes — video timestamp-linked
-- (depends on: profiles, lessons)
CREATE TABLE IF NOT EXISTS public.student_notes (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id   UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  lesson_id    UUID REFERENCES public.lessons(id) ON DELETE CASCADE,
  tenant_id    UUID REFERENCES public.tenants(id) ON DELETE CASCADE,

  timestamp_sec INTEGER,
  -- Video-র কোন second-এ note নেওয়া হয়েছে
  -- NULL হলে lesson-level note

  content      TEXT NOT NULL,
  created_at   TIMESTAMPTZ DEFAULT NOW(),
  updated_at   TIMESTAMPTZ DEFAULT NOW()
);

-- 4h. Class Learning Insights — agent analytics
-- (depends on: tenants, lessons)
CREATE TABLE IF NOT EXISTS public.class_learning_insights (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id    UUID REFERENCES public.tenants(id) ON DELETE CASCADE,
  lesson_id    UUID REFERENCES public.lessons(id) ON DELETE CASCADE,

  avg_completion_rate   NUMERIC,
  avg_mastery_score     NUMERIC,
  avg_struggle_score    NUMERIC,
  avg_dropout_position_pct NUMERIC,
  -- গড়ে কত % এ student ছেড়ে দেয়

  common_struggle_segment JSONB,
  -- {"from_sec": 120, "to_sec": 180, "rewatch_count": 247}

  total_students_accessed INTEGER DEFAULT 0,
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  UNIQUE(tenant_id, lesson_id)
);


-- ============================================================
-- BLOCK 5: INDEXES
-- (query performance-এর জন্য)
-- ============================================================

-- Learning Events
CREATE INDEX IF NOT EXISTS idx_learning_events_student
  ON public.learning_events(student_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_learning_events_lesson
  ON public.learning_events(lesson_id, event_type);

CREATE INDEX IF NOT EXISTS idx_learning_events_type
  ON public.learning_events(event_type, created_at DESC);

-- Lesson Mastery
CREATE INDEX IF NOT EXISTS idx_lesson_mastery_student
  ON public.lesson_mastery(student_id);

CREATE INDEX IF NOT EXISTS idx_lesson_mastery_incomplete
  ON public.lesson_mastery(student_id, is_completed)
  WHERE is_completed = FALSE;
-- "Continue watching" query fast হবে

-- Topic Mastery
CREATE INDEX IF NOT EXISTS idx_topic_mastery_student
  ON public.topic_mastery(student_id, mastery_score ASC);
-- Weakness list fast হবে

CREATE INDEX IF NOT EXISTS idx_topic_mastery_type
  ON public.topic_mastery(student_id, topic_type);

-- Smart Review Queue
CREATE INDEX IF NOT EXISTS idx_review_queue_due
  ON public.smart_review_queue(student_id, next_review_at)
  WHERE next_review_at <= NOW();
-- "আজকের review" query fast হবে

CREATE INDEX IF NOT EXISTS idx_review_queue_priority
  ON public.smart_review_queue(student_id, priority_score DESC);

-- Daily Summary
CREATE INDEX IF NOT EXISTS idx_daily_summary_student
  ON public.daily_learning_summary(student_id, summary_date DESC);

-- Offline Downloads
CREATE INDEX IF NOT EXISTS idx_offline_downloads_student
  ON public.offline_downloads(student_id, status);

CREATE INDEX IF NOT EXISTS idx_offline_downloads_expiry
  ON public.offline_downloads(expires_at)
  WHERE status = 'active';
-- Cleanup cron job fast হবে

-- Student Notes
CREATE INDEX IF NOT EXISTS idx_student_notes_lesson
  ON public.student_notes(student_id, lesson_id);


-- ============================================================
-- BLOCK 6: FUNCTIONS
-- (dependency order: helper functions আগে, triggers পরে)
-- ============================================================

-- 6b. Mastery Score Update (Edge-Driven)
-- Instead of calculating on Every pulse, we receive the summary from Native App.
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
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.lesson_mastery (
    student_id, lesson_id, tenant_id,
    watch_percentage, struggle_score, mastery_score,
    total_watch_time_sec, last_accessed_at, is_completed
  ) VALUES (
    p_student_id, p_lesson_id, p_tenant_id,
    p_watch_pct, p_struggle_score, p_mastery_score,
    p_session_time, NOW(), (p_watch_pct >= 90)
  )
  ON CONFLICT (student_id, lesson_id) DO UPDATE SET
    watch_percentage     = GREATEST(lesson_mastery.watch_percentage, p_watch_pct),
    struggle_score       = p_struggle_score,
    mastery_score        = p_mastery_score,
    total_watch_time_sec = lesson_mastery.total_watch_time_sec + p_session_time,
    last_accessed_at     = NOW(),
    is_completed         = (lesson_mastery.is_completed OR (p_watch_pct >= 90));
END;
$$;

-- 6c. Update Topic Mastery (called after exam question response)
CREATE OR REPLACE FUNCTION public.update_topic_mastery(
  p_student_id    UUID,
  p_tenant_id     UUID,
  p_topic_type    TEXT,
  p_topic_id      UUID,
  p_topic_tag     TEXT,
  p_is_correct    BOOLEAN,
  p_time_sec      NUMERIC DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_prev_mastery NUMERIC;
  v_new_mastery  NUMERIC;
  v_speed_score  NUMERIC;
BEGIN
  -- Speed score: ১৫ sec-এর নিচে সঠিক উত্তর = full speed score
  v_speed_score := CASE
    WHEN p_is_correct AND p_time_sec IS NOT NULL
      THEN GREATEST(0, LEAST(1, 1 - (p_time_sec / 60.0)))
    ELSE 0
  END;

  -- Get previous mastery for trend tracking
  SELECT mastery_score INTO v_prev_mastery
  FROM public.topic_mastery
  WHERE student_id = p_student_id
    AND topic_type = p_topic_type
    AND topic_id   = p_topic_id;

  INSERT INTO public.topic_mastery (
    student_id, tenant_id, topic_type, topic_id, topic_tag,
    total_attempts, correct_attempts, speed_score, mastery_score,
    previous_mastery_score, last_attempted_at
  )
  VALUES (
    p_student_id, p_tenant_id, p_topic_type, p_topic_id, p_topic_tag,
    1,
    CASE WHEN p_is_correct THEN 1 ELSE 0 END,
    v_speed_score,
    CASE WHEN p_is_correct THEN (0.5 * 0.7 + v_speed_score * 0.3) ELSE 0.1 END,
    NULL,
    NOW()
  )
  ON CONFLICT (student_id, topic_type, topic_id) DO UPDATE SET
    total_attempts   = topic_mastery.total_attempts + 1,
    correct_attempts = topic_mastery.correct_attempts +
                       CASE WHEN p_is_correct THEN 1 ELSE 0 END,
    speed_score      = (topic_mastery.speed_score + v_speed_score) / 2.0,
    previous_mastery_score = topic_mastery.mastery_score,
    mastery_score    = ROUND(
      (
        (topic_mastery.correct_attempts +
         CASE WHEN p_is_correct THEN 1 ELSE 0 END)::NUMERIC
        / (topic_mastery.total_attempts + 1)
      ) * 0.7
      + ((topic_mastery.speed_score + v_speed_score) / 2.0) * 0.3
    , 2),
    last_attempted_at = NOW();
END;
$$;

-- 6d. Update Lesson Mastery (called from app every 30 sec while watching)
CREATE OR REPLACE FUNCTION public.update_lesson_mastery(
  p_student_id     UUID,
  p_lesson_id      UUID,
  p_tenant_id      UUID,
  p_watch_pct      INTEGER,
  p_position_sec   INTEGER,
  p_session_sec    INTEGER DEFAULT 0
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_struggle  NUMERIC;
  v_mastery   NUMERIC;
BEGIN
  INSERT INTO public.lesson_mastery (
    student_id, lesson_id, tenant_id,
    watch_percentage, last_position_sec,
    total_watch_time_sec, watch_count,
    is_completed, completed_at, last_accessed_at
  )
  VALUES (
    p_student_id, p_lesson_id, p_tenant_id,
    p_watch_pct, p_position_sec,
    p_session_sec, 1,
    (p_watch_pct >= 90),
    CASE WHEN p_watch_pct >= 90 THEN NOW() ELSE NULL END,
    NOW()
  )
  ON CONFLICT (student_id, lesson_id) DO UPDATE SET
    watch_percentage     = GREATEST(lesson_mastery.watch_percentage, p_watch_pct),
    last_position_sec    = p_position_sec,
    total_watch_time_sec = lesson_mastery.total_watch_time_sec + p_session_sec,
    watch_count          = lesson_mastery.watch_count + 
                           CASE WHEN p_position_sec < 5 THEN 1 ELSE 0 END,
    is_completed  = lesson_mastery.is_completed OR (p_watch_pct >= 90),
    completed_at  = CASE
                      WHEN NOT lesson_mastery.is_completed AND p_watch_pct >= 90
                      THEN NOW()
                      ELSE lesson_mastery.completed_at
                    END,
    last_accessed_at = NOW();

  -- Recalculate scores
  v_struggle := public.calculate_struggle_score(p_student_id, p_lesson_id);
  v_mastery  := public.calculate_mastery_score(p_student_id, p_lesson_id);

  UPDATE public.lesson_mastery
  SET struggle_score = v_struggle,
      mastery_score  = v_mastery
  WHERE student_id = p_student_id AND lesson_id = p_lesson_id;
END;
$$;

-- 6e. Update Smart Review Queue (SM-2 Algorithm)
CREATE OR REPLACE FUNCTION public.update_review_queue(
  p_student_id   UUID,
  p_content_type TEXT,
  p_content_id   UUID,
  p_topic_tag    TEXT,
  p_was_correct  BOOLEAN,
  p_exam_id      UUID DEFAULT NULL,
  p_exam_date    TIMESTAMPTZ DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_interval  INTEGER := 1;
  v_ease      NUMERIC := 2.5;
  v_priority  NUMERIC;
  v_days_to_exam INTEGER;
BEGIN
  SELECT interval_days, ease_factor
  INTO v_interval, v_ease
  FROM public.smart_review_queue
  WHERE student_id   = p_student_id
    AND content_type = p_content_type
    AND content_id   = p_content_id;

  -- SM-2 Algorithm
  IF p_was_correct THEN
    v_interval := ROUND(COALESCE(v_interval, 1) * COALESCE(v_ease, 2.5));
    v_ease     := LEAST(COALESCE(v_ease, 2.5) + 0.1, 4.0);
  ELSE
    v_interval := 1;
    v_ease     := GREATEST(COALESCE(v_ease, 2.5) - 0.2, 1.3);
  END IF;

  -- Priority: exam কাছে আসলে boost করো
  v_priority := 0.5;
  IF p_exam_date IS NOT NULL THEN
    v_days_to_exam := EXTRACT(DAY FROM p_exam_date - NOW())::INTEGER;
    IF v_days_to_exam <= 3 THEN
      v_priority := 0.95;
    ELSIF v_days_to_exam <= 7 THEN
      v_priority := 0.80;
    ELSIF v_days_to_exam <= 14 THEN
      v_priority := 0.65;
    END IF;
  END IF;

  INSERT INTO public.smart_review_queue (
    student_id, content_type, content_id, topic_tag,
    interval_days, ease_factor, review_count,
    next_review_at, priority_score,
    upcoming_exam_id, exam_date, last_reviewed_at
  )
  VALUES (
    p_student_id, p_content_type, p_content_id, p_topic_tag,
    v_interval, v_ease, 1,
    NOW() + (v_interval || ' days')::INTERVAL,
    v_priority,
    p_exam_id, p_exam_date, NOW()
  )
  ON CONFLICT (student_id, content_type, content_id) DO UPDATE SET
    interval_days    = v_interval,
    ease_factor      = v_ease,
    review_count     = smart_review_queue.review_count + 1,
    next_review_at   = NOW() + (v_interval || ' days')::INTERVAL,
    priority_score   = v_priority,
    upcoming_exam_id = COALESCE(p_exam_id, smart_review_queue.upcoming_exam_id),
    exam_date        = COALESCE(p_exam_date, smart_review_queue.exam_date),
    last_reviewed_at = NOW();
END;
$$;

-- 6f. Update Daily Summary + Streak
CREATE OR REPLACE FUNCTION public.update_daily_summary(
  p_student_id           UUID,
  p_lessons_watched      INTEGER DEFAULT 0,
  p_lessons_completed    INTEGER DEFAULT 0,
  p_questions_attempted  INTEGER DEFAULT 0,
  p_minutes_studied      INTEGER DEFAULT 0,
  p_accuracy             NUMERIC DEFAULT 0,
  p_reviews_completed    INTEGER DEFAULT 0,
  p_new_topics           INTEGER DEFAULT 0,
  p_mastery_improvements INTEGER DEFAULT 0
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_today        DATE := CURRENT_DATE;
  v_yesterday    DATE := CURRENT_DATE - INTERVAL '1 day';
  v_quality      NUMERIC;
  v_streak_ok    BOOLEAN;
  v_had_yesterday BOOLEAN;
BEGIN
  -- Quality score formula (0-100)
  v_quality := LEAST(100,
    (LEAST(p_lessons_completed, 3)   * 13.3) +  -- max 40
    (LEAST(p_accuracy, 1.0)          * 30)   +  -- max 30
    (LEAST(p_reviews_completed, 5)   * 4)    +  -- max 20
    (LEAST(p_new_topics, 2)          * 5)       -- max 10
  );

  v_streak_ok := v_quality >= 30;

  INSERT INTO public.daily_learning_summary (
    student_id, summary_date,
    lessons_watched, lessons_completed,
    questions_attempted, minutes_studied,
    accuracy_today, new_topics_explored,
    reviews_completed, mastery_improvements,
    quality_score, streak_maintained
  )
  VALUES (
    p_student_id, v_today,
    p_lessons_watched, p_lessons_completed,
    p_questions_attempted, p_minutes_studied,
    p_accuracy, p_new_topics,
    p_reviews_completed, p_mastery_improvements,
    v_quality, v_streak_ok
  )
  ON CONFLICT (student_id, summary_date) DO UPDATE SET
    lessons_watched     = daily_learning_summary.lessons_watched + p_lessons_watched,
    lessons_completed   = daily_learning_summary.lessons_completed + p_lessons_completed,
    questions_attempted = daily_learning_summary.questions_attempted + p_questions_attempted,
    minutes_studied     = daily_learning_summary.minutes_studied + p_minutes_studied,
    accuracy_today      = (daily_learning_summary.accuracy_today + p_accuracy) / 2,
    new_topics_explored = daily_learning_summary.new_topics_explored + p_new_topics,
    reviews_completed   = daily_learning_summary.reviews_completed + p_reviews_completed,
    mastery_improvements = daily_learning_summary.mastery_improvements + p_mastery_improvements,
    quality_score       = LEAST(100,
      (LEAST(daily_learning_summary.lessons_completed + p_lessons_completed, 3) * 13.3) +
      (LEAST((daily_learning_summary.accuracy_today + p_accuracy)/2, 1.0) * 30) +
      (LEAST(daily_learning_summary.reviews_completed + p_reviews_completed, 5) * 4) +
      (LEAST(daily_learning_summary.new_topics_explored + p_new_topics, 2) * 5)
    ),
    streak_maintained = (
      LEAST(100,
        (LEAST(daily_learning_summary.lessons_completed + p_lessons_completed, 3) * 13.3) +
        (LEAST((daily_learning_summary.accuracy_today + p_accuracy)/2, 1.0) * 30) +
        (LEAST(daily_learning_summary.reviews_completed + p_reviews_completed, 5) * 4) +
        (LEAST(daily_learning_summary.new_topics_explored + p_new_topics, 2) * 5)
      ) >= 30
    );

  -- Streak Update
  IF v_streak_ok THEN
    SELECT EXISTS(
      SELECT 1 FROM public.daily_learning_summary
      WHERE student_id       = p_student_id
        AND summary_date     = v_yesterday
        AND streak_maintained = TRUE
    ) INTO v_had_yesterday;

    IF v_had_yesterday THEN
      UPDATE public.profiles
      SET streak_count = streak_count + 1
      WHERE id = p_student_id;
    ELSE
      UPDATE public.profiles
      SET streak_count = 1
      WHERE id = p_student_id;
    END IF;
  END IF;
END;
$$;

-- 6g. Archive Student Data (Yearly Cleanup Logic)
CREATE OR REPLACE FUNCTION public.archive_student_data(
  p_student_id UUID,
  p_year       INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- 1. Create Yearly Summary from detailed data
  INSERT INTO public.student_yearly_summaries (
    student_id, academic_year, total_minutes_studied, 
    total_lessons_watched, avg_accuracy, top_subjects
  )
  SELECT 
    p_student_id, p_year,
    SUM(minutes_studied), 
    SUM(lessons_watched), 
    AVG(accuracy_today),
    ARRAY_AGG(DISTINCT (metadata->>'subject')) -- Simplistic example
  FROM public.daily_learning_summary
  WHERE student_id = p_student_id 
    AND EXTRACT(YEAR FROM summary_date) = p_year;

  -- 2. Purge Detailed Data (Only if needed to save space)
  -- Note: We notify user 30 days BEFORE calling this.
  DELETE FROM public.daily_learning_summary
  WHERE student_id = p_student_id 
    AND EXTRACT(YEAR FROM summary_date) = p_year;
END;
$$;

-- 6h. Revoke Offline Access (agent calls this)
CREATE OR REPLACE FUNCTION public.revoke_offline_access(
  p_student_id UUID,
  p_lesson_id  UUID,
  p_tenant_id  UUID
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  UPDATE public.offline_downloads
  SET status     = 'revoked',
      play_token = NULL
  WHERE student_id = p_student_id
    AND lesson_id  = p_lesson_id
    AND tenant_id  = p_tenant_id;
END;
$$;

-- 6i. Refresh Class Insights (agent dashboard-এর জন্য)
CREATE OR REPLACE FUNCTION public.refresh_class_insights(
  p_lesson_id UUID,
  p_tenant_id UUID
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_avg_completion  NUMERIC;
  v_avg_mastery     NUMERIC;
  v_avg_struggle    NUMERIC;
  v_avg_dropout     NUMERIC;
  v_total           INTEGER;
BEGIN
  SELECT
    AVG(watch_percentage),
    AVG(mastery_score),
    AVG(struggle_score),
    AVG(CASE WHEN NOT is_completed THEN watch_percentage END),
    COUNT(*)
  INTO
    v_avg_completion, v_avg_mastery,
    v_avg_struggle, v_avg_dropout, v_total
  FROM public.lesson_mastery
  WHERE lesson_id = p_lesson_id
    AND tenant_id = p_tenant_id;

  INSERT INTO public.class_learning_insights (
    tenant_id, lesson_id,
    avg_completion_rate, avg_mastery_score,
    avg_struggle_score, avg_dropout_position_pct,
    total_students_accessed, updated_at
  )
  VALUES (
    p_tenant_id, p_lesson_id,
    v_avg_completion, v_avg_mastery,
    v_avg_struggle, v_avg_dropout,
    v_total, NOW()
  )
  ON CONFLICT (tenant_id, lesson_id) DO UPDATE SET
    avg_completion_rate      = v_avg_completion,
    avg_mastery_score        = v_avg_mastery,
    avg_struggle_score       = v_avg_struggle,
    avg_dropout_position_pct = v_avg_dropout,
    total_students_accessed  = v_total,
    updated_at               = NOW();
END;
$$;

-- 6j. Get Student Dashboard Data (Flutter home screen-এর জন্য)
CREATE OR REPLACE FUNCTION public.get_student_dashboard(
  p_student_id UUID
)
RETURNS JSON
LANGUAGE plpgsql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_result JSON;
BEGIN
  SELECT json_build_object(
    'streak',          p.streak_count,
    'continue_lessons', (
      SELECT json_agg(row_to_json(cl)) FROM (
        SELECT lm.lesson_id, lm.watch_percentage,
               lm.last_position_sec, lm.mastery_level,
               l.title, l.duration_sec, l.thumbnail_url
        FROM public.lesson_mastery lm
        JOIN public.lessons l ON l.id = lm.lesson_id
        WHERE lm.student_id    = p_student_id
          AND lm.is_completed  = FALSE
          AND lm.watch_percentage > 5
        ORDER BY lm.last_accessed_at DESC
        LIMIT 5
      ) cl
    ),
    'weak_topics', (
      SELECT json_agg(row_to_json(wt)) FROM (
        SELECT topic_tag, weakness_level, mastery_score, trend
        FROM public.topic_mastery
        WHERE student_id = p_student_id
          AND total_attempts >= 3
        ORDER BY mastery_score ASC
        LIMIT 5
      ) wt
    ),
    'strong_topics', (
      SELECT json_agg(row_to_json(st)) FROM (
        SELECT topic_tag, weakness_level, mastery_score, trend
        FROM public.topic_mastery
        WHERE student_id   = p_student_id
          AND weakness_level = 'Strong'
          AND total_attempts >= 5
        ORDER BY mastery_score DESC
        LIMIT 3
      ) st
    ),
    'reviews_due_today', (
      SELECT COUNT(*) FROM public.smart_review_queue
      WHERE student_id   = p_student_id
        AND next_review_at <= NOW()
    ),
    'today_summary', (
      SELECT row_to_json(ds) FROM (
        SELECT quality_score, minutes_studied,
               lessons_completed, accuracy_today,
               streak_maintained
        FROM public.daily_learning_summary
        WHERE student_id   = p_student_id
          AND summary_date = CURRENT_DATE
      ) ds
    )
  )
  INTO v_result
  FROM public.profiles p
  WHERE p.id = p_student_id;

  RETURN v_result;
END;
$$;


-- ============================================================
-- BLOCK 7: TRIGGERS
-- ============================================================

-- 7a. live_stream_sessions শেষ হলে lesson auto-update
CREATE OR REPLACE FUNCTION public.handle_live_stream_ended()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
    UPDATE public.lessons
    SET lesson_type       = 'video',
        is_recorded_live  = TRUE,
        live_ended_at     = NOW(),
        content_url       = COALESCE(NEW.recording_url, content_url),
        status            = 'draft',
        updated_at        = NOW()
    WHERE id = NEW.lesson_id;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_live_stream_ended ON public.live_stream_sessions;
CREATE TRIGGER trg_live_stream_ended
  AFTER UPDATE OF status ON public.live_stream_sessions
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_live_stream_ended();


-- ============================================================
-- BLOCK 8: ROW LEVEL SECURITY
-- ============================================================

-- Learning Events
ALTER TABLE public.learning_events ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students insert own events" ON public.learning_events
  FOR INSERT WITH CHECK (auth.uid() = student_id);

CREATE POLICY "Students view own events" ON public.learning_events
  FOR SELECT USING (auth.uid() = student_id);

CREATE POLICY "Admins view tenant events" ON public.learning_events
  FOR SELECT USING (is_active_admin(tenant_id));

-- Lesson Mastery
ALTER TABLE public.lesson_mastery ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students manage own mastery" ON public.lesson_mastery
  FOR ALL USING (auth.uid() = student_id);

CREATE POLICY "Admins view tenant mastery" ON public.lesson_mastery
  FOR SELECT USING (is_active_admin(tenant_id));

-- Topic Mastery
ALTER TABLE public.topic_mastery ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students manage own topic mastery" ON public.topic_mastery
  FOR ALL USING (auth.uid() = student_id);

CREATE POLICY "Admins view tenant topic mastery" ON public.topic_mastery
  FOR SELECT USING (is_active_admin(tenant_id));

-- Daily Summary
ALTER TABLE public.daily_learning_summary ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students manage own daily summary" ON public.daily_learning_summary
  FOR ALL USING (auth.uid() = student_id);

-- Smart Review Queue
ALTER TABLE public.smart_review_queue ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students manage own review queue" ON public.smart_review_queue
  FOR ALL USING (auth.uid() = student_id);

-- Student Bookmarks
ALTER TABLE public.student_bookmarks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students manage own bookmarks" ON public.student_bookmarks
  FOR ALL USING (auth.uid() = student_id);

-- Student Notes
ALTER TABLE public.student_notes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students manage own notes" ON public.student_notes
  FOR ALL USING (auth.uid() = student_id);

-- Offline Downloads
ALTER TABLE public.offline_downloads ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students view own downloads" ON public.offline_downloads
  FOR SELECT USING (auth.uid() = student_id);

CREATE POLICY "Students insert own downloads" ON public.offline_downloads
  FOR INSERT WITH CHECK (auth.uid() = student_id);

CREATE POLICY "Admins manage tenant downloads" ON public.offline_downloads
  FOR ALL USING (is_active_admin(tenant_id));

-- Storage Configs
ALTER TABLE public.storage_configs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Only owner manages storage config" ON public.storage_configs
  FOR ALL USING (is_tenant_owner(tenant_id));

-- Class Learning Insights
ALTER TABLE public.class_learning_insights ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Admins view class insights" ON public.class_learning_insights
  FOR SELECT USING (is_active_admin(tenant_id));

CREATE POLICY "System updates class insights" ON public.class_learning_insights
  FOR ALL USING (is_active_admin(tenant_id));


-- ============================================================
-- BLOCK 9: USEFUL QUERIES (reference — run manually as needed)
-- ============================================================

-- ❶ Student-এর top weak topics
-- SELECT topic_tag, weakness_level, mastery_score, trend
-- FROM topic_mastery
-- WHERE student_id = '<uuid>'
-- ORDER BY mastery_score ASC LIMIT 5;

-- ❷ আজকের review queue
-- SELECT * FROM smart_review_queue
-- WHERE student_id = '<uuid>'
--   AND next_review_at <= NOW()
-- ORDER BY priority_score DESC;

-- ❸ Continue watching
-- SELECT lm.*, l.title FROM lesson_mastery lm
-- JOIN lessons l ON l.id = lm.lesson_id
-- WHERE lm.student_id = '<uuid>'
--   AND lm.is_completed = FALSE
--   AND lm.watch_percentage > 5
-- ORDER BY lm.last_accessed_at DESC;

-- ❹ Agent: lesson-এর common struggle segment
-- SELECT common_struggle_segment, avg_dropout_position_pct
-- FROM class_learning_insights
-- WHERE lesson_id = '<uuid>';

-- ❺ pg_cron setup (Supabase dashboard থেকে একবার run করো)
-- SELECT cron.schedule(
--   'cleanup-expired-downloads',
--   '0 3 * * *',  -- প্রতিদিন রাত ৩টায়
--   'SELECT public.cleanup_expired_downloads();'
-- );


-- ============================================================
-- DONE
-- ============================================================
-- Migration complete.
-- Tables created   : 10 নতুন
-- Tables altered   : 5 existing (non-breaking)
-- Functions created: 10
-- Triggers created : 1
-- RLS policies     : 15+
-- ============================================================
