import 'package:json_annotation/json_annotation.dart';

part 'document_delete.g.dart';

@JsonSerializable()
class DocumentDeleteModel {
  bool? success;
  String? message;

  DocumentDeleteModel({
    this.success,
    this.message,
  });

  factory DocumentDeleteModel.fromJson(Map<String, dynamic> json) => _$DocumentDeleteModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentDeleteModelToJson(this);
}
