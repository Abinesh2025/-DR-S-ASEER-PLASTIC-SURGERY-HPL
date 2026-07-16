// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayrollDetailsModel _$PayrollDetailsModelFromJson(Map<String, dynamic> json) =>
    PayrollDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : PayrollDetailsData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PayrollDetailsModelToJson(
  PayrollDetailsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.toJson(),
  'message': instance.message,
};

PayrollDetailsData _$PayrollDetailsDataFromJson(Map<String, dynamic> json) =>
    PayrollDetailsData(
      id: (json['id'] as num?)?.toInt(),
      sr_no: (json['sr_no'] as num?)?.toInt(),
      payroll_id: json['payroll_id'] as String?,
      month: json['month'] as String?,
      year: (json['year'] as num?)?.toInt(),
      net_salary: (json['net_salary'] as num?)?.toInt(),
      status: json['status'] as String?,
      basic_salary: (json['basic_salary'] as num?)?.toInt(),
      allowance: (json['allowance'] as num?)?.toInt(),
      deductions: (json['deductions'] as num?)?.toInt(),
      created_on: json['created_on'] as String?,
      currency_symbol: json['currency_symbol'] as String?,
      app_logo: json['app_logo'] as String?,
    );

Map<String, dynamic> _$PayrollDetailsDataToJson(PayrollDetailsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sr_no': instance.sr_no,
      'payroll_id': instance.payroll_id,
      'month': instance.month,
      'year': instance.year,
      'net_salary': instance.net_salary,
      'status': instance.status,
      'basic_salary': instance.basic_salary,
      'allowance': instance.allowance,
      'deductions': instance.deductions,
      'created_on': instance.created_on,
      'currency_symbol': instance.currency_symbol,
      'app_logo': instance.app_logo,
    };
