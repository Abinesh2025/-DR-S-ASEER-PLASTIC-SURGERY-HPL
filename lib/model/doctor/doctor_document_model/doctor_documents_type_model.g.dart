// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_documents_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorDocumentsTypeModel _$DoctorDocumentsTypeModelFromJson(
  Map<String, dynamic> json,
) => DoctorDocumentsTypeModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => DoctorDocumentTypeData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorDocumentsTypeModelToJson(
  DoctorDocumentsTypeModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

DoctorDocumentTypeData _$DoctorDocumentTypeDataFromJson(
  Map<String, dynamic> json,
) => DoctorDocumentTypeData(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);

Map<String, dynamic> _$DoctorDocumentTypeDataToJson(
  DoctorDocumentTypeData instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
