import 'package:json_annotation/json_annotation.dart';

part 'beds_model.g.dart';

@JsonSerializable()
class BedsModel {
  bool? success;
  List<BedsData>? data;
  String? message;

  BedsModel({
    this.success,
    this.data,
    this.message,
  });

  factory BedsModel.fromJson(Map<String, dynamic> json) => _$BedsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BedsModelToJson(this);
}

@JsonSerializable()
class BedsData {
  int? id;
  String? name;

  BedsData({
    this.id,
    this.name,
  });

  factory BedsData.fromJson(Map<String, dynamic> json) => _$BedsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BedsDataToJson(this);
}
