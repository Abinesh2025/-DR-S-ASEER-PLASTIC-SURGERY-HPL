// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_gateway_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentGatewayModel _$PaymentGatewayModelFromJson(Map<String, dynamic> json) =>
    PaymentGatewayModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : PaymentGatewayData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PaymentGatewayModelToJson(
  PaymentGatewayModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

PaymentGatewayData _$PaymentGatewayDataFromJson(Map<String, dynamic> json) =>
    PaymentGatewayData(
      razorpay: json['razorpay'] as bool?,
      razorpayKey: json['razorpay_key'] as String?,
      stripe: json['stripe'] as bool?,
      stripeKey: json['stripe_key'] as String?,
      paypal: json['paypal'] as bool?,
      paypalClientId: json['paypal_client_id'] as String?,
      paypalMode: json['paypal_mode'] as String?,
      paystack: json['paystack'] as bool?,
      paystackPublicKey: json['paystack_public_key'] as String?,
      phonepe: json['phonepe'] as bool?,
      phonepeMerchantId: json['phonepe_merchant_id'] as String?,
      phonepeEnv: json['phonepe_env'] as String?,
      flutterwave: json['flutterwave'] as bool?,
      flutterwavePublicKey: json['flutterwave_public_key'] as String?,
    );

Map<String, dynamic> _$PaymentGatewayDataToJson(PaymentGatewayData instance) =>
    <String, dynamic>{
      'razorpay': instance.razorpay,
      'razorpay_key': instance.razorpayKey,
      'stripe': instance.stripe,
      'stripe_key': instance.stripeKey,
      'paypal': instance.paypal,
      'paypal_client_id': instance.paypalClientId,
      'paypal_mode': instance.paypalMode,
      'paystack': instance.paystack,
      'paystack_public_key': instance.paystackPublicKey,
      'phonepe': instance.phonepe,
      'phonepe_merchant_id': instance.phonepeMerchantId,
      'phonepe_env': instance.phonepeEnv,
      'flutterwave': instance.flutterwave,
      'flutterwave_public_key': instance.flutterwavePublicKey,
    };
