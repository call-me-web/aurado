// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discovery_course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiscoveryCourseModel {

 String get id;@JsonKey(name: 'tenant_id') String get tenantId; String get title;@JsonKey(name: 'course_id') String? get courseId; String? get description;@JsonKey(name: 'thumbnail_url') String? get thumbnailUrl; double get price; String get currency; List<String> get hashtags; String? get level; String? get duration; String? get language;@JsonKey(name: 'what_you_will_learn') List<String> get whatYouWillLearn; List<String> get requirements;@JsonKey(name: 'course_type') String? get courseType;@JsonKey(name: 'learning_materials') List<String> get learningMaterials;@JsonKey(name: 'course_category') List<String> get courseCategory;@JsonKey(name: 'tenant_name') String? get tenantName;@JsonKey(name: 'tenant_logo_url') String? get tenantLogoUrl;
/// Create a copy of DiscoveryCourseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoveryCourseModelCopyWith<DiscoveryCourseModel> get copyWith => _$DiscoveryCourseModelCopyWithImpl<DiscoveryCourseModel>(this as DiscoveryCourseModel, _$identity);

  /// Serializes this DiscoveryCourseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoveryCourseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.title, title) || other.title == title)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.description, description) || other.description == description)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.hashtags, hashtags)&&(identical(other.level, level) || other.level == level)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other.whatYouWillLearn, whatYouWillLearn)&&const DeepCollectionEquality().equals(other.requirements, requirements)&&(identical(other.courseType, courseType) || other.courseType == courseType)&&const DeepCollectionEquality().equals(other.learningMaterials, learningMaterials)&&const DeepCollectionEquality().equals(other.courseCategory, courseCategory)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.tenantLogoUrl, tenantLogoUrl) || other.tenantLogoUrl == tenantLogoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tenantId,title,courseId,description,thumbnailUrl,price,currency,const DeepCollectionEquality().hash(hashtags),level,duration,language,const DeepCollectionEquality().hash(whatYouWillLearn),const DeepCollectionEquality().hash(requirements),courseType,const DeepCollectionEquality().hash(learningMaterials),const DeepCollectionEquality().hash(courseCategory),tenantName,tenantLogoUrl]);

@override
String toString() {
  return 'DiscoveryCourseModel(id: $id, tenantId: $tenantId, title: $title, courseId: $courseId, description: $description, thumbnailUrl: $thumbnailUrl, price: $price, currency: $currency, hashtags: $hashtags, level: $level, duration: $duration, language: $language, whatYouWillLearn: $whatYouWillLearn, requirements: $requirements, courseType: $courseType, learningMaterials: $learningMaterials, courseCategory: $courseCategory, tenantName: $tenantName, tenantLogoUrl: $tenantLogoUrl)';
}


}

