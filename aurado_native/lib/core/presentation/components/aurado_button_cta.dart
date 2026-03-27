import 'dart:ui';
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
        context: context,
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
    required BuildContext context,
    required VoidCallback? onPressed,
    required double radius,
    required Color effectiveColor,
    required Color effectiveTextColor,
    required EdgeInsets padding,
    required Widget child,
  }) {
    switch (variant) {
      case AuradoButtonVariant.filled:
        final bool isDisabled = onPressed == null;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            boxShadow: isDisabled
                ? []
                : [
                    BoxShadow(
                      color: effectiveColor.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  highlightColor: Colors.white.withValues(alpha: 0.1),
                  splashColor: Colors.white.withValues(alpha: 0.2),
                  child: Container(
                    padding: padding,
                    decoration: BoxDecoration(
                      color: isDisabled
                          ? Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                          : effectiveColor.withValues(alpha: 0.65), // Translucent fill
                      border: Border.all(
                        color: Colors.white.withValues(alpha: isDisabled ? 0.1 : 0.25),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(radius),
                      gradient: isDisabled
                          ? null
                          : LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withValues(alpha: 0.25),
                                effectiveColor.withValues(alpha: 0.1),
                                Colors.black.withValues(alpha: 0.15),
                              ],
                              stops: const [0.0, 0.4, 1.0],
                            ),
                    ),
                    alignment: Alignment.center,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
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
