// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionResponseModel {

@JsonKey(includeIfNull: false) String? get id;@JsonKey(name: 'attempt_id') String get attemptId;@JsonKey(name: 'question_id') String get questionId; Map<String, dynamic>? get answer;@JsonKey(name: 'upload_urls') List<String> get uploadUrls;@JsonKey(name: 'time_spent_ms') int get timeSpentMs;@JsonKey(name: 'marks_obtained') int get marksObtained;@JsonKey(name: 'is_correct') bool get isCorrect;
/// Create a copy of QuestionResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionResponseModelCopyWith<QuestionResponseModel> get copyWith => _$QuestionResponseModelCopyWithImpl<QuestionResponseModel>(this as QuestionResponseModel, _$identity);

  /// Serializes this QuestionResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.attemptId, attemptId) || other.attemptId == attemptId)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&const DeepCollectionEquality().equals(other.answer, answer)&&const DeepCollectionEquality().equals(other.uploadUrls, uploadUrls)&&(identical(other.timeSpentMs, timeSpentMs) || other.timeSpentMs == timeSpentMs)&&(identical(other.marksObtained, marksObtained) || other.marksObtained == marksObtained)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attemptId,questionId,const DeepCollectionEquality().hash(answer),const DeepCollectionEquality().hash(uploadUrls),timeSpentMs,marksObtained,isCorrect);

