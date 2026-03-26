import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:aurado/features/auth/data/repositories/supabase_auth_repository.dart';
import 'package:aurado/features/auth/domain/repositories/auth_repository.dart';
import 'package:aurado/features/sync/domain/repositories/sync_repository.dart';
import 'package:aurado/features/sync/data/repositories/sync_repository_impl.dart';
import 'package:aurado/core/constants/app_constants.dart';
import 'package:aurado/features/home/domain/repositories/dashboard_repository.dart';
import 'package:aurado/features/home/data/repositories/drift_dashboard_repository.dart';
import 'package:aurado/core/network/dio_client.dart';
import 'package:aurado/core/network/network_info.dart';
import 'package:aurado/features/learning/domain/repositories/intelligence_repository.dart';
import 'package:aurado/features/learning/data/repositories/drift_intelligence_repository.dart';
import 'package:aurado/features/sync/domain/repositories/backup_repository.dart';
import 'package:aurado/features/sync/data/repositories/supabase_backup_repository.dart';
import 'package:aurado/features/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:aurado/features/marketplace/data/repositories/supabase_marketplace_repository.dart';
import 'package:aurado/features/learning/domain/repositories/curriculum_repository.dart';
import 'package:aurado/features/learning/data/repositories/supabase_curriculum_repository.dart';
import 'package:aurado/features/exams/domain/repositories/exam_repository.dart';
import 'package:aurado/features/exams/data/repositories/supabase_exam_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:aurado/core/local_storage/drift_database.dart';
import 'package:aurado/core/network/signed_url_resolver.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

/// Initializes Supabase and registers all services into [sl].
///
/// Call this once in [main] before [runApp].
Future<void> initDependencies() async {
  // ── Validation ──────────────────────────────────────────
  if (AppConstants.supabaseUrl.isEmpty || AppConstants.supabaseAnonKey.isEmpty) {
    debugPrint('❌ ERROR: Missing Supabase credentials!');
    debugPrint('Run with: flutter run --dart-define-from-file=.env');
    debugPrint('Or use: make run');
    // In debug mode, throw a clear error to prevent cryptic downstream crashes
    if (kDebugMode) throw Exception('AppConstants.supabaseUrl is EMPTY. Injected values missing.');
  }

  // ── Supabase ─────────────────────────────────────────────
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // ── Core Utilities ────────────────────────────────────────
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<SignedUrlResolver>(() => SignedUrlResolver(sl<DioClient>().instance, sl<SupabaseClient>()));
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  // ── Database ─────────────────────────────────────────────
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // --- Sync Repository ---
  sl.registerLazySingleton<SyncRepository>(
    () => SyncRepositoryImpl(sl<AppDatabase>(), Supabase.instance.client),
  );
  sl.registerLazySingleton<BackupRepository>(
    () => SupabaseBackupRepository(sl<AppDatabase>(), sl<SupabaseClient>()),
  );

  // --- Learning / Intelligence ---
  sl.registerLazySingleton<IntelligenceRepository>(
    () => DriftIntelligenceRepository(sl<AppDatabase>()),
  );

  // --- Home / Dashboard ---
  sl.registerLazySingleton<DashboardRepository>(
    () => DriftDashboardRepository(sl<AppDatabase>()),
  );

  sl.registerLazySingleton<MarketplaceRepository>(
    () => SupabaseMarketplaceRepository(sl<SupabaseClient>(), sl<DioClient>().instance),
  );

  sl.registerLazySingleton<CurriculumRepository>(
    () => SupabaseCurriculumRepository(sl<SupabaseClient>()),
  );
  
  sl.registerLazySingleton<ExamRepository>(
    () => SupabaseExamRepository(sl<SupabaseClient>()),
  );

  _registerAuth();
}

void _registerAuth() {
  sl.registerLazySingleton<AuthRepository>(
    () => SupabaseAuthRepository(sl<SupabaseClient>()),
  );
}
