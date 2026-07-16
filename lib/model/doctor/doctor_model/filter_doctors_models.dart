// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'filter_doctors_models.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterDoctorsModel {
  bool? success;
  List<FilterDoctorsData>? data;
  String? message;

  FilterDoctorsModel({
    this.success,
    this.data,
    this.message,
  });

  factory FilterDoctorsModel.fromJson(Map<String, dynamic> json) => _$FilterDoctorsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDoctorsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FilterDoctorsData {
  int? id;
  String? doctor_name;
  String? doctor_department;
  String? doctor_image;
  String? doctor_specialist;

  FilterDoctorsData({
    this.id,
    this.doctor_name,
    this.doctor_department,
    this.doctor_image,
    this.doctor_specialist
  });
  factory FilterDoctorsData.fromJson(Map<String, dynamic> json) => _$FilterDoctorsDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDoctorsDataToJson(this);
}
