import 'package:flutter/material.dart';

/// Single Source of Truth for all Aurado Design Tokens.
///
/// Modify this file to instantly change the branding, typography, spacing,
/// and shapes across the entire application.
class ThemeConfig {
  ThemeConfig._();

  // ── 1. Typography ──────────────────────────────────────────────────────────
  /// The primary font family used throughout the app.
  /// Changing this automatically updates all text styles via GoogleFonts.
  static const String fontFamily = 'Inter';

  // ── 2. Brand Colors (4 Main Colors) ────────────────────────────────────────
  static const Color primary = Color(0xFF5F6898);
  static const Color secondary = Color(0xFF7C84C8);
  static const Color tertiary = Color(0xFF9FA8DA);
  static const Color quaternary = Color(0xFFC5CAE9);

  // ── 3. Base Layout Colors (Light Mode) ─────────────────────────────────────
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF1F3F5);
  static const Color lightDivider = Color(0xFFE9ECEF);
  static const Color onLightBackground = Color(0xFF212529);
  static const Color onLightSurface = Color(0xFF495057);
  static const Color lightMuted = Color(0xFF868E96);

  // ── 4. Base Layout Colors (Dark Mode) ──────────────────────────────────────
  static const Color darkBackground = Color(0xFF0D0D12);
  static const Color darkSurface = Color(0xFF17171F);
  static const Color darkSurfaceElevated = Color(0xFF1E1E2A);
  static const Color darkDivider = Color(0xFF2C2C3A);
  static const Color onDarkBackground = Color(0xFFF0F0F5);
  static const Color onDarkSurface = Color(0xFFCCCCDD);
  static const Color darkMuted = Color(0xFF6B6B80);

  // ── 5. Semantic Colors ─────────────────────────────────────────────────────
  static const Color error = Color(0xFFFF5252);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF2196F3);
  static const Color navBarActive = Color.fromARGB(
    255,
    174,
    98,
    255,
  ); // Coral/Peach from reference
  static const double navBarGlassOpacity = 0.7;
  static const double navBarBlur = 15.0;
  static const double navBarStrokeWidth = 1.2;

  // ── 6. Spacing ─────────────────────────────────────────────────────────────
  /// Base spacing multiplier. All layouts should use these tokens.
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // ── 7. Shapes & Borders ────────────────────────────────────────────────────
  /// Global border radii for different UI components.
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0; // Buttons, Inputs
  static const double radiusLg = 17.0; // Cards, Dialogs
  static const double radiusXl = 24.0; // Bottom Sheets
  static const double radiusFull = 999.0; // Pills, Badges

  /// Global stroke/border widths.
  static const double strokeWidthThin = 1.5;
  static const double strokeWidthThick = 2.0;
}
