// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_patients_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorPatientsDocumentsModel _$DoctorPatientsDocumentsModelFromJson(
  Map<String, dynamic> json,
) => DoctorPatientsDocumentsModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PatientData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorPatientsDocumentsModelToJson(
  DoctorPatientsDocumentsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

PatientData _$PatientDataFromJson(Map<String, dynamic> json) => PatientData(
  id: (json['id'] as num?)?.toInt(),
  patient_name: json['patient_name'] as String?,
);

Map<String, dynamic> _$PatientDataToJson(PatientData instance) =>
    <String, dynamic>{'id': instance.id, 'patient_name': instance.patient_name};
