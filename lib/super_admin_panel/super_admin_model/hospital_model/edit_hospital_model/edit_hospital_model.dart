// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'edit_hospital_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateHospitalModel {
  bool? success;
  String? message;

  UpdateHospitalModel({
    this.success,
    this.message,
  });

  factory UpdateHospitalModel.fromJson(Map<String, dynamic> json) => _$UpdateHospitalModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateHospitalModelToJson(this);
}