@override
String toString() {
  return 'QuestionResponseModel(id: $id, attemptId: $attemptId, questionId: $questionId, answer: $answer, uploadUrls: $uploadUrls, timeSpentMs: $timeSpentMs, marksObtained: $marksObtained, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class $QuestionResponseModelCopyWith<$Res>  {
  factory $QuestionResponseModelCopyWith(QuestionResponseModel value, $Res Function(QuestionResponseModel) _then) = _$QuestionResponseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? id,@JsonKey(name: 'attempt_id') String attemptId,@JsonKey(name: 'question_id') String questionId, Map<String, dynamic>? answer,@JsonKey(name: 'upload_urls') List<String> uploadUrls,@JsonKey(name: 'time_spent_ms') int timeSpentMs,@JsonKey(name: 'marks_obtained') int marksObtained,@JsonKey(name: 'is_correct') bool isCorrect
});




}
/// @nodoc
class _$QuestionResponseModelCopyWithImpl<$Res>
    implements $QuestionResponseModelCopyWith<$Res> {
  _$QuestionResponseModelCopyWithImpl(this._self, this._then);

  final QuestionResponseModel _self;
  final $Res Function(QuestionResponseModel) _then;

/// Create a copy of QuestionResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? attemptId = null,Object? questionId = null,Object? answer = freezed,Object? uploadUrls = null,Object? timeSpentMs = null,Object? marksObtained = null,Object? isCorrect = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,attemptId: null == attemptId ? _self.attemptId : attemptId // ignore: cast_nullable_to_non_nullable
as String,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,uploadUrls: null == uploadUrls ? _self.uploadUrls : uploadUrls // ignore: cast_nullable_to_non_nullable
as List<String>,timeSpentMs: null == timeSpentMs ? _self.timeSpentMs : timeSpentMs // ignore: cast_nullable_to_non_nullable
as int,marksObtained: null == marksObtained ? _self.marksObtained : marksObtained // ignore: cast_nullable_to_non_nullable
as int,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionResponseModel].
extension QuestionResponseModelPatterns on QuestionResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _QuestionResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: 'attempt_id')  String attemptId, @JsonKey(name: 'question_id')  String questionId,  Map<String, dynamic>? answer, @JsonKey(name: 'upload_urls')  List<String> uploadUrls, @JsonKey(name: 'time_spent_ms')  int timeSpentMs, @JsonKey(name: 'marks_obtained')  int marksObtained, @JsonKey(name: 'is_correct')  bool isCorrect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionResponseModel() when $default != null:
return $default(_that.id,_that.attemptId,_that.questionId,_that.answer,_that.uploadUrls,_that.timeSpentMs,_that.marksObtained,_that.isCorrect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: 'attempt_id')  String attemptId, @JsonKey(name: 'question_id')  String questionId,  Map<String, dynamic>? answer, @JsonKey(name: 'upload_urls')  List<String> uploadUrls, @JsonKey(name: 'time_spent_ms')  int timeSpentMs, @JsonKey(name: 'marks_obtained')  int marksObtained, @JsonKey(name: 'is_correct')  bool isCorrect)  $default,) {final _that = this;
switch (_that) {
case _QuestionResponseModel():
return $default(_that.id,_that.attemptId,_that.questionId,_that.answer,_that.uploadUrls,_that.timeSpentMs,_that.marksObtained,_that.isCorrect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: 'attempt_id')  String attemptId, @JsonKey(name: 'question_id')  String questionId,  Map<String, dynamic>? answer, @JsonKey(name: 'upload_urls')  List<String> uploadUrls, @JsonKey(name: 'time_spent_ms')  int timeSpentMs, @JsonKey(name: 'marks_obtained')  int marksObtained, @JsonKey(name: 'is_correct')  bool isCorrect)?  $default,) {final _that = this;
switch (_that) {
case _QuestionResponseModel() when $default != null:
return $default(_that.id,_that.attemptId,_that.questionId,_that.answer,_that.uploadUrls,_that.timeSpentMs,_that.marksObtained,_that.isCorrect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionResponseModel extends QuestionResponseModel {
  const _QuestionResponseModel({@JsonKey(includeIfNull: false) this.id, @JsonKey(name: 'attempt_id') required this.attemptId, @JsonKey(name: 'question_id') required this.questionId, final  Map<String, dynamic>? answer, @JsonKey(name: 'upload_urls') final  List<String> uploadUrls = const [], @JsonKey(name: 'time_spent_ms') this.timeSpentMs = 0, @JsonKey(name: 'marks_obtained') this.marksObtained = 0, @JsonKey(name: 'is_correct') this.isCorrect = false}): _answer = answer,_uploadUrls = uploadUrls,super._();
  factory _QuestionResponseModel.fromJson(Map<String, dynamic> json) => _$QuestionResponseModelFromJson(json);

@override@JsonKey(includeIfNull: false) final  String? id;
@override@JsonKey(name: 'attempt_id') final  String attemptId;
@override@JsonKey(name: 'question_id') final  String questionId;
 final  Map<String, dynamic>? _answer;
@override Map<String, dynamic>? get answer {
  final value = _answer;
  if (value == null) return null;
  if (_answer is EqualUnmodifiableMapView) return _answer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<String> _uploadUrls;
@override@JsonKey(name: 'upload_urls') List<String> get uploadUrls {
  if (_uploadUrls is EqualUnmodifiableListView) return _uploadUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uploadUrls);
}

@override@JsonKey(name: 'time_spent_ms') final  int timeSpentMs;
@override@JsonKey(name: 'marks_obtained') final  int marksObtained;
@override@JsonKey(name: 'is_correct') final  bool isCorrect;

/// Create a copy of QuestionResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionResponseModelCopyWith<_QuestionResponseModel> get copyWith => __$QuestionResponseModelCopyWithImpl<_QuestionResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.attemptId, attemptId) || other.attemptId == attemptId)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&const DeepCollectionEquality().equals(other._answer, _answer)&&const DeepCollectionEquality().equals(other._uploadUrls, _uploadUrls)&&(identical(other.timeSpentMs, timeSpentMs) || other.timeSpentMs == timeSpentMs)&&(identical(other.marksObtained, marksObtained) || other.marksObtained == marksObtained)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attemptId,questionId,const DeepCollectionEquality().hash(_answer),const DeepCollectionEquality().hash(_uploadUrls),timeSpentMs,marksObtained,isCorrect);

@override
String toString() {
  return 'QuestionResponseModel(id: $id, attemptId: $attemptId, questionId: $questionId, answer: $answer, uploadUrls: $uploadUrls, timeSpentMs: $timeSpentMs, marksObtained: $marksObtained, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class _$QuestionResponseModelCopyWith<$Res> implements $QuestionResponseModelCopyWith<$Res> {
  factory _$QuestionResponseModelCopyWith(_QuestionResponseModel value, $Res Function(_QuestionResponseModel) _then) = __$QuestionResponseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? id,@JsonKey(name: 'attempt_id') String attemptId,@JsonKey(name: 'question_id') String questionId, Map<String, dynamic>? answer,@JsonKey(name: 'upload_urls') List<String> uploadUrls,@JsonKey(name: 'time_spent_ms') int timeSpentMs,@JsonKey(name: 'marks_obtained') int marksObtained,@JsonKey(name: 'is_correct') bool isCorrect
});




}
/// @nodoc
class __$QuestionResponseModelCopyWithImpl<$Res>
    implements _$QuestionResponseModelCopyWith<$Res> {
  __$QuestionResponseModelCopyWithImpl(this._self, this._then);

  final _QuestionResponseModel _self;
  final $Res Function(_QuestionResponseModel) _then;

/// Create a copy of QuestionResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? attemptId = null,Object? questionId = null,Object? answer = freezed,Object? uploadUrls = null,Object? timeSpentMs = null,Object? marksObtained = null,Object? isCorrect = null,}) {
  return _then(_QuestionResponseModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,attemptId: null == attemptId ? _self.attemptId : attemptId // ignore: cast_nullable_to_non_nullable
as String,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,answer: freezed == answer ? _self._answer : answer // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,uploadUrls: null == uploadUrls ? _self._uploadUrls : uploadUrls // ignore: cast_nullable_to_non_nullable
as List<String>,timeSpentMs: null == timeSpentMs ? _self.timeSpentMs : timeSpentMs // ignore: cast_nullable_to_non_nullable
as int,marksObtained: null == marksObtained ? _self.marksObtained : marksObtained // ignore: cast_nullable_to_non_nullable
as int,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
