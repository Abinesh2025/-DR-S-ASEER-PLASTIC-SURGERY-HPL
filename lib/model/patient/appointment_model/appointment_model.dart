// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AppointmentModel {
  bool? success;
  List<AppointmentData>? data;
  String? message;

  AppointmentModel({
    this.success,
    this.data,
    this.message,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AppointmentData {
  int? id;
  String? doctor_name;
  String? appointment_date;
  String? appointment_time;
  String? doctor_department;
  String? doctor_image_url;
  String? patient_name;
  String? patient_image;
  String? is_completed;
  String? token_number;
  String? token_label;
  String? appointment_type;

  AppointmentData({
    this.id,
    this.doctor_name,
    this.appointment_date,
    this.appointment_time,
    this.doctor_department,
    this.doctor_image_url,
    this.patient_name,
    this.patient_image,
    this.is_completed,
    this.token_number,
    this.token_label,
    this.appointment_type,
  });
  factory AppointmentData.fromJson(Map<String, dynamic> json) => _$AppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentDataToJson(this);
}
