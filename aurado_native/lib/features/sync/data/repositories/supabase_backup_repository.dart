import 'dart:convert';
import 'dart:typed_data';

import 'package:aurado/core/local_storage/drift_database.dart';
import 'package:aurado/features/sync/domain/repositories/backup_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBackupRepository implements BackupRepository {
  final AppDatabase _db;
  final SupabaseClient _supabase;

  static const String _backupBucket = 'backups';

  SupabaseBackupRepository(this._db, this._supabase);

  @override
  Future<void> createBackup(String studentId) async {
    // 1. Serialize all relevant tables
    final state = {
      'topicMastery': await _db.select(_db.localTopicMastery).get(),
      'reviewQueue': await _db.select(_db.localSmartReviewQueue).get(),
      'dailySummary': await _db.select(_db.localDailyLearningSummary).get(),
      'bookmarks': await _db.select(_db.localStudentBookmarks).get(),
      'notes': await _db.select(_db.localStudentNotes).get(),
      'lessonMastery': await _db.select(_db.localLessonMastery).get(),
    };

    final jsonData = jsonEncode(state);

    // 2. Encrypt the data
    final key = await _getOrCreateEncryptionKey(studentId);
    final iv = enc.IV.fromLength(16);
    final encrypter = enc.Encrypter(enc.AES(key));

    final encrypted = encrypter.encrypt(jsonData, iv: iv);
    
    // Combine IV and Encrypted data for storage
    final combined = Uint8List.fromList(iv.bytes + encrypted.bytes);

    // 3. Upload to Supabase Storage
    await _supabase.storage.from('backups').uploadBinary(
      '$studentId/state.bin',
      combined,
      fileOptions: const FileOptions(upsert: true),
    );
  }

  @override
  Future<void> restoreBackup(String studentId) async {
    // 1. Download from Supabase
    final bytes = await _supabase.storage.from(_backupBucket).download('$studentId/state.bin');
    
    if (bytes.length < 16) throw Exception('Invalid backup file');

    // 2. Decrypt
    final iv = enc.IV(bytes.sublist(0, 16));
    final encryptedBytes = bytes.sublist(16);
    
    final key = await _getOrCreateEncryptionKey(studentId);
    final encrypter = enc.Encrypter(enc.AES(key));

    final decryptedJson = encrypter.decrypt(enc.Encrypted(encryptedBytes), iv: iv);
    final Map<String, dynamic> state = jsonDecode(decryptedJson);

    // 3. Restore to Drift (Transactionally)
    await _db.transaction(() async {
      // Clear existing data (optional but safer for clean state)
      // Note: In real scenarios, we might want to merge, but for "Restore", overwrite is common.
      
      if (state.containsKey('topicMastery')) {
        await _db.delete(_db.localTopicMastery).go();
        for (var item in state['topicMastery']) {
          await _db.into(_db.localTopicMastery).insert(LocalTopicMasteryData.fromJson(item));
        }
      }
      
      if (state.containsKey('reviewQueue')) {
        await _db.delete(_db.localSmartReviewQueue).go();
        for (var item in state['reviewQueue']) {
          await _db.into(_db.localSmartReviewQueue).insert(LocalSmartReviewQueueData.fromJson(item));
        }
      }

      if (state.containsKey('dailySummary')) {
        await _db.delete(_db.localDailyLearningSummary).go();
        for (var item in state['dailySummary']) {
          await _db.into(_db.localDailyLearningSummary).insert(LocalDailyLearningSummaryData.fromJson(item));
        }
      }

      if (state.containsKey('bookmarks')) {
        await _db.delete(_db.localStudentBookmarks).go();
        for (var item in state['bookmarks']) {
          await _db.into(_db.localStudentBookmarks).insert(LocalStudentBookmark.fromJson(item));
        }
      }

      if (state.containsKey('notes')) {
        await _db.delete(_db.localStudentNotes).go();
        for (var item in state['notes']) {
          await _db.into(_db.localStudentNotes).insert(LocalStudentNote.fromJson(item));
        }
      }

      if (state.containsKey('lessonMastery')) {
        await _db.delete(_db.localLessonMastery).go();
        for (var item in state['lessonMastery']) {
          await _db.into(_db.localLessonMastery).insert(LocalLessonMasteryData.fromJson(item));
        }
      }
    });
  }

  @override
  Future<bool> hasBackup(String studentId) async {
    try {
      final list = await _supabase.storage.from(_backupBucket).list(path: studentId);
      return list.any((file) => file.name == 'state.bin');
    } catch (e) {
      return false;
    }
  }

  Future<enc.Key> _getOrCreateEncryptionKey(String studentId) async {
    // For cross-device sync without a shared secret/password, we need a way to share the key.
    // Simple approach: Derive from studentId + a secret (not ideal but better than plain text)
    // Professional approach: Store an encrypted backup key in Supabase profile, reachable by user token.
    
    // For this MVP, we will derive it from the studentId salted with a server-side constant if possible,
    // or store it in the user's secure storage and sync it via Supabase metadata.
    
    // Let's use a deterministic derivation for cross-device consistency for now:
    final salt = "aurado_v1_secret_salt";
    final bytes = utf8.encode(studentId + salt);
    final digest = sha256.convert(bytes);
    
    return enc.Key(Uint8List.fromList(digest.bytes));
  }
}
