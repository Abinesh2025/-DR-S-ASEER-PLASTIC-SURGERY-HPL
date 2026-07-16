
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medicine_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MedicineResponseModel {
  final bool? success;
  final List<MedicineModel>? data;
  final String? message;

  MedicineResponseModel({
    this.success,
    this.data,
    this.message,
  });

  factory MedicineResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineResponseModelToJson(this);
}
