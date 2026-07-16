// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayrollModel _$PayrollModelFromJson(Map<String, dynamic> json) => PayrollModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PayrollData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$PayrollModelToJson(PayrollModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

PayrollData _$PayrollDataFromJson(Map<String, dynamic> json) => PayrollData(
  id: (json['id'] as num?)?.toInt(),
  payroll_id: json['payroll_id'] as String?,
  month: json['month'] as String?,
  year: (json['year'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$PayrollDataToJson(PayrollData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payroll_id': instance.payroll_id,
      'month': instance.month,
      'year': instance.year,
      'status': instance.status,
    };
