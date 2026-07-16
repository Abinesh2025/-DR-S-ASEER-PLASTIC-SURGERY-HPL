// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_admission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientAdmissionModel _$PatientAdmissionModelFromJson(
  Map<String, dynamic> json,
) => PatientAdmissionModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PatientAdmissionData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$PatientAdmissionModelToJson(
  PatientAdmissionModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

PatientAdmissionData _$PatientAdmissionDataFromJson(
  Map<String, dynamic> json,
) => PatientAdmissionData(
  id: (json['id'] as num?)?.toInt(),
  patient_name: json['patient_name'] as String?,
  admission_id: json['admission_id'] as String?,
  patient_image: json['patient_image'] as String?,
  admission_date: json['admission_date'] as String?,
  admission_time: json['admission_time'] as String?,
);

Map<String, dynamic> _$PatientAdmissionDataToJson(
  PatientAdmissionData instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_name': instance.patient_name,
  'admission_id': instance.admission_id,
  'patient_image': instance.patient_image,
  'admission_date': instance.admission_date,
  'admission_time': instance.admission_time,
};
