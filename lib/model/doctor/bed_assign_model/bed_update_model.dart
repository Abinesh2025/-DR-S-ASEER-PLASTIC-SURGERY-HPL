// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'bed_update_model.g.dart';

@JsonSerializable()
class BedUpdatedDetailsModel {
  bool? success;
  String? message;

  BedUpdatedDetailsModel({
    this.success,
    this.message,
  });
  factory BedUpdatedDetailsModel.fromJson(Map<String, dynamic> json) => _$BedUpdatedDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BedUpdatedDetailsModelToJson(this);
}
