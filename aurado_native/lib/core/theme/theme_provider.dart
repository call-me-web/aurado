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
    this.backgroundColor,
    this.cardColor,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final Color quaternaryColor;
  final String fontFamily;
  final ThemeMode themeMode;
  final Color? backgroundColor;
  final Color? cardColor;

  ThemeState copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? quaternaryColor,
    String? fontFamily,
    ThemeMode? themeMode,
    Color? backgroundColor,
    Color? cardColor,
  }) {
    return ThemeState(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      tertiaryColor: tertiaryColor ?? this.tertiaryColor,
      quaternaryColor: quaternaryColor ?? this.quaternaryColor,
      fontFamily: fontFamily ?? this.fontFamily,
      themeMode: themeMode ?? this.themeMode,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cardColor: cardColor ?? this.cardColor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeState &&
          runtimeType == other.runtimeType &&
          primaryColor == other.primaryColor &&
          secondaryColor == other.secondaryColor &&
          tertiaryColor == other.tertiaryColor &&
          quaternaryColor == other.quaternaryColor &&
          fontFamily == other.fontFamily &&
          themeMode == other.themeMode &&
          backgroundColor == other.backgroundColor &&
          cardColor == other.cardColor;

  @override
  int get hashCode =>
      primaryColor.hashCode ^
      secondaryColor.hashCode ^
      tertiaryColor.hashCode ^
      quaternaryColor.hashCode ^
      fontFamily.hashCode ^
      themeMode.hashCode ^
      backgroundColor.hashCode ^
      cardColor.hashCode;
}

/// A Notifier to manage the active [ThemeState].
class ThemeNotifier extends Notifier<ThemeState> {
  @override
  ThemeState build() {
    return const ThemeState();
  }

  /// Update the current theme based on fetched tenant branding.
  /// 
  /// Only updates if the values have actually changed to prevent redundant rebuilds.
  void updateTheme({
    Color? primaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? quaternaryColor,
    String? fontFamily,
    Color? backgroundColor,
    Color? cardColor,
  }) {
    final newState = state.copyWith(
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      tertiaryColor: tertiaryColor,
      quaternaryColor: quaternaryColor,
      fontFamily: fontFamily,
      backgroundColor: backgroundColor,
      cardColor: cardColor,
    );

    if (state != newState) {
      state = newState;
    }
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

