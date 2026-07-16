import 'package:json_annotation/json_annotation.dart';

part 'doctor_documents_type_model.g.dart';

@JsonSerializable()
class DoctorDocumentsTypeModel {
  bool? success;
  List<DoctorDocumentTypeData>? data;
  String? message;

  DoctorDocumentsTypeModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorDocumentsTypeModel.fromJson(Map<String, dynamic> json) => _$DoctorDocumentsTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDocumentsTypeModelToJson(this);
}

@JsonSerializable()
class DoctorDocumentTypeData {
  int? id;
  String? name;

  DoctorDocumentTypeData({
    this.id,
    this.name,
  });

  factory DoctorDocumentTypeData.fromJson(Map<String, dynamic> json) => _$DoctorDocumentTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDocumentTypeDataToJson(this);
}
