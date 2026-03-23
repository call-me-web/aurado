import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_config.dart';

/// Represents the current theme configuration state.
/// This allows us to override static [ThemeConfig] defaults
/// dynamically when fetching tenant branding from Supabase.
class ThemeState {
  const ThemeState({
    this.primaryColor = ThemeConfig.primary,
    this.secondaryColor = ThemeConfig.secondary,
    this.tertiaryColor = ThemeConfig.tertiary,
    this.quaternaryColor = ThemeConfig.quaternary,
    this.fontFamily = ThemeConfig.fontFamily,
    this.themeMode = ThemeMode.system,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final Color quaternaryColor;
  final String fontFamily;
  final ThemeMode themeMode;

  ThemeState copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? quaternaryColor,
    String? fontFamily,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      tertiaryColor: tertiaryColor ?? this.tertiaryColor,
      quaternaryColor: quaternaryColor ?? this.quaternaryColor,
      fontFamily: fontFamily ?? this.fontFamily,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

/// A Notifier to manage the active [ThemeState].
class ThemeNotifier extends Notifier<ThemeState> {
  @override
  ThemeState build() {
    return const ThemeState();
  }

  /// Update the current theme based on fetched tenant branding.
  void updateTheme({
    Color? primaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? quaternaryColor,
    String? fontFamily,
  }) {
    state = state.copyWith(
      primaryColor: primaryColor ?? ThemeConfig.primary,
      secondaryColor: secondaryColor ?? ThemeConfig.secondary,
      tertiaryColor: tertiaryColor ?? ThemeConfig.tertiary,
      quaternaryColor: quaternaryColor ?? ThemeConfig.quaternary,
      fontFamily: fontFamily ?? ThemeConfig.fontFamily,
    );
  }

  /// Reset the theme to its default Aurado values.
  void resetTheme() {
    state = const ThemeState();
  }

  /// Update the application theme mode (dark/light/system)
  void updateThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }
}

/// The global provider for the application's theme state.
final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(ThemeNotifier.new);

