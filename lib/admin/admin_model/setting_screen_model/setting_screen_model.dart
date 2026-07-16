// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'setting_screen_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AdminSettingModel {
  bool? success;
  SettingsData? data;
  String? message;

  AdminSettingModel({
    this.success,
    this.data,
    this.message,
  });
  factory AdminSettingModel.fromJson(Map<String, dynamic> json) => _$AdminSettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdminSettingModelToJson(this);

}

@JsonSerializable(explicitToJson: true)
class SettingsData {
  String? app_name;
  String? company_name;
  String? hospital_email;
  String? hospital_phone;
  String? country_code;
  String? enable_google_recaptcha;
  String? app_logo;
  String? favicon;

  SettingsData({
    this.app_name,
    this.company_name,
    this.hospital_email,
    this.hospital_phone,
    this.country_code,
    this.enable_google_recaptcha,
    this.app_logo,
    this.favicon,
  });
  factory SettingsData.fromJson(Map<String, dynamic> json) => _$SettingsDataFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsDataToJson(this);

}
