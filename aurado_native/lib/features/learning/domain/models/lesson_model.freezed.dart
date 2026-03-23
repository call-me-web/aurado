// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LessonModel {

 String get id;@JsonKey(name: 'chapter_id') String? get chapterId;@JsonKey(name: 'subject_id') String? get subjectId;@JsonKey(name: 'course_id') String? get courseId; String get title; String? get description;@JsonKey(name: 'content_url') String? get contentUrl;@JsonKey(name: 'thumbnail_url') String? get thumbnailUrl;@JsonKey(name: 'pdf_urls') List<String> get pdfUrls;@JsonKey(name: 'is_free') bool get isFree; int get order;@JsonKey(name: 'lesson_type') String get lessonType;@JsonKey(name: 'duration_sec') int? get durationSec;@JsonKey(name: 'is_pdf_downloadable') bool get isPdfDownloadable; bool get isCompleted;
/// Create a copy of LessonModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonModelCopyWith<LessonModel> get copyWith => _$LessonModelCopyWithImpl<LessonModel>(this as LessonModel, _$identity);

  /// Serializes this LessonModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonModel&&(identical(other.id, id) || other.id == id)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&const DeepCollectionEquality().equals(other.pdfUrls, pdfUrls)&&(identical(other.isFree, isFree) || other.isFree == isFree)&&(identical(other.order, order) || other.order == order)&&(identical(other.lessonType, lessonType) || other.lessonType == lessonType)&&(identical(other.durationSec, durationSec) || other.durationSec == durationSec)&&(identical(other.isPdfDownloadable, isPdfDownloadable) || other.isPdfDownloadable == isPdfDownloadable)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chapterId,subjectId,courseId,title,description,contentUrl,thumbnailUrl,const DeepCollectionEquality().hash(pdfUrls),isFree,order,lessonType,durationSec,isPdfDownloadable,isCompleted);

