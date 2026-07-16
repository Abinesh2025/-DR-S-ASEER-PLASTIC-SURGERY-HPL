import 'package:json_annotation/json_annotation.dart';

part 'doctor_department_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorDepartmentModel {
  bool? success;
  List<DoctorDepartmentData>? data;
  String? message;

  DoctorDepartmentModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorDepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorDepartmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDepartmentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorDepartmentData {
  int? id;
  String? title;
  String? description;
  @JsonKey(name: 'doctor_department_image')
  String? doctorDepartmentImage;

  DoctorDepartmentData({
    this.id,
    this.title,
    this.description,
    this.doctorDepartmentImage,
  });

  factory DoctorDepartmentData.fromJson(Map<String, dynamic> json) =>
      _$DoctorDepartmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDepartmentDataToJson(this);
}
