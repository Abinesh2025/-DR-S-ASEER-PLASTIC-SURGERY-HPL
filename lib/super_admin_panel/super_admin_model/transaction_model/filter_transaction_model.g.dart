// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterTransactionModel _$FilterTransactionModelFromJson(
  Map<String, dynamic> json,
) => FilterTransactionModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => FilterTransactionData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$FilterTransactionModelToJson(
  FilterTransactionModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

FilterTransactionData _$FilterTransactionDataFromJson(
  Map<String, dynamic> json,
) => FilterTransactionData(
  id: (json['id'] as num?)?.toInt(),
  hospital_name: json['hospital_name'] as String?,
  payment_type: json['payment_type'] as String?,
  amount: json['amount'] as String?,
  is_manual_payment: (json['is_manual_payment'] as num?)?.toInt(),
  status: json['status'] as String?,
  transaction_date: json['transaction_date'] as String?,
  currency_symbol: json['currency_symbol'] as String?,
  start_date: json['start_date'] as String?,
  start_time: json['start_time'] as String?,
  expire_date: json['expire_date'] as String?,
  expire_time: json['expire_time'] as String?,
);

Map<String, dynamic> _$FilterTransactionDataToJson(
  FilterTransactionData instance,
) => <String, dynamic>{
  'id': instance.id,
  'hospital_name': instance.hospital_name,
  'payment_type': instance.payment_type,
  'amount': instance.amount,
  'is_manual_payment': instance.is_manual_payment,
  'status': instance.status,
  'transaction_date': instance.transaction_date,
  'currency_symbol': instance.currency_symbol,
  'start_date': instance.start_date,
  'start_time': instance.start_time,
  'expire_date': instance.expire_date,
  'expire_time': instance.expire_time,
};
