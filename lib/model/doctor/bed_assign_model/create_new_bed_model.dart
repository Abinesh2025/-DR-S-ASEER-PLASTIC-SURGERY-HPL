import 'package:json_annotation/json_annotation.dart';

part 'create_new_bed_model.g.dart';

@JsonSerializable()
class CreateNewBedModel {
  bool? success;
  String? message;

  CreateNewBedModel({
    this.success,
    this.message,
  });

  factory CreateNewBedModel.fromJson(Map<String, dynamic> json) => _$CreateNewBedModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewBedModelToJson(this);
}
