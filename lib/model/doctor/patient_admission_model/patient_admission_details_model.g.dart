// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_admission_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientAdmissionDetailsModel _$PatientAdmissionDetailsModelFromJson(
  Map<String, dynamic> json,
) => PatientAdmissionDetailsModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : PatientAdmissionDetailsData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  message: json['message'] as String?,
);

Map<String, dynamic> _$PatientAdmissionDetailsModelToJson(
  PatientAdmissionDetailsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.toJson(),
  'message': instance.message,
};

PatientAdmissionDetailsData _$PatientAdmissionDetailsDataFromJson(
  Map<String, dynamic> json,
) => PatientAdmissionDetailsData(
  id: (json['id'] as num?)?.toInt(),
  admission_id: json['admission_id'] as String?,
  patient: json['patient'] as String?,
  admission_date: json['admission_date'] as String?,
  discharge_date: json['discharge_date'] as String?,
  bed: json['bed'] as String?,
  guardian_name: json['guardian_name'] as String?,
  guardian_relation: json['guardian_relation'] as String?,
  guardian_contact: json['guardian_contact'] as String?,
  guardian_address: json['guardian_address'] as String?,
  created_on: json['created_on'] as String?,
  package_name: json['package_name'] as String?,
  insurance_name: json['insurance_name'] as String?,
  agent_name: json['agent_name'] as String?,
  policy_number: json['policy_number'] as String?,
);

Map<String, dynamic> _$PatientAdmissionDetailsDataToJson(
  PatientAdmissionDetailsData instance,
) => <String, dynamic>{
  'id': instance.id,
  'admission_id': instance.admission_id,
  'patient': instance.patient,
  'admission_date': instance.admission_date,
  'discharge_date': instance.discharge_date,
  'bed': instance.bed,
  'guardian_name': instance.guardian_name,
  'guardian_relation': instance.guardian_relation,
  'guardian_contact': instance.guardian_contact,
  'guardian_address': instance.guardian_address,
  'created_on': instance.created_on,
  'package_name': instance.package_name,
  'insurance_name': instance.insurance_name,
  'agent_name': instance.agent_name,
  'policy_number': instance.policy_number,
};
