import 'package:json_annotation/json_annotation.dart';

part 'hospital_type_model.g.dart';

@JsonSerializable()
class HospitalTypeModel {
  bool? success;
  List<HospitalTypeData>? data;
  String? message;

  HospitalTypeModel({
    this.success,
    this.data,
    this.message
  });

  factory HospitalTypeModel.fromJson(Map<String, dynamic> json) => _$HospitalTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HospitalTypeModelToJson(this);
}

@JsonSerializable()
class HospitalTypeData {
  int? id;
  String? name;

  HospitalTypeData({
    this.id,
    this.name
  });

  factory HospitalTypeData.fromJson(Map<String, dynamic> json) => _$HospitalTypeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HospitalTypeDataToJson(this);
}
