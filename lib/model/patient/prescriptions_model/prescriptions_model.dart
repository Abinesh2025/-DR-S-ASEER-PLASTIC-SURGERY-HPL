// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'prescriptions_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PrescriptionsModel {
  bool? success;
  List<PrescriptionsData>? data;
  String? message;

  PrescriptionsModel({
    this.success,
    this.data,
    this.message,
  });

  factory PrescriptionsModel.fromJson(Map<String, dynamic> json) => _$PrescriptionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PrescriptionsData {
  int? id;
  String? doctor_name;
  String? doctor_image;
  String? created_date;
  String? created_time;

  PrescriptionsData({
    this.id,
    this.doctor_name,
    this.doctor_image,
    this.created_date,
    this.created_time,
  });
  factory PrescriptionsData.fromJson(Map<String, dynamic> json) => _$PrescriptionsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionsDataToJson(this);
}
