// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterSubscriptionModel _$FilterSubscriptionModelFromJson(
  Map<String, dynamic> json,
) => FilterSubscriptionModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => FilterSubscriptionData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$FilterSubscriptionModelToJson(
  FilterSubscriptionModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

FilterSubscriptionData _$FilterSubscriptionDataFromJson(
  Map<String, dynamic> json,
) => FilterSubscriptionData(
  id: (json['id'] as num?)?.toInt(),
  hospital_name: json['hospital_name'] as String?,
  subscription_plan_name: json['subscription_plan_name'] as String?,
  amount: (json['amount'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  plan_frequency: json['plan_frequency'] as String?,
  start_date: json['start_date'] as String?,
  start_time: json['start_time'] as String?,
  expire_date: json['expire_date'] as String?,
  expire_time: json['expire_time'] as String?,
  sms_limit: (json['sms_limit'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$FilterSubscriptionDataToJson(
  FilterSubscriptionData instance,
) => <String, dynamic>{
  'id': instance.id,
  'hospital_name': instance.hospital_name,
  'subscription_plan_name': instance.subscription_plan_name,
  'amount': instance.amount,
  'currency': instance.currency,
  'plan_frequency': instance.plan_frequency,
  'start_date': instance.start_date,
  'start_time': instance.start_time,
  'expire_date': instance.expire_date,
  'expire_time': instance.expire_time,
  'sms_limit': instance.sms_limit,
  'status': instance.status,
};
