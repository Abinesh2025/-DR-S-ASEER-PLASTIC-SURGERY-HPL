// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDoctorModel _$GetDoctorModelFromJson(Map<String, dynamic> json) =>
    GetDoctorModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GetDoctorData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetDoctorModelToJson(GetDoctorModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

GetDoctorData _$GetDoctorDataFromJson(Map<String, dynamic> json) =>
    GetDoctorData(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      doctor_image: json['doctor_image'] as String?,
      doctor_image_url: json['doctor_image_url'] as String?,
      doctor_department: json['doctor_department'] as String?,
      department_id: (json['department_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      specialist: json['specialist'] as String?,
      appointment_charge: (json['appointment_charge'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDoctorDataToJson(GetDoctorData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'doctor_image': instance.doctor_image,
      'doctor_image_url': instance.doctor_image_url,
      'doctor_department': instance.doctor_department,
      'department_id': instance.department_id,
      'description': instance.description,
      'specialist': instance.specialist,
      'appointment_charge': instance.appointment_charge,
      'user': instance.user?.toJson(),
    };
