// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'investigation_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InvestigationReportModel {
  bool? success;
  List<InvestigationReportData>? data;
  String? message;

  InvestigationReportModel({
    this.success,
    this.data,
    this.message,
  });

  factory InvestigationReportModel.fromJson(Map<String, dynamic> json) => _$InvestigationReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvestigationReportModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InvestigationReportData {
  int? id;
  String? patient_name;
  String? patient_image;
  String? title;
  String? date;
  String? time;
  String? attachment;

  InvestigationReportData({
    this.id,
    this.patient_name,
    this.patient_image,
    this.title,
    this.date,
    this.time,
    this.attachment,
  });
  factory InvestigationReportData.fromJson(Map<String, dynamic> json) => _$InvestigationReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvestigationReportDataToJson(this);
}
