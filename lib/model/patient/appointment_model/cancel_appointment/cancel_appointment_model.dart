import 'package:json_annotation/json_annotation.dart';

part 'cancel_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CancelAppointmentModel {
  bool? success;
  String? message;

  CancelAppointmentModel({
    this.success,
    this.message,
  });

  factory CancelAppointmentModel.fromJson(Map<String, dynamic> json) => _$CancelAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CancelAppointmentModelToJson(this);
}
