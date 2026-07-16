// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investigation_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestigationReportModel _$InvestigationReportModelFromJson(
  Map<String, dynamic> json,
) => InvestigationReportModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => InvestigationReportData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$InvestigationReportModelToJson(
  InvestigationReportModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

InvestigationReportData _$InvestigationReportDataFromJson(
  Map<String, dynamic> json,
) => InvestigationReportData(
  id: (json['id'] as num?)?.toInt(),
  patient_name: json['patient_name'] as String?,
  patient_image: json['patient_image'] as String?,
  title: json['title'] as String?,
  date: json['date'] as String?,
  time: json['time'] as String?,
  attachment: json['attachment'] as String?,
);

Map<String, dynamic> _$InvestigationReportDataToJson(
  InvestigationReportData instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_name': instance.patient_name,
  'patient_image': instance.patient_image,
  'title': instance.title,
  'date': instance.date,
  'time': instance.time,
  'attachment': instance.attachment,
};
