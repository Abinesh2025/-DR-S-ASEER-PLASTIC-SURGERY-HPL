// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorsDetailModel {
  bool? success;
  DoctorsDetailData? data;
  String? message;

  DoctorsDetailModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorsDetailModel.fromJson(Map<String, dynamic> json) => _$DoctorsDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorsDetailModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorsDetailData {
  int? id;
  String? doctor_name;
  String? email;
  String? phone;
  String? designation;
  String? doctor_department;
  String? qualification;
  String? blood_group;
  String? date_of_birth;
  String? gender;
  String? specialist;
  String? address1;
  String? address2;
  String? city;
  String? zip;

  DoctorsDetailData({
    this.id,
    this.doctor_name,
    this.email,
    this.phone,
    this.designation,
    this.doctor_department,
    this.qualification,
    this.blood_group,
    this.date_of_birth,
    this.gender,
    this.specialist,
    this.address1,
    this.address2,
    this.city,
    this.zip,
  });
  factory DoctorsDetailData.fromJson(Map<String, dynamic> json) => _$DoctorsDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorsDetailDataToJson(this);
}
