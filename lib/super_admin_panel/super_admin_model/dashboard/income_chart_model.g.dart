// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeModel _$IncomeModelFromJson(Map<String, dynamic> json) => IncomeModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => IncomeData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$IncomeModelToJson(IncomeModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

IncomeData _$IncomeDataFromJson(Map<String, dynamic> json) => IncomeData(
  days: json['days'] as String?,
  income: (json['income'] as num?)?.toDouble(),
);

Map<String, dynamic> _$IncomeDataToJson(IncomeData instance) =>
    <String, dynamic>{'days': instance.days, 'income': instance.income};
