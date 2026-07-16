import 'package:json_annotation/json_annotation.dart';

part 'delete_test_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeleteTestModel {
  bool? success;
  String? message;

  DeleteTestModel({
    this.success,
    this.message,
  });

  factory DeleteTestModel.fromJson(Map<String, dynamic> json) => _$DeleteTestModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteTestModelToJson(this);
}
