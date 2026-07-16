import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/login_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_doctor_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetDoctorModel {
  bool? success;
  List<GetDoctorData>? data;
  String? message;

  GetDoctorModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetDoctorModel.fromJson(Map<String, dynamic> json) =>
      _$GetDoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetDoctorModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetDoctorData {
  int? id;
  String? title;
  String? doctor_image;
  String? doctor_image_url;
  String? doctor_department;
  int? department_id;
  String? description;
  String? specialist;
  int? appointment_charge;
  UserData? user;

  GetDoctorData({
    this.id,
    this.title,
    this.doctor_image,
    this.doctor_image_url,
    this.doctor_department,
    this.department_id,
    this.description,
    this.specialist,
    this.appointment_charge,
    this.user,
  });

  factory GetDoctorData.fromJson(Map<String, dynamic> json) =>
      _$GetDoctorDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetDoctorDataToJson(this);
}
