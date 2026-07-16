// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

InvoiceData _$InvoiceDataFromJson(Map<String, dynamic> json) => InvoiceData(
  id: (json['id'] as num?)?.toInt(),
  invoice_id: json['invoice_id'] as String?,
  invoice_date: json['invoice_date'] as String?,
  amount: json['amount'],
  status: json['status'] as bool?,
  currency: json['currency'] as String?,
);

Map<String, dynamic> _$InvoiceDataToJson(InvoiceData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_id': instance.invoice_id,
      'invoice_date': instance.invoice_date,
      'amount': instance.amount,
      'status': instance.status,
      'currency': instance.currency,
    };
