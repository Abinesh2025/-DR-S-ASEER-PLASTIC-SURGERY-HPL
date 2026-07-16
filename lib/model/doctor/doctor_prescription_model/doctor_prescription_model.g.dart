// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_prescription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorPrescriptionModel _$DoctorPrescriptionModelFromJson(
  Map<String, dynamic> json,
) => DoctorPrescriptionModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => DoctorPrescriptionData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorPrescriptionModelToJson(
  DoctorPrescriptionModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

DoctorPrescriptionData _$DoctorPrescriptionDataFromJson(
  Map<String, dynamic> json,
) => DoctorPrescriptionData(
  id: (json['id'] as num?)?.toInt(),
  patient_name: json['patient_name'] as String?,
  patient_image: json['patient_image'] as String?,
  created_date: json['created_date'] as String?,
);

Map<String, dynamic> _$DoctorPrescriptionDataToJson(
  DoctorPrescriptionData instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_name': instance.patient_name,
  'patient_image': instance.patient_image,
  'created_date': instance.created_date,
};
