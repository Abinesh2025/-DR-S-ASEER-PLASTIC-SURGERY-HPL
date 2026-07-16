// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsTypeModel _$DocumentsTypeModelFromJson(Map<String, dynamic> json) =>
    DocumentsTypeModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DocumentsTypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DocumentsTypeModelToJson(DocumentsTypeModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

DocumentsTypeData _$DocumentsTypeDataFromJson(Map<String, dynamic> json) =>
    DocumentsTypeData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DocumentsTypeDataToJson(DocumentsTypeData instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
