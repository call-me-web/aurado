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

  // ── 8. Font Sizes ──────────────────────────────────────────────────────────
  /// Use these instead of hardcoding `fontSize` anywhere in widget files.
  static const double fontSizeXs = 10.0;   // Institution label, fine print
  static const double fontSizeSm = 12.0;   // Chips, tags, badge text
  static const double fontSizeMd = 14.0;   // Body, form labels, hints
  static const double fontSizeLg = 16.0;   // Section body, button labels
  static const double fontSizeXl = 18.0;   // Titles, card headings
  static const double fontSizeXxl = 22.0;  // Screen display headings
  static const double fontSizeDisplay = 28.0; // Hero / splash display

  // ── 9. Font Weights ────────────────────────────────────────────────────────
  /// Semantic weight aliases. Prefer these over raw `FontWeight.w___` values.
  static const FontWeight weightRegular  = FontWeight.w400; // Body copy
  static const FontWeight weightMedium   = FontWeight.w500; // Subtle emphasis
  static const FontWeight weightSemiBold = FontWeight.w600; // Labels, titles
  static const FontWeight weightBold     = FontWeight.w700; // Headings
  static const FontWeight weightExtraBold = FontWeight.w800; // Section headers
  static const FontWeight weightBlack    = FontWeight.w900; // Hero text

  // ── 10. Semantic Text Colors ───────────────────────────────────────────────
  /// Semantic helpers that auto-adapt to light / dark mode via [Brightness].
  ///
  /// Usage: `ThemeConfig.textPrimary(isDark)`
  /// or wrap with `Theme.of(context).colorScheme` checks in widgets.

  /// Main body / heading text — high contrast.
  static Color textPrimary(bool isDark) =>
      isDark ? onDarkBackground : onLightBackground;

  /// Secondary text — body copy on surface.
  static Color textSecondary(bool isDark) =>
      isDark ? onDarkSurface : onLightSurface;

  /// Muted / hint / caption text — low emphasis.
  static Color textMuted(bool isDark) =>
      isDark ? darkMuted : lightMuted;

  /// Price highlight — always uses the brand primary color.
  static const Color textPrice = primary;

  /// Category accent — always uses the brand secondary color.
  static const Color textCategoryAccent = secondary;

  /// Destructive / error text.
  static const Color textError = error;

  // ── 11. Role-Based Text Style Specs ───────────────────────────────────────
  // These are named roles used in widgets via `textTheme.*?.copyWith(...)`.
  // Do NOT duplicate TextStyle objects here; instead define size+weight pairs
  // that widgets can pick up from TextTheme and override selectively.

  /// Section header (e.g. "Featured Courses", "Top Institutions").
  static const double sectionHeaderSize   = fontSizeLg;
  static const FontWeight sectionHeaderWeight = weightExtraBold;
  static const double sectionHeaderLetterSpacing = -0.5;

  /// Card title (primary text on course/institution cards).
  static const double cardTitleSize   = fontSizeMd;
  static const FontWeight cardTitleWeight = weightBold;

  /// Card subtitle / metadata (e.g. duration, level).
  static const double cardMetaSize   = fontSizeSm;
  static const FontWeight cardMetaWeight = weightMedium;

  /// Price label on cards.
  static const double cardPriceSize   = fontSizeSm;
  static const FontWeight cardPriceWeight = weightExtraBold;

  /// "See All" / action link text.
  static const double actionLinkSize   = fontSizeSm;
  static const FontWeight actionLinkWeight = weightBold;

  /// Chip / category filter label.
  static const double chipLabelSize   = fontSizeSm;
  static const FontWeight chipLabelWeight = weightSemiBold;

  /// Institution label under circle avatar.
  static const double institutionLabelSize   = fontSizeXs;
  static const FontWeight institutionLabelWeight = weightSemiBold;

  /// Descriptive/body text (e.g. "This course is perfect for...").
  static const double descriptionBodySize   = fontSizeMd;
  static const FontWeight descriptionBodyWeight = weightRegular;

  /// Bold inline highlight within description (e.g. category value).
  static const FontWeight descriptionAccentWeight = weightBold;
}
