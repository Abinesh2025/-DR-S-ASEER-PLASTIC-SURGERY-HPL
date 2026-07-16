// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'live_consultation_meeting_model.g.dart';

@JsonSerializable()
class LiveConsultationMeetingModel {
  bool? success;
  LiveConsultationMeetingData? data;
  String? message;

  LiveConsultationMeetingModel({
    this.success,
    this.data,
    this.message,
  });

  factory LiveConsultationMeetingModel.fromJson(Map<String, dynamic> json) => _$LiveConsultationMeetingModelFromJson(json);

  Map<String, dynamic> toJson() => _$LiveConsultationMeetingModelToJson(this);
}

@JsonSerializable()
class LiveConsultationMeetingData {
  String? consultation_title;
  String? status;
  String? host_video;
  String? consultation_date;
  String? duration_minutes;
  String? meta;

  LiveConsultationMeetingData({
    this.consultation_title,
    this.status,
    this.host_video,
    this.consultation_date,
    this.duration_minutes,
    this.meta,
  });
  factory LiveConsultationMeetingData.fromJson(Map<String, dynamic> json) => _$LiveConsultationMeetingDataFromJson(json);

  Map<String, dynamic> toJson() => _$LiveConsultationMeetingDataToJson(this);
}
