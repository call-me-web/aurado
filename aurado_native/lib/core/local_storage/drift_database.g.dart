// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $LocalLearningEventsTable extends LocalLearningEvents
    with TableInfo<$LocalLearningEventsTable, LocalLearningEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalLearningEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionSecMeta = const VerificationMeta(
    'positionSec',
  );
  @override
  late final GeneratedColumn<int> positionSec = GeneratedColumn<int>(
    'position_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    lessonId,
    eventType,
    positionSec,
    createdAt,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_learning_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalLearningEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('position_sec')) {
      context.handle(
        _positionSecMeta,
        positionSec.isAcceptableOrUnknown(
          data['position_sec']!,
          _positionSecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_positionSecMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalLearningEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalLearningEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      positionSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position_sec'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
    );
  }

  @override
  $LocalLearningEventsTable createAlias(String alias) {
    return $LocalLearningEventsTable(attachedDatabase, alias);
  }
}

class LocalLearningEvent extends DataClass
    implements Insertable<LocalLearningEvent> {
  final int id;
  final String studentId;
  final String lessonId;
  final String eventType;
  final int positionSec;
  final DateTime createdAt;
  final String? metadata;
  const LocalLearningEvent({
    required this.id,
    required this.studentId,
    required this.lessonId,
    required this.eventType,
    required this.positionSec,
    required this.createdAt,
    this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<String>(studentId);
    map['lesson_id'] = Variable<String>(lessonId);
    map['event_type'] = Variable<String>(eventType);
    map['position_sec'] = Variable<int>(positionSec);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  LocalLearningEventsCompanion toCompanion(bool nullToAbsent) {
    return LocalLearningEventsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      lessonId: Value(lessonId),
      eventType: Value(eventType),
      positionSec: Value(positionSec),
      createdAt: Value(createdAt),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
    );
  }

  factory LocalLearningEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalLearningEvent(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<String>(json['studentId']),
      lessonId: serializer.fromJson<String>(json['lessonId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      positionSec: serializer.fromJson<int>(json['positionSec']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      metadata: serializer.fromJson<String?>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<String>(studentId),
      'lessonId': serializer.toJson<String>(lessonId),
      'eventType': serializer.toJson<String>(eventType),
      'positionSec': serializer.toJson<int>(positionSec),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'metadata': serializer.toJson<String?>(metadata),
    };
  }

  LocalLearningEvent copyWith({
    int? id,
    String? studentId,
    String? lessonId,
    String? eventType,
    int? positionSec,
    DateTime? createdAt,
    Value<String?> metadata = const Value.absent(),
  }) => LocalLearningEvent(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    lessonId: lessonId ?? this.lessonId,
    eventType: eventType ?? this.eventType,
    positionSec: positionSec ?? this.positionSec,
    createdAt: createdAt ?? this.createdAt,
    metadata: metadata.present ? metadata.value : this.metadata,
  );
  LocalLearningEvent copyWithCompanion(LocalLearningEventsCompanion data) {
    return LocalLearningEvent(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      positionSec: data.positionSec.present
          ? data.positionSec.value
          : this.positionSec,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalLearningEvent(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('lessonId: $lessonId, ')
          ..write('eventType: $eventType, ')
          ..write('positionSec: $positionSec, ')
          ..write('createdAt: $createdAt, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    lessonId,
    eventType,
    positionSec,
    createdAt,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalLearningEvent &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.lessonId == this.lessonId &&
          other.eventType == this.eventType &&
          other.positionSec == this.positionSec &&
          other.createdAt == this.createdAt &&
          other.metadata == this.metadata);
}

class LocalLearningEventsCompanion extends UpdateCompanion<LocalLearningEvent> {
  final Value<int> id;
  final Value<String> studentId;
  final Value<String> lessonId;
  final Value<String> eventType;
  final Value<int> positionSec;
  final Value<DateTime> createdAt;
  final Value<String?> metadata;
  const LocalLearningEventsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.positionSec = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.metadata = const Value.absent(),
  });
  LocalLearningEventsCompanion.insert({
    this.id = const Value.absent(),
    required String studentId,
    required String lessonId,
    required String eventType,
    required int positionSec,
    this.createdAt = const Value.absent(),
    this.metadata = const Value.absent(),
  }) : studentId = Value(studentId),
       lessonId = Value(lessonId),
       eventType = Value(eventType),
       positionSec = Value(positionSec);
  static Insertable<LocalLearningEvent> custom({
    Expression<int>? id,
    Expression<String>? studentId,
    Expression<String>? lessonId,
    Expression<String>? eventType,
    Expression<int>? positionSec,
    Expression<DateTime>? createdAt,
    Expression<String>? metadata,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (lessonId != null) 'lesson_id': lessonId,
      if (eventType != null) 'event_type': eventType,
      if (positionSec != null) 'position_sec': positionSec,
      if (createdAt != null) 'created_at': createdAt,
      if (metadata != null) 'metadata': metadata,
    });
  }

  LocalLearningEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? studentId,
    Value<String>? lessonId,
    Value<String>? eventType,
    Value<int>? positionSec,
    Value<DateTime>? createdAt,
    Value<String?>? metadata,
  }) {
    return LocalLearningEventsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      lessonId: lessonId ?? this.lessonId,
      eventType: eventType ?? this.eventType,
      positionSec: positionSec ?? this.positionSec,
      createdAt: createdAt ?? this.createdAt,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (positionSec.present) {
      map['position_sec'] = Variable<int>(positionSec.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalLearningEventsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('lessonId: $lessonId, ')
          ..write('eventType: $eventType, ')
          ..write('positionSec: $positionSec, ')
          ..write('createdAt: $createdAt, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }
}

class $LocalLessonMasteryTable extends LocalLessonMastery
    with TableInfo<$LocalLessonMasteryTable, LocalLessonMasteryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalLessonMasteryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _watchPercentageMeta = const VerificationMeta(
    'watchPercentage',
  );
  @override
  late final GeneratedColumn<int> watchPercentage = GeneratedColumn<int>(
    'watch_percentage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastPositionSecMeta = const VerificationMeta(
    'lastPositionSec',
  );
  @override
  late final GeneratedColumn<int> lastPositionSec = GeneratedColumn<int>(
    'last_position_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _struggleScoreMeta = const VerificationMeta(
    'struggleScore',
  );
  @override
  late final GeneratedColumn<double> struggleScore = GeneratedColumn<double>(
    'struggle_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _masteryScoreMeta = const VerificationMeta(
    'masteryScore',
  );
  @override
  late final GeneratedColumn<double> masteryScore = GeneratedColumn<double>(
    'mastery_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lastAccessedAtMeta = const VerificationMeta(
    'lastAccessedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAccessedAt =
      GeneratedColumn<DateTime>(
        'last_accessed_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    lessonId,
    studentId,
    tenantId,
    watchPercentage,
    lastPositionSec,
    struggleScore,
    masteryScore,
    lastAccessedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_lesson_mastery';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalLessonMasteryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('watch_percentage')) {
      context.handle(
        _watchPercentageMeta,
        watchPercentage.isAcceptableOrUnknown(
          data['watch_percentage']!,
          _watchPercentageMeta,
        ),
      );
    }
    if (data.containsKey('last_position_sec')) {
      context.handle(
        _lastPositionSecMeta,
        lastPositionSec.isAcceptableOrUnknown(
          data['last_position_sec']!,
          _lastPositionSecMeta,
        ),
      );
    }
    if (data.containsKey('struggle_score')) {
      context.handle(
        _struggleScoreMeta,
        struggleScore.isAcceptableOrUnknown(
          data['struggle_score']!,
          _struggleScoreMeta,
        ),
      );
    }
    if (data.containsKey('mastery_score')) {
      context.handle(
        _masteryScoreMeta,
        masteryScore.isAcceptableOrUnknown(
          data['mastery_score']!,
          _masteryScoreMeta,
        ),
      );
    }
    if (data.containsKey('last_accessed_at')) {
      context.handle(
        _lastAccessedAtMeta,
        lastAccessedAt.isAcceptableOrUnknown(
          data['last_accessed_at']!,
          _lastAccessedAtMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {studentId, lessonId};
  @override
  LocalLessonMasteryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalLessonMasteryData(
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      watchPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}watch_percentage'],
      )!,
      lastPositionSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_position_sec'],
      )!,
      struggleScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}struggle_score'],
      )!,
      masteryScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mastery_score'],
      )!,
      lastAccessedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_accessed_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalLessonMasteryTable createAlias(String alias) {
    return $LocalLessonMasteryTable(attachedDatabase, alias);
  }
}

class LocalLessonMasteryData extends DataClass
    implements Insertable<LocalLessonMasteryData> {
  final String lessonId;
  final String studentId;
  final String tenantId;
  final int watchPercentage;
  final int lastPositionSec;
  final double struggleScore;
  final double masteryScore;
  final DateTime lastAccessedAt;
  final bool isSynced;
  const LocalLessonMasteryData({
    required this.lessonId,
    required this.studentId,
    required this.tenantId,
    required this.watchPercentage,
    required this.lastPositionSec,
    required this.struggleScore,
    required this.masteryScore,
    required this.lastAccessedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['lesson_id'] = Variable<String>(lessonId);
    map['student_id'] = Variable<String>(studentId);
    map['tenant_id'] = Variable<String>(tenantId);
    map['watch_percentage'] = Variable<int>(watchPercentage);
    map['last_position_sec'] = Variable<int>(lastPositionSec);
    map['struggle_score'] = Variable<double>(struggleScore);
    map['mastery_score'] = Variable<double>(masteryScore);
    map['last_accessed_at'] = Variable<DateTime>(lastAccessedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalLessonMasteryCompanion toCompanion(bool nullToAbsent) {
    return LocalLessonMasteryCompanion(
      lessonId: Value(lessonId),
      studentId: Value(studentId),
      tenantId: Value(tenantId),
      watchPercentage: Value(watchPercentage),
      lastPositionSec: Value(lastPositionSec),
      struggleScore: Value(struggleScore),
      masteryScore: Value(masteryScore),
      lastAccessedAt: Value(lastAccessedAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalLessonMasteryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalLessonMasteryData(
      lessonId: serializer.fromJson<String>(json['lessonId']),
      studentId: serializer.fromJson<String>(json['studentId']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      watchPercentage: serializer.fromJson<int>(json['watchPercentage']),
      lastPositionSec: serializer.fromJson<int>(json['lastPositionSec']),
      struggleScore: serializer.fromJson<double>(json['struggleScore']),
      masteryScore: serializer.fromJson<double>(json['masteryScore']),
      lastAccessedAt: serializer.fromJson<DateTime>(json['lastAccessedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lessonId': serializer.toJson<String>(lessonId),
      'studentId': serializer.toJson<String>(studentId),
      'tenantId': serializer.toJson<String>(tenantId),
      'watchPercentage': serializer.toJson<int>(watchPercentage),
      'lastPositionSec': serializer.toJson<int>(lastPositionSec),
      'struggleScore': serializer.toJson<double>(struggleScore),
      'masteryScore': serializer.toJson<double>(masteryScore),
      'lastAccessedAt': serializer.toJson<DateTime>(lastAccessedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalLessonMasteryData copyWith({
    String? lessonId,
    String? studentId,
    String? tenantId,
    int? watchPercentage,
    int? lastPositionSec,
    double? struggleScore,
    double? masteryScore,
    DateTime? lastAccessedAt,
    bool? isSynced,
  }) => LocalLessonMasteryData(
    lessonId: lessonId ?? this.lessonId,
    studentId: studentId ?? this.studentId,
    tenantId: tenantId ?? this.tenantId,
    watchPercentage: watchPercentage ?? this.watchPercentage,
    lastPositionSec: lastPositionSec ?? this.lastPositionSec,
    struggleScore: struggleScore ?? this.struggleScore,
    masteryScore: masteryScore ?? this.masteryScore,
    lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalLessonMasteryData copyWithCompanion(LocalLessonMasteryCompanion data) {
    return LocalLessonMasteryData(
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      watchPercentage: data.watchPercentage.present
          ? data.watchPercentage.value
          : this.watchPercentage,
      lastPositionSec: data.lastPositionSec.present
          ? data.lastPositionSec.value
          : this.lastPositionSec,
      struggleScore: data.struggleScore.present
          ? data.struggleScore.value
          : this.struggleScore,
      masteryScore: data.masteryScore.present
          ? data.masteryScore.value
          : this.masteryScore,
      lastAccessedAt: data.lastAccessedAt.present
          ? data.lastAccessedAt.value
          : this.lastAccessedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalLessonMasteryData(')
          ..write('lessonId: $lessonId, ')
          ..write('studentId: $studentId, ')
          ..write('tenantId: $tenantId, ')
          ..write('watchPercentage: $watchPercentage, ')
          ..write('lastPositionSec: $lastPositionSec, ')
          ..write('struggleScore: $struggleScore, ')
          ..write('masteryScore: $masteryScore, ')
          ..write('lastAccessedAt: $lastAccessedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    lessonId,
    studentId,
    tenantId,
    watchPercentage,
    lastPositionSec,
    struggleScore,
    masteryScore,
    lastAccessedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalLessonMasteryData &&
          other.lessonId == this.lessonId &&
          other.studentId == this.studentId &&
          other.tenantId == this.tenantId &&
          other.watchPercentage == this.watchPercentage &&
          other.lastPositionSec == this.lastPositionSec &&
          other.struggleScore == this.struggleScore &&
          other.masteryScore == this.masteryScore &&
          other.lastAccessedAt == this.lastAccessedAt &&
          other.isSynced == this.isSynced);
}

class LocalLessonMasteryCompanion
    extends UpdateCompanion<LocalLessonMasteryData> {
  final Value<String> lessonId;
  final Value<String> studentId;
  final Value<String> tenantId;
  final Value<int> watchPercentage;
  final Value<int> lastPositionSec;
  final Value<double> struggleScore;
  final Value<double> masteryScore;
  final Value<DateTime> lastAccessedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalLessonMasteryCompanion({
    this.lessonId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.watchPercentage = const Value.absent(),
    this.lastPositionSec = const Value.absent(),
    this.struggleScore = const Value.absent(),
    this.masteryScore = const Value.absent(),
    this.lastAccessedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalLessonMasteryCompanion.insert({
    required String lessonId,
    required String studentId,
    required String tenantId,
    this.watchPercentage = const Value.absent(),
    this.lastPositionSec = const Value.absent(),
    this.struggleScore = const Value.absent(),
    this.masteryScore = const Value.absent(),
    this.lastAccessedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : lessonId = Value(lessonId),
       studentId = Value(studentId),
       tenantId = Value(tenantId);
  static Insertable<LocalLessonMasteryData> custom({
    Expression<String>? lessonId,
    Expression<String>? studentId,
    Expression<String>? tenantId,
    Expression<int>? watchPercentage,
    Expression<int>? lastPositionSec,
    Expression<double>? struggleScore,
    Expression<double>? masteryScore,
    Expression<DateTime>? lastAccessedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (lessonId != null) 'lesson_id': lessonId,
      if (studentId != null) 'student_id': studentId,
      if (tenantId != null) 'tenant_id': tenantId,
      if (watchPercentage != null) 'watch_percentage': watchPercentage,
      if (lastPositionSec != null) 'last_position_sec': lastPositionSec,
      if (struggleScore != null) 'struggle_score': struggleScore,
      if (masteryScore != null) 'mastery_score': masteryScore,
      if (lastAccessedAt != null) 'last_accessed_at': lastAccessedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalLessonMasteryCompanion copyWith({
    Value<String>? lessonId,
    Value<String>? studentId,
    Value<String>? tenantId,
    Value<int>? watchPercentage,
    Value<int>? lastPositionSec,
    Value<double>? struggleScore,
    Value<double>? masteryScore,
    Value<DateTime>? lastAccessedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalLessonMasteryCompanion(
      lessonId: lessonId ?? this.lessonId,
      studentId: studentId ?? this.studentId,
      tenantId: tenantId ?? this.tenantId,
      watchPercentage: watchPercentage ?? this.watchPercentage,
      lastPositionSec: lastPositionSec ?? this.lastPositionSec,
      struggleScore: struggleScore ?? this.struggleScore,
      masteryScore: masteryScore ?? this.masteryScore,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (watchPercentage.present) {
      map['watch_percentage'] = Variable<int>(watchPercentage.value);
    }
    if (lastPositionSec.present) {
      map['last_position_sec'] = Variable<int>(lastPositionSec.value);
    }
    if (struggleScore.present) {
      map['struggle_score'] = Variable<double>(struggleScore.value);
    }
    if (masteryScore.present) {
      map['mastery_score'] = Variable<double>(masteryScore.value);
    }
    if (lastAccessedAt.present) {
      map['last_accessed_at'] = Variable<DateTime>(lastAccessedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalLessonMasteryCompanion(')
          ..write('lessonId: $lessonId, ')
          ..write('studentId: $studentId, ')
          ..write('tenantId: $tenantId, ')
          ..write('watchPercentage: $watchPercentage, ')
          ..write('lastPositionSec: $lastPositionSec, ')
          ..write('struggleScore: $struggleScore, ')
          ..write('masteryScore: $masteryScore, ')
          ..write('lastAccessedAt: $lastAccessedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalTopicMasteryTable extends LocalTopicMastery
    with TableInfo<$LocalTopicMasteryTable, LocalTopicMasteryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalTopicMasteryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicTypeMeta = const VerificationMeta(
    'topicType',
  );
  @override
  late final GeneratedColumn<String> topicType = GeneratedColumn<String>(
    'topic_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicTagMeta = const VerificationMeta(
    'topicTag',
  );
  @override
  late final GeneratedColumn<String> topicTag = GeneratedColumn<String>(
    'topic_tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAttemptsMeta = const VerificationMeta(
    'totalAttempts',
  );
  @override
  late final GeneratedColumn<int> totalAttempts = GeneratedColumn<int>(
    'total_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctAttemptsMeta = const VerificationMeta(
    'correctAttempts',
  );
  @override
  late final GeneratedColumn<int> correctAttempts = GeneratedColumn<int>(
    'correct_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _speedScoreMeta = const VerificationMeta(
    'speedScore',
  );
  @override
  late final GeneratedColumn<double> speedScore = GeneratedColumn<double>(
    'speed_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _masteryScoreMeta = const VerificationMeta(
    'masteryScore',
  );
  @override
  late final GeneratedColumn<double> masteryScore = GeneratedColumn<double>(
    'mastery_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _previousMasteryScoreMeta =
      const VerificationMeta('previousMasteryScore');
  @override
  late final GeneratedColumn<double> previousMasteryScore =
      GeneratedColumn<double>(
        'previous_mastery_score',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastAttemptedAtMeta = const VerificationMeta(
    'lastAttemptedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptedAt =
      GeneratedColumn<DateTime>(
        'last_attempted_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    studentId,
    topicType,
    topicId,
    topicTag,
    totalAttempts,
    correctAttempts,
    speedScore,
    masteryScore,
    previousMasteryScore,
    lastAttemptedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_topic_mastery';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalTopicMasteryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('topic_type')) {
      context.handle(
        _topicTypeMeta,
        topicType.isAcceptableOrUnknown(data['topic_type']!, _topicTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_topicTypeMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('topic_tag')) {
      context.handle(
        _topicTagMeta,
        topicTag.isAcceptableOrUnknown(data['topic_tag']!, _topicTagMeta),
      );
    } else if (isInserting) {
      context.missing(_topicTagMeta);
    }
    if (data.containsKey('total_attempts')) {
      context.handle(
        _totalAttemptsMeta,
        totalAttempts.isAcceptableOrUnknown(
          data['total_attempts']!,
          _totalAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('correct_attempts')) {
      context.handle(
        _correctAttemptsMeta,
        correctAttempts.isAcceptableOrUnknown(
          data['correct_attempts']!,
          _correctAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('speed_score')) {
      context.handle(
        _speedScoreMeta,
        speedScore.isAcceptableOrUnknown(data['speed_score']!, _speedScoreMeta),
      );
    }
    if (data.containsKey('mastery_score')) {
      context.handle(
        _masteryScoreMeta,
        masteryScore.isAcceptableOrUnknown(
          data['mastery_score']!,
          _masteryScoreMeta,
        ),
      );
    }
    if (data.containsKey('previous_mastery_score')) {
      context.handle(
        _previousMasteryScoreMeta,
        previousMasteryScore.isAcceptableOrUnknown(
          data['previous_mastery_score']!,
          _previousMasteryScoreMeta,
        ),
      );
    }
    if (data.containsKey('last_attempted_at')) {
      context.handle(
        _lastAttemptedAtMeta,
        lastAttemptedAt.isAcceptableOrUnknown(
          data['last_attempted_at']!,
          _lastAttemptedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {studentId, topicType, topicId};
  @override
  LocalTopicMasteryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalTopicMasteryData(
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      topicType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_type'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      )!,
      topicTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_tag'],
      )!,
      totalAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_attempts'],
      )!,
      correctAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_attempts'],
      )!,
      speedScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed_score'],
      )!,
      masteryScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mastery_score'],
      )!,
      previousMasteryScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}previous_mastery_score'],
      ),
      lastAttemptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempted_at'],
      ),
    );
  }

  @override
  $LocalTopicMasteryTable createAlias(String alias) {
    return $LocalTopicMasteryTable(attachedDatabase, alias);
  }
}

class LocalTopicMasteryData extends DataClass
    implements Insertable<LocalTopicMasteryData> {
  final String studentId;
  final String topicType;
  final String topicId;
  final String topicTag;
  final int totalAttempts;
  final int correctAttempts;
  final double speedScore;
  final double masteryScore;
  final double? previousMasteryScore;
  final DateTime? lastAttemptedAt;
  const LocalTopicMasteryData({
    required this.studentId,
    required this.topicType,
    required this.topicId,
    required this.topicTag,
    required this.totalAttempts,
    required this.correctAttempts,
    required this.speedScore,
    required this.masteryScore,
    this.previousMasteryScore,
    this.lastAttemptedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['student_id'] = Variable<String>(studentId);
    map['topic_type'] = Variable<String>(topicType);
    map['topic_id'] = Variable<String>(topicId);
    map['topic_tag'] = Variable<String>(topicTag);
    map['total_attempts'] = Variable<int>(totalAttempts);
    map['correct_attempts'] = Variable<int>(correctAttempts);
    map['speed_score'] = Variable<double>(speedScore);
    map['mastery_score'] = Variable<double>(masteryScore);
    if (!nullToAbsent || previousMasteryScore != null) {
      map['previous_mastery_score'] = Variable<double>(previousMasteryScore);
    }
    if (!nullToAbsent || lastAttemptedAt != null) {
      map['last_attempted_at'] = Variable<DateTime>(lastAttemptedAt);
    }
    return map;
  }

  LocalTopicMasteryCompanion toCompanion(bool nullToAbsent) {
    return LocalTopicMasteryCompanion(
      studentId: Value(studentId),
      topicType: Value(topicType),
      topicId: Value(topicId),
      topicTag: Value(topicTag),
      totalAttempts: Value(totalAttempts),
      correctAttempts: Value(correctAttempts),
      speedScore: Value(speedScore),
      masteryScore: Value(masteryScore),
      previousMasteryScore: previousMasteryScore == null && nullToAbsent
          ? const Value.absent()
          : Value(previousMasteryScore),
      lastAttemptedAt: lastAttemptedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptedAt),
    );
  }

  factory LocalTopicMasteryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalTopicMasteryData(
      studentId: serializer.fromJson<String>(json['studentId']),
      topicType: serializer.fromJson<String>(json['topicType']),
      topicId: serializer.fromJson<String>(json['topicId']),
      topicTag: serializer.fromJson<String>(json['topicTag']),
      totalAttempts: serializer.fromJson<int>(json['totalAttempts']),
      correctAttempts: serializer.fromJson<int>(json['correctAttempts']),
      speedScore: serializer.fromJson<double>(json['speedScore']),
      masteryScore: serializer.fromJson<double>(json['masteryScore']),
      previousMasteryScore: serializer.fromJson<double?>(
        json['previousMasteryScore'],
      ),
      lastAttemptedAt: serializer.fromJson<DateTime?>(json['lastAttemptedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'studentId': serializer.toJson<String>(studentId),
      'topicType': serializer.toJson<String>(topicType),
      'topicId': serializer.toJson<String>(topicId),
      'topicTag': serializer.toJson<String>(topicTag),
      'totalAttempts': serializer.toJson<int>(totalAttempts),
      'correctAttempts': serializer.toJson<int>(correctAttempts),
      'speedScore': serializer.toJson<double>(speedScore),
      'masteryScore': serializer.toJson<double>(masteryScore),
      'previousMasteryScore': serializer.toJson<double?>(previousMasteryScore),
      'lastAttemptedAt': serializer.toJson<DateTime?>(lastAttemptedAt),
    };
  }

  LocalTopicMasteryData copyWith({
    String? studentId,
    String? topicType,
    String? topicId,
    String? topicTag,
    int? totalAttempts,
    int? correctAttempts,
    double? speedScore,
    double? masteryScore,
    Value<double?> previousMasteryScore = const Value.absent(),
    Value<DateTime?> lastAttemptedAt = const Value.absent(),
  }) => LocalTopicMasteryData(
    studentId: studentId ?? this.studentId,
    topicType: topicType ?? this.topicType,
    topicId: topicId ?? this.topicId,
    topicTag: topicTag ?? this.topicTag,
    totalAttempts: totalAttempts ?? this.totalAttempts,
    correctAttempts: correctAttempts ?? this.correctAttempts,
    speedScore: speedScore ?? this.speedScore,
    masteryScore: masteryScore ?? this.masteryScore,
    previousMasteryScore: previousMasteryScore.present
        ? previousMasteryScore.value
        : this.previousMasteryScore,
    lastAttemptedAt: lastAttemptedAt.present
        ? lastAttemptedAt.value
        : this.lastAttemptedAt,
  );
  LocalTopicMasteryData copyWithCompanion(LocalTopicMasteryCompanion data) {
    return LocalTopicMasteryData(
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      topicType: data.topicType.present ? data.topicType.value : this.topicType,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      topicTag: data.topicTag.present ? data.topicTag.value : this.topicTag,
      totalAttempts: data.totalAttempts.present
          ? data.totalAttempts.value
          : this.totalAttempts,
      correctAttempts: data.correctAttempts.present
          ? data.correctAttempts.value
          : this.correctAttempts,
      speedScore: data.speedScore.present
          ? data.speedScore.value
          : this.speedScore,
      masteryScore: data.masteryScore.present
          ? data.masteryScore.value
          : this.masteryScore,
      previousMasteryScore: data.previousMasteryScore.present
          ? data.previousMasteryScore.value
          : this.previousMasteryScore,
      lastAttemptedAt: data.lastAttemptedAt.present
          ? data.lastAttemptedAt.value
          : this.lastAttemptedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalTopicMasteryData(')
          ..write('studentId: $studentId, ')
          ..write('topicType: $topicType, ')
          ..write('topicId: $topicId, ')
          ..write('topicTag: $topicTag, ')
          ..write('totalAttempts: $totalAttempts, ')
          ..write('correctAttempts: $correctAttempts, ')
          ..write('speedScore: $speedScore, ')
          ..write('masteryScore: $masteryScore, ')
          ..write('previousMasteryScore: $previousMasteryScore, ')
          ..write('lastAttemptedAt: $lastAttemptedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    studentId,
    topicType,
    topicId,
    topicTag,
    totalAttempts,
    correctAttempts,
    speedScore,
    masteryScore,
    previousMasteryScore,
    lastAttemptedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTopicMasteryData &&
          other.studentId == this.studentId &&
          other.topicType == this.topicType &&
          other.topicId == this.topicId &&
          other.topicTag == this.topicTag &&
          other.totalAttempts == this.totalAttempts &&
          other.correctAttempts == this.correctAttempts &&
          other.speedScore == this.speedScore &&
          other.masteryScore == this.masteryScore &&
          other.previousMasteryScore == this.previousMasteryScore &&
          other.lastAttemptedAt == this.lastAttemptedAt);
}

class LocalTopicMasteryCompanion
    extends UpdateCompanion<LocalTopicMasteryData> {
  final Value<String> studentId;
  final Value<String> topicType;
  final Value<String> topicId;
  final Value<String> topicTag;
  final Value<int> totalAttempts;
  final Value<int> correctAttempts;
  final Value<double> speedScore;
  final Value<double> masteryScore;
  final Value<double?> previousMasteryScore;
  final Value<DateTime?> lastAttemptedAt;
  final Value<int> rowid;
  const LocalTopicMasteryCompanion({
    this.studentId = const Value.absent(),
    this.topicType = const Value.absent(),
    this.topicId = const Value.absent(),
    this.topicTag = const Value.absent(),
    this.totalAttempts = const Value.absent(),
    this.correctAttempts = const Value.absent(),
    this.speedScore = const Value.absent(),
    this.masteryScore = const Value.absent(),
    this.previousMasteryScore = const Value.absent(),
    this.lastAttemptedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalTopicMasteryCompanion.insert({
    required String studentId,
    required String topicType,
    required String topicId,
    required String topicTag,
    this.totalAttempts = const Value.absent(),
    this.correctAttempts = const Value.absent(),
    this.speedScore = const Value.absent(),
    this.masteryScore = const Value.absent(),
    this.previousMasteryScore = const Value.absent(),
    this.lastAttemptedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : studentId = Value(studentId),
       topicType = Value(topicType),
       topicId = Value(topicId),
       topicTag = Value(topicTag);
  static Insertable<LocalTopicMasteryData> custom({
    Expression<String>? studentId,
    Expression<String>? topicType,
    Expression<String>? topicId,
    Expression<String>? topicTag,
    Expression<int>? totalAttempts,
    Expression<int>? correctAttempts,
    Expression<double>? speedScore,
    Expression<double>? masteryScore,
    Expression<double>? previousMasteryScore,
    Expression<DateTime>? lastAttemptedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (studentId != null) 'student_id': studentId,
      if (topicType != null) 'topic_type': topicType,
      if (topicId != null) 'topic_id': topicId,
      if (topicTag != null) 'topic_tag': topicTag,
      if (totalAttempts != null) 'total_attempts': totalAttempts,
      if (correctAttempts != null) 'correct_attempts': correctAttempts,
      if (speedScore != null) 'speed_score': speedScore,
      if (masteryScore != null) 'mastery_score': masteryScore,
      if (previousMasteryScore != null)
        'previous_mastery_score': previousMasteryScore,
      if (lastAttemptedAt != null) 'last_attempted_at': lastAttemptedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalTopicMasteryCompanion copyWith({
    Value<String>? studentId,
    Value<String>? topicType,
    Value<String>? topicId,
    Value<String>? topicTag,
    Value<int>? totalAttempts,
    Value<int>? correctAttempts,
    Value<double>? speedScore,
    Value<double>? masteryScore,
    Value<double?>? previousMasteryScore,
    Value<DateTime?>? lastAttemptedAt,
    Value<int>? rowid,
  }) {
    return LocalTopicMasteryCompanion(
      studentId: studentId ?? this.studentId,
      topicType: topicType ?? this.topicType,
      topicId: topicId ?? this.topicId,
      topicTag: topicTag ?? this.topicTag,
      totalAttempts: totalAttempts ?? this.totalAttempts,
      correctAttempts: correctAttempts ?? this.correctAttempts,
      speedScore: speedScore ?? this.speedScore,
      masteryScore: masteryScore ?? this.masteryScore,
      previousMasteryScore: previousMasteryScore ?? this.previousMasteryScore,
      lastAttemptedAt: lastAttemptedAt ?? this.lastAttemptedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (topicType.present) {
      map['topic_type'] = Variable<String>(topicType.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (topicTag.present) {
      map['topic_tag'] = Variable<String>(topicTag.value);
    }
    if (totalAttempts.present) {
      map['total_attempts'] = Variable<int>(totalAttempts.value);
    }
    if (correctAttempts.present) {
      map['correct_attempts'] = Variable<int>(correctAttempts.value);
    }
    if (speedScore.present) {
      map['speed_score'] = Variable<double>(speedScore.value);
    }
    if (masteryScore.present) {
      map['mastery_score'] = Variable<double>(masteryScore.value);
    }
    if (previousMasteryScore.present) {
      map['previous_mastery_score'] = Variable<double>(
        previousMasteryScore.value,
      );
    }
    if (lastAttemptedAt.present) {
      map['last_attempted_at'] = Variable<DateTime>(lastAttemptedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalTopicMasteryCompanion(')
          ..write('studentId: $studentId, ')
          ..write('topicType: $topicType, ')
          ..write('topicId: $topicId, ')
          ..write('topicTag: $topicTag, ')
          ..write('totalAttempts: $totalAttempts, ')
          ..write('correctAttempts: $correctAttempts, ')
          ..write('speedScore: $speedScore, ')
          ..write('masteryScore: $masteryScore, ')
          ..write('previousMasteryScore: $previousMasteryScore, ')
          ..write('lastAttemptedAt: $lastAttemptedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSmartReviewQueueTable extends LocalSmartReviewQueue
    with TableInfo<$LocalSmartReviewQueueTable, LocalSmartReviewQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSmartReviewQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicTagMeta = const VerificationMeta(
    'topicTag',
  );
  @override
  late final GeneratedColumn<String> topicTag = GeneratedColumn<String>(
    'topic_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _easeFactorMeta = const VerificationMeta(
    'easeFactor',
  );
  @override
  late final GeneratedColumn<double> easeFactor = GeneratedColumn<double>(
    'ease_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.5),
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextReviewAtMeta = const VerificationMeta(
    'nextReviewAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextReviewAt = GeneratedColumn<DateTime>(
    'next_review_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityScoreMeta = const VerificationMeta(
    'priorityScore',
  );
  @override
  late final GeneratedColumn<double> priorityScore = GeneratedColumn<double>(
    'priority_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>(
        'last_reviewed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    studentId,
    contentType,
    contentId,
    topicTag,
    intervalDays,
    easeFactor,
    reviewCount,
    nextReviewAt,
    priorityScore,
    lastReviewedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_smart_review_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSmartReviewQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('topic_tag')) {
      context.handle(
        _topicTagMeta,
        topicTag.isAcceptableOrUnknown(data['topic_tag']!, _topicTagMeta),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('ease_factor')) {
      context.handle(
        _easeFactorMeta,
        easeFactor.isAcceptableOrUnknown(data['ease_factor']!, _easeFactorMeta),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
        _nextReviewAtMeta,
        nextReviewAt.isAcceptableOrUnknown(
          data['next_review_at']!,
          _nextReviewAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextReviewAtMeta);
    }
    if (data.containsKey('priority_score')) {
      context.handle(
        _priorityScoreMeta,
        priorityScore.isAcceptableOrUnknown(
          data['priority_score']!,
          _priorityScoreMeta,
        ),
      );
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {studentId, contentType, contentId};
  @override
  LocalSmartReviewQueueData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSmartReviewQueueData(
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      topicTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_tag'],
      ),
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      )!,
      easeFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ease_factor'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      nextReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review_at'],
      )!,
      priorityScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}priority_score'],
      )!,
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed_at'],
      ),
    );
  }

  @override
  $LocalSmartReviewQueueTable createAlias(String alias) {
    return $LocalSmartReviewQueueTable(attachedDatabase, alias);
  }
}

class LocalSmartReviewQueueData extends DataClass
    implements Insertable<LocalSmartReviewQueueData> {
  final String studentId;
  final String contentType;
  final String contentId;
  final String? topicTag;
  final int intervalDays;
  final double easeFactor;
  final int reviewCount;
  final DateTime nextReviewAt;
  final double priorityScore;
  final DateTime? lastReviewedAt;
  const LocalSmartReviewQueueData({
    required this.studentId,
    required this.contentType,
    required this.contentId,
    this.topicTag,
    required this.intervalDays,
    required this.easeFactor,
    required this.reviewCount,
    required this.nextReviewAt,
    required this.priorityScore,
    this.lastReviewedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['student_id'] = Variable<String>(studentId);
    map['content_type'] = Variable<String>(contentType);
    map['content_id'] = Variable<String>(contentId);
    if (!nullToAbsent || topicTag != null) {
      map['topic_tag'] = Variable<String>(topicTag);
    }
    map['interval_days'] = Variable<int>(intervalDays);
    map['ease_factor'] = Variable<double>(easeFactor);
    map['review_count'] = Variable<int>(reviewCount);
    map['next_review_at'] = Variable<DateTime>(nextReviewAt);
    map['priority_score'] = Variable<double>(priorityScore);
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    return map;
  }

  LocalSmartReviewQueueCompanion toCompanion(bool nullToAbsent) {
    return LocalSmartReviewQueueCompanion(
      studentId: Value(studentId),
      contentType: Value(contentType),
      contentId: Value(contentId),
      topicTag: topicTag == null && nullToAbsent
          ? const Value.absent()
          : Value(topicTag),
      intervalDays: Value(intervalDays),
      easeFactor: Value(easeFactor),
      reviewCount: Value(reviewCount),
      nextReviewAt: Value(nextReviewAt),
      priorityScore: Value(priorityScore),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
    );
  }

  factory LocalSmartReviewQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSmartReviewQueueData(
      studentId: serializer.fromJson<String>(json['studentId']),
      contentType: serializer.fromJson<String>(json['contentType']),
      contentId: serializer.fromJson<String>(json['contentId']),
      topicTag: serializer.fromJson<String?>(json['topicTag']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      easeFactor: serializer.fromJson<double>(json['easeFactor']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      nextReviewAt: serializer.fromJson<DateTime>(json['nextReviewAt']),
      priorityScore: serializer.fromJson<double>(json['priorityScore']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'studentId': serializer.toJson<String>(studentId),
      'contentType': serializer.toJson<String>(contentType),
      'contentId': serializer.toJson<String>(contentId),
      'topicTag': serializer.toJson<String?>(topicTag),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'easeFactor': serializer.toJson<double>(easeFactor),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'nextReviewAt': serializer.toJson<DateTime>(nextReviewAt),
      'priorityScore': serializer.toJson<double>(priorityScore),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
    };
  }

  LocalSmartReviewQueueData copyWith({
    String? studentId,
    String? contentType,
    String? contentId,
    Value<String?> topicTag = const Value.absent(),
    int? intervalDays,
    double? easeFactor,
    int? reviewCount,
    DateTime? nextReviewAt,
    double? priorityScore,
    Value<DateTime?> lastReviewedAt = const Value.absent(),
  }) => LocalSmartReviewQueueData(
    studentId: studentId ?? this.studentId,
    contentType: contentType ?? this.contentType,
    contentId: contentId ?? this.contentId,
    topicTag: topicTag.present ? topicTag.value : this.topicTag,
    intervalDays: intervalDays ?? this.intervalDays,
    easeFactor: easeFactor ?? this.easeFactor,
    reviewCount: reviewCount ?? this.reviewCount,
    nextReviewAt: nextReviewAt ?? this.nextReviewAt,
    priorityScore: priorityScore ?? this.priorityScore,
    lastReviewedAt: lastReviewedAt.present
        ? lastReviewedAt.value
        : this.lastReviewedAt,
  );
  LocalSmartReviewQueueData copyWithCompanion(
    LocalSmartReviewQueueCompanion data,
  ) {
    return LocalSmartReviewQueueData(
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      topicTag: data.topicTag.present ? data.topicTag.value : this.topicTag,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      easeFactor: data.easeFactor.present
          ? data.easeFactor.value
          : this.easeFactor,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
      priorityScore: data.priorityScore.present
          ? data.priorityScore.value
          : this.priorityScore,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSmartReviewQueueData(')
          ..write('studentId: $studentId, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('topicTag: $topicTag, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('priorityScore: $priorityScore, ')
          ..write('lastReviewedAt: $lastReviewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    studentId,
    contentType,
    contentId,
    topicTag,
    intervalDays,
    easeFactor,
    reviewCount,
    nextReviewAt,
    priorityScore,
    lastReviewedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSmartReviewQueueData &&
          other.studentId == this.studentId &&
          other.contentType == this.contentType &&
          other.contentId == this.contentId &&
          other.topicTag == this.topicTag &&
          other.intervalDays == this.intervalDays &&
          other.easeFactor == this.easeFactor &&
          other.reviewCount == this.reviewCount &&
          other.nextReviewAt == this.nextReviewAt &&
          other.priorityScore == this.priorityScore &&
          other.lastReviewedAt == this.lastReviewedAt);
}

class LocalSmartReviewQueueCompanion
    extends UpdateCompanion<LocalSmartReviewQueueData> {
  final Value<String> studentId;
  final Value<String> contentType;
  final Value<String> contentId;
  final Value<String?> topicTag;
  final Value<int> intervalDays;
  final Value<double> easeFactor;
  final Value<int> reviewCount;
  final Value<DateTime> nextReviewAt;
  final Value<double> priorityScore;
  final Value<DateTime?> lastReviewedAt;
  final Value<int> rowid;
  const LocalSmartReviewQueueCompanion({
    this.studentId = const Value.absent(),
    this.contentType = const Value.absent(),
    this.contentId = const Value.absent(),
    this.topicTag = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.priorityScore = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSmartReviewQueueCompanion.insert({
    required String studentId,
    required String contentType,
    required String contentId,
    this.topicTag = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.reviewCount = const Value.absent(),
    required DateTime nextReviewAt,
    this.priorityScore = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : studentId = Value(studentId),
       contentType = Value(contentType),
       contentId = Value(contentId),
       nextReviewAt = Value(nextReviewAt);
  static Insertable<LocalSmartReviewQueueData> custom({
    Expression<String>? studentId,
    Expression<String>? contentType,
    Expression<String>? contentId,
    Expression<String>? topicTag,
    Expression<int>? intervalDays,
    Expression<double>? easeFactor,
    Expression<int>? reviewCount,
    Expression<DateTime>? nextReviewAt,
    Expression<double>? priorityScore,
    Expression<DateTime>? lastReviewedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (studentId != null) 'student_id': studentId,
      if (contentType != null) 'content_type': contentType,
      if (contentId != null) 'content_id': contentId,
      if (topicTag != null) 'topic_tag': topicTag,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (easeFactor != null) 'ease_factor': easeFactor,
      if (reviewCount != null) 'review_count': reviewCount,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (priorityScore != null) 'priority_score': priorityScore,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSmartReviewQueueCompanion copyWith({
    Value<String>? studentId,
    Value<String>? contentType,
    Value<String>? contentId,
    Value<String?>? topicTag,
    Value<int>? intervalDays,
    Value<double>? easeFactor,
    Value<int>? reviewCount,
    Value<DateTime>? nextReviewAt,
    Value<double>? priorityScore,
    Value<DateTime?>? lastReviewedAt,
    Value<int>? rowid,
  }) {
    return LocalSmartReviewQueueCompanion(
      studentId: studentId ?? this.studentId,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      topicTag: topicTag ?? this.topicTag,
      intervalDays: intervalDays ?? this.intervalDays,
      easeFactor: easeFactor ?? this.easeFactor,
      reviewCount: reviewCount ?? this.reviewCount,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      priorityScore: priorityScore ?? this.priorityScore,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (topicTag.present) {
      map['topic_tag'] = Variable<String>(topicTag.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (easeFactor.present) {
      map['ease_factor'] = Variable<double>(easeFactor.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt.value);
    }
    if (priorityScore.present) {
      map['priority_score'] = Variable<double>(priorityScore.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSmartReviewQueueCompanion(')
          ..write('studentId: $studentId, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('topicTag: $topicTag, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('priorityScore: $priorityScore, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalDailyLearningSummaryTable extends LocalDailyLearningSummary
    with
        TableInfo<
          $LocalDailyLearningSummaryTable,
          LocalDailyLearningSummaryData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalDailyLearningSummaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryDateMeta = const VerificationMeta(
    'summaryDate',
  );
  @override
  late final GeneratedColumn<DateTime> summaryDate = GeneratedColumn<DateTime>(
    'summary_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonsWatchedMeta = const VerificationMeta(
    'lessonsWatched',
  );
  @override
  late final GeneratedColumn<int> lessonsWatched = GeneratedColumn<int>(
    'lessons_watched',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lessonsCompletedMeta = const VerificationMeta(
    'lessonsCompleted',
  );
  @override
  late final GeneratedColumn<int> lessonsCompleted = GeneratedColumn<int>(
    'lessons_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _questionsAttemptedMeta =
      const VerificationMeta('questionsAttempted');
  @override
  late final GeneratedColumn<int> questionsAttempted = GeneratedColumn<int>(
    'questions_attempted',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _minutesStudiedMeta = const VerificationMeta(
    'minutesStudied',
  );
  @override
  late final GeneratedColumn<int> minutesStudied = GeneratedColumn<int>(
    'minutes_studied',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _accuracyTodayMeta = const VerificationMeta(
    'accuracyToday',
  );
  @override
  late final GeneratedColumn<double> accuracyToday = GeneratedColumn<double>(
    'accuracy_today',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _streakMaintainedMeta = const VerificationMeta(
    'streakMaintained',
  );
  @override
  late final GeneratedColumn<bool> streakMaintained = GeneratedColumn<bool>(
    'streak_maintained',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("streak_maintained" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    studentId,
    summaryDate,
    lessonsWatched,
    lessonsCompleted,
    questionsAttempted,
    minutesStudied,
    accuracyToday,
    streakMaintained,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_daily_learning_summary';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalDailyLearningSummaryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('summary_date')) {
      context.handle(
        _summaryDateMeta,
        summaryDate.isAcceptableOrUnknown(
          data['summary_date']!,
          _summaryDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_summaryDateMeta);
    }
    if (data.containsKey('lessons_watched')) {
      context.handle(
        _lessonsWatchedMeta,
        lessonsWatched.isAcceptableOrUnknown(
          data['lessons_watched']!,
          _lessonsWatchedMeta,
        ),
      );
    }
    if (data.containsKey('lessons_completed')) {
      context.handle(
        _lessonsCompletedMeta,
        lessonsCompleted.isAcceptableOrUnknown(
          data['lessons_completed']!,
          _lessonsCompletedMeta,
        ),
      );
    }
    if (data.containsKey('questions_attempted')) {
      context.handle(
        _questionsAttemptedMeta,
        questionsAttempted.isAcceptableOrUnknown(
          data['questions_attempted']!,
          _questionsAttemptedMeta,
        ),
      );
    }
    if (data.containsKey('minutes_studied')) {
      context.handle(
        _minutesStudiedMeta,
        minutesStudied.isAcceptableOrUnknown(
          data['minutes_studied']!,
          _minutesStudiedMeta,
        ),
      );
    }
    if (data.containsKey('accuracy_today')) {
      context.handle(
        _accuracyTodayMeta,
        accuracyToday.isAcceptableOrUnknown(
          data['accuracy_today']!,
          _accuracyTodayMeta,
        ),
      );
    }
    if (data.containsKey('streak_maintained')) {
      context.handle(
        _streakMaintainedMeta,
        streakMaintained.isAcceptableOrUnknown(
          data['streak_maintained']!,
          _streakMaintainedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {studentId, summaryDate};
  @override
  LocalDailyLearningSummaryData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalDailyLearningSummaryData(
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      summaryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}summary_date'],
      )!,
      lessonsWatched: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lessons_watched'],
      )!,
      lessonsCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lessons_completed'],
      )!,
      questionsAttempted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}questions_attempted'],
      )!,
      minutesStudied: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes_studied'],
      )!,
      accuracyToday: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_today'],
      )!,
      streakMaintained: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}streak_maintained'],
      )!,
    );
  }

  @override
  $LocalDailyLearningSummaryTable createAlias(String alias) {
    return $LocalDailyLearningSummaryTable(attachedDatabase, alias);
  }
}

class LocalDailyLearningSummaryData extends DataClass
    implements Insertable<LocalDailyLearningSummaryData> {
  final String studentId;
  final DateTime summaryDate;
  final int lessonsWatched;
  final int lessonsCompleted;
  final int questionsAttempted;
  final int minutesStudied;
  final double accuracyToday;
  final bool streakMaintained;
  const LocalDailyLearningSummaryData({
    required this.studentId,
    required this.summaryDate,
    required this.lessonsWatched,
    required this.lessonsCompleted,
    required this.questionsAttempted,
    required this.minutesStudied,
    required this.accuracyToday,
    required this.streakMaintained,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['student_id'] = Variable<String>(studentId);
    map['summary_date'] = Variable<DateTime>(summaryDate);
    map['lessons_watched'] = Variable<int>(lessonsWatched);
    map['lessons_completed'] = Variable<int>(lessonsCompleted);
    map['questions_attempted'] = Variable<int>(questionsAttempted);
    map['minutes_studied'] = Variable<int>(minutesStudied);
    map['accuracy_today'] = Variable<double>(accuracyToday);
    map['streak_maintained'] = Variable<bool>(streakMaintained);
    return map;
  }

  LocalDailyLearningSummaryCompanion toCompanion(bool nullToAbsent) {
    return LocalDailyLearningSummaryCompanion(
      studentId: Value(studentId),
      summaryDate: Value(summaryDate),
      lessonsWatched: Value(lessonsWatched),
      lessonsCompleted: Value(lessonsCompleted),
      questionsAttempted: Value(questionsAttempted),
      minutesStudied: Value(minutesStudied),
      accuracyToday: Value(accuracyToday),
      streakMaintained: Value(streakMaintained),
    );
  }

  factory LocalDailyLearningSummaryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalDailyLearningSummaryData(
      studentId: serializer.fromJson<String>(json['studentId']),
      summaryDate: serializer.fromJson<DateTime>(json['summaryDate']),
      lessonsWatched: serializer.fromJson<int>(json['lessonsWatched']),
      lessonsCompleted: serializer.fromJson<int>(json['lessonsCompleted']),
      questionsAttempted: serializer.fromJson<int>(json['questionsAttempted']),
      minutesStudied: serializer.fromJson<int>(json['minutesStudied']),
      accuracyToday: serializer.fromJson<double>(json['accuracyToday']),
      streakMaintained: serializer.fromJson<bool>(json['streakMaintained']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'studentId': serializer.toJson<String>(studentId),
      'summaryDate': serializer.toJson<DateTime>(summaryDate),
      'lessonsWatched': serializer.toJson<int>(lessonsWatched),
      'lessonsCompleted': serializer.toJson<int>(lessonsCompleted),
      'questionsAttempted': serializer.toJson<int>(questionsAttempted),
      'minutesStudied': serializer.toJson<int>(minutesStudied),
      'accuracyToday': serializer.toJson<double>(accuracyToday),
      'streakMaintained': serializer.toJson<bool>(streakMaintained),
    };
  }

  LocalDailyLearningSummaryData copyWith({
    String? studentId,
    DateTime? summaryDate,
    int? lessonsWatched,
    int? lessonsCompleted,
    int? questionsAttempted,
    int? minutesStudied,
    double? accuracyToday,
    bool? streakMaintained,
  }) => LocalDailyLearningSummaryData(
    studentId: studentId ?? this.studentId,
    summaryDate: summaryDate ?? this.summaryDate,
    lessonsWatched: lessonsWatched ?? this.lessonsWatched,
    lessonsCompleted: lessonsCompleted ?? this.lessonsCompleted,
    questionsAttempted: questionsAttempted ?? this.questionsAttempted,
    minutesStudied: minutesStudied ?? this.minutesStudied,
    accuracyToday: accuracyToday ?? this.accuracyToday,
    streakMaintained: streakMaintained ?? this.streakMaintained,
  );
  LocalDailyLearningSummaryData copyWithCompanion(
    LocalDailyLearningSummaryCompanion data,
  ) {
    return LocalDailyLearningSummaryData(
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      summaryDate: data.summaryDate.present
          ? data.summaryDate.value
          : this.summaryDate,
      lessonsWatched: data.lessonsWatched.present
          ? data.lessonsWatched.value
          : this.lessonsWatched,
      lessonsCompleted: data.lessonsCompleted.present
          ? data.lessonsCompleted.value
          : this.lessonsCompleted,
      questionsAttempted: data.questionsAttempted.present
          ? data.questionsAttempted.value
          : this.questionsAttempted,
      minutesStudied: data.minutesStudied.present
          ? data.minutesStudied.value
          : this.minutesStudied,
      accuracyToday: data.accuracyToday.present
          ? data.accuracyToday.value
          : this.accuracyToday,
      streakMaintained: data.streakMaintained.present
          ? data.streakMaintained.value
          : this.streakMaintained,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalDailyLearningSummaryData(')
          ..write('studentId: $studentId, ')
          ..write('summaryDate: $summaryDate, ')
          ..write('lessonsWatched: $lessonsWatched, ')
          ..write('lessonsCompleted: $lessonsCompleted, ')
          ..write('questionsAttempted: $questionsAttempted, ')
          ..write('minutesStudied: $minutesStudied, ')
          ..write('accuracyToday: $accuracyToday, ')
          ..write('streakMaintained: $streakMaintained')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    studentId,
    summaryDate,
    lessonsWatched,
    lessonsCompleted,
    questionsAttempted,
    minutesStudied,
    accuracyToday,
    streakMaintained,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalDailyLearningSummaryData &&
          other.studentId == this.studentId &&
          other.summaryDate == this.summaryDate &&
          other.lessonsWatched == this.lessonsWatched &&
          other.lessonsCompleted == this.lessonsCompleted &&
          other.questionsAttempted == this.questionsAttempted &&
          other.minutesStudied == this.minutesStudied &&
          other.accuracyToday == this.accuracyToday &&
          other.streakMaintained == this.streakMaintained);
}

class LocalDailyLearningSummaryCompanion
    extends UpdateCompanion<LocalDailyLearningSummaryData> {
  final Value<String> studentId;
  final Value<DateTime> summaryDate;
  final Value<int> lessonsWatched;
  final Value<int> lessonsCompleted;
  final Value<int> questionsAttempted;
  final Value<int> minutesStudied;
  final Value<double> accuracyToday;
  final Value<bool> streakMaintained;
  final Value<int> rowid;
  const LocalDailyLearningSummaryCompanion({
    this.studentId = const Value.absent(),
    this.summaryDate = const Value.absent(),
    this.lessonsWatched = const Value.absent(),
    this.lessonsCompleted = const Value.absent(),
    this.questionsAttempted = const Value.absent(),
    this.minutesStudied = const Value.absent(),
    this.accuracyToday = const Value.absent(),
    this.streakMaintained = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalDailyLearningSummaryCompanion.insert({
    required String studentId,
    required DateTime summaryDate,
    this.lessonsWatched = const Value.absent(),
    this.lessonsCompleted = const Value.absent(),
    this.questionsAttempted = const Value.absent(),
    this.minutesStudied = const Value.absent(),
    this.accuracyToday = const Value.absent(),
    this.streakMaintained = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : studentId = Value(studentId),
       summaryDate = Value(summaryDate);
  static Insertable<LocalDailyLearningSummaryData> custom({
    Expression<String>? studentId,
    Expression<DateTime>? summaryDate,
    Expression<int>? lessonsWatched,
    Expression<int>? lessonsCompleted,
    Expression<int>? questionsAttempted,
    Expression<int>? minutesStudied,
    Expression<double>? accuracyToday,
    Expression<bool>? streakMaintained,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (studentId != null) 'student_id': studentId,
      if (summaryDate != null) 'summary_date': summaryDate,
      if (lessonsWatched != null) 'lessons_watched': lessonsWatched,
      if (lessonsCompleted != null) 'lessons_completed': lessonsCompleted,
      if (questionsAttempted != null) 'questions_attempted': questionsAttempted,
      if (minutesStudied != null) 'minutes_studied': minutesStudied,
      if (accuracyToday != null) 'accuracy_today': accuracyToday,
      if (streakMaintained != null) 'streak_maintained': streakMaintained,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalDailyLearningSummaryCompanion copyWith({
    Value<String>? studentId,
    Value<DateTime>? summaryDate,
    Value<int>? lessonsWatched,
    Value<int>? lessonsCompleted,
    Value<int>? questionsAttempted,
    Value<int>? minutesStudied,
    Value<double>? accuracyToday,
    Value<bool>? streakMaintained,
    Value<int>? rowid,
  }) {
    return LocalDailyLearningSummaryCompanion(
      studentId: studentId ?? this.studentId,
      summaryDate: summaryDate ?? this.summaryDate,
      lessonsWatched: lessonsWatched ?? this.lessonsWatched,
      lessonsCompleted: lessonsCompleted ?? this.lessonsCompleted,
      questionsAttempted: questionsAttempted ?? this.questionsAttempted,
      minutesStudied: minutesStudied ?? this.minutesStudied,
      accuracyToday: accuracyToday ?? this.accuracyToday,
      streakMaintained: streakMaintained ?? this.streakMaintained,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (summaryDate.present) {
      map['summary_date'] = Variable<DateTime>(summaryDate.value);
    }
    if (lessonsWatched.present) {
      map['lessons_watched'] = Variable<int>(lessonsWatched.value);
    }
    if (lessonsCompleted.present) {
      map['lessons_completed'] = Variable<int>(lessonsCompleted.value);
    }
    if (questionsAttempted.present) {
      map['questions_attempted'] = Variable<int>(questionsAttempted.value);
    }
    if (minutesStudied.present) {
      map['minutes_studied'] = Variable<int>(minutesStudied.value);
    }
    if (accuracyToday.present) {
      map['accuracy_today'] = Variable<double>(accuracyToday.value);
    }
    if (streakMaintained.present) {
      map['streak_maintained'] = Variable<bool>(streakMaintained.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalDailyLearningSummaryCompanion(')
          ..write('studentId: $studentId, ')
          ..write('summaryDate: $summaryDate, ')
          ..write('lessonsWatched: $lessonsWatched, ')
          ..write('lessonsCompleted: $lessonsCompleted, ')
          ..write('questionsAttempted: $questionsAttempted, ')
          ..write('minutesStudied: $minutesStudied, ')
          ..write('accuracyToday: $accuracyToday, ')
          ..write('streakMaintained: $streakMaintained, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalStudentNotesTable extends LocalStudentNotes
    with TableInfo<$LocalStudentNotesTable, LocalStudentNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalStudentNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampSecMeta = const VerificationMeta(
    'timestampSec',
  );
  @override
  late final GeneratedColumn<int> timestampSec = GeneratedColumn<int>(
    'timestamp_sec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    lessonId,
    tenantId,
    timestampSec,
    content,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_student_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalStudentNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('timestamp_sec')) {
      context.handle(
        _timestampSecMeta,
        timestampSec.isAcceptableOrUnknown(
          data['timestamp_sec']!,
          _timestampSecMeta,
        ),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalStudentNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalStudentNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson_id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      timestampSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_sec'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocalStudentNotesTable createAlias(String alias) {
    return $LocalStudentNotesTable(attachedDatabase, alias);
  }
}

class LocalStudentNote extends DataClass
    implements Insertable<LocalStudentNote> {
  final int id;
  final String studentId;
  final String lessonId;
  final String tenantId;
  final int? timestampSec;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalStudentNote({
    required this.id,
    required this.studentId,
    required this.lessonId,
    required this.tenantId,
    this.timestampSec,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<String>(studentId);
    map['lesson_id'] = Variable<String>(lessonId);
    map['tenant_id'] = Variable<String>(tenantId);
    if (!nullToAbsent || timestampSec != null) {
      map['timestamp_sec'] = Variable<int>(timestampSec);
    }
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalStudentNotesCompanion toCompanion(bool nullToAbsent) {
    return LocalStudentNotesCompanion(
      id: Value(id),
      studentId: Value(studentId),
      lessonId: Value(lessonId),
      tenantId: Value(tenantId),
      timestampSec: timestampSec == null && nullToAbsent
          ? const Value.absent()
          : Value(timestampSec),
      content: Value(content),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalStudentNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalStudentNote(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<String>(json['studentId']),
      lessonId: serializer.fromJson<String>(json['lessonId']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      timestampSec: serializer.fromJson<int?>(json['timestampSec']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<String>(studentId),
      'lessonId': serializer.toJson<String>(lessonId),
      'tenantId': serializer.toJson<String>(tenantId),
      'timestampSec': serializer.toJson<int?>(timestampSec),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalStudentNote copyWith({
    int? id,
    String? studentId,
    String? lessonId,
    String? tenantId,
    Value<int?> timestampSec = const Value.absent(),
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LocalStudentNote(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    lessonId: lessonId ?? this.lessonId,
    tenantId: tenantId ?? this.tenantId,
    timestampSec: timestampSec.present ? timestampSec.value : this.timestampSec,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalStudentNote copyWithCompanion(LocalStudentNotesCompanion data) {
    return LocalStudentNote(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      timestampSec: data.timestampSec.present
          ? data.timestampSec.value
          : this.timestampSec,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalStudentNote(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('lessonId: $lessonId, ')
          ..write('tenantId: $tenantId, ')
          ..write('timestampSec: $timestampSec, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    lessonId,
    tenantId,
    timestampSec,
    content,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalStudentNote &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.lessonId == this.lessonId &&
          other.tenantId == this.tenantId &&
          other.timestampSec == this.timestampSec &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalStudentNotesCompanion extends UpdateCompanion<LocalStudentNote> {
  final Value<int> id;
  final Value<String> studentId;
  final Value<String> lessonId;
  final Value<String> tenantId;
  final Value<int?> timestampSec;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LocalStudentNotesCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.timestampSec = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalStudentNotesCompanion.insert({
    this.id = const Value.absent(),
    required String studentId,
    required String lessonId,
    required String tenantId,
    this.timestampSec = const Value.absent(),
    required String content,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : studentId = Value(studentId),
       lessonId = Value(lessonId),
       tenantId = Value(tenantId),
       content = Value(content);
  static Insertable<LocalStudentNote> custom({
    Expression<int>? id,
    Expression<String>? studentId,
    Expression<String>? lessonId,
    Expression<String>? tenantId,
    Expression<int>? timestampSec,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (lessonId != null) 'lesson_id': lessonId,
      if (tenantId != null) 'tenant_id': tenantId,
      if (timestampSec != null) 'timestamp_sec': timestampSec,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalStudentNotesCompanion copyWith({
    Value<int>? id,
    Value<String>? studentId,
    Value<String>? lessonId,
    Value<String>? tenantId,
    Value<int?>? timestampSec,
    Value<String>? content,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LocalStudentNotesCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      lessonId: lessonId ?? this.lessonId,
      tenantId: tenantId ?? this.tenantId,
      timestampSec: timestampSec ?? this.timestampSec,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (timestampSec.present) {
      map['timestamp_sec'] = Variable<int>(timestampSec.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalStudentNotesCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('lessonId: $lessonId, ')
          ..write('tenantId: $tenantId, ')
          ..write('timestampSec: $timestampSec, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalStudentBookmarksTable extends LocalStudentBookmarks
    with TableInfo<$LocalStudentBookmarksTable, LocalStudentBookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalStudentBookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    studentId,
    tenantId,
    contentType,
    contentId,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_student_bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalStudentBookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {studentId, contentType, contentId};
  @override
  LocalStudentBookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalStudentBookmark(
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalStudentBookmarksTable createAlias(String alias) {
    return $LocalStudentBookmarksTable(attachedDatabase, alias);
  }
}

class LocalStudentBookmark extends DataClass
    implements Insertable<LocalStudentBookmark> {
  final String studentId;
  final String tenantId;
  final String contentType;
  final String contentId;
  final String? note;
  final DateTime createdAt;
  const LocalStudentBookmark({
    required this.studentId,
    required this.tenantId,
    required this.contentType,
    required this.contentId,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['student_id'] = Variable<String>(studentId);
    map['tenant_id'] = Variable<String>(tenantId);
    map['content_type'] = Variable<String>(contentType);
    map['content_id'] = Variable<String>(contentId);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalStudentBookmarksCompanion toCompanion(bool nullToAbsent) {
    return LocalStudentBookmarksCompanion(
      studentId: Value(studentId),
      tenantId: Value(tenantId),
      contentType: Value(contentType),
      contentId: Value(contentId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory LocalStudentBookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalStudentBookmark(
      studentId: serializer.fromJson<String>(json['studentId']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      contentType: serializer.fromJson<String>(json['contentType']),
      contentId: serializer.fromJson<String>(json['contentId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'studentId': serializer.toJson<String>(studentId),
      'tenantId': serializer.toJson<String>(tenantId),
      'contentType': serializer.toJson<String>(contentType),
      'contentId': serializer.toJson<String>(contentId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalStudentBookmark copyWith({
    String? studentId,
    String? tenantId,
    String? contentType,
    String? contentId,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => LocalStudentBookmark(
    studentId: studentId ?? this.studentId,
    tenantId: tenantId ?? this.tenantId,
    contentType: contentType ?? this.contentType,
    contentId: contentId ?? this.contentId,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalStudentBookmark copyWithCompanion(LocalStudentBookmarksCompanion data) {
    return LocalStudentBookmark(
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalStudentBookmark(')
          ..write('studentId: $studentId, ')
          ..write('tenantId: $tenantId, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(studentId, tenantId, contentType, contentId, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalStudentBookmark &&
          other.studentId == this.studentId &&
          other.tenantId == this.tenantId &&
          other.contentType == this.contentType &&
          other.contentId == this.contentId &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class LocalStudentBookmarksCompanion
    extends UpdateCompanion<LocalStudentBookmark> {
  final Value<String> studentId;
  final Value<String> tenantId;
  final Value<String> contentType;
  final Value<String> contentId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalStudentBookmarksCompanion({
    this.studentId = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.contentType = const Value.absent(),
    this.contentId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalStudentBookmarksCompanion.insert({
    required String studentId,
    required String tenantId,
    required String contentType,
    required String contentId,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : studentId = Value(studentId),
       tenantId = Value(tenantId),
       contentType = Value(contentType),
       contentId = Value(contentId);
  static Insertable<LocalStudentBookmark> custom({
    Expression<String>? studentId,
    Expression<String>? tenantId,
    Expression<String>? contentType,
    Expression<String>? contentId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (studentId != null) 'student_id': studentId,
      if (tenantId != null) 'tenant_id': tenantId,
      if (contentType != null) 'content_type': contentType,
      if (contentId != null) 'content_id': contentId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalStudentBookmarksCompanion copyWith({
    Value<String>? studentId,
    Value<String>? tenantId,
    Value<String>? contentType,
    Value<String>? contentId,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LocalStudentBookmarksCompanion(
      studentId: studentId ?? this.studentId,
      tenantId: tenantId ?? this.tenantId,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalStudentBookmarksCompanion(')
          ..write('studentId: $studentId, ')
          ..write('tenantId: $tenantId, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalLearningEventsTable localLearningEvents =
      $LocalLearningEventsTable(this);
  late final $LocalLessonMasteryTable localLessonMastery =
      $LocalLessonMasteryTable(this);
  late final $LocalTopicMasteryTable localTopicMastery =
      $LocalTopicMasteryTable(this);
  late final $LocalSmartReviewQueueTable localSmartReviewQueue =
      $LocalSmartReviewQueueTable(this);
  late final $LocalDailyLearningSummaryTable localDailyLearningSummary =
      $LocalDailyLearningSummaryTable(this);
  late final $LocalStudentNotesTable localStudentNotes =
      $LocalStudentNotesTable(this);
  late final $LocalStudentBookmarksTable localStudentBookmarks =
      $LocalStudentBookmarksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localLearningEvents,
    localLessonMastery,
    localTopicMastery,
    localSmartReviewQueue,
    localDailyLearningSummary,
    localStudentNotes,
    localStudentBookmarks,
  ];
}

typedef $$LocalLearningEventsTableCreateCompanionBuilder =
    LocalLearningEventsCompanion Function({
      Value<int> id,
      required String studentId,
      required String lessonId,
      required String eventType,
      required int positionSec,
      Value<DateTime> createdAt,
      Value<String?> metadata,
    });
typedef $$LocalLearningEventsTableUpdateCompanionBuilder =
    LocalLearningEventsCompanion Function({
      Value<int> id,
      Value<String> studentId,
      Value<String> lessonId,
      Value<String> eventType,
      Value<int> positionSec,
      Value<DateTime> createdAt,
      Value<String?> metadata,
    });

class $$LocalLearningEventsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalLearningEventsTable> {
  $$LocalLearningEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get positionSec => $composableBuilder(
    column: $table.positionSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalLearningEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalLearningEventsTable> {
  $$LocalLearningEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get positionSec => $composableBuilder(
    column: $table.positionSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalLearningEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalLearningEventsTable> {
  $$LocalLearningEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<int> get positionSec => $composableBuilder(
    column: $table.positionSec,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$LocalLearningEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalLearningEventsTable,
          LocalLearningEvent,
          $$LocalLearningEventsTableFilterComposer,
          $$LocalLearningEventsTableOrderingComposer,
          $$LocalLearningEventsTableAnnotationComposer,
          $$LocalLearningEventsTableCreateCompanionBuilder,
          $$LocalLearningEventsTableUpdateCompanionBuilder,
          (
            LocalLearningEvent,
            BaseReferences<
              _$AppDatabase,
              $LocalLearningEventsTable,
              LocalLearningEvent
            >,
          ),
          LocalLearningEvent,
          PrefetchHooks Function()
        > {
  $$LocalLearningEventsTableTableManager(
    _$AppDatabase db,
    $LocalLearningEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalLearningEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalLearningEventsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalLearningEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<String> lessonId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<int> positionSec = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
              }) => LocalLearningEventsCompanion(
                id: id,
                studentId: studentId,
                lessonId: lessonId,
                eventType: eventType,
                positionSec: positionSec,
                createdAt: createdAt,
                metadata: metadata,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String studentId,
                required String lessonId,
                required String eventType,
                required int positionSec,
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
              }) => LocalLearningEventsCompanion.insert(
                id: id,
                studentId: studentId,
                lessonId: lessonId,
                eventType: eventType,
                positionSec: positionSec,
                createdAt: createdAt,
                metadata: metadata,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalLearningEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalLearningEventsTable,
      LocalLearningEvent,
      $$LocalLearningEventsTableFilterComposer,
      $$LocalLearningEventsTableOrderingComposer,
      $$LocalLearningEventsTableAnnotationComposer,
      $$LocalLearningEventsTableCreateCompanionBuilder,
      $$LocalLearningEventsTableUpdateCompanionBuilder,
      (
        LocalLearningEvent,
        BaseReferences<
          _$AppDatabase,
          $LocalLearningEventsTable,
          LocalLearningEvent
        >,
      ),
      LocalLearningEvent,
      PrefetchHooks Function()
    >;
typedef $$LocalLessonMasteryTableCreateCompanionBuilder =
    LocalLessonMasteryCompanion Function({
      required String lessonId,
      required String studentId,
      required String tenantId,
      Value<int> watchPercentage,
      Value<int> lastPositionSec,
      Value<double> struggleScore,
      Value<double> masteryScore,
      Value<DateTime> lastAccessedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalLessonMasteryTableUpdateCompanionBuilder =
    LocalLessonMasteryCompanion Function({
      Value<String> lessonId,
      Value<String> studentId,
      Value<String> tenantId,
      Value<int> watchPercentage,
      Value<int> lastPositionSec,
      Value<double> struggleScore,
      Value<double> masteryScore,
      Value<DateTime> lastAccessedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalLessonMasteryTableFilterComposer
    extends Composer<_$AppDatabase, $LocalLessonMasteryTable> {
  $$LocalLessonMasteryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get watchPercentage => $composableBuilder(
    column: $table.watchPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastPositionSec => $composableBuilder(
    column: $table.lastPositionSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get struggleScore => $composableBuilder(
    column: $table.struggleScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get masteryScore => $composableBuilder(
    column: $table.masteryScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAccessedAt => $composableBuilder(
    column: $table.lastAccessedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalLessonMasteryTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalLessonMasteryTable> {
  $$LocalLessonMasteryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get watchPercentage => $composableBuilder(
    column: $table.watchPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastPositionSec => $composableBuilder(
    column: $table.lastPositionSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get struggleScore => $composableBuilder(
    column: $table.struggleScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get masteryScore => $composableBuilder(
    column: $table.masteryScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAccessedAt => $composableBuilder(
    column: $table.lastAccessedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalLessonMasteryTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalLessonMasteryTable> {
  $$LocalLessonMasteryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<int> get watchPercentage => $composableBuilder(
    column: $table.watchPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastPositionSec => $composableBuilder(
    column: $table.lastPositionSec,
    builder: (column) => column,
  );

  GeneratedColumn<double> get struggleScore => $composableBuilder(
    column: $table.struggleScore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get masteryScore => $composableBuilder(
    column: $table.masteryScore,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAccessedAt => $composableBuilder(
    column: $table.lastAccessedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalLessonMasteryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalLessonMasteryTable,
          LocalLessonMasteryData,
          $$LocalLessonMasteryTableFilterComposer,
          $$LocalLessonMasteryTableOrderingComposer,
          $$LocalLessonMasteryTableAnnotationComposer,
          $$LocalLessonMasteryTableCreateCompanionBuilder,
          $$LocalLessonMasteryTableUpdateCompanionBuilder,
          (
            LocalLessonMasteryData,
            BaseReferences<
              _$AppDatabase,
              $LocalLessonMasteryTable,
              LocalLessonMasteryData
            >,
          ),
          LocalLessonMasteryData,
          PrefetchHooks Function()
        > {
  $$LocalLessonMasteryTableTableManager(
    _$AppDatabase db,
    $LocalLessonMasteryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalLessonMasteryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalLessonMasteryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalLessonMasteryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> lessonId = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<int> watchPercentage = const Value.absent(),
                Value<int> lastPositionSec = const Value.absent(),
                Value<double> struggleScore = const Value.absent(),
                Value<double> masteryScore = const Value.absent(),
                Value<DateTime> lastAccessedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalLessonMasteryCompanion(
                lessonId: lessonId,
                studentId: studentId,
                tenantId: tenantId,
                watchPercentage: watchPercentage,
                lastPositionSec: lastPositionSec,
                struggleScore: struggleScore,
                masteryScore: masteryScore,
                lastAccessedAt: lastAccessedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String lessonId,
                required String studentId,
                required String tenantId,
                Value<int> watchPercentage = const Value.absent(),
                Value<int> lastPositionSec = const Value.absent(),
                Value<double> struggleScore = const Value.absent(),
                Value<double> masteryScore = const Value.absent(),
                Value<DateTime> lastAccessedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalLessonMasteryCompanion.insert(
                lessonId: lessonId,
                studentId: studentId,
                tenantId: tenantId,
                watchPercentage: watchPercentage,
                lastPositionSec: lastPositionSec,
                struggleScore: struggleScore,
                masteryScore: masteryScore,
                lastAccessedAt: lastAccessedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalLessonMasteryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalLessonMasteryTable,
      LocalLessonMasteryData,
      $$LocalLessonMasteryTableFilterComposer,
      $$LocalLessonMasteryTableOrderingComposer,
      $$LocalLessonMasteryTableAnnotationComposer,
      $$LocalLessonMasteryTableCreateCompanionBuilder,
      $$LocalLessonMasteryTableUpdateCompanionBuilder,
      (
        LocalLessonMasteryData,
        BaseReferences<
          _$AppDatabase,
          $LocalLessonMasteryTable,
          LocalLessonMasteryData
        >,
      ),
      LocalLessonMasteryData,
      PrefetchHooks Function()
    >;
typedef $$LocalTopicMasteryTableCreateCompanionBuilder =
    LocalTopicMasteryCompanion Function({
      required String studentId,
      required String topicType,
      required String topicId,
      required String topicTag,
      Value<int> totalAttempts,
      Value<int> correctAttempts,
      Value<double> speedScore,
      Value<double> masteryScore,
      Value<double?> previousMasteryScore,
      Value<DateTime?> lastAttemptedAt,
      Value<int> rowid,
    });
typedef $$LocalTopicMasteryTableUpdateCompanionBuilder =
    LocalTopicMasteryCompanion Function({
      Value<String> studentId,
      Value<String> topicType,
      Value<String> topicId,
      Value<String> topicTag,
      Value<int> totalAttempts,
      Value<int> correctAttempts,
      Value<double> speedScore,
      Value<double> masteryScore,
      Value<double?> previousMasteryScore,
      Value<DateTime?> lastAttemptedAt,
      Value<int> rowid,
    });

class $$LocalTopicMasteryTableFilterComposer
    extends Composer<_$AppDatabase, $LocalTopicMasteryTable> {
  $$LocalTopicMasteryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicType => $composableBuilder(
    column: $table.topicType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicTag => $composableBuilder(
    column: $table.topicTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAttempts => $composableBuilder(
    column: $table.totalAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAttempts => $composableBuilder(
    column: $table.correctAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speedScore => $composableBuilder(
    column: $table.speedScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get masteryScore => $composableBuilder(
    column: $table.masteryScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get previousMasteryScore => $composableBuilder(
    column: $table.previousMasteryScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptedAt => $composableBuilder(
    column: $table.lastAttemptedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalTopicMasteryTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalTopicMasteryTable> {
  $$LocalTopicMasteryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicType => $composableBuilder(
    column: $table.topicType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicTag => $composableBuilder(
    column: $table.topicTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAttempts => $composableBuilder(
    column: $table.totalAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAttempts => $composableBuilder(
    column: $table.correctAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speedScore => $composableBuilder(
    column: $table.speedScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get masteryScore => $composableBuilder(
    column: $table.masteryScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get previousMasteryScore => $composableBuilder(
    column: $table.previousMasteryScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptedAt => $composableBuilder(
    column: $table.lastAttemptedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalTopicMasteryTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalTopicMasteryTable> {
  $$LocalTopicMasteryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get topicType =>
      $composableBuilder(column: $table.topicType, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<String> get topicTag =>
      $composableBuilder(column: $table.topicTag, builder: (column) => column);

  GeneratedColumn<int> get totalAttempts => $composableBuilder(
    column: $table.totalAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctAttempts => $composableBuilder(
    column: $table.correctAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<double> get speedScore => $composableBuilder(
    column: $table.speedScore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get masteryScore => $composableBuilder(
    column: $table.masteryScore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get previousMasteryScore => $composableBuilder(
    column: $table.previousMasteryScore,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemptedAt => $composableBuilder(
    column: $table.lastAttemptedAt,
    builder: (column) => column,
  );
}

class $$LocalTopicMasteryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalTopicMasteryTable,
          LocalTopicMasteryData,
          $$LocalTopicMasteryTableFilterComposer,
          $$LocalTopicMasteryTableOrderingComposer,
          $$LocalTopicMasteryTableAnnotationComposer,
          $$LocalTopicMasteryTableCreateCompanionBuilder,
          $$LocalTopicMasteryTableUpdateCompanionBuilder,
          (
            LocalTopicMasteryData,
            BaseReferences<
              _$AppDatabase,
              $LocalTopicMasteryTable,
              LocalTopicMasteryData
            >,
          ),
          LocalTopicMasteryData,
          PrefetchHooks Function()
        > {
  $$LocalTopicMasteryTableTableManager(
    _$AppDatabase db,
    $LocalTopicMasteryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalTopicMasteryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalTopicMasteryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalTopicMasteryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> studentId = const Value.absent(),
                Value<String> topicType = const Value.absent(),
                Value<String> topicId = const Value.absent(),
                Value<String> topicTag = const Value.absent(),
                Value<int> totalAttempts = const Value.absent(),
                Value<int> correctAttempts = const Value.absent(),
                Value<double> speedScore = const Value.absent(),
                Value<double> masteryScore = const Value.absent(),
                Value<double?> previousMasteryScore = const Value.absent(),
                Value<DateTime?> lastAttemptedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalTopicMasteryCompanion(
                studentId: studentId,
                topicType: topicType,
                topicId: topicId,
                topicTag: topicTag,
                totalAttempts: totalAttempts,
                correctAttempts: correctAttempts,
                speedScore: speedScore,
                masteryScore: masteryScore,
                previousMasteryScore: previousMasteryScore,
                lastAttemptedAt: lastAttemptedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String studentId,
                required String topicType,
                required String topicId,
                required String topicTag,
                Value<int> totalAttempts = const Value.absent(),
                Value<int> correctAttempts = const Value.absent(),
                Value<double> speedScore = const Value.absent(),
                Value<double> masteryScore = const Value.absent(),
                Value<double?> previousMasteryScore = const Value.absent(),
                Value<DateTime?> lastAttemptedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalTopicMasteryCompanion.insert(
                studentId: studentId,
                topicType: topicType,
                topicId: topicId,
                topicTag: topicTag,
                totalAttempts: totalAttempts,
                correctAttempts: correctAttempts,
                speedScore: speedScore,
                masteryScore: masteryScore,
                previousMasteryScore: previousMasteryScore,
                lastAttemptedAt: lastAttemptedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalTopicMasteryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalTopicMasteryTable,
      LocalTopicMasteryData,
      $$LocalTopicMasteryTableFilterComposer,
      $$LocalTopicMasteryTableOrderingComposer,
      $$LocalTopicMasteryTableAnnotationComposer,
      $$LocalTopicMasteryTableCreateCompanionBuilder,
      $$LocalTopicMasteryTableUpdateCompanionBuilder,
      (
        LocalTopicMasteryData,
        BaseReferences<
          _$AppDatabase,
          $LocalTopicMasteryTable,
          LocalTopicMasteryData
        >,
      ),
      LocalTopicMasteryData,
      PrefetchHooks Function()
    >;
typedef $$LocalSmartReviewQueueTableCreateCompanionBuilder =
    LocalSmartReviewQueueCompanion Function({
      required String studentId,
      required String contentType,
      required String contentId,
      Value<String?> topicTag,
      Value<int> intervalDays,
      Value<double> easeFactor,
      Value<int> reviewCount,
      required DateTime nextReviewAt,
      Value<double> priorityScore,
      Value<DateTime?> lastReviewedAt,
      Value<int> rowid,
    });
typedef $$LocalSmartReviewQueueTableUpdateCompanionBuilder =
    LocalSmartReviewQueueCompanion Function({
      Value<String> studentId,
      Value<String> contentType,
      Value<String> contentId,
      Value<String?> topicTag,
      Value<int> intervalDays,
      Value<double> easeFactor,
      Value<int> reviewCount,
      Value<DateTime> nextReviewAt,
      Value<double> priorityScore,
      Value<DateTime?> lastReviewedAt,
      Value<int> rowid,
    });

class $$LocalSmartReviewQueueTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSmartReviewQueueTable> {
  $$LocalSmartReviewQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicTag => $composableBuilder(
    column: $table.topicTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priorityScore => $composableBuilder(
    column: $table.priorityScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalSmartReviewQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSmartReviewQueueTable> {
  $$LocalSmartReviewQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicTag => $composableBuilder(
    column: $table.topicTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priorityScore => $composableBuilder(
    column: $table.priorityScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalSmartReviewQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSmartReviewQueueTable> {
  $$LocalSmartReviewQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<String> get topicTag =>
      $composableBuilder(column: $table.topicTag, builder: (column) => column);

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get priorityScore => $composableBuilder(
    column: $table.priorityScore,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );
}

class $$LocalSmartReviewQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSmartReviewQueueTable,
          LocalSmartReviewQueueData,
          $$LocalSmartReviewQueueTableFilterComposer,
          $$LocalSmartReviewQueueTableOrderingComposer,
          $$LocalSmartReviewQueueTableAnnotationComposer,
          $$LocalSmartReviewQueueTableCreateCompanionBuilder,
          $$LocalSmartReviewQueueTableUpdateCompanionBuilder,
          (
            LocalSmartReviewQueueData,
            BaseReferences<
              _$AppDatabase,
              $LocalSmartReviewQueueTable,
              LocalSmartReviewQueueData
            >,
          ),
          LocalSmartReviewQueueData,
          PrefetchHooks Function()
        > {
  $$LocalSmartReviewQueueTableTableManager(
    _$AppDatabase db,
    $LocalSmartReviewQueueTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSmartReviewQueueTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalSmartReviewQueueTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalSmartReviewQueueTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> studentId = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String> contentId = const Value.absent(),
                Value<String?> topicTag = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<DateTime> nextReviewAt = const Value.absent(),
                Value<double> priorityScore = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSmartReviewQueueCompanion(
                studentId: studentId,
                contentType: contentType,
                contentId: contentId,
                topicTag: topicTag,
                intervalDays: intervalDays,
                easeFactor: easeFactor,
                reviewCount: reviewCount,
                nextReviewAt: nextReviewAt,
                priorityScore: priorityScore,
                lastReviewedAt: lastReviewedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String studentId,
                required String contentType,
                required String contentId,
                Value<String?> topicTag = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                required DateTime nextReviewAt,
                Value<double> priorityScore = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSmartReviewQueueCompanion.insert(
                studentId: studentId,
                contentType: contentType,
                contentId: contentId,
                topicTag: topicTag,
                intervalDays: intervalDays,
                easeFactor: easeFactor,
                reviewCount: reviewCount,
                nextReviewAt: nextReviewAt,
                priorityScore: priorityScore,
                lastReviewedAt: lastReviewedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalSmartReviewQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSmartReviewQueueTable,
      LocalSmartReviewQueueData,
      $$LocalSmartReviewQueueTableFilterComposer,
      $$LocalSmartReviewQueueTableOrderingComposer,
      $$LocalSmartReviewQueueTableAnnotationComposer,
      $$LocalSmartReviewQueueTableCreateCompanionBuilder,
      $$LocalSmartReviewQueueTableUpdateCompanionBuilder,
      (
        LocalSmartReviewQueueData,
        BaseReferences<
          _$AppDatabase,
          $LocalSmartReviewQueueTable,
          LocalSmartReviewQueueData
        >,
      ),
      LocalSmartReviewQueueData,
      PrefetchHooks Function()
    >;
typedef $$LocalDailyLearningSummaryTableCreateCompanionBuilder =
    LocalDailyLearningSummaryCompanion Function({
      required String studentId,
      required DateTime summaryDate,
      Value<int> lessonsWatched,
      Value<int> lessonsCompleted,
      Value<int> questionsAttempted,
      Value<int> minutesStudied,
      Value<double> accuracyToday,
      Value<bool> streakMaintained,
      Value<int> rowid,
    });
typedef $$LocalDailyLearningSummaryTableUpdateCompanionBuilder =
    LocalDailyLearningSummaryCompanion Function({
      Value<String> studentId,
      Value<DateTime> summaryDate,
      Value<int> lessonsWatched,
      Value<int> lessonsCompleted,
      Value<int> questionsAttempted,
      Value<int> minutesStudied,
      Value<double> accuracyToday,
      Value<bool> streakMaintained,
      Value<int> rowid,
    });

class $$LocalDailyLearningSummaryTableFilterComposer
    extends Composer<_$AppDatabase, $LocalDailyLearningSummaryTable> {
  $$LocalDailyLearningSummaryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get summaryDate => $composableBuilder(
    column: $table.summaryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lessonsWatched => $composableBuilder(
    column: $table.lessonsWatched,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lessonsCompleted => $composableBuilder(
    column: $table.lessonsCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get questionsAttempted => $composableBuilder(
    column: $table.questionsAttempted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minutesStudied => $composableBuilder(
    column: $table.minutesStudied,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyToday => $composableBuilder(
    column: $table.accuracyToday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get streakMaintained => $composableBuilder(
    column: $table.streakMaintained,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalDailyLearningSummaryTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalDailyLearningSummaryTable> {
  $$LocalDailyLearningSummaryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get summaryDate => $composableBuilder(
    column: $table.summaryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lessonsWatched => $composableBuilder(
    column: $table.lessonsWatched,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lessonsCompleted => $composableBuilder(
    column: $table.lessonsCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get questionsAttempted => $composableBuilder(
    column: $table.questionsAttempted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minutesStudied => $composableBuilder(
    column: $table.minutesStudied,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyToday => $composableBuilder(
    column: $table.accuracyToday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get streakMaintained => $composableBuilder(
    column: $table.streakMaintained,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalDailyLearningSummaryTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalDailyLearningSummaryTable> {
  $$LocalDailyLearningSummaryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<DateTime> get summaryDate => $composableBuilder(
    column: $table.summaryDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lessonsWatched => $composableBuilder(
    column: $table.lessonsWatched,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lessonsCompleted => $composableBuilder(
    column: $table.lessonsCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get questionsAttempted => $composableBuilder(
    column: $table.questionsAttempted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minutesStudied => $composableBuilder(
    column: $table.minutesStudied,
    builder: (column) => column,
  );

  GeneratedColumn<double> get accuracyToday => $composableBuilder(
    column: $table.accuracyToday,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get streakMaintained => $composableBuilder(
    column: $table.streakMaintained,
    builder: (column) => column,
  );
}

class $$LocalDailyLearningSummaryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalDailyLearningSummaryTable,
          LocalDailyLearningSummaryData,
          $$LocalDailyLearningSummaryTableFilterComposer,
          $$LocalDailyLearningSummaryTableOrderingComposer,
          $$LocalDailyLearningSummaryTableAnnotationComposer,
          $$LocalDailyLearningSummaryTableCreateCompanionBuilder,
          $$LocalDailyLearningSummaryTableUpdateCompanionBuilder,
          (
            LocalDailyLearningSummaryData,
            BaseReferences<
              _$AppDatabase,
              $LocalDailyLearningSummaryTable,
              LocalDailyLearningSummaryData
            >,
          ),
          LocalDailyLearningSummaryData,
          PrefetchHooks Function()
        > {
  $$LocalDailyLearningSummaryTableTableManager(
    _$AppDatabase db,
    $LocalDailyLearningSummaryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalDailyLearningSummaryTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalDailyLearningSummaryTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalDailyLearningSummaryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> studentId = const Value.absent(),
                Value<DateTime> summaryDate = const Value.absent(),
                Value<int> lessonsWatched = const Value.absent(),
                Value<int> lessonsCompleted = const Value.absent(),
                Value<int> questionsAttempted = const Value.absent(),
                Value<int> minutesStudied = const Value.absent(),
                Value<double> accuracyToday = const Value.absent(),
                Value<bool> streakMaintained = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalDailyLearningSummaryCompanion(
                studentId: studentId,
                summaryDate: summaryDate,
                lessonsWatched: lessonsWatched,
                lessonsCompleted: lessonsCompleted,
                questionsAttempted: questionsAttempted,
                minutesStudied: minutesStudied,
                accuracyToday: accuracyToday,
                streakMaintained: streakMaintained,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String studentId,
                required DateTime summaryDate,
                Value<int> lessonsWatched = const Value.absent(),
                Value<int> lessonsCompleted = const Value.absent(),
                Value<int> questionsAttempted = const Value.absent(),
                Value<int> minutesStudied = const Value.absent(),
                Value<double> accuracyToday = const Value.absent(),
                Value<bool> streakMaintained = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalDailyLearningSummaryCompanion.insert(
                studentId: studentId,
                summaryDate: summaryDate,
                lessonsWatched: lessonsWatched,
                lessonsCompleted: lessonsCompleted,
                questionsAttempted: questionsAttempted,
                minutesStudied: minutesStudied,
                accuracyToday: accuracyToday,
                streakMaintained: streakMaintained,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalDailyLearningSummaryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalDailyLearningSummaryTable,
      LocalDailyLearningSummaryData,
      $$LocalDailyLearningSummaryTableFilterComposer,
      $$LocalDailyLearningSummaryTableOrderingComposer,
      $$LocalDailyLearningSummaryTableAnnotationComposer,
      $$LocalDailyLearningSummaryTableCreateCompanionBuilder,
      $$LocalDailyLearningSummaryTableUpdateCompanionBuilder,
      (
        LocalDailyLearningSummaryData,
        BaseReferences<
          _$AppDatabase,
          $LocalDailyLearningSummaryTable,
          LocalDailyLearningSummaryData
        >,
      ),
      LocalDailyLearningSummaryData,
      PrefetchHooks Function()
    >;
typedef $$LocalStudentNotesTableCreateCompanionBuilder =
    LocalStudentNotesCompanion Function({
      Value<int> id,
      required String studentId,
      required String lessonId,
      required String tenantId,
      Value<int?> timestampSec,
      required String content,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$LocalStudentNotesTableUpdateCompanionBuilder =
    LocalStudentNotesCompanion Function({
      Value<int> id,
      Value<String> studentId,
      Value<String> lessonId,
      Value<String> tenantId,
      Value<int?> timestampSec,
      Value<String> content,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$LocalStudentNotesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalStudentNotesTable> {
  $$LocalStudentNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestampSec => $composableBuilder(
    column: $table.timestampSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalStudentNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalStudentNotesTable> {
  $$LocalStudentNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestampSec => $composableBuilder(
    column: $table.timestampSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalStudentNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalStudentNotesTable> {
  $$LocalStudentNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<int> get timestampSec => $composableBuilder(
    column: $table.timestampSec,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalStudentNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalStudentNotesTable,
          LocalStudentNote,
          $$LocalStudentNotesTableFilterComposer,
          $$LocalStudentNotesTableOrderingComposer,
          $$LocalStudentNotesTableAnnotationComposer,
          $$LocalStudentNotesTableCreateCompanionBuilder,
          $$LocalStudentNotesTableUpdateCompanionBuilder,
          (
            LocalStudentNote,
            BaseReferences<
              _$AppDatabase,
              $LocalStudentNotesTable,
              LocalStudentNote
            >,
          ),
          LocalStudentNote,
          PrefetchHooks Function()
        > {
  $$LocalStudentNotesTableTableManager(
    _$AppDatabase db,
    $LocalStudentNotesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalStudentNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalStudentNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalStudentNotesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<String> lessonId = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<int?> timestampSec = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LocalStudentNotesCompanion(
                id: id,
                studentId: studentId,
                lessonId: lessonId,
                tenantId: tenantId,
                timestampSec: timestampSec,
                content: content,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String studentId,
                required String lessonId,
                required String tenantId,
                Value<int?> timestampSec = const Value.absent(),
                required String content,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LocalStudentNotesCompanion.insert(
                id: id,
                studentId: studentId,
                lessonId: lessonId,
                tenantId: tenantId,
                timestampSec: timestampSec,
                content: content,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalStudentNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalStudentNotesTable,
      LocalStudentNote,
      $$LocalStudentNotesTableFilterComposer,
      $$LocalStudentNotesTableOrderingComposer,
      $$LocalStudentNotesTableAnnotationComposer,
      $$LocalStudentNotesTableCreateCompanionBuilder,
      $$LocalStudentNotesTableUpdateCompanionBuilder,
      (
        LocalStudentNote,
        BaseReferences<
          _$AppDatabase,
          $LocalStudentNotesTable,
          LocalStudentNote
        >,
      ),
      LocalStudentNote,
      PrefetchHooks Function()
    >;
typedef $$LocalStudentBookmarksTableCreateCompanionBuilder =
    LocalStudentBookmarksCompanion Function({
      required String studentId,
      required String tenantId,
      required String contentType,
      required String contentId,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$LocalStudentBookmarksTableUpdateCompanionBuilder =
    LocalStudentBookmarksCompanion Function({
      Value<String> studentId,
      Value<String> tenantId,
      Value<String> contentType,
      Value<String> contentId,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$LocalStudentBookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $LocalStudentBookmarksTable> {
  $$LocalStudentBookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalStudentBookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalStudentBookmarksTable> {
  $$LocalStudentBookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalStudentBookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalStudentBookmarksTable> {
  $$LocalStudentBookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LocalStudentBookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalStudentBookmarksTable,
          LocalStudentBookmark,
          $$LocalStudentBookmarksTableFilterComposer,
          $$LocalStudentBookmarksTableOrderingComposer,
          $$LocalStudentBookmarksTableAnnotationComposer,
          $$LocalStudentBookmarksTableCreateCompanionBuilder,
          $$LocalStudentBookmarksTableUpdateCompanionBuilder,
          (
            LocalStudentBookmark,
            BaseReferences<
              _$AppDatabase,
              $LocalStudentBookmarksTable,
              LocalStudentBookmark
            >,
          ),
          LocalStudentBookmark,
          PrefetchHooks Function()
        > {
  $$LocalStudentBookmarksTableTableManager(
    _$AppDatabase db,
    $LocalStudentBookmarksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalStudentBookmarksTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalStudentBookmarksTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalStudentBookmarksTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> studentId = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String> contentId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalStudentBookmarksCompanion(
                studentId: studentId,
                tenantId: tenantId,
                contentType: contentType,
                contentId: contentId,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String studentId,
                required String tenantId,
                required String contentType,
                required String contentId,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalStudentBookmarksCompanion.insert(
                studentId: studentId,
                tenantId: tenantId,
                contentType: contentType,
                contentId: contentId,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalStudentBookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalStudentBookmarksTable,
      LocalStudentBookmark,
      $$LocalStudentBookmarksTableFilterComposer,
      $$LocalStudentBookmarksTableOrderingComposer,
      $$LocalStudentBookmarksTableAnnotationComposer,
      $$LocalStudentBookmarksTableCreateCompanionBuilder,
      $$LocalStudentBookmarksTableUpdateCompanionBuilder,
      (
        LocalStudentBookmark,
        BaseReferences<
          _$AppDatabase,
          $LocalStudentBookmarksTable,
          LocalStudentBookmark
        >,
      ),
      LocalStudentBookmark,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalLearningEventsTableTableManager get localLearningEvents =>
      $$LocalLearningEventsTableTableManager(_db, _db.localLearningEvents);
  $$LocalLessonMasteryTableTableManager get localLessonMastery =>
      $$LocalLessonMasteryTableTableManager(_db, _db.localLessonMastery);
  $$LocalTopicMasteryTableTableManager get localTopicMastery =>
      $$LocalTopicMasteryTableTableManager(_db, _db.localTopicMastery);
  $$LocalSmartReviewQueueTableTableManager get localSmartReviewQueue =>
      $$LocalSmartReviewQueueTableTableManager(_db, _db.localSmartReviewQueue);
  $$LocalDailyLearningSummaryTableTableManager get localDailyLearningSummary =>
      $$LocalDailyLearningSummaryTableTableManager(
        _db,
        _db.localDailyLearningSummary,
      );
  $$LocalStudentNotesTableTableManager get localStudentNotes =>
      $$LocalStudentNotesTableTableManager(_db, _db.localStudentNotes);
  $$LocalStudentBookmarksTableTableManager get localStudentBookmarks =>
      $$LocalStudentBookmarksTableTableManager(_db, _db.localStudentBookmarks);
}
