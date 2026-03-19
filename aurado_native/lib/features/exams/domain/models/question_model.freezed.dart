// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionModel {

 String get id;@JsonKey(name: 'exam_id') String get examId; String get type;// 'mcq', 'cq', etc.
 String get content; List<QuestionOptionModel> get options;@JsonKey(name: 'cq_parts') List<Map<String, dynamic>> get cqParts; String? get explanation; int get marks;@JsonKey(name: 'order') int get orderIndex;
/// Create a copy of QuestionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionModelCopyWith<QuestionModel> get copyWith => _$QuestionModelCopyWithImpl<QuestionModel>(this as QuestionModel, _$identity);

  /// Serializes this QuestionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.examId, examId) || other.examId == examId)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.cqParts, cqParts)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.marks, marks) || other.marks == marks)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,examId,type,content,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(cqParts),explanation,marks,orderIndex);

@override
String toString() {
  return 'QuestionModel(id: $id, examId: $examId, type: $type, content: $content, options: $options, cqParts: $cqParts, explanation: $explanation, marks: $marks, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class $QuestionModelCopyWith<$Res>  {
  factory $QuestionModelCopyWith(QuestionModel value, $Res Function(QuestionModel) _then) = _$QuestionModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'exam_id') String examId, String type, String content, List<QuestionOptionModel> options,@JsonKey(name: 'cq_parts') List<Map<String, dynamic>> cqParts, String? explanation, int marks,@JsonKey(name: 'order') int orderIndex
});




}
/// @nodoc
class _$QuestionModelCopyWithImpl<$Res>
    implements $QuestionModelCopyWith<$Res> {
  _$QuestionModelCopyWithImpl(this._self, this._then);

  final QuestionModel _self;
  final $Res Function(QuestionModel) _then;

/// Create a copy of QuestionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? examId = null,Object? type = null,Object? content = null,Object? options = null,Object? cqParts = null,Object? explanation = freezed,Object? marks = null,Object? orderIndex = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,examId: null == examId ? _self.examId : examId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<QuestionOptionModel>,cqParts: null == cqParts ? _self.cqParts : cqParts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,marks: null == marks ? _self.marks : marks // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionModel].
extension QuestionModelPatterns on QuestionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionModel value)  $default,){
final _that = this;
switch (_that) {
case _QuestionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionModel value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'exam_id')  String examId,  String type,  String content,  List<QuestionOptionModel> options, @JsonKey(name: 'cq_parts')  List<Map<String, dynamic>> cqParts,  String? explanation,  int marks, @JsonKey(name: 'order')  int orderIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionModel() when $default != null:
return $default(_that.id,_that.examId,_that.type,_that.content,_that.options,_that.cqParts,_that.explanation,_that.marks,_that.orderIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'exam_id')  String examId,  String type,  String content,  List<QuestionOptionModel> options, @JsonKey(name: 'cq_parts')  List<Map<String, dynamic>> cqParts,  String? explanation,  int marks, @JsonKey(name: 'order')  int orderIndex)  $default,) {final _that = this;
switch (_that) {
case _QuestionModel():
return $default(_that.id,_that.examId,_that.type,_that.content,_that.options,_that.cqParts,_that.explanation,_that.marks,_that.orderIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'exam_id')  String examId,  String type,  String content,  List<QuestionOptionModel> options, @JsonKey(name: 'cq_parts')  List<Map<String, dynamic>> cqParts,  String? explanation,  int marks, @JsonKey(name: 'order')  int orderIndex)?  $default,) {final _that = this;
switch (_that) {
case _QuestionModel() when $default != null:
return $default(_that.id,_that.examId,_that.type,_that.content,_that.options,_that.cqParts,_that.explanation,_that.marks,_that.orderIndex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionModel extends QuestionModel {
  const _QuestionModel({required this.id, @JsonKey(name: 'exam_id') required this.examId, required this.type, required this.content, final  List<QuestionOptionModel> options = const [], @JsonKey(name: 'cq_parts') final  List<Map<String, dynamic>> cqParts = const [], this.explanation, this.marks = 1, @JsonKey(name: 'order') this.orderIndex = 0}): _options = options,_cqParts = cqParts,super._();
  factory _QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'exam_id') final  String examId;
@override final  String type;
// 'mcq', 'cq', etc.
@override final  String content;
 final  List<QuestionOptionModel> _options;
@override@JsonKey() List<QuestionOptionModel> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  List<Map<String, dynamic>> _cqParts;
@override@JsonKey(name: 'cq_parts') List<Map<String, dynamic>> get cqParts {
  if (_cqParts is EqualUnmodifiableListView) return _cqParts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cqParts);
}

@override final  String? explanation;
@override@JsonKey() final  int marks;
@override@JsonKey(name: 'order') final  int orderIndex;

/// Create a copy of QuestionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionModelCopyWith<_QuestionModel> get copyWith => __$QuestionModelCopyWithImpl<_QuestionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.examId, examId) || other.examId == examId)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._cqParts, _cqParts)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.marks, marks) || other.marks == marks)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,examId,type,content,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_cqParts),explanation,marks,orderIndex);

@override
String toString() {
  return 'QuestionModel(id: $id, examId: $examId, type: $type, content: $content, options: $options, cqParts: $cqParts, explanation: $explanation, marks: $marks, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class _$QuestionModelCopyWith<$Res> implements $QuestionModelCopyWith<$Res> {
  factory _$QuestionModelCopyWith(_QuestionModel value, $Res Function(_QuestionModel) _then) = __$QuestionModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'exam_id') String examId, String type, String content, List<QuestionOptionModel> options,@JsonKey(name: 'cq_parts') List<Map<String, dynamic>> cqParts, String? explanation, int marks,@JsonKey(name: 'order') int orderIndex
});




}
/// @nodoc
class __$QuestionModelCopyWithImpl<$Res>
    implements _$QuestionModelCopyWith<$Res> {
  __$QuestionModelCopyWithImpl(this._self, this._then);

  final _QuestionModel _self;
  final $Res Function(_QuestionModel) _then;

/// Create a copy of QuestionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? examId = null,Object? type = null,Object? content = null,Object? options = null,Object? cqParts = null,Object? explanation = freezed,Object? marks = null,Object? orderIndex = null,}) {
  return _then(_QuestionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,examId: null == examId ? _self.examId : examId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<QuestionOptionModel>,cqParts: null == cqParts ? _self._cqParts : cqParts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,marks: null == marks ? _self.marks : marks // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$QuestionOptionModel {

 String get id; String get text;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'is_correct') bool get isCorrect;
/// Create a copy of QuestionOptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionOptionModelCopyWith<QuestionOptionModel> get copyWith => _$QuestionOptionModelCopyWithImpl<QuestionOptionModel>(this as QuestionOptionModel, _$identity);

  /// Serializes this QuestionOptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionOptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,imageUrl,isCorrect);

@override
String toString() {
  return 'QuestionOptionModel(id: $id, text: $text, imageUrl: $imageUrl, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class $QuestionOptionModelCopyWith<$Res>  {
  factory $QuestionOptionModelCopyWith(QuestionOptionModel value, $Res Function(QuestionOptionModel) _then) = _$QuestionOptionModelCopyWithImpl;
@useResult
$Res call({
 String id, String text,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'is_correct') bool isCorrect
});




}
/// @nodoc
class _$QuestionOptionModelCopyWithImpl<$Res>
    implements $QuestionOptionModelCopyWith<$Res> {
  _$QuestionOptionModelCopyWithImpl(this._self, this._then);

  final QuestionOptionModel _self;
  final $Res Function(QuestionOptionModel) _then;

/// Create a copy of QuestionOptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? imageUrl = freezed,Object? isCorrect = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionOptionModel].
extension QuestionOptionModelPatterns on QuestionOptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionOptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionOptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionOptionModel value)  $default,){
final _that = this;
switch (_that) {
case _QuestionOptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionOptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionOptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'is_correct')  bool isCorrect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionOptionModel() when $default != null:
return $default(_that.id,_that.text,_that.imageUrl,_that.isCorrect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'is_correct')  bool isCorrect)  $default,) {final _that = this;
switch (_that) {
case _QuestionOptionModel():
return $default(_that.id,_that.text,_that.imageUrl,_that.isCorrect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'is_correct')  bool isCorrect)?  $default,) {final _that = this;
switch (_that) {
case _QuestionOptionModel() when $default != null:
return $default(_that.id,_that.text,_that.imageUrl,_that.isCorrect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionOptionModel extends QuestionOptionModel {
  const _QuestionOptionModel({required this.id, required this.text, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'is_correct') this.isCorrect = false}): super._();
  factory _QuestionOptionModel.fromJson(Map<String, dynamic> json) => _$QuestionOptionModelFromJson(json);

@override final  String id;
@override final  String text;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'is_correct') final  bool isCorrect;

/// Create a copy of QuestionOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionOptionModelCopyWith<_QuestionOptionModel> get copyWith => __$QuestionOptionModelCopyWithImpl<_QuestionOptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionOptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionOptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,imageUrl,isCorrect);

@override
String toString() {
  return 'QuestionOptionModel(id: $id, text: $text, imageUrl: $imageUrl, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class _$QuestionOptionModelCopyWith<$Res> implements $QuestionOptionModelCopyWith<$Res> {
  factory _$QuestionOptionModelCopyWith(_QuestionOptionModel value, $Res Function(_QuestionOptionModel) _then) = __$QuestionOptionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String text,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'is_correct') bool isCorrect
});




}
/// @nodoc
class __$QuestionOptionModelCopyWithImpl<$Res>
    implements _$QuestionOptionModelCopyWith<$Res> {
  __$QuestionOptionModelCopyWithImpl(this._self, this._then);

  final _QuestionOptionModel _self;
  final $Res Function(_QuestionOptionModel) _then;

/// Create a copy of QuestionOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? imageUrl = freezed,Object? isCorrect = null,}) {
  return _then(_QuestionOptionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
