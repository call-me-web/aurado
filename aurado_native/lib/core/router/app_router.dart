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
import 'package:aurado/features/exams/presentation/pages/mcq_screen.dart';
import 'package:aurado/features/exams/presentation/pages/cq_screen.dart';
import 'package:aurado/features/marketplace/presentation/my_courses_screen.dart';
import 'scaffold_with_nav_bar.dart';
import 'course_context_shell.dart';
import 'package:aurado/features/marketplace/presentation/pages/tenant_context/course_overview_screen.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';

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
  static const String courseBase = '/platform/:tenantId/course/:courseId';
  static const String courseOverview =
      '/platform/:tenantId/course/:courseId/overview';
  static const String courseContent =
      '/platform/:tenantId/course/:courseId/content';
  static const String courseLeaderboard =
      '/platform/:tenantId/course/:courseId/leaderboard';
  static const String courseProgress =
      '/platform/:tenantId/course/:courseId/progress';
  static const String academyProfile =
      '/platform/:tenantId/course/:courseId/academy';
  static const String courseDetails =
      '/app/discover-courses/details/:tenantId/:courseId';
  static const String lesson =
      '/platform/:tenantId/course/:courseId/lesson/:lessonId';
  static const String mcq = '/platform/:tenantId/exam/:examId/mcq';
  static const String cq = '/platform/:tenantId/exam/:examId/cq';
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
    ref.listen(enrolledCoursesProvider, (previous, next) => notifyListeners());
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
                routes: [
                  GoRoute(
                    path: 'details/:tenantId/:courseId',
                    name: 'courseDetails',
                    builder: (context, state) {
                      debugPrint('===== ROUTER: building courseDetails route for ${state.matchedLocation} =====');
                      final tenantId = state.pathParameters['tenantId'] ?? '';
                      final courseId = state.pathParameters['courseId'] ?? '';
                      return CourseDetailScreen(
                        tenantId: tenantId,
                        courseId: courseId,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.myCourses,
                name: 'myCourses',
                builder: (context, state) => const MyCoursesScreen(),
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
          final tenantId = state.pathParameters['tenantId'] ?? '';
          return PlatformHomeScreen(tenantId: tenantId);
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          final tenantId = state.pathParameters['tenantId'] ?? '';
          final courseId = state.pathParameters['courseId'] ?? '';
          return CourseContextShell(
            child: child,
            tenantId: tenantId,
            courseId: courseId,
            location: state.matchedLocation,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.courseBase,
            redirect: (context, state) => _checkCourseEnrollment(ref, state),
            builder: (context, state) => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.courseOverview,
            name: 'courseOverview',
            redirect: (context, state) => _checkCourseEnrollment(ref, state),
            builder: (context, state) {
              final tenantId = state.pathParameters['tenantId'] ?? '';
              final courseId = state.pathParameters['courseId'] ?? '';
              return CourseOverviewScreen(
                tenantId: tenantId,
                courseId: courseId,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.courseContent,
            name: 'courseContent',
            redirect: (context, state) => _checkCourseEnrollment(ref, state),
            builder: (context, state) {
              final tenantId = state.pathParameters['tenantId'] ?? '';
              final courseId = state.pathParameters['courseId'] ?? '';
              return CurriculumScreen(
                tenantId: tenantId,
                courseId: courseId,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.courseLeaderboard,
            name: 'courseLeaderboard',
            redirect: (context, state) => _checkCourseEnrollment(ref, state),
            builder: (context, state) {
              final tenantId = state.pathParameters['tenantId'] ?? '';
              return LeaderboardScreen(tenantId: tenantId);
            },
          ),
          GoRoute(
            path: AppRoutes.courseProgress,
            name: 'courseProgress',
            redirect: (context, state) => _checkCourseEnrollment(ref, state),
            builder: (context, state) =>
                const _PlaceholderPage(label: 'Course Progress'),
          ),
          GoRoute(
            path: AppRoutes.academyProfile,
            name: 'academyProfile',
            redirect: (context, state) => _checkCourseEnrollment(ref, state),
            builder: (context, state) {
              final tenantId = state.pathParameters['tenantId'] ?? '';
              return PlatformHomeScreen(tenantId: tenantId);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.lesson,
        name: 'lesson',
        redirect: (context, state) => _checkCourseEnrollment(ref, state),
        builder: (context, state) {
          final tenantId = state.pathParameters['tenantId'] ?? '';
          final courseId = state.pathParameters['courseId'] ?? '';
          final lessonId = state.pathParameters['lessonId'] ?? '';
          return LessonPlayerScreen(
            tenantId: tenantId,
            courseId: courseId,
            lessonId: lessonId,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.mcq,
        name: 'mcq',
        builder: (context, state) {
          final examId = state.pathParameters['examId'] ?? '';
          return McqScreen(examId: examId);
        },
      ),
      GoRoute(
        path: AppRoutes.cq,
        name: 'cq',
        builder: (context, state) {
          final examId = state.pathParameters['examId'] ?? '';
          return CqScreen(examId: examId);
        },
      ),
    ],
  );
});

String? _checkCourseEnrollment(Ref ref, GoRouterState state) {
  debugPrint('===== ROUTER REDIRECT: _checkCourseEnrollment STARTED for ${state.matchedLocation} =====');
  final tenantId = state.pathParameters['tenantId'];
  final courseId = state.pathParameters['courseId'];

  if (tenantId == null || courseId == null) {
     debugPrint('===== ROUTER REDIRECT: tenantId or courseId is null =====');
     return null;
  }

  final enrolledCoursesAsync = ref.read(enrolledCoursesProvider);

  // If we are still loading, don't redirect yet to avoid kicking enrolled users out
  if (enrolledCoursesAsync.isLoading) {
    debugPrint('===== ROUTER REDIRECT: enrolledCoursesAsync is loading. Returning null =====');
    return null;
  }

  final enrolledCourses = enrolledCoursesAsync.asData?.value ?? [];
  final isEnrolled = enrolledCourses.any((c) => c.id == courseId);
  
  debugPrint('===== ROUTER REDIRECT: isEnrolled=$isEnrolled =====');

  if (!isEnrolled) {
    debugPrint('===== ROUTER REDIRECT: NOT enrolled. Redirecting to details screen =====');
    return '/app/discover-courses/details/$tenantId/$courseId';
  }

  // If they are on the base path and enrolled, send to overview
  if (state.matchedLocation == AppRoutes.courseBase) {
    debugPrint('===== ROUTER REDIRECT: Enrolled and on base path. Redirecting to overview =====');
    return '/platform/$tenantId/course/$courseId/overview';
  }

  return null;
}

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
