// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'common_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CommonReportModel {
  bool? success;
  List<CommonReportData>? data;
  String? message;

  CommonReportModel({
    this.success,
    this.data,
    this.message,
  });

  factory CommonReportModel.fromJson(Map<String, dynamic> json) => _$CommonReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommonReportModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommonReportData {
  int? id;
  String? patient_name;
  String? patient_image;
  String? case_id;
  String? date;
  String? time;

  CommonReportData({
    this.id,
    this.patient_name,
    this.patient_image,
    this.case_id,
    this.date,
    this.time,
  });
  factory CommonReportData.fromJson(Map<String, dynamic> json) => _$CommonReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommonReportDataToJson(this);
}
