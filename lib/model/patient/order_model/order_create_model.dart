import 'package:json_annotation/json_annotation.dart';

part 'order_create_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderCreateModel {
  bool? success;
  OrderCreateData? data;
  String? message;

  OrderCreateModel({
    this.success,
    this.data,
    this.message,
  });

  factory OrderCreateModel.fromJson(Map<String, dynamic> json) => _$OrderCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderCreateData {
  @JsonKey(name: 'order_id')
  int? orderId;
  @JsonKey(name: 'total_amount')
  dynamic totalAmount;

  OrderCreateData({
    this.orderId,
    this.totalAmount,
  });

  factory OrderCreateData.fromJson(Map<String, dynamic> json) => _$OrderCreateDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderCreateRequest {
  List<OrderItemRequest>? items;
  @JsonKey(name: 'total_amount')
  double? totalAmount;
  String? address;
  String? city;
  String? pincode;

  OrderCreateRequest({
    this.items,
    this.totalAmount,
    this.address,
    this.city,
    this.pincode,
  });

  factory OrderCreateRequest.fromJson(Map<String, dynamic> json) => _$OrderCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItemRequest {
  @JsonKey(name: 'medicine_id')
  int? medicineId;
  int? quantity;

  OrderItemRequest({
    this.medicineId,
    this.quantity,
  });

  factory OrderItemRequest.fromJson(Map<String, dynamic> json) => _$OrderItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemRequestToJson(this);
}
