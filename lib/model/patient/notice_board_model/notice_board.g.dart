// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeBoardModel _$NoticeBoardModelFromJson(Map<String, dynamic> json) =>
    NoticeBoardModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NoticeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NoticeBoardModelToJson(NoticeBoardModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

NoticeData _$NoticeDataFromJson(Map<String, dynamic> json) => NoticeData(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  date: json['date'] as String?,
  time: json['time'] as String?,
);

Map<String, dynamic> _$NoticeDataToJson(NoticeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
      'time': instance.time,
    };
