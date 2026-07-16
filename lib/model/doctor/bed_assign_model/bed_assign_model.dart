// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'bed_assign_model.g.dart';

@JsonSerializable()
class BedAssignFilterModel {
  bool? success;
  List<BedAssignData>? data;
  String? message;

  BedAssignFilterModel({
    this.success,
    this.data,
    this.message,
  });

  factory BedAssignFilterModel.fromJson(Map<String, dynamic> json) => _$BedAssignFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$BedAssignFilterModelToJson(this);
}

@JsonSerializable()
class BedAssignData {
  int? id;
  String? patient_name;
  String? bed;
  String? case_id;
  int? bed_id;
  String? assign_date;
  String? assign_time;
  String? patient_image;

  BedAssignData({
    this.id,
    this.patient_name,
    this.bed,
    this.case_id,
    this.bed_id,
    this.assign_date,
    this.assign_time,
    this.patient_image,
  });

  factory BedAssignData.fromJson(Map<String, dynamic> json) => _$BedAssignDataFromJson(json);

  Map<String, dynamic> toJson() => _$BedAssignDataToJson(this);
}
