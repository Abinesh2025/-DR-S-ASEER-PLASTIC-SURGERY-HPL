// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'bed_details_model.g.dart';

@JsonSerializable()
class BedDetailsModel {
  bool? success;
  BedDetailsData? data;
  String? message;

  BedDetailsModel({this.success, this.data, this.message});

  factory BedDetailsModel.fromJson(Map<String, dynamic> json) => _$BedDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BedDetailsModelToJson(this);
}

@JsonSerializable()
class BedDetailsData {
  String? bed;
  String? bed_type;
  String? bed_id;
  int? charge;
  int? is_available;
  String? created_on;
  String? description;

  BedDetailsData({
    this.bed,
    this.bed_type,
    this.bed_id,
    this.charge,
    this.is_available,
    this.created_on,
    this.description,
  });

  factory BedDetailsData.fromJson(Map<String, dynamic> json) => _$BedDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BedDetailsDataToJson(this);
}
