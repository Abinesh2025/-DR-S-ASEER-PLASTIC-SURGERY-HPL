import 'package:json_annotation/json_annotation.dart';

part 'create_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateAppointmentModel {
  bool? success;
  String? message;
  AppointmentData? data;

  @JsonKey(includeFromJson: false, includeToJson: true, name: 'appointment_id')
  int? appointmentId;

  CreateAppointmentModel({
    this.success,
    this.message,
    this.data,
    this.appointmentId,
  });

  factory CreateAppointmentModel.fromJson(Map<String, dynamic> json) {
    var model = _$CreateAppointmentModelFromJson(json);
    if (json['appointment_id'] != null) {
      model.appointmentId = int.tryParse(json['appointment_id'].toString());
    }
    return model;
  }

  Map<String, dynamic> toJson() => _$CreateAppointmentModelToJson(this);
}

@JsonSerializable()
class AppointmentData {
  @JsonKey(includeFromJson: false, includeToJson: true)
  int? id;
  @JsonKey(includeFromJson: false, includeToJson: true, name: 'appointment_id')
  int? appointmentId;

  AppointmentData({this.id, this.appointmentId});

  factory AppointmentData.fromJson(Map<String, dynamic> json) {
    var data = _$AppointmentDataFromJson(json);
    if (json['id'] != null) {
      data.id = int.tryParse(json['id'].toString());
    }
    if (json['appointment_id'] != null) {
      data.appointmentId = int.tryParse(json['appointment_id'].toString());
    }
    return data;
  }

  Map<String, dynamic> toJson() => _$AppointmentDataToJson(this);
}
