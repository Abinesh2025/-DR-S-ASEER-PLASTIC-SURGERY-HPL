// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'live_consultation_filter.g.dart';

@JsonSerializable()
class LiveConsultationFilter {
  bool? success;
  List<LiveConsultationFilterData>? data;
  String? message;

  LiveConsultationFilter({
    this.success,
    this.data,
    this.message,
  });

  factory LiveConsultationFilter.fromJson(Map<String, dynamic> json) => _$LiveConsultationFilterFromJson(json);

  Map<String, dynamic> toJson() => _$LiveConsultationFilterToJson(this);
}


@JsonSerializable()
class LiveConsultationFilterData {
  int? id;
  String? consultation_title;
  String? consultation_date;
  String? consultation_time;
  String? status;
  String? doctor_image;

  LiveConsultationFilterData({
    this.id,
    this.consultation_title,
    this.consultation_date,
    this.consultation_time,
    this.status,
    this.doctor_image,
  });

  factory LiveConsultationFilterData.fromJson(Map<String, dynamic> json) => _$LiveConsultationFilterDataFromJson(json);

  Map<String, dynamic> toJson() => _$LiveConsultationFilterDataToJson(this);
}
