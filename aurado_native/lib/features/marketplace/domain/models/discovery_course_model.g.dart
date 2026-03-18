// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery_course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiscoveryCourseModel _$DiscoveryCourseModelFromJson(
  Map<String, dynamic> json,
) => _DiscoveryCourseModel(
  id: json['id'] as String,
  tenantId: json['tenant_id'] as String,
  title: json['title'] as String,
  courseId: json['course_id'] as String?,
  description: json['description'] as String?,
  thumbnailUrl: json['thumbnail_url'] as String?,
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  currency: json['currency'] as String? ?? 'BDT',
  hashtags:
      (json['hashtags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  level: json['level'] as String?,
  duration: json['duration'] as String?,
  language: json['language'] as String?,
  whatYouWillLearn:
      (json['what_you_will_learn'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  requirements:
      (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  courseType: json['course_type'] as String?,
  learningMaterials:
      (json['learning_materials'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  courseCategory:
      (json['course_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  tenantName: json['tenant_name'] as String?,
  tenantLogoUrl: json['tenant_logo_url'] as String?,
);

Map<String, dynamic> _$DiscoveryCourseModelToJson(
  _DiscoveryCourseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'tenant_id': instance.tenantId,
  'title': instance.title,
  'course_id': instance.courseId,
  'description': instance.description,
  'thumbnail_url': instance.thumbnailUrl,
  'price': instance.price,
  'currency': instance.currency,
  'hashtags': instance.hashtags,
  'level': instance.level,
  'duration': instance.duration,
  'language': instance.language,
  'what_you_will_learn': instance.whatYouWillLearn,
  'requirements': instance.requirements,
  'course_type': instance.courseType,
  'learning_materials': instance.learningMaterials,
  'course_category': instance.courseCategory,
  'tenant_name': instance.tenantName,
  'tenant_logo_url': instance.tenantLogoUrl,
};
