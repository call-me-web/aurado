import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/ui_extensions.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/router/app_router.dart';

/// Simplified Splash Screen. 
/// 
/// Shows the brand logo and transitions to Auth or Home once initialization is complete.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // Fallback: If for some reason the router redirect doesn't fire after 3 seconds,
    // and we're still on splash, check if we should move to Auth.
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && GoRouterState.of(context).matchedLocation == AppRoutes.splash) {
        final authState = ref.read(authProvider);
        if (authState.status == AuthStatus.unauthenticated) {
          debugPrint('DEBUG: SplashScreen - Fallback redirect to /auth');
          context.go(AppRoutes.auth);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Note: Navigation is handled by routerProvider's redirect logic 
    // based on the AuthStatus. We just show the brand here.
    
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D12), // Dark Slate/Black
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aurado Brand Moment
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              ),
              child: Icon(
                Icons.school_rounded,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            24.heightBox,
            Text(
              'AURADO',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8.0,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
