// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'live_consultation_details_model.g.dart';

@JsonSerializable()
class LiveConsultationDetailsModel {
  bool? success;
  LiveConsultationDetailsData? data;
  String? message;

  LiveConsultationDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory LiveConsultationDetailsModel.fromJson(Map<String, dynamic> json) => _$LiveConsultationDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LiveConsultationDetailsModelToJson(this);
}

@JsonSerializable()
class LiveConsultationDetailsData {
  int? id;
  String? consultation_title;
  String? consultation_date;
  String? duration;
  String? dostor_name;
  String? type;
  String? type_number;

  LiveConsultationDetailsData({
    this.id,
    this.consultation_title,
    this.consultation_date,
    this.duration,
    this.dostor_name,
    this.type,
    this.type_number,
  });

  factory LiveConsultationDetailsData.fromJson(Map<String, dynamic> json) => _$LiveConsultationDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$LiveConsultationDetailsDataToJson(this);
}
