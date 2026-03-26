import 'package:aurado/core/local_storage/drift_database.dart';
import 'package:aurado/features/sync/domain/repositories/sync_repository.dart';
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SyncRepositoryImpl implements SyncRepository {
  final AppDatabase _db;
  final SupabaseClient _supabase;

  SyncRepositoryImpl(this._db, this._supabase);

  @override
  Future<void> syncLocalAnalytics() async {
    // 1. Fetch unsynced mastery summaries
    final unsynced = await (_db.select(_db.localLessonMastery)
          ..where((t) => t.isSynced.equals(false)))
        .get();

    if (unsynced.isEmpty) {
      return;
    }

    for (final row in unsynced) {
      try {
        // 2. Push to Supabase RPC
        await _supabase.rpc('sync_lesson_mastery', params: {
          'p_student_id': row.studentId,
          'p_lesson_id': row.lessonId,
          'p_tenant_id': row.tenantId,
          'p_watch_pct': row.watchPercentage,
          'p_struggle_score': row.struggleScore,
          'p_mastery_score': row.masteryScore,
          'p_session_time': 0, // session_time is calculated per sync session if needed
        });

        // 3. Mark as synced locally
        await (_db.update(_db.localLessonMastery)
              ..where((t) => t.lessonId.equals(row.lessonId)))
            .write(const LocalLessonMasteryCompanion(isSynced: Value(true)));
            
      } catch (e) {
        // Silently continue for individual sync failures
      }
    }
  }

  @override
  Future<void> performCleanup() async {
    // Purge micro-events older than 24 hours that are already processed
    // For now, simple purge of all micro-events to keep database lightweight
    // as per "Minimal Footprint" policy.
    await _db.delete(_db.localLearningEvents).go();
  }
}
