// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorAppointmentModel _$DoctorAppointmentModelFromJson(
  Map<String, dynamic> json,
) => DoctorAppointmentModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => DoctorAppointmentData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorAppointmentModelToJson(
  DoctorAppointmentModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

DoctorAppointmentData _$DoctorAppointmentDataFromJson(
  Map<String, dynamic> json,
) => DoctorAppointmentData(
  id: (json['id'] as num?)?.toInt(),
  patient_id: (json['patient_id'] as num?)?.toInt(),
  patient_name: json['patient_name'] as String?,
  appointment_date: json['appointment_date'] as String?,
  appointment_time: json['appointment_time'] as String?,
  patient_image: json['patient_image'] as String?,
  token_number: json['token_number'],
  is_completed: json['appointment_status'] as String?,
  appointmentType: json['appointment_type'] as String?,
)..isIsroPatient = json['is_isro_patient'] as bool?;

Map<String, dynamic> _$DoctorAppointmentDataToJson(
  DoctorAppointmentData instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_id': instance.patient_id,
  'patient_name': instance.patient_name,
  'appointment_date': instance.appointment_date,
  'appointment_time': instance.appointment_time,
  'patient_image': instance.patient_image,
  'token_number': instance.token_number,
  'appointment_status': instance.is_completed,
  'appointment_type': instance.appointmentType,
  'is_isro_patient': instance.isIsroPatient,
};