@override
String toString() {
  return 'LessonModel(id: $id, chapterId: $chapterId, subjectId: $subjectId, courseId: $courseId, title: $title, description: $description, contentUrl: $contentUrl, thumbnailUrl: $thumbnailUrl, pdfUrls: $pdfUrls, isFree: $isFree, order: $order, lessonType: $lessonType, durationSec: $durationSec, isPdfDownloadable: $isPdfDownloadable, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $LessonModelCopyWith<$Res>  {
  factory $LessonModelCopyWith(LessonModel value, $Res Function(LessonModel) _then) = _$LessonModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'chapter_id') String? chapterId,@JsonKey(name: 'subject_id') String? subjectId,@JsonKey(name: 'course_id') String? courseId, String title, String? description,@JsonKey(name: 'content_url') String? contentUrl,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl,@JsonKey(name: 'pdf_urls') List<String> pdfUrls,@JsonKey(name: 'is_free') bool isFree, int order,@JsonKey(name: 'lesson_type') String lessonType,@JsonKey(name: 'duration_sec') int? durationSec,@JsonKey(name: 'is_pdf_downloadable') bool isPdfDownloadable, bool isCompleted
});




}
/// @nodoc
class _$LessonModelCopyWithImpl<$Res>
    implements $LessonModelCopyWith<$Res> {
  _$LessonModelCopyWithImpl(this._self, this._then);

  final LessonModel _self;
  final $Res Function(LessonModel) _then;

/// Create a copy of LessonModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? chapterId = freezed,Object? subjectId = freezed,Object? courseId = freezed,Object? title = null,Object? description = freezed,Object? contentUrl = freezed,Object? thumbnailUrl = freezed,Object? pdfUrls = null,Object? isFree = null,Object? order = null,Object? lessonType = null,Object? durationSec = freezed,Object? isPdfDownloadable = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chapterId: freezed == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,pdfUrls: null == pdfUrls ? _self.pdfUrls : pdfUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isFree: null == isFree ? _self.isFree : isFree // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,lessonType: null == lessonType ? _self.lessonType : lessonType // ignore: cast_nullable_to_non_nullable
as String,durationSec: freezed == durationSec ? _self.durationSec : durationSec // ignore: cast_nullable_to_non_nullable
as int?,isPdfDownloadable: null == isPdfDownloadable ? _self.isPdfDownloadable : isPdfDownloadable // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonModel].
extension LessonModelPatterns on LessonModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonModel value)  $default,){
final _that = this;
switch (_that) {
case _LessonModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonModel value)?  $default,){
final _that = this;
switch (_that) {
case _LessonModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'chapter_id')  String? chapterId, @JsonKey(name: 'subject_id')  String? subjectId, @JsonKey(name: 'course_id')  String? courseId,  String title,  String? description, @JsonKey(name: 'content_url')  String? contentUrl, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'pdf_urls')  List<String> pdfUrls, @JsonKey(name: 'is_free')  bool isFree,  int order, @JsonKey(name: 'lesson_type')  String lessonType, @JsonKey(name: 'duration_sec')  int? durationSec, @JsonKey(name: 'is_pdf_downloadable')  bool isPdfDownloadable,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonModel() when $default != null:
return $default(_that.id,_that.chapterId,_that.subjectId,_that.courseId,_that.title,_that.description,_that.contentUrl,_that.thumbnailUrl,_that.pdfUrls,_that.isFree,_that.order,_that.lessonType,_that.durationSec,_that.isPdfDownloadable,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'chapter_id')  String? chapterId, @JsonKey(name: 'subject_id')  String? subjectId, @JsonKey(name: 'course_id')  String? courseId,  String title,  String? description, @JsonKey(name: 'content_url')  String? contentUrl, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'pdf_urls')  List<String> pdfUrls, @JsonKey(name: 'is_free')  bool isFree,  int order, @JsonKey(name: 'lesson_type')  String lessonType, @JsonKey(name: 'duration_sec')  int? durationSec, @JsonKey(name: 'is_pdf_downloadable')  bool isPdfDownloadable,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _LessonModel():
return $default(_that.id,_that.chapterId,_that.subjectId,_that.courseId,_that.title,_that.description,_that.contentUrl,_that.thumbnailUrl,_that.pdfUrls,_that.isFree,_that.order,_that.lessonType,_that.durationSec,_that.isPdfDownloadable,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'chapter_id')  String? chapterId, @JsonKey(name: 'subject_id')  String? subjectId, @JsonKey(name: 'course_id')  String? courseId,  String title,  String? description, @JsonKey(name: 'content_url')  String? contentUrl, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'pdf_urls')  List<String> pdfUrls, @JsonKey(name: 'is_free')  bool isFree,  int order, @JsonKey(name: 'lesson_type')  String lessonType, @JsonKey(name: 'duration_sec')  int? durationSec, @JsonKey(name: 'is_pdf_downloadable')  bool isPdfDownloadable,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _LessonModel() when $default != null:
return $default(_that.id,_that.chapterId,_that.subjectId,_that.courseId,_that.title,_that.description,_that.contentUrl,_that.thumbnailUrl,_that.pdfUrls,_that.isFree,_that.order,_that.lessonType,_that.durationSec,_that.isPdfDownloadable,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LessonModel implements LessonModel {
  const _LessonModel({required this.id, @JsonKey(name: 'chapter_id') this.chapterId, @JsonKey(name: 'subject_id') this.subjectId, @JsonKey(name: 'course_id') this.courseId, required this.title, this.description, @JsonKey(name: 'content_url') this.contentUrl, @JsonKey(name: 'thumbnail_url') this.thumbnailUrl, @JsonKey(name: 'pdf_urls') final  List<String> pdfUrls = const [], @JsonKey(name: 'is_free') this.isFree = false, this.order = 0, @JsonKey(name: 'lesson_type') this.lessonType = 'video', @JsonKey(name: 'duration_sec') this.durationSec, @JsonKey(name: 'is_pdf_downloadable') this.isPdfDownloadable = true, this.isCompleted = false}): _pdfUrls = pdfUrls;
  factory _LessonModel.fromJson(Map<String, dynamic> json) => _$LessonModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'chapter_id') final  String? chapterId;
@override@JsonKey(name: 'subject_id') final  String? subjectId;
@override@JsonKey(name: 'course_id') final  String? courseId;
@override final  String title;
@override final  String? description;
@override@JsonKey(name: 'content_url') final  String? contentUrl;
@override@JsonKey(name: 'thumbnail_url') final  String? thumbnailUrl;
 final  List<String> _pdfUrls;
@override@JsonKey(name: 'pdf_urls') List<String> get pdfUrls {
  if (_pdfUrls is EqualUnmodifiableListView) return _pdfUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pdfUrls);
}

