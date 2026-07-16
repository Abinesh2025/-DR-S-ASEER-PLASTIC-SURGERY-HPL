// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_screen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminSettingModel _$AdminSettingModelFromJson(Map<String, dynamic> json) =>
    AdminSettingModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : SettingsData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AdminSettingModelToJson(AdminSettingModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

SettingsData _$SettingsDataFromJson(Map<String, dynamic> json) => SettingsData(
  app_name: json['app_name'] as String?,
  company_name: json['company_name'] as String?,
  hospital_email: json['hospital_email'] as String?,
  hospital_phone: json['hospital_phone'] as String?,
  country_code: json['country_code'] as String?,
  enable_google_recaptcha: json['enable_google_recaptcha'] as String?,
  app_logo: json['app_logo'] as String?,
  favicon: json['favicon'] as String?,
);

Map<String, dynamic> _$SettingsDataToJson(SettingsData instance) =>
    <String, dynamic>{
      'app_name': instance.app_name,
      'company_name': instance.company_name,
      'hospital_email': instance.hospital_email,
      'hospital_phone': instance.hospital_phone,
      'country_code': instance.country_code,
      'enable_google_recaptcha': instance.enable_google_recaptcha,
      'app_logo': instance.app_logo,
      'favicon': instance.favicon,
    };
