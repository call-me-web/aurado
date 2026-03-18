abstract class BackupRepository {
  /// Creates a secure backup of the local learning state and uploads it to the cloud.
  Future<void> createBackup(String studentId);

  /// Downloads and restores the learning state from a cloud backup.
  Future<void> restoreBackup(String studentId);

  /// Checks if a backup exists in the cloud.
  Future<bool> hasBackup(String studentId);
}
