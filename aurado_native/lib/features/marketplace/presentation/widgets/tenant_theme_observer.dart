import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/tenant_model.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../providers/marketplace_provider.dart';

/// A widget that observes a tenant's branding data and applies it to the app theme.
///
/// When initialized with a [tenantId], it watches the branding data.
/// Once the data is loaded, it updates the [themeProvider].
/// When the widget is disposed, it resets the theme to defaults.
class TenantThemeObserver extends ConsumerStatefulWidget {
  final String tenantId;
  final Widget child;

  const TenantThemeObserver({
    super.key,
    required this.tenantId,
    required this.child,
  });

  @override
  ConsumerState<TenantThemeObserver> createState() => _TenantThemeObserverState();
}

class _TenantThemeObserverState extends ConsumerState<TenantThemeObserver> {
  @override
  void dispose() {
    // Reset theme when leaving the tenant context.
    // Use Future.microtask to avoid modifying state during dispose if needed,
    // though ref.read is generally safe here.
    Future.microtask(() {
      if (mounted) {
        ref.read(themeProvider.notifier).resetTheme();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the tenant data (which now includes branding).
    final tenantAsync = ref.watch(tenantProvider(widget.tenantId));

    return tenantAsync.when(
      data: (tenant) {
        if (tenant != null) {
          _updateTheme(tenant);
        }
        return widget.child;
      },
      loading: () => widget.child, // Keep showing the child (likely a loader in the child)
      error: (e, s) => widget.child, // Fallback to default theme on error
    );
  }

  void _updateTheme(TenantModel tenant) {
    // Schedule the update for the next frame to avoid "build phase" modification errors.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final primaryColor = _parseColor(tenant.colorButton);
      final backgroundColor = _parseColor(tenant.colorBackground);
      final cardColor = _parseColor(tenant.colorCard);
      
      ref.read(themeProvider.notifier).updateTheme(
            primaryColor: primaryColor,
            // Assuming we use background color for secondary/surface in the future
            secondaryColor: primaryColor?.withValues(alpha: 0.8),
            backgroundColor: backgroundColor,
            cardColor: cardColor,
          );
    });
  }

  Color? _parseColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) return null;
    try {
      final hex = hexColor.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (e) {
      return null;
    }
  }
}
