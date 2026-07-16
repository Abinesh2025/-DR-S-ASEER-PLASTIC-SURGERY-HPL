// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beds_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BedsModel _$BedsModelFromJson(Map<String, dynamic> json) => BedsModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => BedsData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$BedsModelToJson(BedsModel instance) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

BedsData _$BedsDataFromJson(Map<String, dynamic> json) =>
    BedsData(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);

Map<String, dynamic> _$BedsDataToJson(BedsData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
