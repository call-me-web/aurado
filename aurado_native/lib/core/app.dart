import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';
import 'theme/aurado_theme.dart';
import 'theme/theme_provider.dart';

/// Root widget of the Aurado app.
///
/// Wrapped in [ProviderScope] to enable Riverpod across the tree.
/// Theme is dynamically rebuildable when [ThemeState] changes (tenant theming).
class AuradoApp extends ConsumerWidget {
  const AuradoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the active theme state from Riverpod
    final themeState = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Aurado',
      debugShowCheckedModeBanner: false,
      theme: AuradoTheme.light(state: themeState),
      darkTheme: AuradoTheme.dark(state: themeState),
      themeMode: themeState.themeMode,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
