// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_documents_model.g.dart';

@JsonSerializable()
class DoctorDocumentsModel {
  bool? success;
  List<DoctorDocumentsDataModel>? data;
  String? message;

  DoctorDocumentsModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorDocumentsModel.fromJson(Map<String, dynamic> json) => _$DoctorDocumentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDocumentsModelToJson(this);
}

@JsonSerializable()
class DoctorDocumentsDataModel {
  int? id;
  String? title;
  int? document_type_id;
  int? patient_id;
  int? uploaded_by;
  String? notes;
  dynamic is_default;
  String? document_url;

  DoctorDocumentsDataModel({
    this.id,
    this.title,
    this.document_type_id,
    this.patient_id,
    this.uploaded_by,
    this.notes,
    this.is_default,
    this.document_url,
  });

  factory DoctorDocumentsDataModel.fromJson(Map<String, dynamic> json) => _$DoctorDocumentsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDocumentsDataModelToJson(this);
}
