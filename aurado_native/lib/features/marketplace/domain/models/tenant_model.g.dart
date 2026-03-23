// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TenantModel _$TenantModelFromJson(Map<String, dynamic> json) => _TenantModel(
  id: json['id'] as String,
  name: json['name'] as String,
  slug: json['slug'] as String,
  logoUrl: json['logo_url'] as String?,
  coverUrl: json['cover_url'] as String?,
  colorBackground: json['color_background'] as String?,
  colorButton: json['color_button'] as String?,
  colorCard: json['color_card'] as String?,
);

Map<String, dynamic> _$TenantModelToJson(_TenantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'logo_url': instance.logoUrl,
      'cover_url': instance.coverUrl,
      'color_background': instance.colorBackground,
      'color_button': instance.colorButton,
      'color_card': instance.colorCard,
    };
