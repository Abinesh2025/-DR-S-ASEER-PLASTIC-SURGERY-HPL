// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'update_settings_model.g.dart';
@JsonSerializable(explicitToJson: true)
class UpdateSettingsModel {
  bool? success;
  SettingsData? data;
  String? message;

  UpdateSettingsModel({
    this.success,
    this.data,
    this.message,
  });
  factory UpdateSettingsModel.fromJson(Map<String, dynamic> json) => _$UpdateSettingsModelFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateSettingsModelToJson(this);

}

@JsonSerializable(explicitToJson: true)
class SettingsData {
  String? app_name;
  String? app_logo;
  String? favicon;
  String? email;
  String? address;
  String? phone;
  String? default_country_code;
  String? plan_expire_notification;
  String? default_language;
  List<Language>? language;
  String? super_admin_currency;
  List<Currency>? currency;

  SettingsData({
    this.app_name,
    this.app_logo,
    this.favicon,
    this.email,
    this.address,
    this.phone,
    this.default_country_code,
    this.plan_expire_notification,
    this.default_language,
    this.language,
    this.super_admin_currency,
    this.currency,
  });
  factory SettingsData.fromJson(Map<String, dynamic> json) => _$SettingsDataFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class Currency {
  int? id;
  String? currency_name;
  String? currency_code;
  String? currency_icon;
  dynamic deleted_at;

  Currency({
    this.id,
    this.currency_name,
    this.currency_code,
    this.currency_icon,
    this.deleted_at,
  });
  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

}

@JsonSerializable(explicitToJson: true)
class Language {
  String? id;
  String? name;

  Language({
    this.id,
    this.name,
  });
  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

}
