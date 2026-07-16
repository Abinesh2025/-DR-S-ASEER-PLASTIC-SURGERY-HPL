// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalSignupModel _$HospitalSignupModelFromJson(Map<String, dynamic> json) =>
    HospitalSignupModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$HospitalSignupModelToJson(
  HospitalSignupModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};
