import 'package:json_annotation/json_annotation.dart';

part 'cancel_admin_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CancelAdminAppointmentModel {
  bool? success;
  String? message;

  CancelAdminAppointmentModel({
    this.success,
    this.message,
  });

  factory CancelAdminAppointmentModel.fromJson(Map<String, dynamic> json) => _$CancelAdminAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CancelAdminAppointmentModelToJson(this);
}
