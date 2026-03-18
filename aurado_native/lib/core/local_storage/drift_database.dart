import 'dart:io';

import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'drift_database.g.dart';

// --- Core Tracking Tables ---

class LocalLearningEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get studentId => text()();
  TextColumn get lessonId => text()();
  TextColumn get eventType => text()();
  IntColumn get positionSec => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get metadata => text().nullable()();
}

class LocalLessonMastery extends Table {
  TextColumn get lessonId => text()();
  TextColumn get studentId => text()();
  TextColumn get tenantId => text()();
  IntColumn get watchPercentage => integer().withDefault(const Constant(0))();
  IntColumn get lastPositionSec => integer().withDefault(const Constant(0))();
  RealColumn get struggleScore => real().withDefault(const Constant(0.0))();
  RealColumn get masteryScore => real().withDefault(const Constant(0.0))();
  DateTimeColumn get lastAccessedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {studentId, lessonId};
}

// --- Intelligence Tables (Phase 9) ---

class LocalTopicMastery extends Table {
  TextColumn get studentId => text()();
  TextColumn get topicType => text()(); // 'subject', 'chapter', 'lesson', 'concept'
  TextColumn get topicId => text()();
  TextColumn get topicTag => text()();
  
  IntColumn get totalAttempts => integer().withDefault(const Constant(0))();
  IntColumn get correctAttempts => integer().withDefault(const Constant(0))();
  RealColumn get speedScore => real().withDefault(const Constant(0.0))();
  RealColumn get masteryScore => real().withDefault(const Constant(0.0))();
  
  RealColumn get previousMasteryScore => real().nullable()();
  DateTimeColumn get lastAttemptedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {studentId, topicType, topicId};
}

class LocalSmartReviewQueue extends Table {
  TextColumn get studentId => text()();
  TextColumn get contentType => text()(); // 'lesson', 'mcq', 'cq', 'pdf'
  TextColumn get contentId => text()();
  TextColumn get topicTag => text().nullable()();

  IntColumn get intervalDays => integer().withDefault(const Constant(1))();
  RealColumn get easeFactor => real().withDefault(const Constant(2.5))();
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextReviewAt => dateTime()();
  
  RealColumn get priorityScore => real().withDefault(const Constant(0.0))();
  DateTimeColumn get lastReviewedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {studentId, contentType, contentId};
}

class LocalDailyLearningSummary extends Table {
  TextColumn get studentId => text()();
  DateTimeColumn get summaryDate => dateTime()();

  IntColumn get lessonsWatched => integer().withDefault(const Constant(0))();
  IntColumn get lessonsCompleted => integer().withDefault(const Constant(0))();
  IntColumn get questionsAttempted => integer().withDefault(const Constant(0))();
  IntColumn get minutesStudied => integer().withDefault(const Constant(0))();
  
  RealColumn get accuracyToday => real().withDefault(const Constant(0.0))();
  BoolColumn get streakMaintained => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {studentId, summaryDate};
}

class LocalStudentNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get studentId => text()();
  TextColumn get lessonId => text()();
  TextColumn get tenantId => text()();
  
  IntColumn get timestampSec => integer().nullable()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class LocalStudentBookmarks extends Table {
  TextColumn get studentId => text()();
  TextColumn get tenantId => text()();
  TextColumn get contentType => text()();
  TextColumn get contentId => text()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {studentId, contentType, contentId};
}

@DriftDatabase(tables: [
  LocalLearningEvents, 
  LocalLessonMastery,
  LocalTopicMastery,
  LocalSmartReviewQueue,
  LocalDailyLearningSummary,
  LocalStudentNotes,
  LocalStudentBookmarks,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.drop(localLessonMastery);
        await migrator.createTable(localLessonMastery);
      }
      if (from < 3) {
        await migrator.createTable(localTopicMastery);
        await migrator.createTable(localSmartReviewQueue);
        await migrator.createTable(localDailyLearningSummary);
        await migrator.createTable(localStudentNotes);
        await migrator.createTable(localStudentBookmarks);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'aurado_local.db'));

    final cachebase = await getTemporaryDirectory();
    sqlite3.tempDirectory = cachebase.path;

    return NativeDatabase.createInBackground(file);
  });
}
