-- Clean Students Table (Identity & Preferences)
CREATE TABLE public.students (
  id UUID PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  education_level TEXT,
  language_preference TEXT DEFAULT 'bn',
  country TEXT DEFAULT 'Bangladesh',
  streak_count INTEGER DEFAULT 0,
  last_active_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Lesson Progress Tracking (Per-Tenant)
CREATE TABLE public.lesson_progress (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  lesson_id UUID REFERENCES public.lessons(id) ON DELETE CASCADE,
  tenant_id UUID REFERENCES public.tenants(id) ON DELETE CASCADE,
  watch_percentage INTEGER DEFAULT 0,      -- 0-100
  last_position_sec INTEGER DEFAULT 0,     -- resume করার জন্য
  is_completed BOOLEAN DEFAULT FALSE,
  completed_at TIMESTAMPTZ,
  watch_count INTEGER DEFAULT 1,           -- কতবার দেখেছে
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, lesson_id)
);

-- Weak Point Tracking (Automatic Calculation)
CREATE TABLE public.student_weak_points (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  tenant_id UUID REFERENCES public.tenants(id) ON DELETE CASCADE,
  subject_tag TEXT NOT NULL,    -- "Physics", "Algebra", "English Grammar"
  wrong_count INTEGER DEFAULT 1,
  total_attempts INTEGER DEFAULT 1,
  weak_score NUMERIC GENERATED ALWAYS AS 
    (wrong_count::numeric / NULLIF(total_attempts, 0)) STORED,
  last_wrong_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, subject_tag, tenant_id)
);

-- Favorites / Bookmarks
CREATE TYPE public.bookmark_type AS ENUM 
  ('lesson', 'pdf', 'mcq', 'cq', 'exam');

CREATE TABLE public.student_bookmarks (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  tenant_id UUID REFERENCES public.tenants(id) ON DELETE CASCADE,
  content_type public.bookmark_type NOT NULL,
  content_id UUID NOT NULL,         -- lesson_id / question_id / exam_id
  note TEXT,                        -- student নিজে note লিখতে পারবে
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, content_type, content_id)
);

-- Spaced Repetition / Review Queue
CREATE TABLE public.student_review_queue (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  content_type public.bookmark_type NOT NULL,
  content_id UUID NOT NULL,
  next_review_at TIMESTAMPTZ NOT NULL,     -- কখন review করতে হবে
  interval_days INTEGER DEFAULT 1,         -- পরের review কতদিন পর
  ease_factor NUMERIC DEFAULT 2.5,         -- কত সহজ মনে হচ্ছে (1-5)
  review_count INTEGER DEFAULT 0,
  UNIQUE(student_id, content_type, content_id)
);

-- Streak / Daily Activity Tracking
CREATE TABLE public.student_streaks (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  streak_date DATE NOT NULL,
  lessons_watched INTEGER DEFAULT 0,
  minutes_studied INTEGER DEFAULT 0,
  UNIQUE(student_id, streak_date)
);

-- Indexes for performance
CREATE INDEX idx_lesson_progress_student ON public.lesson_progress(student_id);
CREATE INDEX idx_weak_points_student ON public.student_weak_points(student_id);
CREATE INDEX idx_bookmarks_student ON public.student_bookmarks(student_id);
CREATE INDEX idx_review_queue_student_date ON public.student_review_queue(student_id, next_review_at);
