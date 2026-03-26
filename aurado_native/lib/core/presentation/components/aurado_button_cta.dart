import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:aurado/core/theme/theme_config.dart';

enum AuradoButtonVariant {
  filled,
  outlined,
  text,
}

enum AuradoButtonSize {
  small,
  medium,
  large,
}

/// A universal call-to-action button component for the Aurado application.
/// 
/// Honors [ThemeConfig] for colors, radii, and spacing.
class AuradoButton_cta extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AuradoButtonVariant variant;
  final AuradoButtonSize size;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? borderRadius;

  const AuradoButton_cta({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AuradoButtonVariant.filled,
    this.size = AuradoButtonSize.medium,
    this.prefixIcon,
    this.suffixIcon,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine dimensions based on size
    double height;
    double fontSize;
    double iconSize;
    EdgeInsets padding;

    switch (size) {
      case AuradoButtonSize.small:
        height = 36.0;
        fontSize = 12.0;
        iconSize = 16.0;
        padding = const EdgeInsets.symmetric(horizontal: 16.0);
        break;
      case AuradoButtonSize.medium:
        height = 48.0;
        fontSize = 14.0;
        iconSize = 20.0;
        padding = const EdgeInsets.symmetric(horizontal: 20.0);
        break;
      case AuradoButtonSize.large:
        height = 56.0;
        fontSize = 16.0;
        iconSize = 24.0;
        padding = const EdgeInsets.symmetric(horizontal: 24.0);
        break;
    }

    final effectiveColor = color ?? colorScheme.primary;
    final effectiveTextColor = textColor ?? (variant == AuradoButtonVariant.filled ? Colors.white : effectiveColor);
    final radius = borderRadius ?? ThemeConfig.radiusMd;

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            height: iconSize,
            width: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
            ),
          ),
          const Gap(8),
        ] else ...[
          if (prefixIcon != null) ...[
            Icon(prefixIcon, size: iconSize, color: effectiveTextColor),
            const Gap(8),
          ],
        ],
        Text(
          text,
          style: theme.textTheme.labelLarge?.copyWith(
            color: effectiveTextColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        if (!isLoading && suffixIcon != null) ...[
          const Gap(8),
          Icon(suffixIcon, size: iconSize, color: effectiveTextColor),
        ],
      ],
    );

    return SizedBox(
      width: width,
      height: height,
      child: _buildButton(
        onPressed: isLoading ? null : onPressed,
        radius: radius,
        effectiveColor: effectiveColor,
        effectiveTextColor: effectiveTextColor,
        padding: padding,
        child: content,
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback? onPressed,
    required double radius,
    required Color effectiveColor,
    required Color effectiveTextColor,
    required EdgeInsets padding,
    required Widget child,
  }) {
    switch (variant) {
      case AuradoButtonVariant.filled:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: effectiveColor,
            foregroundColor: effectiveTextColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: padding,
          ),
          child: child,
        );
      case AuradoButtonVariant.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: effectiveTextColor,
            side: BorderSide(color: effectiveColor, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: padding,
          ),
          child: child,
        );
      case AuradoButtonVariant.text:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: effectiveTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: padding,
          ),
          child: child,
        );
    }
  }
}
