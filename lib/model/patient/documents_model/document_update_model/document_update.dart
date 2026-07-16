import 'package:json_annotation/json_annotation.dart';

part 'document_update.g.dart';

@JsonSerializable()
class DocumentUpdateModel {
  bool? success;
  String? message;

  DocumentUpdateModel({
    this.success,
    this.message,
  });

  factory DocumentUpdateModel.fromJson(Map<String, dynamic> json) => _$DocumentUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentUpdateModelToJson(this);
}
