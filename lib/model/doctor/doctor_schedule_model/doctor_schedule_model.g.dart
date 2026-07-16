// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorScheduleModel _$DoctorScheduleModelFromJson(Map<String, dynamic> json) =>
    DoctorScheduleModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : DoctorScheduleData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DoctorScheduleModelToJson(
  DoctorScheduleModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

DoctorScheduleData _$DoctorScheduleDataFromJson(Map<String, dynamic> json) =>
    DoctorScheduleData(
      id: (json['id'] as num?)?.toInt(),
      per_patient_time: json['per_patient_time'] as String?,
      slot_type: json['slot_type'] as String?,
      schedule_type: json['schedule_type'] as String?,
      max_tokens_per_day: (json['max_tokens_per_day'] as num?)?.toInt(),
      token_block_option: (json['token_block_option'] as num?)?.toInt(),
      token_block_option_label: json['token_block_option_label'] as String?,
      schedule: (json['schedule_days'] as List<dynamic>?)
          ?.map((e) => ScheduleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorScheduleDataToJson(DoctorScheduleData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'per_patient_time': instance.per_patient_time,
      'slot_type': instance.slot_type,
      'schedule_type': instance.schedule_type,
      'max_tokens_per_day': instance.max_tokens_per_day,
      'token_block_option': instance.token_block_option,
      'token_block_option_label': instance.token_block_option_label,
      'schedule_days': instance.schedule,
    };

ScheduleData _$ScheduleDataFromJson(Map<String, dynamic> json) => ScheduleData(
  available_on: json['available_on'] as String?,
  available_from: json['available_from'] as String?,
  available_to: json['available_to'] as String?,
  max_tokens: (json['max_tokens'] as num?)?.toInt(),
  use_slots: json['use_slots'] as bool?,
  opd_tokens: (json['opd_tokens'] as num?)?.toInt(),
  pop_tokens: (json['pop_tokens'] as num?)?.toInt(),
  emergency_tokens: (json['emergency_tokens'] as num?)?.toInt(),
  morning_tokens: (json['morning_tokens'] as num?)?.toInt(),
  afternoon_tokens: (json['afternoon_tokens'] as num?)?.toInt(),
  night_tokens: (json['night_tokens'] as num?)?.toInt(),
  morning_pop_tokens: (json['morning_pop_tokens'] as num?)?.toInt(),
  afternoon_pop_tokens: (json['afternoon_pop_tokens'] as num?)?.toInt(),
  night_pop_tokens: (json['night_pop_tokens'] as num?)?.toInt(),
  morning_emergency_tokens: (json['morning_emergency_tokens'] as num?)?.toInt(),
  afternoon_emergency_tokens: (json['afternoon_emergency_tokens'] as num?)
      ?.toInt(),
  night_emergency_tokens: (json['night_emergency_tokens'] as num?)?.toInt(),
);

Map<String, dynamic> _$ScheduleDataToJson(ScheduleData instance) =>
    <String, dynamic>{
      'available_on': instance.available_on,
      'available_from': instance.available_from,
      'available_to': instance.available_to,
      'max_tokens': instance.max_tokens,
      'use_slots': instance.use_slots,
      'opd_tokens': instance.opd_tokens,
      'pop_tokens': instance.pop_tokens,
      'emergency_tokens': instance.emergency_tokens,
      'morning_tokens': instance.morning_tokens,
      'afternoon_tokens': instance.afternoon_tokens,
      'night_tokens': instance.night_tokens,
      'morning_pop_tokens': instance.morning_pop_tokens,
      'afternoon_pop_tokens': instance.afternoon_pop_tokens,
      'night_pop_tokens': instance.night_pop_tokens,
      'morning_emergency_tokens': instance.morning_emergency_tokens,
      'afternoon_emergency_tokens': instance.afternoon_emergency_tokens,
      'night_emergency_tokens': instance.night_emergency_tokens,
    };
