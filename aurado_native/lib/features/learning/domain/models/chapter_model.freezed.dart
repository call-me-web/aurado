// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChapterModel {

 String get id;@JsonKey(name: 'subject_id') String? get subjectId;@JsonKey(name: 'course_id') String? get courseId; String get title; int get order; List<LessonModel> get lessons;
/// Create a copy of ChapterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterModelCopyWith<ChapterModel> get copyWith => _$ChapterModelCopyWithImpl<ChapterModel>(this as ChapterModel, _$identity);

  /// Serializes this ChapterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.order, order) || other.order == order)&&const DeepCollectionEquality().equals(other.lessons, lessons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subjectId,courseId,title,order,const DeepCollectionEquality().hash(lessons));

@override
String toString() {
  return 'ChapterModel(id: $id, subjectId: $subjectId, courseId: $courseId, title: $title, order: $order, lessons: $lessons)';
}


}

/// @nodoc
abstract mixin class $ChapterModelCopyWith<$Res>  {
  factory $ChapterModelCopyWith(ChapterModel value, $Res Function(ChapterModel) _then) = _$ChapterModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'subject_id') String? subjectId,@JsonKey(name: 'course_id') String? courseId, String title, int order, List<LessonModel> lessons
});




}
/// @nodoc
class _$ChapterModelCopyWithImpl<$Res>
    implements $ChapterModelCopyWith<$Res> {
  _$ChapterModelCopyWithImpl(this._self, this._then);

  final ChapterModel _self;
  final $Res Function(ChapterModel) _then;

/// Create a copy of ChapterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subjectId = freezed,Object? courseId = freezed,Object? title = null,Object? order = null,Object? lessons = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,lessons: null == lessons ? _self.lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterModel].
extension ChapterModelPatterns on ChapterModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterModel value)  $default,){
final _that = this;
switch (_that) {
case _ChapterModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'subject_id')  String? subjectId, @JsonKey(name: 'course_id')  String? courseId,  String title,  int order,  List<LessonModel> lessons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterModel() when $default != null:
return $default(_that.id,_that.subjectId,_that.courseId,_that.title,_that.order,_that.lessons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'subject_id')  String? subjectId, @JsonKey(name: 'course_id')  String? courseId,  String title,  int order,  List<LessonModel> lessons)  $default,) {final _that = this;
switch (_that) {
case _ChapterModel():
return $default(_that.id,_that.subjectId,_that.courseId,_that.title,_that.order,_that.lessons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'subject_id')  String? subjectId, @JsonKey(name: 'course_id')  String? courseId,  String title,  int order,  List<LessonModel> lessons)?  $default,) {final _that = this;
switch (_that) {
case _ChapterModel() when $default != null:
return $default(_that.id,_that.subjectId,_that.courseId,_that.title,_that.order,_that.lessons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChapterModel implements ChapterModel {
  const _ChapterModel({required this.id, @JsonKey(name: 'subject_id') this.subjectId, @JsonKey(name: 'course_id') this.courseId, required this.title, this.order = 0, final  List<LessonModel> lessons = const []}): _lessons = lessons;
  factory _ChapterModel.fromJson(Map<String, dynamic> json) => _$ChapterModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'subject_id') final  String? subjectId;
@override@JsonKey(name: 'course_id') final  String? courseId;
@override final  String title;
@override@JsonKey() final  int order;
 final  List<LessonModel> _lessons;
@override@JsonKey() List<LessonModel> get lessons {
  if (_lessons is EqualUnmodifiableListView) return _lessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessons);
}


/// Create a copy of ChapterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterModelCopyWith<_ChapterModel> get copyWith => __$ChapterModelCopyWithImpl<_ChapterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.order, order) || other.order == order)&&const DeepCollectionEquality().equals(other._lessons, _lessons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subjectId,courseId,title,order,const DeepCollectionEquality().hash(_lessons));

@override
String toString() {
  return 'ChapterModel(id: $id, subjectId: $subjectId, courseId: $courseId, title: $title, order: $order, lessons: $lessons)';
}


}

/// @nodoc
abstract mixin class _$ChapterModelCopyWith<$Res> implements $ChapterModelCopyWith<$Res> {
  factory _$ChapterModelCopyWith(_ChapterModel value, $Res Function(_ChapterModel) _then) = __$ChapterModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'subject_id') String? subjectId,@JsonKey(name: 'course_id') String? courseId, String title, int order, List<LessonModel> lessons
});




}
/// @nodoc
class __$ChapterModelCopyWithImpl<$Res>
    implements _$ChapterModelCopyWith<$Res> {
  __$ChapterModelCopyWithImpl(this._self, this._then);

  final _ChapterModel _self;
  final $Res Function(_ChapterModel) _then;

/// Create a copy of ChapterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subjectId = freezed,Object? courseId = freezed,Object? title = null,Object? order = null,Object? lessons = null,}) {
  return _then(_ChapterModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,lessons: null == lessons ? _self._lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonModel>,
  ));
}


}

// dart format on
