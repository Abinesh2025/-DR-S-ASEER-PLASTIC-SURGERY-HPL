import 'package:json_annotation/json_annotation.dart';

part 'delete_appointment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeleteAppointmentModel {
  bool? success;
  String? message;

  DeleteAppointmentModel({
    this.success,
    this.message,
  });

  factory DeleteAppointmentModel.fromJson(Map<String, dynamic> json) => _$DeleteAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAppointmentModelToJson(this);
}
