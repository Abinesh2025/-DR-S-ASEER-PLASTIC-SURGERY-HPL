// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_schedule_model.g.dart';

@JsonSerializable()
class DoctorScheduleModel {
  bool? success;
  DoctorScheduleData? data;
  String? message;

  DoctorScheduleModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorScheduleModel.fromJson(Map<String, dynamic> json) => _$DoctorScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorScheduleModelToJson(this);
}


@JsonSerializable()
class DoctorScheduleData {
  int? id;
  String? per_patient_time;
  String? slot_type;
  String? schedule_type;
  int? max_tokens_per_day;
  int? token_block_option;
  String? token_block_option_label;
  @JsonKey(name: "schedule_days")
  List<ScheduleData>? schedule;

  DoctorScheduleData({
    this.id,
    this.per_patient_time,
    this.slot_type,
    this.schedule_type,
    this.max_tokens_per_day,
    this.token_block_option,
    this.token_block_option_label,
    this.schedule,
  });
  factory DoctorScheduleData.fromJson(Map<String, dynamic> json) => _$DoctorScheduleDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorScheduleDataToJson(this);
}

@JsonSerializable()
class ScheduleData {
  String? available_on;
  String? available_from;
  String? available_to;
  int? max_tokens;
  bool? use_slots;
  int? opd_tokens;
  int? pop_tokens;
  int? emergency_tokens;
  int? morning_tokens;
  int? afternoon_tokens;
  int? night_tokens;
  int? morning_pop_tokens;
  int? afternoon_pop_tokens;
  int? night_pop_tokens;
  int? morning_emergency_tokens;
  int? afternoon_emergency_tokens;
  int? night_emergency_tokens;

  ScheduleData({
    this.available_on,
    this.available_from,
    this.available_to,
    this.max_tokens,
    this.use_slots,
    this.opd_tokens,
    this.pop_tokens,
    this.emergency_tokens,
    this.morning_tokens,
    this.afternoon_tokens,
    this.night_tokens,
    this.morning_pop_tokens,
    this.afternoon_pop_tokens,
    this.night_pop_tokens,
    this.morning_emergency_tokens,
    this.afternoon_emergency_tokens,
    this.night_emergency_tokens,
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) => _$ScheduleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDataToJson(this);
}
