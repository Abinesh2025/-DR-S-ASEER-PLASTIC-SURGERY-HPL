// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientsDetailModel _$PatientsDetailModelFromJson(Map<String, dynamic> json) =>
    PatientsDetailModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : PatientsDetailData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PatientsDetailModelToJson(
  PatientsDetailModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.toJson(),
  'message': instance.message,
};

PatientsDetailData _$PatientsDetailDataFromJson(Map<String, dynamic> json) =>
    PatientsDetailData(
      id: (json['id'] as num?)?.toInt(),
      patient_name: json['patient_name'] as String?,
      email_id: json['email_id'] as String?,
      phone_no: json['phone_no'] as String?,
      blood_group: json['blood_group'] as String?,
    );

Map<String, dynamic> _$PatientsDetailDataToJson(PatientsDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_name': instance.patient_name,
      'email_id': instance.email_id,
      'phone_no': instance.phone_no,
      'blood_group': instance.blood_group,
    };
