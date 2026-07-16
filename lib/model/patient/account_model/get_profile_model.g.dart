// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileModel _$GetProfileModelFromJson(Map<String, dynamic> json) =>
    GetProfileModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : GetProfileData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetProfileModelToJson(GetProfileModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

GetProfileData _$GetProfileDataFromJson(Map<String, dynamic> json) =>
    GetProfileData(
      id: (json['id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      email: json['email'] as String?,
      last_name: json['last_name'] as String?,
      phone_number: json['phone_number'] as String?,
      region_code: json['region_code'] as String?,
      image_url: json['image_url'] as String?,
      address: json['address'] == null
          ? null
          : PatientAddress.fromJson(json['address'] as Map<String, dynamic>),
      city: json['city'] as String?,
      pincode: json['pincode'] as String?,
      custom_field: json['custom_field'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GetProfileDataToJson(GetProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'email': instance.email,
      'last_name': instance.last_name,
      'phone_number': instance.phone_number,
      'region_code': instance.region_code,
      'image_url': instance.image_url,
      'address': instance.address?.toJson(),
      'city': instance.city,
      'pincode': instance.pincode,
      'custom_field': instance.custom_field,
    };

PatientAddress _$PatientAddressFromJson(Map<String, dynamic> json) =>
    PatientAddress(
      id: (json['id'] as num?)?.toInt(),
      owner_id: (json['owner_id'] as num?)?.toInt(),
      owner_type: json['owner_type'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String?,
      zip: json['zip'] as String?,
      tenant_id: json['tenant_id'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PatientAddressToJson(PatientAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.owner_id,
      'owner_type': instance.owner_type,
      'address1': instance.address1,
      'address2': instance.address2,
      'city': instance.city,
      'zip': instance.zip,
      'tenant_id': instance.tenant_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
