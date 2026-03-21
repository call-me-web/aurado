# Aurado - Master Features & Security Documentation

This document serves as the permanent, living record of all features, architectural decisions, and security layers implemented in the Aurado Student Native App.

## 🏗 Core Architecture
- **Framework**: Flutter (Dart)
- **State Management & DI**: Riverpod + GetIt
- **Navigation**: GoRouter (StatefulShellRoute for persistent bottom navigation)
- **Backend**: Supabase (PostgreSQL, Auth, Realtime, Edge Functions)
- **Video Delivery**: Cloudflare Stream & R2 via `pod_player`

## 🛡️ Multi-Layered Security & Anti-Piracy Matrix

Aurado prioritizes content protection for EdTech creators. Security is built in layers across all platforms.

### 1. iOS Native Guard
- **App Block (Black Screen)**: Critical video players are wrapped in a `FlutterPlatformView` containing a `UITextField` with `isSecureTextEntry = true`. This forces OS-level black-screening during screen recording or screenshots.
- **Dynamic Toggling**: Secure mode is activated via MethodChannels (`com.aurado/security`) automatically when entering full-screen video playback.
- **Screenshot Logging**: `UIApplication.userDidTakeScreenshotNotification` is used to log screenshot attempts to the server (post-event logging).
- **Recording Detection**: `UIScreen.capturedDidChangeNotification` acts as a primary listener to warn the user or immediately hide content if recording begins.

### 2. Android Secure Mode
- **FLAG_SECURE**: MethodChannels toggle `WindowManager.LayoutParams.FLAG_SECURE` on the `MainActivity`, natively preventing screenshots and screen recordings at the OS hardware composer level.

### 3. Desktop Security (Windows)
- **WDA Block**: Native C++ hooks call `SetWindowDisplayAffinity()`. It includes runtime version checks to use `WDA_EXCLUDEFROMCAPTURE` on newer Windows 10/11 builds, and `WDA_MONITOR` for older versions.
- **Multi-Monitor**: Future phases include detecting external displays/projectors.
- **Process Monitoring**: Future phases will check for active blacklisted processes (OBS, Bandicam).

### 4. Forensic & Dynamic Watermarking
- **Visible Layer**: A `DynamicWatermark` Flutter widget floats the user's Name and Phone Number across the screen, changing position every 5-10 seconds to prevent static masking.
- **Invisible Forensic Layer**: A 1% opacity text overlay containing the unique Database User ID / Transaction ID. It moves dynamically. If a video is pirated via an external camera, a high-contrast filter script can recover this ID from the video frames to identify the leaker.
- **Color Contrast**: The watermark dynamically shifts contrast depending on the video background to ensure recoverability.

### 5. App Switcher Obfuscation
- **Lifecycle Observer**: Using `WidgetsBindingObserver`, the app instantly blurs or hides sensitive content when transitioning to `AppLifecycleState.inactive` or `paused`. This prevents the OS App Switcher from capturing an exposed thumbnail.

### 6. Offline Encrypted Storage
- Downloaded lessons bypass the public Gallery. They are fetched securely, stored in an encrypted application folder, and decrypted on-the-fly entirely within the Aurado player's memory.

## 🚀 Roadmap Phases Completed
- [x] **Phase 1**: Project Initialization & Core Folders
- [x] **Phase 2**: Core Infrastructure (GetIt, GoRouter, Network Clients)
- [ ] **Phase 3**: Security Baseline (Executing...)
