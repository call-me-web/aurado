import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant_model.freezed.dart';
part 'tenant_model.g.dart';

@freezed
abstract class TenantModel with _$TenantModel {
  const TenantModel._();

  const factory TenantModel({
    required String id,
    required String name,
    required String slug,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    @JsonKey(name: 'primary_color') String? primaryColor,
    @JsonKey(name: 'secondary_color') String? secondaryColor,
  }) = _TenantModel;

  factory TenantModel.fromJson(Map<String, dynamic> json) => _$TenantModelFromJson(json);
}
