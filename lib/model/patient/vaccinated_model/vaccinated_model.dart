// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'vaccinated_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VaccinatedModel {
  bool? success;
  List<VaccinatedData>? data;
  String? message;

  VaccinatedModel({
    this.success,
    this.data,
    this.message,
  });

  factory VaccinatedModel.fromJson(Map<String, dynamic> json) => _$VaccinatedModelFromJson(json);

  Map<String, dynamic> toJson() => _$VaccinatedModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VaccinatedData {
  int? id;
  String? vaccine_name;
  String? dose_number;
  String? date;
  String? time;
  String? serial_number;

  VaccinatedData({
    this.id,
    this.vaccine_name,
    this.dose_number,
    this.date,
    this.time,
    this.serial_number,
  });
  factory VaccinatedData.fromJson(Map<String, dynamic> json) => _$VaccinatedDataFromJson(json);

  Map<String, dynamic> toJson() => _$VaccinatedDataToJson(this);
}
