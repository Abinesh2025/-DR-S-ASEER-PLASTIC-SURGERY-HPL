// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponseModel _$OrderResponseModelFromJson(Map<String, dynamic> json) =>
    OrderResponseModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$OrderResponseModelToJson(OrderResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

OrderDataModel _$OrderDataModelFromJson(Map<String, dynamic> json) =>
    OrderDataModel(
      orderId: (json['order_id'] as num?)?.toInt(),
      totalAmount: json['total_amount'],
      status: json['status'] as String?,
      deliveryAddress: json['delivery_address'] as String?,
      deliveryCity: json['delivery_city'] as String?,
      deliveryPincode: json['delivery_pincode'] as String?,
      createdAt: json['created_at'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDataModelToJson(OrderDataModel instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'total_amount': instance.totalAmount,
      'status': instance.status,
      'delivery_address': instance.deliveryAddress,
      'delivery_city': instance.deliveryCity,
      'delivery_pincode': instance.deliveryPincode,
      'created_at': instance.createdAt,
      'items': instance.items,
    };

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      medicineId: (json['medicine_id'] as num?)?.toInt(),
      medicineName: json['medicine_name'] as String?,
      quantity: json['quantity'],
      price: json['price'],
      subtotal: json['subtotal'],
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'medicine_id': instance.medicineId,
      'medicine_name': instance.medicineName,
      'quantity': instance.quantity,
      'price': instance.price,
      'subtotal': instance.subtotal,
    };
