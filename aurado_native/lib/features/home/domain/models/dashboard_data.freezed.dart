// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardData {

 String get studentName; int get streakCount; int get reviewsDueCount; double get todayWatchProgress;// 0.0 to 1.0
 int get todayWatchMinutes; List<RecentLesson> get recentLessons;
/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<DashboardData> get copyWith => _$DashboardDataCopyWithImpl<DashboardData>(this as DashboardData, _$identity);

  /// Serializes this DashboardData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardData&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.streakCount, streakCount) || other.streakCount == streakCount)&&(identical(other.reviewsDueCount, reviewsDueCount) || other.reviewsDueCount == reviewsDueCount)&&(identical(other.todayWatchProgress, todayWatchProgress) || other.todayWatchProgress == todayWatchProgress)&&(identical(other.todayWatchMinutes, todayWatchMinutes) || other.todayWatchMinutes == todayWatchMinutes)&&const DeepCollectionEquality().equals(other.recentLessons, recentLessons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentName,streakCount,reviewsDueCount,todayWatchProgress,todayWatchMinutes,const DeepCollectionEquality().hash(recentLessons));

@override
String toString() {
  return 'DashboardData(studentName: $studentName, streakCount: $streakCount, reviewsDueCount: $reviewsDueCount, todayWatchProgress: $todayWatchProgress, todayWatchMinutes: $todayWatchMinutes, recentLessons: $recentLessons)';
}


}

/// @nodoc
abstract mixin class $DashboardDataCopyWith<$Res>  {
  factory $DashboardDataCopyWith(DashboardData value, $Res Function(DashboardData) _then) = _$DashboardDataCopyWithImpl;
@useResult
$Res call({
 String studentName, int streakCount, int reviewsDueCount, double todayWatchProgress, int todayWatchMinutes, List<RecentLesson> recentLessons
});




}
/// @nodoc
class _$DashboardDataCopyWithImpl<$Res>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._self, this._then);

  final DashboardData _self;
  final $Res Function(DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentName = null,Object? streakCount = null,Object? reviewsDueCount = null,Object? todayWatchProgress = null,Object? todayWatchMinutes = null,Object? recentLessons = null,}) {
  return _then(_self.copyWith(
studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,streakCount: null == streakCount ? _self.streakCount : streakCount // ignore: cast_nullable_to_non_nullable
as int,reviewsDueCount: null == reviewsDueCount ? _self.reviewsDueCount : reviewsDueCount // ignore: cast_nullable_to_non_nullable
as int,todayWatchProgress: null == todayWatchProgress ? _self.todayWatchProgress : todayWatchProgress // ignore: cast_nullable_to_non_nullable
as double,todayWatchMinutes: null == todayWatchMinutes ? _self.todayWatchMinutes : todayWatchMinutes // ignore: cast_nullable_to_non_nullable
as int,recentLessons: null == recentLessons ? _self.recentLessons : recentLessons // ignore: cast_nullable_to_non_nullable
as List<RecentLesson>,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardData].
extension DashboardDataPatterns on DashboardData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardData value)  $default,){
final _that = this;
switch (_that) {
case _DashboardData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardData value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String studentName,  int streakCount,  int reviewsDueCount,  double todayWatchProgress,  int todayWatchMinutes,  List<RecentLesson> recentLessons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
return $default(_that.studentName,_that.streakCount,_that.reviewsDueCount,_that.todayWatchProgress,_that.todayWatchMinutes,_that.recentLessons);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String studentName,  int streakCount,  int reviewsDueCount,  double todayWatchProgress,  int todayWatchMinutes,  List<RecentLesson> recentLessons)  $default,) {final _that = this;
switch (_that) {
case _DashboardData():
return $default(_that.studentName,_that.streakCount,_that.reviewsDueCount,_that.todayWatchProgress,_that.todayWatchMinutes,_that.recentLessons);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String studentName,  int streakCount,  int reviewsDueCount,  double todayWatchProgress,  int todayWatchMinutes,  List<RecentLesson> recentLessons)?  $default,) {final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
return $default(_that.studentName,_that.streakCount,_that.reviewsDueCount,_that.todayWatchProgress,_that.todayWatchMinutes,_that.recentLessons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardData extends DashboardData {
  const _DashboardData({this.studentName = '', this.streakCount = 0, this.reviewsDueCount = 0, this.todayWatchProgress = 0.0, this.todayWatchMinutes = 0, final  List<RecentLesson> recentLessons = const []}): _recentLessons = recentLessons,super._();
  factory _DashboardData.fromJson(Map<String, dynamic> json) => _$DashboardDataFromJson(json);

@override@JsonKey() final  String studentName;
@override@JsonKey() final  int streakCount;
@override@JsonKey() final  int reviewsDueCount;
@override@JsonKey() final  double todayWatchProgress;
// 0.0 to 1.0
@override@JsonKey() final  int todayWatchMinutes;
 final  List<RecentLesson> _recentLessons;
@override@JsonKey() List<RecentLesson> get recentLessons {
  if (_recentLessons is EqualUnmodifiableListView) return _recentLessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentLessons);
}


/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardDataCopyWith<_DashboardData> get copyWith => __$DashboardDataCopyWithImpl<_DashboardData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardData&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.streakCount, streakCount) || other.streakCount == streakCount)&&(identical(other.reviewsDueCount, reviewsDueCount) || other.reviewsDueCount == reviewsDueCount)&&(identical(other.todayWatchProgress, todayWatchProgress) || other.todayWatchProgress == todayWatchProgress)&&(identical(other.todayWatchMinutes, todayWatchMinutes) || other.todayWatchMinutes == todayWatchMinutes)&&const DeepCollectionEquality().equals(other._recentLessons, _recentLessons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentName,streakCount,reviewsDueCount,todayWatchProgress,todayWatchMinutes,const DeepCollectionEquality().hash(_recentLessons));

