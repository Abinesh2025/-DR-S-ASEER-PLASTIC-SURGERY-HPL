// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'bed_status_model.g.dart';

@JsonSerializable()
class BedStatusModel {
  bool? success;
  List<BedList>? data;
  String? message;

  BedStatusModel({
    this.success,
    this.data,
    this.message,
  });

  factory BedStatusModel.fromJson(Map<String, dynamic> json) => _$BedStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$BedStatusModelToJson(this);
}

@JsonSerializable()
class BedList {
  String? bed_title;
  List<BedData>? bed;

  BedList({
    this.bed_title,
    this.bed,
  });

  factory BedList.fromJson(Map<String, dynamic> json) => _$BedListFromJson(json);

  Map<String, dynamic> toJson() => _$BedListToJson(this);
}

@JsonSerializable()
class BedData {
  int? id;
  String? name;
  bool? status;

  BedData({
    this.id,
    this.name,
    this.status,
  });

  factory BedData.fromJson(Map<String, dynamic> json) => _$BedDataFromJson(json);

  Map<String, dynamic> toJson() => _$BedDataToJson(this);
}
