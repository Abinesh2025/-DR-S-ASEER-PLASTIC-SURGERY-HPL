import 'package:json_annotation/json_annotation.dart';

part 'delete_admission_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeleteAdmissionModel {
  bool? success;
  String? message;

  DeleteAdmissionModel({
    this.success,
    this.message,
  });

  factory DeleteAdmissionModel.fromJson(Map<String, dynamic> json) => _$DeleteAdmissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAdmissionModelToJson(this);
}