@override
String toString() {
  return 'DashboardData(studentName: $studentName, streakCount: $streakCount, reviewsDueCount: $reviewsDueCount, todayWatchProgress: $todayWatchProgress, todayWatchMinutes: $todayWatchMinutes, recentLessons: $recentLessons)';
}


}

/// @nodoc
abstract mixin class _$DashboardDataCopyWith<$Res> implements $DashboardDataCopyWith<$Res> {
  factory _$DashboardDataCopyWith(_DashboardData value, $Res Function(_DashboardData) _then) = __$DashboardDataCopyWithImpl;
@override @useResult
$Res call({
 String studentName, int streakCount, int reviewsDueCount, double todayWatchProgress, int todayWatchMinutes, List<RecentLesson> recentLessons
});




}
/// @nodoc
class __$DashboardDataCopyWithImpl<$Res>
    implements _$DashboardDataCopyWith<$Res> {
  __$DashboardDataCopyWithImpl(this._self, this._then);

  final _DashboardData _self;
  final $Res Function(_DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentName = null,Object? streakCount = null,Object? reviewsDueCount = null,Object? todayWatchProgress = null,Object? todayWatchMinutes = null,Object? recentLessons = null,}) {
  return _then(_DashboardData(
studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,streakCount: null == streakCount ? _self.streakCount : streakCount // ignore: cast_nullable_to_non_nullable
as int,reviewsDueCount: null == reviewsDueCount ? _self.reviewsDueCount : reviewsDueCount // ignore: cast_nullable_to_non_nullable
as int,todayWatchProgress: null == todayWatchProgress ? _self.todayWatchProgress : todayWatchProgress // ignore: cast_nullable_to_non_nullable
as double,todayWatchMinutes: null == todayWatchMinutes ? _self.todayWatchMinutes : todayWatchMinutes // ignore: cast_nullable_to_non_nullable
as int,recentLessons: null == recentLessons ? _self._recentLessons : recentLessons // ignore: cast_nullable_to_non_nullable
as List<RecentLesson>,
  ));
}


}


/// @nodoc
mixin _$RecentLesson {

 String get lessonId; String get title; String get thumbnailUrl; int get watchPercentage; DateTime? get lastAccessedAt;
/// Create a copy of RecentLesson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentLessonCopyWith<RecentLesson> get copyWith => _$RecentLessonCopyWithImpl<RecentLesson>(this as RecentLesson, _$identity);

  /// Serializes this RecentLesson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentLesson&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.title, title) || other.title == title)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.watchPercentage, watchPercentage) || other.watchPercentage == watchPercentage)&&(identical(other.lastAccessedAt, lastAccessedAt) || other.lastAccessedAt == lastAccessedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lessonId,title,thumbnailUrl,watchPercentage,lastAccessedAt);

@override
String toString() {
  return 'RecentLesson(lessonId: $lessonId, title: $title, thumbnailUrl: $thumbnailUrl, watchPercentage: $watchPercentage, lastAccessedAt: $lastAccessedAt)';
}


}

