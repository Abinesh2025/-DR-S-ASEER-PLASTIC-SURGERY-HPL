// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed_status_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BedStatusDetailsModel _$BedStatusDetailsModelFromJson(
  Map<String, dynamic> json,
) => BedStatusDetailsModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : BedStatusDetailsData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$BedStatusDetailsModelToJson(
  BedStatusDetailsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

BedStatusDetailsData _$BedStatusDetailsDataFromJson(
  Map<String, dynamic> json,
) => BedStatusDetailsData(
  bed_name: json['bed_name'] as String?,
  patient: json['patient'] as String?,
  phone: json['phone'] as String?,
  admission_date: json['admission_date'] as String?,
  gender: json['gender'] as String?,
);

Map<String, dynamic> _$BedStatusDetailsDataToJson(
  BedStatusDetailsData instance,
) => <String, dynamic>{
  'bed_name': instance.bed_name,
  'patient': instance.patient,
  'phone': instance.phone,
  'admission_date': instance.admission_date,
  'gender': instance.gender,
};
