import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_config.dart';
import 'theme_provider.dart';

/// Global ThemeData builder consuming tokens explicitly from [ThemeConfig] or dynamic [ThemeState].
class AuradoTheme {
  AuradoTheme._();

  /// Builds a [ThemeData] for light mode.
  static ThemeData light({ThemeState? state}) => _buildTheme(Brightness.light, state);
  
  /// Builds a [ThemeData] for dark mode.
  static ThemeData dark({ThemeState? state}) => _buildTheme(Brightness.dark, state);

  /// Central logic for building [ThemeData] based on [Brightness] and dynamic config.
  static ThemeData _buildTheme(Brightness brightness, ThemeState? state) {
    final isDark = brightness == Brightness.dark;
    
    final primary = state?.primaryColor ?? ThemeConfig.primary;
    final secondary = state?.secondaryColor ?? ThemeConfig.secondary;
    final tertiary = state?.tertiaryColor ?? ThemeConfig.tertiary;
    final fontFamily = state?.fontFamily ?? ThemeConfig.fontFamily;

    final background = state?.backgroundColor ?? (isDark ? ThemeConfig.darkBackground : ThemeConfig.lightBackground);
    final surface = state?.cardColor ?? (isDark ? ThemeConfig.darkSurface : ThemeConfig.lightSurface);
    final surfaceElevated = isDark ? ThemeConfig.darkSurfaceElevated : ThemeConfig.lightSurfaceElevated;
    final divider = isDark ? ThemeConfig.darkDivider : ThemeConfig.lightDivider;
    final onBackground = isDark ? ThemeConfig.onDarkBackground : ThemeConfig.onLightBackground;
    final onSurface = isDark ? ThemeConfig.onDarkSurface : ThemeConfig.onLightSurface;
    final muted = isDark ? ThemeConfig.darkMuted : ThemeConfig.lightMuted;
    final navBarActive = ThemeConfig.navBarActive;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onBackground,
      secondary: secondary,
      onSecondary: onBackground,
      tertiary: tertiary,
      onTertiary: onBackground,
      error: ThemeConfig.error,
      onError: onBackground,
      surface: surface,
      onSurface: onSurface,
    );

    // Retrieve the dynamic font family properly colored for light or dark mode.
    final textTheme = GoogleFonts.getTextTheme(
      fontFamily, 
      _buildTextTheme(onBackground, onSurface, muted),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.radiusLg),
          side: BorderSide(
            color: divider,
            width: ThemeConfig.strokeWidthThin,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeConfig.radiusMd),
          ),
          textStyle: GoogleFonts.getFont(
            fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeConfig.radiusMd),
          ),
          side: BorderSide(
            color: primary,
            width: ThemeConfig.strokeWidthThick,
          ),
          textStyle: GoogleFonts.getFont(
            fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: ThemeConfig.spacingMd,
          vertical: ThemeConfig.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.radiusMd),
          borderSide: BorderSide(
            color: divider,
            width: ThemeConfig.strokeWidthThin,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.radiusMd),
          borderSide: BorderSide(
            color: primary, 
            width: ThemeConfig.strokeWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.radiusMd),
          borderSide: const BorderSide(
            color: ThemeConfig.error,
            width: ThemeConfig.strokeWidthThin,
          ),
        ),
        hintStyle: TextStyle(color: muted, fontSize: 14),
        labelStyle: TextStyle(color: muted),
      ),
      dividerTheme: DividerThemeData(
        color: divider,
        thickness: ThemeConfig.strokeWidthThin,
        space: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: muted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: onBackground,
        elevation: 0,
        centerTitle: false,
      ),
      extensions: [
        NavBarTheme(
          activeColor: navBarActive,
          glassOpacity: ThemeConfig.navBarGlassOpacity,
          blur: ThemeConfig.navBarBlur,
          strokeWidth: ThemeConfig.navBarStrokeWidth,
          strokeColor: isDark ? Colors.white : Colors.black,
          unselectedColor: isDark ? Colors.white : Colors.black,
        ),
      ],
    );
  }

  static TextTheme _buildTextTheme(Color onBackground, Color onSurface, Color muted) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: onBackground,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: onBackground,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: onBackground,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: onBackground,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: muted,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: onBackground,
      ),
    );
  }
}

/// Custom theme extension for the Aurado Navigation Bar.
class NavBarTheme extends ThemeExtension<NavBarTheme> {
  final Color activeColor;
  final double glassOpacity;
  final double blur;
  final double strokeWidth;
  final Color strokeColor;
  final Color unselectedColor;

  NavBarTheme({
    required this.activeColor,
    required this.glassOpacity,
    required this.blur,
    required this.strokeWidth,
    required this.strokeColor,
    required this.unselectedColor,
  });

  @override
  NavBarTheme copyWith({
    Color? activeColor,
    double? glassOpacity,
    double? blur,
    double? strokeWidth,
    Color? strokeColor,
    Color? unselectedColor,
  }) {
    return NavBarTheme(
      activeColor: activeColor ?? this.activeColor,
      glassOpacity: glassOpacity ?? this.glassOpacity,
      blur: blur ?? this.blur,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeColor: strokeColor ?? this.strokeColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
    );
  }

  @override
  NavBarTheme lerp(ThemeExtension<NavBarTheme>? other, double t) {
    if (other is! NavBarTheme) return this;
    return NavBarTheme(
      activeColor: Color.lerp(activeColor, other.activeColor, t) ?? activeColor,
      glassOpacity: _lerpDouble(glassOpacity, other.glassOpacity, t),
      blur: _lerpDouble(blur, other.blur, t),
      strokeWidth: _lerpDouble(strokeWidth, other.strokeWidth, t),
      strokeColor: Color.lerp(strokeColor, other.strokeColor, t) ?? strokeColor,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t) ?? unselectedColor,
    );
  }

  double _lerpDouble(double? a, double? b, double t) {
    final start = a ?? 0.0;
    final end = b ?? 0.0;
    return start + (end - start) * t;
  }
}

