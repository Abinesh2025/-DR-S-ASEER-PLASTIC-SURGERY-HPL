// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorsModel {
  bool? success;
  List<DoctorsData>? data;
  String? message;

  DoctorsModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorsModel.fromJson(Map<String, dynamic> json) => _$DoctorsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorsData {
  int? id;
  String? doctor_name;
  String? doctor_department;
  String? doctor_image;
  String? doctor_specialist;

  DoctorsData({
    this.id,
    this.doctor_name,
    this.doctor_department,
    this.doctor_image,
    this.doctor_specialist
  });
  factory DoctorsData.fromJson(Map<String, dynamic> json) => _$DoctorsDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorsDataToJson(this);
}