@override@JsonKey(name: 'is_free') final  bool isFree;
@override@JsonKey() final  int order;
@override@JsonKey(name: 'lesson_type') final  String lessonType;
@override@JsonKey(name: 'duration_sec') final  int? durationSec;
@override@JsonKey(name: 'is_pdf_downloadable') final  bool isPdfDownloadable;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of LessonModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonModelCopyWith<_LessonModel> get copyWith => __$LessonModelCopyWithImpl<_LessonModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessonModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonModel&&(identical(other.id, id) || other.id == id)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&const DeepCollectionEquality().equals(other._pdfUrls, _pdfUrls)&&(identical(other.isFree, isFree) || other.isFree == isFree)&&(identical(other.order, order) || other.order == order)&&(identical(other.lessonType, lessonType) || other.lessonType == lessonType)&&(identical(other.durationSec, durationSec) || other.durationSec == durationSec)&&(identical(other.isPdfDownloadable, isPdfDownloadable) || other.isPdfDownloadable == isPdfDownloadable)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chapterId,subjectId,courseId,title,description,contentUrl,thumbnailUrl,const DeepCollectionEquality().hash(_pdfUrls),isFree,order,lessonType,durationSec,isPdfDownloadable,isCompleted);

@override
String toString() {
  return 'LessonModel(id: $id, chapterId: $chapterId, subjectId: $subjectId, courseId: $courseId, title: $title, description: $description, contentUrl: $contentUrl, thumbnailUrl: $thumbnailUrl, pdfUrls: $pdfUrls, isFree: $isFree, order: $order, lessonType: $lessonType, durationSec: $durationSec, isPdfDownloadable: $isPdfDownloadable, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$LessonModelCopyWith<$Res> implements $LessonModelCopyWith<$Res> {
  factory _$LessonModelCopyWith(_LessonModel value, $Res Function(_LessonModel) _then) = __$LessonModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'chapter_id') String? chapterId,@JsonKey(name: 'subject_id') String? subjectId,@JsonKey(name: 'course_id') String? courseId, String title, String? description,@JsonKey(name: 'content_url') String? contentUrl,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl,@JsonKey(name: 'pdf_urls') List<String> pdfUrls,@JsonKey(name: 'is_free') bool isFree, int order,@JsonKey(name: 'lesson_type') String lessonType,@JsonKey(name: 'duration_sec') int? durationSec,@JsonKey(name: 'is_pdf_downloadable') bool isPdfDownloadable, bool isCompleted
});




}
/// @nodoc
class __$LessonModelCopyWithImpl<$Res>
    implements _$LessonModelCopyWith<$Res> {
  __$LessonModelCopyWithImpl(this._self, this._then);

  final _LessonModel _self;
  final $Res Function(_LessonModel) _then;

/// Create a copy of LessonModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? chapterId = freezed,Object? subjectId = freezed,Object? courseId = freezed,Object? title = null,Object? description = freezed,Object? contentUrl = freezed,Object? thumbnailUrl = freezed,Object? pdfUrls = null,Object? isFree = null,Object? order = null,Object? lessonType = null,Object? durationSec = freezed,Object? isPdfDownloadable = null,Object? isCompleted = null,}) {
  return _then(_LessonModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chapterId: freezed == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,pdfUrls: null == pdfUrls ? _self._pdfUrls : pdfUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isFree: null == isFree ? _self.isFree : isFree // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,lessonType: null == lessonType ? _self.lessonType : lessonType // ignore: cast_nullable_to_non_nullable
as String,durationSec: freezed == durationSec ? _self.durationSec : durationSec // ignore: cast_nullable_to_non_nullable
as int?,isPdfDownloadable: null == isPdfDownloadable ? _self.isPdfDownloadable : isPdfDownloadable // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
