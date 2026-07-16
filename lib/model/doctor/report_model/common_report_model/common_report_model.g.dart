// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonReportModel _$CommonReportModelFromJson(Map<String, dynamic> json) =>
    CommonReportModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CommonReportData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CommonReportModelToJson(CommonReportModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

CommonReportData _$CommonReportDataFromJson(Map<String, dynamic> json) =>
    CommonReportData(
      id: (json['id'] as num?)?.toInt(),
      patient_name: json['patient_name'] as String?,
      patient_image: json['patient_image'] as String?,
      case_id: json['case_id'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$CommonReportDataToJson(CommonReportData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_name': instance.patient_name,
      'patient_image': instance.patient_image,
      'case_id': instance.case_id,
      'date': instance.date,
      'time': instance.time,
    };
