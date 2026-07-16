import 'package:json_annotation/json_annotation.dart';

part 'document_download.g.dart';

@JsonSerializable()
class DocumentDownloadModel {
  bool? success;
  String? data;
  String? message;

  DocumentDownloadModel({
    this.success,
    this.data,
    this.message,
  });

  factory DocumentDownloadModel.fromJson(Map<String, dynamic> json) => _$DocumentDownloadModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentDownloadModelToJson(this);
}
