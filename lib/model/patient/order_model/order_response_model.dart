import 'package:json_annotation/json_annotation.dart';

part 'order_response_model.g.dart';

@JsonSerializable()
class OrderResponseModel {
  bool? success;
  List<OrderDataModel>? data;
  String? message;

  OrderResponseModel({this.success, this.data, this.message});

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseModelToJson(this);
}

@JsonSerializable()
class OrderDataModel {
  @JsonKey(name: 'order_id')
  int? orderId;

  @JsonKey(name: 'total_amount')
  dynamic totalAmount;

  String? status;

  @JsonKey(name: 'delivery_address')
  String? deliveryAddress;

  @JsonKey(name: 'delivery_city')
  String? deliveryCity;

  @JsonKey(name: 'delivery_pincode')
  String? deliveryPincode;

  @JsonKey(name: 'created_at')
  String? createdAt;

  List<OrderItemModel>? items;

  OrderDataModel({
    this.orderId,
    this.totalAmount,
    this.status,
    this.deliveryAddress,
    this.deliveryCity,
    this.deliveryPincode,
    this.createdAt,
    this.items,
  });

  factory OrderDataModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataModelToJson(this);
}

@JsonSerializable()
class OrderItemModel {
  @JsonKey(name: 'medicine_id')
  int? medicineId;

  @JsonKey(name: 'medicine_name')
  String? medicineName;

  dynamic quantity;
  dynamic price;
  dynamic subtotal;

  OrderItemModel({
    this.medicineId,
    this.medicineName,
    this.quantity,
    this.price,
    this.subtotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
