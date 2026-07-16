import 'package:json_annotation/json_annotation.dart';

part 'document_store.g.dart';

@JsonSerializable()
class DocumentStoreModel {
  bool? success;
  String? message;

  DocumentStoreModel({
    this.success,
    this.message,
  });

  factory DocumentStoreModel.fromJson(Map<String, dynamic> json) => _$DocumentStoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentStoreModelToJson(this);
}
