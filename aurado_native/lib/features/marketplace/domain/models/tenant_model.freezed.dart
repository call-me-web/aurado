// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TenantModel {

 String get id; String get name; String get slug;@JsonKey(name: 'logo_url') String? get logoUrl;@JsonKey(name: 'cover_url') String? get coverUrl;@JsonKey(name: 'color_background') String? get colorBackground;@JsonKey(name: 'color_button') String? get colorButton;@JsonKey(name: 'color_card') String? get colorCard;
/// Create a copy of TenantModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantModelCopyWith<TenantModel> get copyWith => _$TenantModelCopyWithImpl<TenantModel>(this as TenantModel, _$identity);

  /// Serializes this TenantModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.colorBackground, colorBackground) || other.colorBackground == colorBackground)&&(identical(other.colorButton, colorButton) || other.colorButton == colorButton)&&(identical(other.colorCard, colorCard) || other.colorCard == colorCard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,logoUrl,coverUrl,colorBackground,colorButton,colorCard);

@override
String toString() {
  return 'TenantModel(id: $id, name: $name, slug: $slug, logoUrl: $logoUrl, coverUrl: $coverUrl, colorBackground: $colorBackground, colorButton: $colorButton, colorCard: $colorCard)';
}


}

/// @nodoc
abstract mixin class $TenantModelCopyWith<$Res>  {
  factory $TenantModelCopyWith(TenantModel value, $Res Function(TenantModel) _then) = _$TenantModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String slug,@JsonKey(name: 'logo_url') String? logoUrl,@JsonKey(name: 'cover_url') String? coverUrl,@JsonKey(name: 'color_background') String? colorBackground,@JsonKey(name: 'color_button') String? colorButton,@JsonKey(name: 'color_card') String? colorCard
});




}
/// @nodoc
class _$TenantModelCopyWithImpl<$Res>
    implements $TenantModelCopyWith<$Res> {
  _$TenantModelCopyWithImpl(this._self, this._then);

  final TenantModel _self;
  final $Res Function(TenantModel) _then;

/// Create a copy of TenantModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? colorBackground = freezed,Object? colorButton = freezed,Object? colorCard = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,colorBackground: freezed == colorBackground ? _self.colorBackground : colorBackground // ignore: cast_nullable_to_non_nullable
as String?,colorButton: freezed == colorButton ? _self.colorButton : colorButton // ignore: cast_nullable_to_non_nullable
as String?,colorCard: freezed == colorCard ? _self.colorCard : colorCard // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantModel].
extension TenantModelPatterns on TenantModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantModel value)  $default,){
final _that = this;
switch (_that) {
case _TenantModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantModel value)?  $default,){
final _that = this;
switch (_that) {
case _TenantModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String slug, @JsonKey(name: 'logo_url')  String? logoUrl, @JsonKey(name: 'cover_url')  String? coverUrl, @JsonKey(name: 'color_background')  String? colorBackground, @JsonKey(name: 'color_button')  String? colorButton, @JsonKey(name: 'color_card')  String? colorCard)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantModel() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.logoUrl,_that.coverUrl,_that.colorBackground,_that.colorButton,_that.colorCard);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String slug, @JsonKey(name: 'logo_url')  String? logoUrl, @JsonKey(name: 'cover_url')  String? coverUrl, @JsonKey(name: 'color_background')  String? colorBackground, @JsonKey(name: 'color_button')  String? colorButton, @JsonKey(name: 'color_card')  String? colorCard)  $default,) {final _that = this;
switch (_that) {
case _TenantModel():
return $default(_that.id,_that.name,_that.slug,_that.logoUrl,_that.coverUrl,_that.colorBackground,_that.colorButton,_that.colorCard);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String slug, @JsonKey(name: 'logo_url')  String? logoUrl, @JsonKey(name: 'cover_url')  String? coverUrl, @JsonKey(name: 'color_background')  String? colorBackground, @JsonKey(name: 'color_button')  String? colorButton, @JsonKey(name: 'color_card')  String? colorCard)?  $default,) {final _that = this;
switch (_that) {
case _TenantModel() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.logoUrl,_that.coverUrl,_that.colorBackground,_that.colorButton,_that.colorCard);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantModel extends TenantModel {
  const _TenantModel({required this.id, required this.name, required this.slug, @JsonKey(name: 'logo_url') this.logoUrl, @JsonKey(name: 'cover_url') this.coverUrl, @JsonKey(name: 'color_background') this.colorBackground, @JsonKey(name: 'color_button') this.colorButton, @JsonKey(name: 'color_card') this.colorCard}): super._();
  factory _TenantModel.fromJson(Map<String, dynamic> json) => _$TenantModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String slug;
@override@JsonKey(name: 'logo_url') final  String? logoUrl;
@override@JsonKey(name: 'cover_url') final  String? coverUrl;
@override@JsonKey(name: 'color_background') final  String? colorBackground;
@override@JsonKey(name: 'color_button') final  String? colorButton;
@override@JsonKey(name: 'color_card') final  String? colorCard;

/// Create a copy of TenantModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantModelCopyWith<_TenantModel> get copyWith => __$TenantModelCopyWithImpl<_TenantModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.colorBackground, colorBackground) || other.colorBackground == colorBackground)&&(identical(other.colorButton, colorButton) || other.colorButton == colorButton)&&(identical(other.colorCard, colorCard) || other.colorCard == colorCard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,logoUrl,coverUrl,colorBackground,colorButton,colorCard);

@override
String toString() {
  return 'TenantModel(id: $id, name: $name, slug: $slug, logoUrl: $logoUrl, coverUrl: $coverUrl, colorBackground: $colorBackground, colorButton: $colorButton, colorCard: $colorCard)';
}


}

/// @nodoc
abstract mixin class _$TenantModelCopyWith<$Res> implements $TenantModelCopyWith<$Res> {
  factory _$TenantModelCopyWith(_TenantModel value, $Res Function(_TenantModel) _then) = __$TenantModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String slug,@JsonKey(name: 'logo_url') String? logoUrl,@JsonKey(name: 'cover_url') String? coverUrl,@JsonKey(name: 'color_background') String? colorBackground,@JsonKey(name: 'color_button') String? colorButton,@JsonKey(name: 'color_card') String? colorCard
});




}
/// @nodoc
class __$TenantModelCopyWithImpl<$Res>
    implements _$TenantModelCopyWith<$Res> {
  __$TenantModelCopyWithImpl(this._self, this._then);

  final _TenantModel _self;
  final $Res Function(_TenantModel) _then;

/// Create a copy of TenantModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? colorBackground = freezed,Object? colorButton = freezed,Object? colorCard = freezed,}) {
  return _then(_TenantModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,colorBackground: freezed == colorBackground ? _self.colorBackground : colorBackground // ignore: cast_nullable_to_non_nullable
as String?,colorButton: freezed == colorButton ? _self.colorButton : colorButton // ignore: cast_nullable_to_non_nullable
as String?,colorCard: freezed == colorCard ? _self.colorCard : colorCard // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
