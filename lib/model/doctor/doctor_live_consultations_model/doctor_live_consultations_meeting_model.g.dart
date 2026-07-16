// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_live_consultations_meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorLiveConsultationsMeetingModel
_$DoctorLiveConsultationsMeetingModelFromJson(Map<String, dynamic> json) =>
    DoctorLiveConsultationsMeetingModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : DoctorLiveConsultationsMeetingData.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DoctorLiveConsultationsMeetingModelToJson(
  DoctorLiveConsultationsMeetingModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.toJson(),
  'message': instance.message,
};

DoctorLiveConsultationsMeetingData _$DoctorLiveConsultationsMeetingDataFromJson(
  Map<String, dynamic> json,
) => DoctorLiveConsultationsMeetingData(
  consultation_title: json['consultation_title'] as String?,
  status: json['status'] as String?,
  host_video: json['host_video'] as String?,
  consultation_date: json['consultation_date'] as String?,
  duration_minutes: json['duration_minutes'] as String?,
  meta: json['meta'] as String?,
);

Map<String, dynamic> _$DoctorLiveConsultationsMeetingDataToJson(
  DoctorLiveConsultationsMeetingData instance,
) => <String, dynamic>{
  'consultation_title': instance.consultation_title,
  'status': instance.status,
  'host_video': instance.host_video,
  'consultation_date': instance.consultation_date,
  'duration_minutes': instance.duration_minutes,
  'meta': instance.meta,
};
