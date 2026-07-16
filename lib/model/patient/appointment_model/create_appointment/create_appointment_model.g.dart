// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAppointmentModel _$CreateAppointmentModelFromJson(
  Map<String, dynamic> json,
) => CreateAppointmentModel(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : AppointmentData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateAppointmentModelToJson(
  CreateAppointmentModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data?.toJson(),
  'appointment_id': instance.appointmentId,
};

AppointmentData _$AppointmentDataFromJson(Map<String, dynamic> json) =>
    AppointmentData();

Map<String, dynamic> _$AppointmentDataToJson(AppointmentData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointment_id': instance.appointmentId,
    };
