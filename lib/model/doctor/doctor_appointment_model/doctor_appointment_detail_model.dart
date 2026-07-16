import 'package:json_annotation/json_annotation.dart';

part 'doctor_appointment_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorAppointmentDetailModel {
  bool? success;
  DoctorAppointmentDetailData? data;
  String? message;

  DoctorAppointmentDetailModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorAppointmentDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAppointmentDetailModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorAppointmentDetailData {
  @JsonKey(name: 'appointment_id')
  int? id;
  String? patient_name;
  String? appointment_date;
  String? appointment_time;
  @JsonKey(name: 'photo')
  String? patient_image;
  int? token_number;
  String? schedule_type;
  @JsonKey(name: 'appointment_status')
  String? status;
  @JsonKey(name: 'email')
  String? patient_email;
  @JsonKey(name: 'phone')
  dynamic patient_phone;
  dynamic gender;
  String? problem;

  DoctorAppointmentDetailData({
    this.id,
    this.patient_name,
    this.appointment_date,
    this.appointment_time,
    this.patient_image,
    this.token_number,
    this.schedule_type,
    this.status,
    this.patient_email,
    this.patient_phone,
    this.gender,
    this.problem,
  });

  factory DoctorAppointmentDetailData.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAppointmentDetailDataToJson(this);
}
