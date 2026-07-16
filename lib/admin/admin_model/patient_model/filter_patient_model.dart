// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'filter_patient_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterPatientModel {
  bool? success;
  List<FilterPatientsData>? data;
  String? message;

  FilterPatientModel({
    this.success,
    this.data,
    this.message,
  });

  factory FilterPatientModel.fromJson(Map<String, dynamic> json) => _$FilterPatientModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterPatientModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FilterPatientsData {
  int? id;
  String? patient_name;
  String? phone_no;
  String? patient_image;

  FilterPatientsData({
    this.id,
    this.patient_name,
    this.phone_no,
    this.patient_image,
  });
  factory FilterPatientsData.fromJson(Map<String, dynamic> json) => _$FilterPatientsDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterPatientsDataToJson(this);
}