/// @nodoc
abstract mixin class $DiscoveryCourseModelCopyWith<$Res>  {
  factory $DiscoveryCourseModelCopyWith(DiscoveryCourseModel value, $Res Function(DiscoveryCourseModel) _then) = _$DiscoveryCourseModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId, String title,@JsonKey(name: 'course_id') String? courseId, String? description,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl, double price, String currency, List<String> hashtags, String? level, String? duration, String? language,@JsonKey(name: 'what_you_will_learn') List<String> whatYouWillLearn, List<String> requirements,@JsonKey(name: 'course_type') String? courseType,@JsonKey(name: 'learning_materials') List<String> learningMaterials,@JsonKey(name: 'course_category') List<String> courseCategory,@JsonKey(name: 'tenant_name') String? tenantName,@JsonKey(name: 'tenant_logo_url') String? tenantLogoUrl
});




}
/// @nodoc
class _$DiscoveryCourseModelCopyWithImpl<$Res>
    implements $DiscoveryCourseModelCopyWith<$Res> {
  _$DiscoveryCourseModelCopyWithImpl(this._self, this._then);

  final DiscoveryCourseModel _self;
  final $Res Function(DiscoveryCourseModel) _then;

/// Create a copy of DiscoveryCourseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? title = null,Object? courseId = freezed,Object? description = freezed,Object? thumbnailUrl = freezed,Object? price = null,Object? currency = null,Object? hashtags = null,Object? level = freezed,Object? duration = freezed,Object? language = freezed,Object? whatYouWillLearn = null,Object? requirements = null,Object? courseType = freezed,Object? learningMaterials = null,Object? courseCategory = null,Object? tenantName = freezed,Object? tenantLogoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self.hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,whatYouWillLearn: null == whatYouWillLearn ? _self.whatYouWillLearn : whatYouWillLearn // ignore: cast_nullable_to_non_nullable
as List<String>,requirements: null == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,courseType: freezed == courseType ? _self.courseType : courseType // ignore: cast_nullable_to_non_nullable
as String?,learningMaterials: null == learningMaterials ? _self.learningMaterials : learningMaterials // ignore: cast_nullable_to_non_nullable
as List<String>,courseCategory: null == courseCategory ? _self.courseCategory : courseCategory // ignore: cast_nullable_to_non_nullable
as List<String>,tenantName: freezed == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String?,tenantLogoUrl: freezed == tenantLogoUrl ? _self.tenantLogoUrl : tenantLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DiscoveryCourseModel].
extension DiscoveryCourseModelPatterns on DiscoveryCourseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscoveryCourseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscoveryCourseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscoveryCourseModel value)  $default,){
final _that = this;
switch (_that) {
case _DiscoveryCourseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscoveryCourseModel value)?  $default,){
final _that = this;
switch (_that) {
case _DiscoveryCourseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String title, @JsonKey(name: 'course_id')  String? courseId,  String? description, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl,  double price,  String currency,  List<String> hashtags,  String? level,  String? duration,  String? language, @JsonKey(name: 'what_you_will_learn')  List<String> whatYouWillLearn,  List<String> requirements, @JsonKey(name: 'course_type')  String? courseType, @JsonKey(name: 'learning_materials')  List<String> learningMaterials, @JsonKey(name: 'course_category')  List<String> courseCategory, @JsonKey(name: 'tenant_name')  String? tenantName, @JsonKey(name: 'tenant_logo_url')  String? tenantLogoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscoveryCourseModel() when $default != null:
return $default(_that.id,_that.tenantId,_that.title,_that.courseId,_that.description,_that.thumbnailUrl,_that.price,_that.currency,_that.hashtags,_that.level,_that.duration,_that.language,_that.whatYouWillLearn,_that.requirements,_that.courseType,_that.learningMaterials,_that.courseCategory,_that.tenantName,_that.tenantLogoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String title, @JsonKey(name: 'course_id')  String? courseId,  String? description, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl,  double price,  String currency,  List<String> hashtags,  String? level,  String? duration,  String? language, @JsonKey(name: 'what_you_will_learn')  List<String> whatYouWillLearn,  List<String> requirements, @JsonKey(name: 'course_type')  String? courseType, @JsonKey(name: 'learning_materials')  List<String> learningMaterials, @JsonKey(name: 'course_category')  List<String> courseCategory, @JsonKey(name: 'tenant_name')  String? tenantName, @JsonKey(name: 'tenant_logo_url')  String? tenantLogoUrl)  $default,) {final _that = this;
switch (_that) {
case _DiscoveryCourseModel():
return $default(_that.id,_that.tenantId,_that.title,_that.courseId,_that.description,_that.thumbnailUrl,_that.price,_that.currency,_that.hashtags,_that.level,_that.duration,_that.language,_that.whatYouWillLearn,_that.requirements,_that.courseType,_that.learningMaterials,_that.courseCategory,_that.tenantName,_that.tenantLogoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String title, @JsonKey(name: 'course_id')  String? courseId,  String? description, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl,  double price,  String currency,  List<String> hashtags,  String? level,  String? duration,  String? language, @JsonKey(name: 'what_you_will_learn')  List<String> whatYouWillLearn,  List<String> requirements, @JsonKey(name: 'course_type')  String? courseType, @JsonKey(name: 'learning_materials')  List<String> learningMaterials, @JsonKey(name: 'course_category')  List<String> courseCategory, @JsonKey(name: 'tenant_name')  String? tenantName, @JsonKey(name: 'tenant_logo_url')  String? tenantLogoUrl)?  $default,) {final _that = this;
switch (_that) {
case _DiscoveryCourseModel() when $default != null:
return $default(_that.id,_that.tenantId,_that.title,_that.courseId,_that.description,_that.thumbnailUrl,_that.price,_that.currency,_that.hashtags,_that.level,_that.duration,_that.language,_that.whatYouWillLearn,_that.requirements,_that.courseType,_that.learningMaterials,_that.courseCategory,_that.tenantName,_that.tenantLogoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiscoveryCourseModel extends DiscoveryCourseModel {
  const _DiscoveryCourseModel({required this.id, @JsonKey(name: 'tenant_id') required this.tenantId, required this.title, @JsonKey(name: 'course_id') this.courseId, this.description, @JsonKey(name: 'thumbnail_url') this.thumbnailUrl, this.price = 0.0, this.currency = 'BDT', final  List<String> hashtags = const [], this.level, this.duration, this.language, @JsonKey(name: 'what_you_will_learn') final  List<String> whatYouWillLearn = const [], final  List<String> requirements = const [], @JsonKey(name: 'course_type') this.courseType, @JsonKey(name: 'learning_materials') final  List<String> learningMaterials = const [], @JsonKey(name: 'course_category') final  List<String> courseCategory = const [], @JsonKey(name: 'tenant_name') this.tenantName, @JsonKey(name: 'tenant_logo_url') this.tenantLogoUrl}): _hashtags = hashtags,_whatYouWillLearn = whatYouWillLearn,_requirements = requirements,_learningMaterials = learningMaterials,_courseCategory = courseCategory,super._();
  factory _DiscoveryCourseModel.fromJson(Map<String, dynamic> json) => _$DiscoveryCourseModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'tenant_id') final  String tenantId;
@override final  String title;
@override@JsonKey(name: 'course_id') final  String? courseId;
@override final  String? description;
@override@JsonKey(name: 'thumbnail_url') final  String? thumbnailUrl;
@override@JsonKey() final  double price;
@override@JsonKey() final  String currency;
 final  List<String> _hashtags;
@override@JsonKey() List<String> get hashtags {
  if (_hashtags is EqualUnmodifiableListView) return _hashtags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hashtags);
}

@override final  String? level;
@override final  String? duration;
@override final  String? language;
 final  List<String> _whatYouWillLearn;
@override@JsonKey(name: 'what_you_will_learn') List<String> get whatYouWillLearn {
  if (_whatYouWillLearn is EqualUnmodifiableListView) return _whatYouWillLearn;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_whatYouWillLearn);
}

 final  List<String> _requirements;
@override@JsonKey() List<String> get requirements {
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requirements);
}

@override@JsonKey(name: 'course_type') final  String? courseType;
 final  List<String> _learningMaterials;
@override@JsonKey(name: 'learning_materials') List<String> get learningMaterials {
  if (_learningMaterials is EqualUnmodifiableListView) return _learningMaterials;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_learningMaterials);
}

 final  List<String> _courseCategory;
@override@JsonKey(name: 'course_category') List<String> get courseCategory {
  if (_courseCategory is EqualUnmodifiableListView) return _courseCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courseCategory);
}

