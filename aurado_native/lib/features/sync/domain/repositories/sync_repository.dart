abstract class SyncRepository {
  /// Synchronizes local summarized progress with Supabase.
  /// 
  /// Fetches non-synced data from Drift and calls Supabase RPCs.
  Future<void> syncLocalAnalytics();
  
  /// Performs cleanup of synced micro-events and old records.
  Future<void> performCleanup();
}
