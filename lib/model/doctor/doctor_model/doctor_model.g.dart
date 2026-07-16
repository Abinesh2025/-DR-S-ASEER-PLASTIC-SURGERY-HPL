// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorsModel _$DoctorsModelFromJson(Map<String, dynamic> json) => DoctorsModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => DoctorsData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorsModelToJson(DoctorsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

DoctorsData _$DoctorsDataFromJson(Map<String, dynamic> json) => DoctorsData(
  id: (json['id'] as num?)?.toInt(),
  doctor_name: json['doctor_name'] as String?,
  doctor_department: json['doctor_department'] as String?,
  doctor_image: json['doctor_image'] as String?,
  doctor_specialist: json['doctor_specialist'] as String?,
);

Map<String, dynamic> _$DoctorsDataToJson(DoctorsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_name': instance.doctor_name,
      'doctor_department': instance.doctor_department,
      'doctor_image': instance.doctor_image,
      'doctor_specialist': instance.doctor_specialist,
    };
