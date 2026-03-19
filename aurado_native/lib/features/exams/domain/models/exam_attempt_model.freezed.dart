// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_attempt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExamAttemptModel {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'exam_id') String get examId; String get status;@JsonKey(name: 'attempt_type') String get attemptType;@JsonKey(name: 'start_time') DateTime get startTime;@JsonKey(name: 'end_time') DateTime? get endTime;@JsonKey(name: 'total_score') int get totalScore; String? get feedback;
/// Create a copy of ExamAttemptModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExamAttemptModelCopyWith<ExamAttemptModel> get copyWith => _$ExamAttemptModelCopyWithImpl<ExamAttemptModel>(this as ExamAttemptModel, _$identity);

  /// Serializes this ExamAttemptModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExamAttemptModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.examId, examId) || other.examId == examId)&&(identical(other.status, status) || other.status == status)&&(identical(other.attemptType, attemptType) || other.attemptType == attemptType)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.feedback, feedback) || other.feedback == feedback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,examId,status,attemptType,startTime,endTime,totalScore,feedback);

@override
String toString() {
  return 'ExamAttemptModel(id: $id, userId: $userId, examId: $examId, status: $status, attemptType: $attemptType, startTime: $startTime, endTime: $endTime, totalScore: $totalScore, feedback: $feedback)';
}


}

/// @nodoc
abstract mixin class $ExamAttemptModelCopyWith<$Res>  {
  factory $ExamAttemptModelCopyWith(ExamAttemptModel value, $Res Function(ExamAttemptModel) _then) = _$ExamAttemptModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'exam_id') String examId, String status,@JsonKey(name: 'attempt_type') String attemptType,@JsonKey(name: 'start_time') DateTime startTime,@JsonKey(name: 'end_time') DateTime? endTime,@JsonKey(name: 'total_score') int totalScore, String? feedback
});




}
/// @nodoc
class _$ExamAttemptModelCopyWithImpl<$Res>
    implements $ExamAttemptModelCopyWith<$Res> {
  _$ExamAttemptModelCopyWithImpl(this._self, this._then);

  final ExamAttemptModel _self;
  final $Res Function(ExamAttemptModel) _then;

/// Create a copy of ExamAttemptModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? examId = null,Object? status = null,Object? attemptType = null,Object? startTime = null,Object? endTime = freezed,Object? totalScore = null,Object? feedback = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,examId: null == examId ? _self.examId : examId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,attemptType: null == attemptType ? _self.attemptType : attemptType // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExamAttemptModel].
extension ExamAttemptModelPatterns on ExamAttemptModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExamAttemptModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExamAttemptModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExamAttemptModel value)  $default,){
final _that = this;
switch (_that) {
case _ExamAttemptModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExamAttemptModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExamAttemptModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'exam_id')  String examId,  String status, @JsonKey(name: 'attempt_type')  String attemptType, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'end_time')  DateTime? endTime, @JsonKey(name: 'total_score')  int totalScore,  String? feedback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExamAttemptModel() when $default != null:
return $default(_that.id,_that.userId,_that.examId,_that.status,_that.attemptType,_that.startTime,_that.endTime,_that.totalScore,_that.feedback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'exam_id')  String examId,  String status, @JsonKey(name: 'attempt_type')  String attemptType, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'end_time')  DateTime? endTime, @JsonKey(name: 'total_score')  int totalScore,  String? feedback)  $default,) {final _that = this;
switch (_that) {
case _ExamAttemptModel():
return $default(_that.id,_that.userId,_that.examId,_that.status,_that.attemptType,_that.startTime,_that.endTime,_that.totalScore,_that.feedback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'exam_id')  String examId,  String status, @JsonKey(name: 'attempt_type')  String attemptType, @JsonKey(name: 'start_time')  DateTime startTime, @JsonKey(name: 'end_time')  DateTime? endTime, @JsonKey(name: 'total_score')  int totalScore,  String? feedback)?  $default,) {final _that = this;
switch (_that) {
case _ExamAttemptModel() when $default != null:
return $default(_that.id,_that.userId,_that.examId,_that.status,_that.attemptType,_that.startTime,_that.endTime,_that.totalScore,_that.feedback);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExamAttemptModel extends ExamAttemptModel {
  const _ExamAttemptModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'exam_id') required this.examId, this.status = 'started', @JsonKey(name: 'attempt_type') this.attemptType = 'live', @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'end_time') this.endTime, @JsonKey(name: 'total_score') this.totalScore = 0, this.feedback}): super._();
  factory _ExamAttemptModel.fromJson(Map<String, dynamic> json) => _$ExamAttemptModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'exam_id') final  String examId;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'attempt_type') final  String attemptType;
@override@JsonKey(name: 'start_time') final  DateTime startTime;
@override@JsonKey(name: 'end_time') final  DateTime? endTime;
@override@JsonKey(name: 'total_score') final  int totalScore;
@override final  String? feedback;

/// Create a copy of ExamAttemptModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExamAttemptModelCopyWith<_ExamAttemptModel> get copyWith => __$ExamAttemptModelCopyWithImpl<_ExamAttemptModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExamAttemptModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExamAttemptModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.examId, examId) || other.examId == examId)&&(identical(other.status, status) || other.status == status)&&(identical(other.attemptType, attemptType) || other.attemptType == attemptType)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.feedback, feedback) || other.feedback == feedback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,examId,status,attemptType,startTime,endTime,totalScore,feedback);

@override
String toString() {
  return 'ExamAttemptModel(id: $id, userId: $userId, examId: $examId, status: $status, attemptType: $attemptType, startTime: $startTime, endTime: $endTime, totalScore: $totalScore, feedback: $feedback)';
}


}

/// @nodoc
abstract mixin class _$ExamAttemptModelCopyWith<$Res> implements $ExamAttemptModelCopyWith<$Res> {
  factory _$ExamAttemptModelCopyWith(_ExamAttemptModel value, $Res Function(_ExamAttemptModel) _then) = __$ExamAttemptModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'exam_id') String examId, String status,@JsonKey(name: 'attempt_type') String attemptType,@JsonKey(name: 'start_time') DateTime startTime,@JsonKey(name: 'end_time') DateTime? endTime,@JsonKey(name: 'total_score') int totalScore, String? feedback
});




}
/// @nodoc
class __$ExamAttemptModelCopyWithImpl<$Res>
    implements _$ExamAttemptModelCopyWith<$Res> {
  __$ExamAttemptModelCopyWithImpl(this._self, this._then);

  final _ExamAttemptModel _self;
  final $Res Function(_ExamAttemptModel) _then;

/// Create a copy of ExamAttemptModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? examId = null,Object? status = null,Object? attemptType = null,Object? startTime = null,Object? endTime = freezed,Object? totalScore = null,Object? feedback = freezed,}) {
  return _then(_ExamAttemptModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,examId: null == examId ? _self.examId : examId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,attemptType: null == attemptType ? _self.attemptType : attemptType // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
