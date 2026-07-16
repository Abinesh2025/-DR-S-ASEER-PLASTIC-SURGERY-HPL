// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'admin_dashboard_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AdminDashboardModel {
  bool? success;
  AdminDashboardData? message;

  AdminDashboardModel({
    this.success,
    this.message,
  });

  factory AdminDashboardModel.fromJson(Map<String, dynamic> json) => _$AdminDashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDashboardModelToJson(this);

}

@JsonSerializable(explicitToJson: true)
class AdminDashboardData {
  double? invoiceAmount;
  double? billAmount;
  double? paymentAmount;
  double? advancePaymentAmount;
  int? doctor;
  int? patients;
  int? nurses;
  int? availableBeds;
  String? currency;
  String? currency_symbol;
  List<UpcomingAppointment>? upcomingAppointments;

  AdminDashboardData({
    this.invoiceAmount,
    this.billAmount,
    this.paymentAmount,
    this.advancePaymentAmount,
    this.doctor,
    this.patients,
    this.nurses,
    this.availableBeds,
    this.currency,
    this.currency_symbol,
    this.upcomingAppointments,
  });

  factory AdminDashboardData.fromJson(Map<String, dynamic> json) => _$AdminDashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDashboardDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpcomingAppointment {
  int? id;
  int? patient_id;
  String? patient_name;
  String? patine_image;
  String? appointment_date;
  String? appointment_time;
  int? doctor_id;
  String? doctor_name;
  int? doctor_department_id;
  String? doctor_department;

  UpcomingAppointment({
    this.id,
    this.patient_id,
    this.patient_name,
    this.patine_image,
    this.appointment_date,
    this.appointment_time,
    this.doctor_id,
    this.doctor_name,
    this.doctor_department_id,
    this.doctor_department,
  });

  factory UpcomingAppointment.fromJson(Map<String, dynamic> json) => _$UpcomingAppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingAppointmentToJson(this);

}
