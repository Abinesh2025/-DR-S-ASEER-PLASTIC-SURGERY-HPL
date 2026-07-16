// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminAppointmentModel _$AdminAppointmentModelFromJson(
  Map<String, dynamic> json,
) => AdminAppointmentModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => AppointmentData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$AdminAppointmentModelToJson(
  AdminAppointmentModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

AppointmentData _$AppointmentDataFromJson(Map<String, dynamic> json) =>
    AppointmentData(
      id: (json['id'] as num?)?.toInt(),
      patient_id: (json['patient_id'] as num?)?.toInt(),
      patient_name: json['patient_name'] as String?,
      patient_image: json['patient_image'] as String?,
      appointment_date: json['appointment_date'] as String?,
      appointment_time: json['appointment_time'] as String?,
      doctor_id: (json['doctor_id'] as num?)?.toInt(),
      is_completed: json['is_completed'] as String?,
      doctor_name: json['doctor_name'] as String?,
      doctor_department: json['doctor_department'] as String?,
    );

Map<String, dynamic> _$AppointmentDataToJson(AppointmentData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patient_id,
      'patient_name': instance.patient_name,
      'patient_image': instance.patient_image,
      'appointment_date': instance.appointment_date,
      'appointment_time': instance.appointment_time,
      'doctor_id': instance.doctor_id,
      'is_completed': instance.is_completed,
      'doctor_name': instance.doctor_name,
      'doctor_department': instance.doctor_department,
    };
