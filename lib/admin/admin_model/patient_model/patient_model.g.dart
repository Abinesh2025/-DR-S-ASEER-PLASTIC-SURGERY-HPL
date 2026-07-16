// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PatientsData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

PatientsData _$PatientsDataFromJson(Map<String, dynamic> json) => PatientsData(
  id: (json['id'] as num?)?.toInt(),
  patient_name: json['patient_name'] as String?,
  phone_no: json['phone_no'] as String?,
  patient_image: json['patient_image'] as String?,
);

Map<String, dynamic> _$PatientsDataToJson(PatientsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_name': instance.patient_name,
      'phone_no': instance.phone_no,
      'patient_image': instance.patient_image,
    };
