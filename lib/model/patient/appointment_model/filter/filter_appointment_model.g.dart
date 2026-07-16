// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterAppointmentModel _$FilterAppointmentModelFromJson(
  Map<String, dynamic> json,
) => FilterAppointmentModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => FilterAppointmentData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$FilterAppointmentModelToJson(
  FilterAppointmentModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

FilterAppointmentData _$FilterAppointmentDataFromJson(
  Map<String, dynamic> json,
) => FilterAppointmentData(
  id: (json['id'] as num?)?.toInt(),
  doctor_name: json['doctor_name'] as String?,
  appointment_date: json['appointment_date'] as String?,
  appointment_time: json['appointment_time'] as String?,
  doctor_department: json['doctor_department'] as String?,
  doctor_image_url: json['doctor_image_url'] as String?,
  token_number: json['token_number'],
  appointmentType: json['appointment_type'] as String?,
);

Map<String, dynamic> _$FilterAppointmentDataToJson(
  FilterAppointmentData instance,
) => <String, dynamic>{
  'id': instance.id,
  'doctor_name': instance.doctor_name,
  'appointment_date': instance.appointment_date,
  'appointment_time': instance.appointment_time,
  'doctor_department': instance.doctor_department,
  'doctor_image_url': instance.doctor_image_url,
  'token_number': instance.token_number,
  'appointment_type': instance.appointmentType,
};
