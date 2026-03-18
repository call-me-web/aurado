import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Defines the three sequential states of the onboarding splash flow.
enum SplashState {
  /// Splash 1: The core tenant's brand logo or generic brand intro.
  brandIntro,
  /// Splash 2: "Powered by Aurado" or a feature showcase.
  platformShowcase,
  /// Splash 3: The sequence has finished, user is ready for role selection.
  roleSelection,
}

/// A notifier that automatically progresses through the splash sequence.
class SplashNotifier extends Notifier<SplashState> {
  bool _isDisposed = false;

  @override
  SplashState build() {
    ref.onDispose(() => _isDisposed = true);
    _startSequence();
    return SplashState.brandIntro;
  }

  /// Initiates the auto-advancing timer sequence.
  Future<void> _startSequence() async {
    // 1. Stay on Brand Intro for 2.5 seconds
    await Future.delayed(const Duration(milliseconds: 2500));
    if (_isDisposed) return;
    
    // 2. Transition to Platform Showcase
    state = SplashState.platformShowcase;
    
    // 3. Stay on Platform Showcase for 2.5 seconds
    await Future.delayed(const Duration(milliseconds: 2500));
    if (_isDisposed) return;
    
    // 4. End sequence and transition to Role Selection
    state = SplashState.roleSelection;
  }
}

/// Provider to watch the current splash sequence state.
final splashProvider = NotifierProvider<SplashNotifier, SplashState>(
  SplashNotifier.new,
);
