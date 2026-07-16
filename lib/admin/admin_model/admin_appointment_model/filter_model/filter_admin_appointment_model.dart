// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'filter_admin_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterAdminAppointmentModel {
  bool? success;
  List<FilterAppointmentData>? data;
  String? message;

  FilterAdminAppointmentModel({
    this.success,
    this.data,
    this.message,
  });

  factory FilterAdminAppointmentModel.fromJson(Map<String, dynamic> json) => _$FilterAdminAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterAdminAppointmentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FilterAppointmentData {
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

  FilterAppointmentData({
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
  factory FilterAppointmentData.fromJson(Map<String, dynamic> json) => _$FilterAppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterAppointmentDataToJson(this);
}
