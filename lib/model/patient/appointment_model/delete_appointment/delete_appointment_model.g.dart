// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAppointmentModel _$DeleteAppointmentModelFromJson(
  Map<String, dynamic> json,
) => DeleteAppointmentModel(
  success: json['success'] as bool?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$DeleteAppointmentModelToJson(
  DeleteAppointmentModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};
