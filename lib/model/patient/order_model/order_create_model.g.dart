// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateModel _$OrderCreateModelFromJson(Map<String, dynamic> json) =>
    OrderCreateModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : OrderCreateData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$OrderCreateModelToJson(OrderCreateModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

OrderCreateData _$OrderCreateDataFromJson(Map<String, dynamic> json) =>
    OrderCreateData(
      orderId: (json['order_id'] as num?)?.toInt(),
      totalAmount: json['total_amount'],
    );

Map<String, dynamic> _$OrderCreateDataToJson(OrderCreateData instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'total_amount': instance.totalAmount,
    };

OrderCreateRequest _$OrderCreateRequestFromJson(Map<String, dynamic> json) =>
    OrderCreateRequest(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      address: json['address'] as String?,
      city: json['city'] as String?,
      pincode: json['pincode'] as String?,
    );

Map<String, dynamic> _$OrderCreateRequestToJson(OrderCreateRequest instance) =>
    <String, dynamic>{
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'total_amount': instance.totalAmount,
      'address': instance.address,
      'city': instance.city,
      'pincode': instance.pincode,
    };

OrderItemRequest _$OrderItemRequestFromJson(Map<String, dynamic> json) =>
    OrderItemRequest(
      medicineId: (json['medicine_id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderItemRequestToJson(OrderItemRequest instance) =>
    <String, dynamic>{
      'medicine_id': instance.medicineId,
      'quantity': instance.quantity,
    };
