import 'package:json_annotation/json_annotation.dart';

part 'hospital_registration_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HospitalSignupModel {
  bool? success;
  String? message;

  HospitalSignupModel({
    this.success,
    this.message,
  });

  factory HospitalSignupModel.fromJson(Map<String, dynamic> json) => _$HospitalSignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalSignupModelToJson(this);
}
