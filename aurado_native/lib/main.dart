import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/app.dart';
import 'core/di/service_locator.dart';
import 'core/sync/sync_engine.dart';
import 'features/onboarding/providers/onboarding_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ── Load Environment Variables ───────────────────────────
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint('DOTENV LOAD FAILURE: $e');
  }
  
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('CRITICAL ERROR: ${details.exception}');
    debugPrint('STACK TRACE: ${details.stack}');
  };

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
  try {
    await initDependencies();
    await SyncEngine.initialize();
    await SyncEngine.schedulePeriodicSync();
  } catch (e) {
    debugPrint('BOOTSTRAP FAILURE: $e');
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0D12),
      ),
      home: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0D0D12),
                Color(0xFF17171F),
                Color(0xFF0D0D12),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Animated-like Icon Header ──────────────────────
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5252).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFF5252).withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    color: Color(0xFFFF5252),
                    size: 80,
                  ),
                ),
                const SizedBox(height: 48),

                // ── Title ──────────────────────────────────────────
                const Text(
                  'Security Lockdown',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),

                // ── Subtitle ───────────────────────────────────────
                const Text(
                  'Environment credentials are missing or invalid.\nTo protect sensitive keys, the app requires secure injection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF6B6B80),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),

                // ── Action Card ────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'RESOLUTION',
                        style: TextStyle(
                          color: Color(0xFF5F6898),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Run the following command in your terminal:',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.terminal, color: Color(0xFF4CAF50), size: 18),
                            SizedBox(width: 12),
                            Text(
                              'flutter run',
                              style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // ── Tip ────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: const Color(0xFF5F6898).withValues(alpha: 0.8),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Tip: Ensure your .env file is present in root.',
                      style: TextStyle(
                        color: const Color(0xFF6B6B80).withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
    return;
  }
  
  final prefs = await SharedPreferences.getInstance();

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
