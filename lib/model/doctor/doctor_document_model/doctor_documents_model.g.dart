// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_documents_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorDocumentsModel _$DoctorDocumentsModelFromJson(
  Map<String, dynamic> json,
) => DoctorDocumentsModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => DoctorDocumentsDataModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorDocumentsModelToJson(
  DoctorDocumentsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

DoctorDocumentsDataModel _$DoctorDocumentsDataModelFromJson(
  Map<String, dynamic> json,
) => DoctorDocumentsDataModel(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  document_type_id: (json['document_type_id'] as num?)?.toInt(),
  patient_id: (json['patient_id'] as num?)?.toInt(),
  uploaded_by: (json['uploaded_by'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  is_default: json['is_default'],
  document_url: json['document_url'] as String?,
);

Map<String, dynamic> _$DoctorDocumentsDataModelToJson(
  DoctorDocumentsDataModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'document_type_id': instance.document_type_id,
  'patient_id': instance.patient_id,
  'uploaded_by': instance.uploaded_by,
  'notes': instance.notes,
  'is_default': instance.is_default,
  'document_url': instance.document_url,
};
