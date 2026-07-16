// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_download.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentDownloadModel _$DocumentDownloadModelFromJson(
  Map<String, dynamic> json,
) => DocumentDownloadModel(
  success: json['success'] as bool?,
  data: json['data'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$DocumentDownloadModelToJson(
  DocumentDownloadModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};
