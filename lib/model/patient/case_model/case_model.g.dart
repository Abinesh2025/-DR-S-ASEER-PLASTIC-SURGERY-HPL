// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseModel _$CaseModelFromJson(Map<String, dynamic> json) => CaseModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => CaseData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$CaseModelToJson(CaseModel instance) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

CaseData _$CaseDataFromJson(Map<String, dynamic> json) => CaseData(
  id: (json['id'] as num?)?.toInt(),
  doctor_name: json['doctor_name'] as String?,
  doctor_image: json['doctor_image'] as String?,
  case_id: json['case_id'] as String?,
  status: json['status'] as String?,
  case_date: json['case_date'] as String?,
  case_time: json['case_time'] as String?,
  fee: (json['fee'] as num?)?.toInt(),
  created_on: json['created_on'] as String?,
  description: json['description'] as String?,
  currency: json['currency'] as String?,
  app_logo: json['app_logo'] as String?,
);

Map<String, dynamic> _$CaseDataToJson(CaseData instance) => <String, dynamic>{
  'id': instance.id,
  'doctor_name': instance.doctor_name,
  'doctor_image': instance.doctor_image,
  'case_id': instance.case_id,
  'status': instance.status,
  'case_date': instance.case_date,
  'case_time': instance.case_time,
  'fee': instance.fee,
  'created_on': instance.created_on,
  'description': instance.description,
  'currency': instance.currency,
  'app_logo': instance.app_logo,
};
