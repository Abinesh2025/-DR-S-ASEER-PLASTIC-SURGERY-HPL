import 'package:json_annotation/json_annotation.dart';

part 'doctor_schedule_update_model.g.dart';

@JsonSerializable()
class DoctorScheduleUpdateModel {
  bool? success;
  String? message;

  DoctorScheduleUpdateModel({
    this.success,
    this.message,
  });

  factory DoctorScheduleUpdateModel.fromJson(Map<String, dynamic> json) => _$DoctorScheduleUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorScheduleUpdateModelToJson(this);
}
