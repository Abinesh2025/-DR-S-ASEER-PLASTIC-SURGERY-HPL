import 'package:json_annotation/json_annotation.dart';

part 'notice_board.g.dart';

@JsonSerializable()
class NoticeBoardModel {
  bool? success;
  List<NoticeData>? data;
  String? message;

  NoticeBoardModel({
    this.success,
    this.data,
    this.message,
  });

  factory NoticeBoardModel.fromJson(Map<String, dynamic> json) => _$NoticeBoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeBoardModelToJson(this);
}

@JsonSerializable()
class NoticeData {
  int? id;
  String? title;
  String? description;
  String? date;
  String? time;

  NoticeData({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
  });

  factory NoticeData.fromJson(Map<String, dynamic> json) => _$NoticeDataFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeDataToJson(this);
}
