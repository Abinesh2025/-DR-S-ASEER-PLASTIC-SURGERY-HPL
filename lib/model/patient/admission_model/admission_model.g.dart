// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdmissionModel _$AdmissionModelFromJson(Map<String, dynamic> json) =>
    AdmissionModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AdmissionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AdmissionModelToJson(AdmissionModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

AdmissionData _$AdmissionDataFromJson(Map<String, dynamic> json) =>
    AdmissionData(
      id: (json['id'] as num?)?.toInt(),
      patient_admission_id: json['patient_admission_id'] as String?,
      doctor_id: (json['doctor_id'] as num?)?.toInt(),
      doctor_name: json['doctor_name'] as String?,
      doctor_image: json['doctor_image'] as String?,
      admission_date: json['admission_date'] as String?,
      admission_time: json['admission_time'] as String?,
      discharge_date: json['discharge_date'] as String?,
      discharge_time: json['discharge_time'] as String?,
      bed_id: json['bed_id'] as String?,
      guardian_name: json['guardian_name'] as String?,
      guardian_relation: json['guardian_relation'] as String?,
      guardian_contact: json['guardian_contact'] as String?,
      guardian_address: json['guardian_address'] as String?,
      created_on: json['created_on'] as String?,
      insurance_detail: json['insurance_detail'] == null
          ? null
          : InsuranceDetail.fromJson(
              json['insurance_detail'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AdmissionDataToJson(AdmissionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_admission_id': instance.patient_admission_id,
      'doctor_id': instance.doctor_id,
      'doctor_name': instance.doctor_name,
      'doctor_image': instance.doctor_image,
      'admission_date': instance.admission_date,
      'admission_time': instance.admission_time,
      'discharge_date': instance.discharge_date,
      'discharge_time': instance.discharge_time,
      'bed_id': instance.bed_id,
      'guardian_name': instance.guardian_name,
      'guardian_relation': instance.guardian_relation,
      'guardian_contact': instance.guardian_contact,
      'guardian_address': instance.guardian_address,
      'created_on': instance.created_on,
      'insurance_detail': instance.insurance_detail?.toJson(),
    };

InsuranceDetail _$InsuranceDetailFromJson(Map<String, dynamic> json) =>
    InsuranceDetail(
      package_name: json['package_name'] as String?,
      insurance_name: json['insurance_name'] as String?,
      agent_name: json['agent_name'] as String?,
      policy_no: json['policy_no'] as String?,
    );

Map<String, dynamic> _$InsuranceDetailToJson(InsuranceDetail instance) =>
    <String, dynamic>{
      'package_name': instance.package_name,
      'insurance_name': instance.insurance_name,
      'agent_name': instance.agent_name,
      'policy_no': instance.policy_no,
    };
