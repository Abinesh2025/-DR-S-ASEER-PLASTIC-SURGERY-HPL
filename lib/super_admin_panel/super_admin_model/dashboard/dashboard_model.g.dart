// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashBoardModel _$DashBoardModelFromJson(Map<String, dynamic> json) =>
    DashBoardModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : DashboardData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DashBoardModelToJson(DashBoardModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      users: (json['users'] as num?)?.toInt(),
      revenue: (json['revenue'] as num?)?.toDouble(),
      currency: json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      activeHospitalPlan: (json['activeHospitalPlan'] as num?)?.toInt(),
      deActiveHospitalPlan: (json['deActiveHospitalPlan'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'users': instance.users,
      'revenue': instance.revenue,
      'currency': instance.currency?.toJson(),
      'activeHospitalPlan': instance.activeHospitalPlan,
      'deActiveHospitalPlan': instance.deActiveHospitalPlan,
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
