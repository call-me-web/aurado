// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExamModel {

 String get id;@JsonKey(name: 'tenant_id') String get tenantId; String get title; String? get description;@JsonKey(name: 'duration_minutes') int get durationMinutes;@JsonKey(name: 'available_from') DateTime? get availableFrom;@JsonKey(name: 'available_until') DateTime? get availableUntil;@JsonKey(name: 'passing_score') int get passingScore;@JsonKey(name: 'total_marks') int get totalMarks;@JsonKey(name: 'target_type') String get targetType;@JsonKey(name: 'target_id') String get targetId; Map<String, dynamic> get config; String get status; List<QuestionModel> get questions;
/// Create a copy of ExamModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExamModelCopyWith<ExamModel> get copyWith => _$ExamModelCopyWithImpl<ExamModel>(this as ExamModel, _$identity);

  /// Serializes this ExamModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExamModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.availableFrom, availableFrom) || other.availableFrom == availableFrom)&&(identical(other.availableUntil, availableUntil) || other.availableUntil == availableUntil)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore)&&(identical(other.totalMarks, totalMarks) || other.totalMarks == totalMarks)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&const DeepCollectionEquality().equals(other.config, config)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.questions, questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,title,description,durationMinutes,availableFrom,availableUntil,passingScore,totalMarks,targetType,targetId,const DeepCollectionEquality().hash(config),status,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'ExamModel(id: $id, tenantId: $tenantId, title: $title, description: $description, durationMinutes: $durationMinutes, availableFrom: $availableFrom, availableUntil: $availableUntil, passingScore: $passingScore, totalMarks: $totalMarks, targetType: $targetType, targetId: $targetId, config: $config, status: $status, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $ExamModelCopyWith<$Res>  {
  factory $ExamModelCopyWith(ExamModel value, $Res Function(ExamModel) _then) = _$ExamModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId, String title, String? description,@JsonKey(name: 'duration_minutes') int durationMinutes,@JsonKey(name: 'available_from') DateTime? availableFrom,@JsonKey(name: 'available_until') DateTime? availableUntil,@JsonKey(name: 'passing_score') int passingScore,@JsonKey(name: 'total_marks') int totalMarks,@JsonKey(name: 'target_type') String targetType,@JsonKey(name: 'target_id') String targetId, Map<String, dynamic> config, String status, List<QuestionModel> questions
});




}
/// @nodoc
class _$ExamModelCopyWithImpl<$Res>
    implements $ExamModelCopyWith<$Res> {
  _$ExamModelCopyWithImpl(this._self, this._then);

  final ExamModel _self;
  final $Res Function(ExamModel) _then;

/// Create a copy of ExamModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? title = null,Object? description = freezed,Object? durationMinutes = null,Object? availableFrom = freezed,Object? availableUntil = freezed,Object? passingScore = null,Object? totalMarks = null,Object? targetType = null,Object? targetId = null,Object? config = null,Object? status = null,Object? questions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,availableFrom: freezed == availableFrom ? _self.availableFrom : availableFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,availableUntil: freezed == availableUntil ? _self.availableUntil : availableUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,passingScore: null == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int,totalMarks: null == totalMarks ? _self.totalMarks : totalMarks // ignore: cast_nullable_to_non_nullable
as int,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuestionModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExamModel].
extension ExamModelPatterns on ExamModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExamModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExamModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExamModel value)  $default,){
final _that = this;
switch (_that) {
case _ExamModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExamModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExamModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String title,  String? description, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'available_from')  DateTime? availableFrom, @JsonKey(name: 'available_until')  DateTime? availableUntil, @JsonKey(name: 'passing_score')  int passingScore, @JsonKey(name: 'total_marks')  int totalMarks, @JsonKey(name: 'target_type')  String targetType, @JsonKey(name: 'target_id')  String targetId,  Map<String, dynamic> config,  String status,  List<QuestionModel> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExamModel() when $default != null:
return $default(_that.id,_that.tenantId,_that.title,_that.description,_that.durationMinutes,_that.availableFrom,_that.availableUntil,_that.passingScore,_that.totalMarks,_that.targetType,_that.targetId,_that.config,_that.status,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String title,  String? description, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'available_from')  DateTime? availableFrom, @JsonKey(name: 'available_until')  DateTime? availableUntil, @JsonKey(name: 'passing_score')  int passingScore, @JsonKey(name: 'total_marks')  int totalMarks, @JsonKey(name: 'target_type')  String targetType, @JsonKey(name: 'target_id')  String targetId,  Map<String, dynamic> config,  String status,  List<QuestionModel> questions)  $default,) {final _that = this;
switch (_that) {
case _ExamModel():
return $default(_that.id,_that.tenantId,_that.title,_that.description,_that.durationMinutes,_that.availableFrom,_that.availableUntil,_that.passingScore,_that.totalMarks,_that.targetType,_that.targetId,_that.config,_that.status,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String title,  String? description, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'available_from')  DateTime? availableFrom, @JsonKey(name: 'available_until')  DateTime? availableUntil, @JsonKey(name: 'passing_score')  int passingScore, @JsonKey(name: 'total_marks')  int totalMarks, @JsonKey(name: 'target_type')  String targetType, @JsonKey(name: 'target_id')  String targetId,  Map<String, dynamic> config,  String status,  List<QuestionModel> questions)?  $default,) {final _that = this;
switch (_that) {
case _ExamModel() when $default != null:
return $default(_that.id,_that.tenantId,_that.title,_that.description,_that.durationMinutes,_that.availableFrom,_that.availableUntil,_that.passingScore,_that.totalMarks,_that.targetType,_that.targetId,_that.config,_that.status,_that.questions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExamModel extends ExamModel {
  const _ExamModel({required this.id, @JsonKey(name: 'tenant_id') required this.tenantId, required this.title, this.description, @JsonKey(name: 'duration_minutes') this.durationMinutes = 30, @JsonKey(name: 'available_from') this.availableFrom, @JsonKey(name: 'available_until') this.availableUntil, @JsonKey(name: 'passing_score') this.passingScore = 0, @JsonKey(name: 'total_marks') this.totalMarks = 0, @JsonKey(name: 'target_type') required this.targetType, @JsonKey(name: 'target_id') required this.targetId, final  Map<String, dynamic> config = const {}, this.status = 'draft', final  List<QuestionModel> questions = const []}): _config = config,_questions = questions,super._();
  factory _ExamModel.fromJson(Map<String, dynamic> json) => _$ExamModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'tenant_id') final  String tenantId;
@override final  String title;
@override final  String? description;
@override@JsonKey(name: 'duration_minutes') final  int durationMinutes;
@override@JsonKey(name: 'available_from') final  DateTime? availableFrom;
@override@JsonKey(name: 'available_until') final  DateTime? availableUntil;
@override@JsonKey(name: 'passing_score') final  int passingScore;
@override@JsonKey(name: 'total_marks') final  int totalMarks;
@override@JsonKey(name: 'target_type') final  String targetType;
@override@JsonKey(name: 'target_id') final  String targetId;
 final  Map<String, dynamic> _config;
@override@JsonKey() Map<String, dynamic> get config {
  if (_config is EqualUnmodifiableMapView) return _config;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_config);
}

@override@JsonKey() final  String status;
 final  List<QuestionModel> _questions;
@override@JsonKey() List<QuestionModel> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of ExamModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExamModelCopyWith<_ExamModel> get copyWith => __$ExamModelCopyWithImpl<_ExamModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExamModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExamModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.availableFrom, availableFrom) || other.availableFrom == availableFrom)&&(identical(other.availableUntil, availableUntil) || other.availableUntil == availableUntil)&&(identical(other.passingScore, passingScore) || other.passingScore == passingScore)&&(identical(other.totalMarks, totalMarks) || other.totalMarks == totalMarks)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&const DeepCollectionEquality().equals(other._config, _config)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,title,description,durationMinutes,availableFrom,availableUntil,passingScore,totalMarks,targetType,targetId,const DeepCollectionEquality().hash(_config),status,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'ExamModel(id: $id, tenantId: $tenantId, title: $title, description: $description, durationMinutes: $durationMinutes, availableFrom: $availableFrom, availableUntil: $availableUntil, passingScore: $passingScore, totalMarks: $totalMarks, targetType: $targetType, targetId: $targetId, config: $config, status: $status, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$ExamModelCopyWith<$Res> implements $ExamModelCopyWith<$Res> {
  factory _$ExamModelCopyWith(_ExamModel value, $Res Function(_ExamModel) _then) = __$ExamModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId, String title, String? description,@JsonKey(name: 'duration_minutes') int durationMinutes,@JsonKey(name: 'available_from') DateTime? availableFrom,@JsonKey(name: 'available_until') DateTime? availableUntil,@JsonKey(name: 'passing_score') int passingScore,@JsonKey(name: 'total_marks') int totalMarks,@JsonKey(name: 'target_type') String targetType,@JsonKey(name: 'target_id') String targetId, Map<String, dynamic> config, String status, List<QuestionModel> questions
});




}
/// @nodoc
class __$ExamModelCopyWithImpl<$Res>
    implements _$ExamModelCopyWith<$Res> {
  __$ExamModelCopyWithImpl(this._self, this._then);

  final _ExamModel _self;
  final $Res Function(_ExamModel) _then;

/// Create a copy of ExamModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? title = null,Object? description = freezed,Object? durationMinutes = null,Object? availableFrom = freezed,Object? availableUntil = freezed,Object? passingScore = null,Object? totalMarks = null,Object? targetType = null,Object? targetId = null,Object? config = null,Object? status = null,Object? questions = null,}) {
  return _then(_ExamModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,availableFrom: freezed == availableFrom ? _self.availableFrom : availableFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,availableUntil: freezed == availableUntil ? _self.availableUntil : availableUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,passingScore: null == passingScore ? _self.passingScore : passingScore // ignore: cast_nullable_to_non_nullable
as int,totalMarks: null == totalMarks ? _self.totalMarks : totalMarks // ignore: cast_nullable_to_non_nullable
as int,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,config: null == config ? _self._config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuestionModel>,
  ));
}


}

// dart format on
