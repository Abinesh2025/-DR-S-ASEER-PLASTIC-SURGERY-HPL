// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorSessionModel _$DoctorSessionModelFromJson(Map<String, dynamic> json) =>
    DoctorSessionModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : DoctorSessionData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DoctorSessionModelToJson(DoctorSessionModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

DoctorSessionData _$DoctorSessionDataFromJson(Map<String, dynamic> json) =>
    DoctorSessionData(
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      doctorName: json['doctor_name'] as String?,
      sessionStatus: json['session_status'] as String?,
      sessionType: json['session_type'] as String?,
      sessionLabel: json['session_label'] as String?,
      startedAt: json['started_at'] as String?,
      pausedAt: json['paused_at'] as String?,
      resumedAt: json['resumed_at'] as String?,
      stoppedAt: json['stopped_at'] as String?,
      delayTime: (json['delay_time'] as num?)?.toInt(),
      delayReason: json['delay_reason'] as String?,
      hasSchedule: json['has_schedule'] as bool?,
    );

Map<String, dynamic> _$DoctorSessionDataToJson(DoctorSessionData instance) =>
    <String, dynamic>{
      'doctor_id': instance.doctorId,
      'doctor_name': instance.doctorName,
      'session_status': instance.sessionStatus,
      'session_type': instance.sessionType,
      'session_label': instance.sessionLabel,
      'started_at': instance.startedAt,
      'paused_at': instance.pausedAt,
      'resumed_at': instance.resumedAt,
      'stopped_at': instance.stoppedAt,
      'delay_time': instance.delayTime,
      'delay_reason': instance.delayReason,
      'has_schedule': instance.hasSchedule,
    };
