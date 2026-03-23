import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier to manage application performance settings.
class PerformanceSettings {
  final bool enableGlassmorphism;
  final bool enableComplexAnimations;

  const PerformanceSettings({
    this.enableGlassmorphism = true,
    this.enableComplexAnimations = true,
  });

  PerformanceSettings copyWith({
    bool? enableGlassmorphism,
    bool? enableComplexAnimations,
  }) {
    return PerformanceSettings(
      enableGlassmorphism: enableGlassmorphism ?? this.enableGlassmorphism,
      enableComplexAnimations: enableComplexAnimations ?? this.enableComplexAnimations,
    );
  }
}

class PerformanceNotifier extends Notifier<PerformanceSettings> {
  @override
  PerformanceSettings build() {
    // In a real app, we might detect device capabilities here
    // or load from persistent storage.
    return const PerformanceSettings();
  }

  void toggleGlassmorphism(bool value) {
    state = state.copyWith(enableGlassmorphism: value);
  }

  void toggleAnimations(bool value) {
    state = state.copyWith(enableComplexAnimations: value);
  }
}

final performanceProvider = NotifierProvider<PerformanceNotifier, PerformanceSettings>(
  PerformanceNotifier.new,
);
