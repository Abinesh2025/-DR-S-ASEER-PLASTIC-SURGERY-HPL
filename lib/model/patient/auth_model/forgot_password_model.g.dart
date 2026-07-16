// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordModel _$ForgotPasswordModelFromJson(Map<String, dynamic> json) =>
    ForgotPasswordModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordModelToJson(
  ForgotPasswordModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};
