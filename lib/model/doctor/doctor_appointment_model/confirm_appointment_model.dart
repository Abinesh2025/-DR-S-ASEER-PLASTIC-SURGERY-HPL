import 'package:json_annotation/json_annotation.dart';

part 'confirm_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ConfirmAppointmentModel {
  bool? success;
  String? message;

  ConfirmAppointmentModel({
    this.success,
    this.message,
  });

  factory ConfirmAppointmentModel.fromJson(Map<String, dynamic> json) => _$ConfirmAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmAppointmentModelToJson(this);
}
