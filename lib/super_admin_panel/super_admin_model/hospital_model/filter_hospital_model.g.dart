// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_hospital_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterHospitalModel _$FilterHospitalModelFromJson(Map<String, dynamic> json) =>
    FilterHospitalModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FilterHospitalData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FilterHospitalModelToJson(
  FilterHospitalModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

FilterHospitalData _$FilterHospitalDataFromJson(Map<String, dynamic> json) =>
    FilterHospitalData(
      id: (json['id'] as num?)?.toInt(),
      hospital_name: json['hospital_name'] as String?,
      email: json['email'] as String?,
      hospital_slug: json['hospital_slug'] as String?,
      hospital_type: json['hospital_type'] as String?,
      hospital_type_id: json['hospital_type_id'],
      city: json['city'] as String?,
      status: (json['status'] as num?)?.toInt(),
      phone_no: json['phone_no'] as String?,
      region_code: json['region_code'] as String?,
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$FilterHospitalDataToJson(FilterHospitalData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hospital_name': instance.hospital_name,
      'email': instance.email,
      'hospital_slug': instance.hospital_slug,
      'hospital_type': instance.hospital_type,
      'hospital_type_id': instance.hospital_type_id,
      'city': instance.city,
      'status': instance.status,
      'phone_no': instance.phone_no,
      'region_code': instance.region_code,
      'image_url': instance.image_url,
    };
