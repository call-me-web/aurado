import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app.dart';
import 'core/di/service_locator.dart';
import 'core/sync/sync_engine.dart';
import 'features/onboarding/providers/onboarding_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('CRITICAL ERROR: ${details.exception}');
    debugPrint('STACK TRACE: ${details.stack}');
  };

  // ── Load environment variables ────────────────────────────
  await dotenv.load(fileName: '.env');

  // ── Prevent landscape on phones ──────────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ── System UI dark overlay ────────────────────────────────
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0D0D12),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // ── Initialize all dependencies (Supabase, DI) ───────────
  debugPrint('DEBUG: Starting initDependencies...');
  await initDependencies();
  debugPrint('DEBUG: initDependencies completed.');

  // ── Sync Engine Initialization ───────────────────────────
  await SyncEngine.initialize();
  await SyncEngine.schedulePeriodicSync();
  debugPrint('DEBUG: SyncEngine initialized.');
  
  debugPrint('DEBUG: Fetching SharedPreferences...');
  final prefs = await SharedPreferences.getInstance();
  debugPrint('DEBUG: SharedPreferences fetched.');

  runApp(
    // ProviderScope is the root for Riverpod state management
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const AuradoApp(),
    ),
  );
}
