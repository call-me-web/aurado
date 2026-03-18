import 'package:freezed_annotation/freezed_annotation.dart';

part 'discovery_course_model.freezed.dart';
part 'discovery_course_model.g.dart';

@freezed
abstract class DiscoveryCourseModel with _$DiscoveryCourseModel {
  const DiscoveryCourseModel._();

  const factory DiscoveryCourseModel({
    required String id,
    @JsonKey(name: 'tenant_id') required String tenantId,
    required String title,
    @JsonKey(name: 'course_id') String? courseId,
    String? description,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @Default(0.0) double price,
    @Default('BDT') String currency,
    @Default([]) List<String> hashtags,
    String? level,
    String? duration,
    String? language,
    @JsonKey(name: 'what_you_will_learn') @Default([]) List<String> whatYouWillLearn,
    @Default([]) List<String> requirements,
    @JsonKey(name: 'course_type') String? courseType,
    @JsonKey(name: 'learning_materials') @Default([]) List<String> learningMaterials,
    @JsonKey(name: 'course_category') @Default([]) List<String> courseCategory,
    @JsonKey(name: 'tenant_name') String? tenantName,
    @JsonKey(name: 'tenant_logo_url') String? tenantLogoUrl,
  }) = _DiscoveryCourseModel;

  factory DiscoveryCourseModel.fromJson(Map<String, dynamic> json) => _$DiscoveryCourseModelFromJson(json);
}
