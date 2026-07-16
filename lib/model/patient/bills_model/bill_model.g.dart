// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillsModel _$BillsModelFromJson(Map<String, dynamic> json) => BillsModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => BillsData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$BillsModelToJson(BillsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

BillsData _$BillsDataFromJson(Map<String, dynamic> json) => BillsData(
  id: (json['id'] as num?)?.toInt(),
  bill_id: json['bill_id'] as String?,
  bill_date: json['bill_date'] as String?,
  bill_time: json['bill_time'] as String?,
  amount: (json['amount'] as num?)?.toInt(),
  currency: json['currency'] as String?,
);

Map<String, dynamic> _$BillsDataToJson(BillsData instance) => <String, dynamic>{
  'id': instance.id,
  'bill_id': instance.bill_id,
  'bill_time': instance.bill_time,
  'bill_date': instance.bill_date,
  'amount': instance.amount,
  'currency': instance.currency,
};
