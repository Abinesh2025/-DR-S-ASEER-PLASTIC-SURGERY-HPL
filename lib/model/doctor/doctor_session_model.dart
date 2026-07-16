import 'package:json_annotation/json_annotation.dart';

part 'doctor_session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorSessionModel {
  bool? success;
  DoctorSessionData? data;
  String? message;

  DoctorSessionModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorSessionModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorSessionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorSessionData {
  @JsonKey(name: 'doctor_id')
  int? doctorId;
  @JsonKey(name: 'doctor_name')
  String? doctorName;
  @JsonKey(name: 'session_status')
  String? sessionStatus; // 'started', 'paused', 'stopped'
  @JsonKey(name: 'session_type')
  String? sessionType;
  @JsonKey(name: 'session_label')
  String? sessionLabel;
  @JsonKey(name: 'started_at')
  String? startedAt;
  @JsonKey(name: 'paused_at')
  String? pausedAt;
  @JsonKey(name: 'resumed_at')
  String? resumedAt;
  @JsonKey(name: 'stopped_at')
  String? stoppedAt;
  @JsonKey(name: 'delay_time')
  int? delayTime;
  @JsonKey(name: 'delay_reason')
  String? delayReason;
  @JsonKey(name: 'has_schedule')
  bool? hasSchedule;

  DoctorSessionData({
    this.doctorId,
    this.doctorName,
    this.sessionStatus,
    this.sessionType,
    this.sessionLabel,
    this.startedAt,
    this.pausedAt,
    this.resumedAt,
    this.stoppedAt,
    this.delayTime,
    this.delayReason,
    this.hasSchedule,
  });

  factory DoctorSessionData.fromJson(Map<String, dynamic> json) =>
      _$DoctorSessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorSessionDataToJson(this);
}
