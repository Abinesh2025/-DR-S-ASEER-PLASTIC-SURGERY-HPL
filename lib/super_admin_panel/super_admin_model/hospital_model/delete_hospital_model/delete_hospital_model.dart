import 'package:json_annotation/json_annotation.dart';

part 'delete_hospital_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeleteHospitalModel {
  bool? success;
  String? message;

  DeleteHospitalModel({
    this.success,
    this.message,
  });

  factory DeleteHospitalModel.fromJson(Map<String, dynamic> json) => _$DeleteHospitalModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteHospitalModelToJson(this);
}