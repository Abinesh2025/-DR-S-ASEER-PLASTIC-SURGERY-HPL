// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelAppointmentModel _$CancelAppointmentModelFromJson(
  Map<String, dynamic> json,
) => CancelAppointmentModel(
  success: json['success'] as bool?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$CancelAppointmentModelToJson(
  CancelAppointmentModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};