@override@JsonKey(name: 'tenant_name') final  String? tenantName;
@override@JsonKey(name: 'tenant_logo_url') final  String? tenantLogoUrl;

/// Create a copy of DiscoveryCourseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscoveryCourseModelCopyWith<_DiscoveryCourseModel> get copyWith => __$DiscoveryCourseModelCopyWithImpl<_DiscoveryCourseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscoveryCourseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscoveryCourseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.title, title) || other.title == title)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.description, description) || other.description == description)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._hashtags, _hashtags)&&(identical(other.level, level) || other.level == level)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other._whatYouWillLearn, _whatYouWillLearn)&&const DeepCollectionEquality().equals(other._requirements, _requirements)&&(identical(other.courseType, courseType) || other.courseType == courseType)&&const DeepCollectionEquality().equals(other._learningMaterials, _learningMaterials)&&const DeepCollectionEquality().equals(other._courseCategory, _courseCategory)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.tenantLogoUrl, tenantLogoUrl) || other.tenantLogoUrl == tenantLogoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,tenantId,title,courseId,description,thumbnailUrl,price,currency,const DeepCollectionEquality().hash(_hashtags),level,duration,language,const DeepCollectionEquality().hash(_whatYouWillLearn),const DeepCollectionEquality().hash(_requirements),courseType,const DeepCollectionEquality().hash(_learningMaterials),const DeepCollectionEquality().hash(_courseCategory),tenantName,tenantLogoUrl]);

