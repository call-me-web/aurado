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

### 4. Premium Dashboard
- **Dynamic Stats**: Displays real-time streaks, study minutes, and "Smart Review" counts.
- **Recent Insights**: Quick access to recently accessed lessons and progress.

## 🛠 Tech Stack
- **Core**: Flutter 3.x
- **State Management**: Riverpod 3.0 (with @riverpod generators)
- **Database**: Drift (SQLite) for high-performance edge storage
- **Backend**: Supabase (Auth, DB, Storage)
- **Background Tasks**: Workmanager
- **Security**: AES-256 Encryption, Flutter Secure Storage

## 🏗 Architecture
Aurado follows **Clean Architecture** principles:
- **domain/**: Pure business logic (Models, Repository Interfaces).
- **data/**: External data sources (Mappers, Repository Implementations).
- **presentation/**: UI and State Management (Riverpod Notifiers).

---
*Maintainable · Clean · 7-Year Futureproof*
