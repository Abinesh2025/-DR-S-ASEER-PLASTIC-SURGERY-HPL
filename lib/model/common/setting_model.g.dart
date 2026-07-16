// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingModel _$SettingModelFromJson(Map<String, dynamic> json) => SettingModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : SettingData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$SettingModelToJson(SettingModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

SettingData _$SettingDataFromJson(Map<String, dynamic> json) => SettingData(
  app_name: json['app_name'] as String?,
  company_name: json['company_name'] as String?,
  hospital_email: json['hospital_email'] as String?,
  hospital_phone: json['hospital_phone'] as String?,
  country_code: json['country_code'] as String?,
  enable_google_recaptcha: json['enable_google_recaptcha'] as String?,
  app_logo: json['app_logo'] as String?,
  favicon: json['favicon'] as String?,
  theme_color: json['theme_color'] as String?,
  patient_custom_fields: (json['patient_custom_fields'] as List<dynamic>?)
      ?.map((e) => PatientCustomField.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SettingDataToJson(SettingData instance) =>
    <String, dynamic>{
      'app_name': instance.app_name,
      'company_name': instance.company_name,
      'hospital_email': instance.hospital_email,
      'hospital_phone': instance.hospital_phone,
      'country_code': instance.country_code,
      'enable_google_recaptcha': instance.enable_google_recaptcha,
      'app_logo': instance.app_logo,
      'favicon': instance.favicon,
      'theme_color': instance.theme_color,
      'patient_custom_fields': instance.patient_custom_fields,
    };

PatientCustomField _$PatientCustomFieldFromJson(Map<String, dynamic> json) =>
    PatientCustomField(
      id: (json['id'] as num?)?.toInt(),
      field_name: json['field_name'] as String?,
      field_type: (json['field_type'] as num?)?.toInt(),
      field_type_name: json['field_type_name'] as String?,
      is_required: json['is_required'] as bool?,
      has_notes: json['has_notes'] as bool?,
      values: json['values'] as List<dynamic>?,
      grid: (json['grid'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PatientCustomFieldToJson(PatientCustomField instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field_name': instance.field_name,
      'field_type': instance.field_type,
      'field_type_name': instance.field_type_name,
      'is_required': instance.is_required,
      'has_notes': instance.has_notes,
      'values': instance.values,
      'grid': instance.grid,
    };
