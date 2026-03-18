import 'package:aurado/core/di/service_locator.dart';
import 'package:aurado/features/sync/domain/repositories/sync_repository.dart';
import 'package:aurado/features/sync/domain/repositories/backup_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

/// The entry point for background tasks. 
/// Must be a top-level function for Workmanager to find it.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    debugPrint('BG_SYNC: Task started - $task');
    
    try {
      // 1. Re-initialize dependencies for the new isolate.
      // We wrap it in a try-catch to ensure the isolate doesn't crash silently.
      await initDependencies();
      
      final syncRepo = sl<SyncRepository>();
      
      // 2. Perform the sync
      await syncRepo.syncLocalAnalytics();
      
      // 3. Perform cleanup
      await syncRepo.performCleanup();
      
      // 4. Create a secure backup
      final studentId = sl<SupabaseClient>().auth.currentUser?.id;
      if (studentId != null) {
        await sl<BackupRepository>().createBackup(studentId);
        debugPrint('BG_SYNC: Backup created successfully.');
      }
      
      debugPrint('BG_SYNC: Task completed successfully.');
      return true;
    } catch (e, stack) {
      debugPrint('BG_SYNC ERROR: $e');
      debugPrint('BG_SYNC STACK: $stack');
      return false;
    }
  });
}

class SyncEngine {
  static const String periodicSyncTask = "com.aurado.periodic_sync";
  static const String immediateSyncTask = "com.aurado.immediate_sync";

  /// Initializes the Workmanager with the callback dispatcher.
  static Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
    );
    debugPrint('BG_SYNC: Workmanager initialized.');
  }

  /// Schedules a periodic sync task.
  /// This runs every 6 hours if network is available.
  static Future<void> schedulePeriodicSync() async {
    await Workmanager().registerPeriodicTask(
      "aurado_daily_sync",
      periodicSyncTask,
      frequency: const Duration(hours: 6),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
    debugPrint('BG_SYNC: Periodic task scheduled.');
  }

  /// Manually triggers an immediate background sync.
  static Future<void> triggerImmediateSync() async {
    await Workmanager().registerOneOffTask(
      DateTime.now().millisecondsSinceEpoch.toString(),
      immediateSyncTask,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }
}