@override
String toString() {
  return 'DiscoveryCourseModel(id: $id, tenantId: $tenantId, title: $title, courseId: $courseId, description: $description, thumbnailUrl: $thumbnailUrl, price: $price, currency: $currency, hashtags: $hashtags, level: $level, duration: $duration, language: $language, whatYouWillLearn: $whatYouWillLearn, requirements: $requirements, courseType: $courseType, learningMaterials: $learningMaterials, courseCategory: $courseCategory, tenantName: $tenantName, tenantLogoUrl: $tenantLogoUrl)';
}


}

/// @nodoc
abstract mixin class _$DiscoveryCourseModelCopyWith<$Res> implements $DiscoveryCourseModelCopyWith<$Res> {
  factory _$DiscoveryCourseModelCopyWith(_DiscoveryCourseModel value, $Res Function(_DiscoveryCourseModel) _then) = __$DiscoveryCourseModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId, String title,@JsonKey(name: 'course_id') String? courseId, String? description,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl, double price, String currency, List<String> hashtags, String? level, String? duration, String? language,@JsonKey(name: 'what_you_will_learn') List<String> whatYouWillLearn, List<String> requirements,@JsonKey(name: 'course_type') String? courseType,@JsonKey(name: 'learning_materials') List<String> learningMaterials,@JsonKey(name: 'course_category') List<String> courseCategory,@JsonKey(name: 'tenant_name') String? tenantName,@JsonKey(name: 'tenant_logo_url') String? tenantLogoUrl
});




}
/// @nodoc
class __$DiscoveryCourseModelCopyWithImpl<$Res>
    implements _$DiscoveryCourseModelCopyWith<$Res> {
  __$DiscoveryCourseModelCopyWithImpl(this._self, this._then);

  final _DiscoveryCourseModel _self;
  final $Res Function(_DiscoveryCourseModel) _then;

/// Create a copy of DiscoveryCourseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? title = null,Object? courseId = freezed,Object? description = freezed,Object? thumbnailUrl = freezed,Object? price = null,Object? currency = null,Object? hashtags = null,Object? level = freezed,Object? duration = freezed,Object? language = freezed,Object? whatYouWillLearn = null,Object? requirements = null,Object? courseType = freezed,Object? learningMaterials = null,Object? courseCategory = null,Object? tenantName = freezed,Object? tenantLogoUrl = freezed,}) {
  return _then(_DiscoveryCourseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,courseId: freezed == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self._hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,whatYouWillLearn: null == whatYouWillLearn ? _self._whatYouWillLearn : whatYouWillLearn // ignore: cast_nullable_to_non_nullable
as List<String>,requirements: null == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,courseType: freezed == courseType ? _self.courseType : courseType // ignore: cast_nullable_to_non_nullable
as String?,learningMaterials: null == learningMaterials ? _self._learningMaterials : learningMaterials // ignore: cast_nullable_to_non_nullable
as List<String>,courseCategory: null == courseCategory ? _self._courseCategory : courseCategory // ignore: cast_nullable_to_non_nullable
as List<String>,tenantName: freezed == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String?,tenantLogoUrl: freezed == tenantLogoUrl ? _self.tenantLogoUrl : tenantLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
