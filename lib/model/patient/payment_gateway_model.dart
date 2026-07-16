import 'package:json_annotation/json_annotation.dart';

part 'payment_gateway_model.g.dart';

@JsonSerializable()
class PaymentGatewayModel {
  bool? success;
  PaymentGatewayData? data;
  String? message;

  PaymentGatewayModel({this.success, this.data, this.message});

  factory PaymentGatewayModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewayModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentGatewayModelToJson(this);
}

@JsonSerializable()
class PaymentGatewayData {
  bool? razorpay;
  @JsonKey(name: 'razorpay_key')
  String? razorpayKey;
  bool? stripe;
  @JsonKey(name: 'stripe_key')
  String? stripeKey;
  bool? paypal;
  @JsonKey(name: 'paypal_client_id')
  String? paypalClientId;
  @JsonKey(name: 'paypal_mode')
  String? paypalMode;
  bool? paystack;
  @JsonKey(name: 'paystack_public_key')
  String? paystackPublicKey;
  bool? phonepe;
  @JsonKey(name: 'phonepe_merchant_id')
  String? phonepeMerchantId;
  @JsonKey(name: 'phonepe_env')
  String? phonepeEnv;
  bool? flutterwave;
  @JsonKey(name: 'flutterwave_public_key')
  String? flutterwavePublicKey;

  PaymentGatewayData({
    this.razorpay,
    this.razorpayKey,
    this.stripe,
    this.stripeKey,
    this.paypal,
    this.paypalClientId,
    this.paypalMode,
    this.paystack,
    this.paystackPublicKey,
    this.phonepe,
    this.phonepeMerchantId,
    this.phonepeEnv,
    this.flutterwave,
    this.flutterwavePublicKey,
  });

  factory PaymentGatewayData.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewayDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentGatewayDataToJson(this);
}
