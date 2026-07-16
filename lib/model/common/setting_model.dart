import 'package:json_annotation/json_annotation.dart';

part 'setting_model.g.dart';

@JsonSerializable()
class SettingModel {
  bool? success;
  SettingData? data;
  String? message;

  SettingModel({
    this.success,
    this.data,
    this.message,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingModelToJson(this);
}

@JsonSerializable()
class SettingData {
  String? app_name;
  String? company_name;
  String? hospital_email;
  String? hospital_phone;
  String? country_code;
  String? enable_google_recaptcha;
  String? app_logo;
  String? favicon;
  String? theme_color;

  // NEW FIELD
  List<PatientCustomField>? patient_custom_fields;

  SettingData({
    this.app_name,
    this.company_name,
    this.hospital_email,
    this.hospital_phone,
    this.country_code,
    this.enable_google_recaptcha,
    this.app_logo,
    this.favicon,
    this.theme_color,
    this.patient_custom_fields,
  });

  factory SettingData.fromJson(Map<String, dynamic> json) =>
      _$SettingDataFromJson(json);

  Map<String, dynamic> toJson() => _$SettingDataToJson(this);
}

@JsonSerializable()
class PatientCustomField {
  int? id;
  String? field_name;
  int? field_type;
  String? field_type_name;
  bool? is_required;
  bool? has_notes;
  List<dynamic>? values;
  int? grid;

  PatientCustomField({
    this.id,
    this.field_name,
    this.field_type,
    this.field_type_name,
    this.is_required,
    this.has_notes,
    this.values,
    this.grid,
  });

  factory PatientCustomField.fromJson(Map<String, dynamic> json) =>
      _$PatientCustomFieldFromJson(json);

  Map<String, dynamic> toJson() => _$PatientCustomFieldToJson(this);
}