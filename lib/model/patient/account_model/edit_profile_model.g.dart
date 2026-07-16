// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileModel _$EditProfileModelFromJson(Map<String, dynamic> json) =>
    EditProfileModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : EditProfileData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$EditProfileModelToJson(EditProfileModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

EditProfileData _$EditProfileDataFromJson(Map<String, dynamic> json) =>
    EditProfileData(
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      region_code: json['region_code'] as String?,
      profile_image: json['profile_image'] as String?,
      address: json['address'] == null
          ? null
          : PatientAddress.fromJson(json['address'] as Map<String, dynamic>),
      city: json['city'] as String?,
      pincode: json['pincode'] as String?,
    );

Map<String, dynamic> _$EditProfileDataToJson(EditProfileData instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'phone': instance.phone,
      'region_code': instance.region_code,
      'profile_image': instance.profile_image,
      'address': instance.address?.toJson(),
      'city': instance.city,
      'pincode': instance.pincode,
    };
