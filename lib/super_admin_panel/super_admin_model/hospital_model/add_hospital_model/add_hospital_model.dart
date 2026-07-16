// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'add_hospital_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AddHospitalModel {
  bool? success;
  String? message;

  AddHospitalModel({
    this.success,
    this.message,
  });

  factory AddHospitalModel.fromJson(Map<String, dynamic> json) => _$AddHospitalModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddHospitalModelToJson(this);
}
