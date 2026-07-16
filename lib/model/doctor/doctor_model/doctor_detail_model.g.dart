// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorsDetailModel _$DoctorsDetailModelFromJson(Map<String, dynamic> json) =>
    DoctorsDetailModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : DoctorsDetailData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DoctorsDetailModelToJson(DoctorsDetailModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

DoctorsDetailData _$DoctorsDetailDataFromJson(Map<String, dynamic> json) =>
    DoctorsDetailData(
      id: (json['id'] as num?)?.toInt(),
      doctor_name: json['doctor_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      designation: json['designation'] as String?,
      doctor_department: json['doctor_department'] as String?,
      qualification: json['qualification'] as String?,
      blood_group: json['blood_group'] as String?,
      date_of_birth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      specialist: json['specialist'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String?,
      zip: json['zip'] as String?,
    );

Map<String, dynamic> _$DoctorsDetailDataToJson(DoctorsDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_name': instance.doctor_name,
      'email': instance.email,
      'phone': instance.phone,
      'designation': instance.designation,
      'doctor_department': instance.doctor_department,
      'qualification': instance.qualification,
      'blood_group': instance.blood_group,
      'date_of_birth': instance.date_of_birth,
      'gender': instance.gender,
      'specialist': instance.specialist,
      'address1': instance.address1,
      'address2': instance.address2,
      'city': instance.city,
      'zip': instance.zip,
    };
