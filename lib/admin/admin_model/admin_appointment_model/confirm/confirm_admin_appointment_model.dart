import 'package:json_annotation/json_annotation.dart';

part 'confirm_admin_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ConfirmAdminAppointmentModel {
  bool? success;
  String? message;

  ConfirmAdminAppointmentModel({
    this.success,
    this.message,
  });

  factory ConfirmAdminAppointmentModel.fromJson(Map<String, dynamic> json) => _$ConfirmAdminAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmAdminAppointmentModelToJson(this);
}
