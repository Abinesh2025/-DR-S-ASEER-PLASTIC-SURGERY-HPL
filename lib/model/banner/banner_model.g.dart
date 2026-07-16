// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => BannerData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

BannerData _$BannerDataFromJson(Map<String, dynamic> json) => BannerData(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  imageUrl: json['image_url'] as String?,
  startDate: json['start_date'] as String?,
  endDate: json['end_date'] as String?,
);

Map<String, dynamic> _$BannerDataToJson(BannerData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.imageUrl,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
    };
