// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_appointment_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorAppointmentDetailModel _$DoctorAppointmentDetailModelFromJson(
  Map<String, dynamic> json,
) => DoctorAppointmentDetailModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : DoctorAppointmentDetailData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorAppointmentDetailModelToJson(
  DoctorAppointmentDetailModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.toJson(),
  'message': instance.message,
};

DoctorAppointmentDetailData _$DoctorAppointmentDetailDataFromJson(
  Map<String, dynamic> json,
) => DoctorAppointmentDetailData(
  id: (json['appointment_id'] as num?)?.toInt(),
  patient_name: json['patient_name'] as String?,
  appointment_date: json['appointment_date'] as String?,
  appointment_time: json['appointment_time'] as String?,
  patient_image: json['photo'] as String?,
  token_number: (json['token_number'] as num?)?.toInt(),
  schedule_type: json['schedule_type'] as String?,
  status: json['appointment_status'] as String?,
  patient_email: json['email'] as String?,
  patient_phone: json['phone'],
  gender: json['gender'],
  problem: json['problem'] as String?,
);

Map<String, dynamic> _$DoctorAppointmentDetailDataToJson(
  DoctorAppointmentDetailData instance,
) => <String, dynamic>{
  'appointment_id': instance.id,
  'patient_name': instance.patient_name,
  'appointment_date': instance.appointment_date,
  'appointment_time': instance.appointment_time,
  'photo': instance.patient_image,
  'token_number': instance.token_number,
  'schedule_type': instance.schedule_type,
  'appointment_status': instance.status,
  'email': instance.patient_email,
  'phone': instance.patient_phone,
  'gender': instance.gender,
  'problem': instance.problem,
};
