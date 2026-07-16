// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'admin_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AdminAppointmentModel {
  bool? success;
  List<AppointmentData>? data;
  String? message;

  AdminAppointmentModel({
    this.success,
    this.data,
    this.message,
  });

  factory AdminAppointmentModel.fromJson(Map<String, dynamic> json) => _$AdminAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAppointmentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AppointmentData {
  int? id;
  int? patient_id;
  String? patient_name;
  String? patient_image;
  String? appointment_date;
  String? appointment_time;
  int? doctor_id;
  String? is_completed;
  String? doctor_name;
  String? doctor_department;

  AppointmentData({
    this.id,
    this.patient_id,
    this.patient_name,
    this.patient_image,
    this.appointment_date,
    this.appointment_time,
    this.doctor_id,
    this.is_completed,
    this.doctor_name,
    this.doctor_department
  });
  factory AppointmentData.fromJson(Map<String, dynamic> json) => _$AppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentDataToJson(this);
}
