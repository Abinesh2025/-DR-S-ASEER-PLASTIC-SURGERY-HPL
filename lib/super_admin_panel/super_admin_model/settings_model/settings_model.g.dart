// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : SettingsData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

SettingsData _$SettingsDataFromJson(Map<String, dynamic> json) => SettingsData(
  app_name: json['app_name'] as String?,
  app_logo: json['app_logo'] as String?,
  favicon: json['favicon'] as String?,
  email: json['email'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  default_country_code: json['default_country_code'] as String?,
  plan_expire_notification: json['plan_expire_notification'] as String?,
  default_language: json['default_language'] as String?,
  language: (json['language'] as List<dynamic>?)
      ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
      .toList(),
  super_admin_currency: json['super_admin_currency'] as String?,
  currency: (json['currency'] as List<dynamic>?)
      ?.map((e) => Currency.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SettingsDataToJson(SettingsData instance) =>
    <String, dynamic>{
      'app_name': instance.app_name,
      'app_logo': instance.app_logo,
      'favicon': instance.favicon,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'default_country_code': instance.default_country_code,
      'plan_expire_notification': instance.plan_expire_notification,
      'default_language': instance.default_language,
      'language': instance.language?.map((e) => e.toJson()).toList(),
      'super_admin_currency': instance.super_admin_currency,
      'currency': instance.currency?.map((e) => e.toJson()).toList(),
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
  id: (json['id'] as num?)?.toInt(),
  currency_name: json['currency_name'] as String?,
  currency_code: json['currency_code'] as String?,
  currency_icon: json['currency_icon'] as String?,
  deleted_at: json['deleted_at'],
);

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
  'id': instance.id,
  'currency_name': instance.currency_name,
  'currency_code': instance.currency_code,
  'currency_icon': instance.currency_icon,
  'deleted_at': instance.deleted_at,
};

Language _$LanguageFromJson(Map<String, dynamic> json) =>
    Language(id: json['id'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
