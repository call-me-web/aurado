import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:aurado/features/auth/presentation/auth_screen.dart';
import 'package:aurado/features/auth/providers/auth_provider.dart';
import 'package:aurado/features/onboarding/presentation/role_selection_screen.dart';
import 'package:aurado/features/onboarding/presentation/splash_screen.dart';
import 'package:aurado/features/onboarding/presentation/onboarding_slides_screen.dart';
import 'package:aurado/features/onboarding/presentation/personalization_screen.dart';
import 'package:aurado/features/onboarding/providers/onboarding_provider.dart';
import 'package:aurado/features/home/presentation/home_screen.dart';
import 'package:aurado/features/marketplace/presentation/discover_courses_screen.dart';
import 'package:aurado/features/profile/presentation/screens/profile_screen.dart';
import 'package:aurado/features/marketplace/presentation/pages/tenant_context/platform_home_screen.dart';
import 'package:aurado/features/marketplace/presentation/pages/tenant_context/course_detail_screen.dart';
import 'package:aurado/features/marketplace/presentation/pages/tenant_context/curriculum_screen.dart';
import 'package:aurado/features/marketplace/presentation/pages/tenant_context/lesson_player_screen.dart';
import 'package:aurado/features/marketplace/presentation/pages/tenant_context/leaderboard_screen.dart';
import 'scaffold_with_nav_bar.dart';

/// Centralized route name constants — avoids hardcoded path strings.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String personalization = '/personalization';
  static const String roleSelection = '/role-selection';
  static const String auth = '/auth';
  static const String login = '/login';
  static const String otpVerify = '/otp-verify';
  static const String shell = '/app';
  static const String home = '/app/home';
  static const String discoverCourses = '/app/discover-courses';
  static const String myCourses = '/app/my-courses';
  static const String library = '/app/library';
  static const String profile = '/app/profile';
  static const String platform = '/platform/:tenantId';
  static const String courseDetail = '/platform/:tenantId/course/:courseId';
  static const String curriculum =
      '/platform/:tenantId/course/:courseId/curriculum';
  static const String lesson =
      '/platform/:tenantId/course/:courseId/lesson/:lessonId';
  static const String leaderboard = '/platform/:tenantId/leaderboard';
  static const String exam = '/platform/:tenantId/exam/:examId';
  static const String notifications = '/notifications';
}

/// A [Listenable] that reacts to all providers that should trigger a redirect.
class RouterRefreshListenable extends ChangeNotifier {
  RouterRefreshListenable(Ref ref) {
    // We use ref.listen to trigger notifyListeners whenever the state changes.
    // This is safe to call in the constructor if used within a Provider.
    ref.listen(authProvider, (previous, next) => notifyListeners());
    ref.listen(onboardingProvider, (previous, next) => notifyListeners());
    ref.listen(personalizationProvider, (previous, next) => notifyListeners());
  }
}

/// A provider that creates the [RouterRefreshListenable].
final routerRefreshListenableProvider = Provider(
  (ref) => RouterRefreshListenable(ref),
);

/// Production GoRouter configuration provider.
final routerProvider = Provider<GoRouter>((ref) {
  // We watch the listenable to ensure the router is aware of changes,
  // but GoRouter itself handles the refresh internally via the refreshListenable property.
  final listenable = ref.watch(routerRefreshListenableProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: listenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isOnboardingCompleted = ref.read(onboardingProvider);
      final isPersonalizationCompleted = ref.read(personalizationProvider);

      final status = authState.status;
      final location = state.matchedLocation;

      debugPrint(
        'DEBUG: Router Redirect Logic - Location: $location, AuthStatus: $status',
      );

      // Screen categories
      final isSplash = location == AppRoutes.splash;
      final isRoleSelection = location == AppRoutes.roleSelection;
      final isAuth =
          location == AppRoutes.auth ||
          location == AppRoutes.login ||
          location == AppRoutes.otpVerify;
      final isOnboarding = location == AppRoutes.onboarding;
      final isPersonalization = location == AppRoutes.personalization;

      // 1. App is initializing
      if (status == AuthStatus.initial) {
        debugPrint('DEBUG: Router - AuthStatus is initial, staying put');
        return null;
      }

      // 2. Not logged in
      if (status == AuthStatus.unauthenticated) {
        debugPrint(
          'DEBUG: Router - Unauthenticated. isSplash: $isSplash, isAuth: $isAuth',
        );
        if (isSplash || isRoleSelection || isAuth) return null;
        debugPrint('DEBUG: Router - Redirecting to Auth');
        return AppRoutes.auth;
      }

      // 3. Logged in
      if (status == AuthStatus.authenticated) {
        debugPrint(
          'DEBUG: Router - Authenticated. Onboarding: $isOnboardingCompleted, Personalization: $isPersonalizationCompleted',
        );

        // Redirection logic for student journey
        if (isOnboardingCompleted == false) {
          if (isOnboarding) return null;
          return AppRoutes.onboarding;
        }

        if (isPersonalizationCompleted == false) {
          if (isPersonalization) return null;
          return AppRoutes.personalization;
        }

        // If everything is done, but they are on gatekeeper screens, send to home
        if (isSplash ||
            isRoleSelection ||
            isAuth ||
            isOnboarding ||
            isPersonalization) {
          return AppRoutes.home;
        }

        return null;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.roleSelection,
        name: 'roleSelection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingSlidesScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: AppRoutes.personalization,
        name: 'personalization',
        builder: (context, state) => const PersonalizationScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.otpVerify,
        name: 'otpVerify',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.shell,
        redirect: (context, state) => AppRoutes.home,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.discoverCourses,
                name: 'discoverCourses',
                builder: (context, state) => const DiscoverCoursesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.myCourses,
                name: 'myCourses',
                builder: (context, state) =>
                    const _PlaceholderPage(label: 'My Courses'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.library,
                name: 'library',
                builder: (context, state) =>
                    const _PlaceholderPage(label: 'library'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.platform,
        name: 'platform',
        builder: (context, state) {
          final tenantId = state.pathParameters['tenantId']!;
          return PlatformHomeScreen(tenantId: tenantId);
        },
      ),
      GoRoute(
        path: AppRoutes.courseDetail,
        name: 'courseDetail',
        builder: (context, state) {
          final tenantId = state.pathParameters['tenantId']!;
          final courseId = state.pathParameters['courseId']!;
          return CourseDetailScreen(tenantId: tenantId, courseId: courseId);
        },
      ),
      GoRoute(
        path: AppRoutes.curriculum,
        name: 'curriculum',
        builder: (context, state) {
          final tenantId = state.pathParameters['tenantId']!;
          final courseId = state.pathParameters['courseId']!;
          return CurriculumScreen(tenantId: tenantId, courseId: courseId);
        },
      ),
      GoRoute(
        path: AppRoutes.lesson,
        name: 'lesson',
        builder: (context, state) {
          final tenantId = state.pathParameters['tenantId']!;
          final courseId = state.pathParameters['courseId']!;
          final lessonId = state.pathParameters['lessonId']!;
          return LessonPlayerScreen(
            tenantId: tenantId,
            courseId: courseId,
            lessonId: lessonId,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.leaderboard,
        name: 'leaderboard',
        builder: (context, state) {
          final tenantId = state.pathParameters['tenantId']!;
          return LeaderboardScreen(tenantId: tenantId);
        },
      ),
    ],
  );
});

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(label, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
