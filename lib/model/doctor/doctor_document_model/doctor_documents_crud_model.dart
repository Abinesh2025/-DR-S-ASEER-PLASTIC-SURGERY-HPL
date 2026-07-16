import 'package:json_annotation/json_annotation.dart';

part 'doctor_documents_crud_model.g.dart';

@JsonSerializable()
class DoctorDocumentsCRUDModel {
  bool? success;
  String? message;

  DoctorDocumentsCRUDModel({
    this.success,
    this.message,
  });

  factory DoctorDocumentsCRUDModel.fromJson(Map<String, dynamic> json) => _$DoctorDocumentsCRUDModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDocumentsCRUDModelToJson(this);
}
