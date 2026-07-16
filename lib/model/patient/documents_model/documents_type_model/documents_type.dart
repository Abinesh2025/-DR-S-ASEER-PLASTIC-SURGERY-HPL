import 'package:json_annotation/json_annotation.dart';

part 'documents_type.g.dart';

@JsonSerializable()
class DocumentsTypeModel {
  bool? success;
  List<DocumentsTypeData>? data;
  String? message;

  DocumentsTypeModel({
    this.success,
    this.data,
    this.message,
  });
  factory DocumentsTypeModel.fromJson(Map<String, dynamic> json) => _$DocumentsTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentsTypeModelToJson(this);
}

@JsonSerializable()
class DocumentsTypeData {
  int? id;
  String? name;

  DocumentsTypeData({
    this.id,
    this.name,
  });

  factory DocumentsTypeData.fromJson(Map<String, dynamic> json) => _$DocumentsTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentsTypeDataToJson(this);
}
