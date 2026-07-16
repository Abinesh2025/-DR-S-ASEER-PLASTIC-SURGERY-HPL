// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorAppointmentModel {
  bool? success;
  List<DoctorAppointmentData>? data;
  String? message;

  DoctorAppointmentModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAppointmentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorAppointmentData {
  int? id;
  int? patient_id;
  String? patient_name;
  String? appointment_date;
  String? appointment_time;
  String? patient_image;
  dynamic token_number;
  @JsonKey(name: 'appointment_status')
  String? is_completed;

  @JsonKey(name: 'appointment_type')
  String? appointmentType;
  @JsonKey(name: "is_isro_patient")
  bool? isIsroPatient;
  DoctorAppointmentData({
    this.id,
    this.patient_id,
    this.patient_name,
    this.appointment_date,
    this.appointment_time,
    this.patient_image,
    this.token_number,
    this.is_completed,
    this.appointmentType,
  });

  factory DoctorAppointmentData.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAppointmentDataToJson(this);
}