/// @nodoc
abstract mixin class $RecentLessonCopyWith<$Res>  {
  factory $RecentLessonCopyWith(RecentLesson value, $Res Function(RecentLesson) _then) = _$RecentLessonCopyWithImpl;
@useResult
$Res call({
 String lessonId, String title, String thumbnailUrl, int watchPercentage, DateTime? lastAccessedAt
});




}
/// @nodoc
class _$RecentLessonCopyWithImpl<$Res>
    implements $RecentLessonCopyWith<$Res> {
  _$RecentLessonCopyWithImpl(this._self, this._then);

  final RecentLesson _self;
  final $Res Function(RecentLesson) _then;

/// Create a copy of RecentLesson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lessonId = null,Object? title = null,Object? thumbnailUrl = null,Object? watchPercentage = null,Object? lastAccessedAt = freezed,}) {
  return _then(_self.copyWith(
lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,watchPercentage: null == watchPercentage ? _self.watchPercentage : watchPercentage // ignore: cast_nullable_to_non_nullable
as int,lastAccessedAt: freezed == lastAccessedAt ? _self.lastAccessedAt : lastAccessedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentLesson].
extension RecentLessonPatterns on RecentLesson {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentLesson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentLesson() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentLesson value)  $default,){
final _that = this;
switch (_that) {
case _RecentLesson():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentLesson value)?  $default,){
final _that = this;
switch (_that) {
case _RecentLesson() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lessonId,  String title,  String thumbnailUrl,  int watchPercentage,  DateTime? lastAccessedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentLesson() when $default != null:
return $default(_that.lessonId,_that.title,_that.thumbnailUrl,_that.watchPercentage,_that.lastAccessedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lessonId,  String title,  String thumbnailUrl,  int watchPercentage,  DateTime? lastAccessedAt)  $default,) {final _that = this;
switch (_that) {
case _RecentLesson():
return $default(_that.lessonId,_that.title,_that.thumbnailUrl,_that.watchPercentage,_that.lastAccessedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lessonId,  String title,  String thumbnailUrl,  int watchPercentage,  DateTime? lastAccessedAt)?  $default,) {final _that = this;
switch (_that) {
case _RecentLesson() when $default != null:
return $default(_that.lessonId,_that.title,_that.thumbnailUrl,_that.watchPercentage,_that.lastAccessedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentLesson extends RecentLesson {
  const _RecentLesson({required this.lessonId, this.title = 'Untitled Lesson', this.thumbnailUrl = '', this.watchPercentage = 0, this.lastAccessedAt}): super._();
  factory _RecentLesson.fromJson(Map<String, dynamic> json) => _$RecentLessonFromJson(json);

@override final  String lessonId;
@override@JsonKey() final  String title;
@override@JsonKey() final  String thumbnailUrl;
@override@JsonKey() final  int watchPercentage;
@override final  DateTime? lastAccessedAt;

/// Create a copy of RecentLesson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentLessonCopyWith<_RecentLesson> get copyWith => __$RecentLessonCopyWithImpl<_RecentLesson>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentLessonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentLesson&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.title, title) || other.title == title)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.watchPercentage, watchPercentage) || other.watchPercentage == watchPercentage)&&(identical(other.lastAccessedAt, lastAccessedAt) || other.lastAccessedAt == lastAccessedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lessonId,title,thumbnailUrl,watchPercentage,lastAccessedAt);

@override
String toString() {
  return 'RecentLesson(lessonId: $lessonId, title: $title, thumbnailUrl: $thumbnailUrl, watchPercentage: $watchPercentage, lastAccessedAt: $lastAccessedAt)';
}


}

/// @nodoc
abstract mixin class _$RecentLessonCopyWith<$Res> implements $RecentLessonCopyWith<$Res> {
  factory _$RecentLessonCopyWith(_RecentLesson value, $Res Function(_RecentLesson) _then) = __$RecentLessonCopyWithImpl;
@override @useResult
$Res call({
 String lessonId, String title, String thumbnailUrl, int watchPercentage, DateTime? lastAccessedAt
});




}
/// @nodoc
class __$RecentLessonCopyWithImpl<$Res>
    implements _$RecentLessonCopyWith<$Res> {
  __$RecentLessonCopyWithImpl(this._self, this._then);

  final _RecentLesson _self;
  final $Res Function(_RecentLesson) _then;

/// Create a copy of RecentLesson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lessonId = null,Object? title = null,Object? thumbnailUrl = null,Object? watchPercentage = null,Object? lastAccessedAt = freezed,}) {
  return _then(_RecentLesson(
lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,watchPercentage: null == watchPercentage ? _self.watchPercentage : watchPercentage // ignore: cast_nullable_to_non_nullable
as int,lastAccessedAt: freezed == lastAccessedAt ? _self.lastAccessedAt : lastAccessedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
