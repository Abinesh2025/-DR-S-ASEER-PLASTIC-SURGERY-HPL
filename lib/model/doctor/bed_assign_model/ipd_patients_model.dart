// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'ipd_patients_model.g.dart';

@JsonSerializable()
class IPDPatientsModel {
  bool? success;
  List<IPDPatientsData>? data;
  String? message;

  IPDPatientsModel({
    this.success,
    this.data,
    this.message,
  });

  factory IPDPatientsModel.fromJson(Map<String, dynamic> json) => _$IPDPatientsModelFromJson(json);

  Map<String, dynamic> toJson() => _$IPDPatientsModelToJson(this);
}

@JsonSerializable()
class IPDPatientsData {
  int? id;
  String? ipd_number;

  IPDPatientsData({this.id, this.ipd_number,});

  factory IPDPatientsData.fromJson(Map<String, dynamic> json) => _$IPDPatientsDataFromJson(json);

  Map<String, dynamic> toJson() => _$IPDPatientsDataToJson(this);

}