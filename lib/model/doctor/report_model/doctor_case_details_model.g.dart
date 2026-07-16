// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_case_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorCaseDetailsModel _$DoctorCaseDetailsModelFromJson(
  Map<String, dynamic> json,
) => DoctorCaseDetailsModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : DoctorCaseDetailsData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorCaseDetailsModelToJson(
  DoctorCaseDetailsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.toJson(),
  'message': instance.message,
};

DoctorCaseDetailsData _$DoctorCaseDetailsDataFromJson(
  Map<String, dynamic> json,
) => DoctorCaseDetailsData(
  id: (json['id'] as num?)?.toInt(),
  case_id: json['case_id'] as String?,
  case_date: json['case_date'] as String?,
  patient: json['patient'] as String?,
  phone: json['phone'] as String?,
  fee: (json['fee'] as num?)?.toInt(),
  created_on: json['created_on'] as String?,
  description: json['description'] as String?,
  currency: json['currency'] as String?,
);

Map<String, dynamic> _$DoctorCaseDetailsDataToJson(
  DoctorCaseDetailsData instance,
) => <String, dynamic>{
  'id': instance.id,
  'case_id': instance.case_id,
  'case_date': instance.case_date,
  'patient': instance.patient,
  'phone': instance.phone,
  'fee': instance.fee,
  'created_on': instance.created_on,
  'description': instance.description,
  'currency': instance.currency,
};
