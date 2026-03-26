# Aurado — The Multi-Platform EdTech Super App

Aurado is a production-grade educational platform built with a **"Local-First, Edge-Driven"** architecture. It minimizes server load while providing high-speed, personalized learning experiences.

## 🚀 Key Capabilities

### 1. Edge Intelligence (SM-2 Engine)
- **Spaced Repetition (SM-2)**: Manages student review queues locally using the SM-2 algorithm to optimize memory retention.
- **Topic Mastery Tracking**: Calculates accuracy and speed scores locally to determine mastery or struggle without hitting the server.
- **Micro-Event Tracking**: Tracks precise video seek/pause events locally for deep analytics.

### 2. Intelligent Sync Engine
- **Background Sync**: Uses `workmanager` to sync consolidated summaries to Supabase daily (e.g., at 2 AM).
- **Edge-Driven Summarization**: Instead of sending raw logs, the app calculates "Mastery Scores" and "Watch Percentages" locally and sends only 1-line summaries to the server.

### 3. Cross-Device State Sync (WhatsApp Style)
- **Encrypted Backups**: Automatically serializes and encrypts (AES-256) all local learning data.
- **Cloud Storage**: Securely stores backup blobs in Supabase Storage.
- **Auto-Restore**: Detects existing progress on new devices and prompts for a one-click restoration.

### 5. Exam Engine (Phase 3 — In Progress)
- **Anti-Cheat Guard**: Prevents app backgrounding and split-screen during active exams.
- **Engagement Analytics**: Tracks "stuck" points and per-question time spent for teacher insights.
- **Secure MCQ & CQ**: Supports Multiple Choice and Creative Questions with photo upload via Cloudflare R2.
- **Adaptive Offline Review**: Mistakes and bookmarked questions are synced to the local Drift database for offline study.

## 🛠 Tech Stack
- **Core**: Flutter 3.x
- **State Management**: Riverpod 3.0 (with @riverpod generators)
- **Database**: Drift (SQLite) for high-performance edge storage
- **Backend**: Supabase (Auth, DB, Storage)
- **Background Tasks**: Workmanager
- **Security**: AES-256 Encryption, Flutter Secure Storage

## 🔐 Environment Setup (Rule 54)

Aurado Native strictly enforces that no secrets are committed to the repository. The app expects a `.env` file at the root.

**1. Create your `.env`:**
Place a `.env` file in the root with your credentials (e.g. `VITE_SUPABASE_URL=...`).

**2. Running the app:**
- **Terminal**: Use `make run` to inject variables during development.
- **VS Code**: Use the pre-configured *Run Aurado (with .env)* launch configuration from the Debug tab.

*Note: For manual builds, ensure you use `--dart-define-from-file=.env`. Or run `dart scripts/inject_env.dart` to generate a fallback `env_secrets.dart` file.*

## 🏗 Architecture
Aurado follows **Clean Architecture** principles:
- **domain/**: Pure business logic (Models, Repository Interfaces).
- **data/**: External data sources (Mappers, Repository Implementations).
- **presentation/**: UI and State Management (Riverpod Notifiers).

---
*Maintainable · Clean · 7-Year Futureproof*
