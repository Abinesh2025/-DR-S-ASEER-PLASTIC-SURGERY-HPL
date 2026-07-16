
import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  bool? success;
  List<BannerData>? data;
  String? message;

  BannerModel({this.success, this.data, this.message});

  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}

@JsonSerializable()
class BannerData {
  int? id;
  String? title;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;

  BannerData({this.id, this.title, this.imageUrl, this.startDate, this.endDate});

  factory BannerData.fromJson(Map<String, dynamic> json) => _$BannerDataFromJson(json);
  Map<String, dynamic> toJson() => _$BannerDataToJson(this);
}
