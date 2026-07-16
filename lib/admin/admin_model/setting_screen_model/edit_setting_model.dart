// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'edit_setting_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EditSettingModel {
  bool? success;
  String? message;

  EditSettingModel({
    this.success,
    this.message,
  });

  factory EditSettingModel.fromJson(Map<String, dynamic> json) => _$EditSettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditSettingModelToJson(this);
}
