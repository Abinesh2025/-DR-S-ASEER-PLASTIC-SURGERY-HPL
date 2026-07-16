// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterPatientModel _$FilterPatientModelFromJson(Map<String, dynamic> json) =>
    FilterPatientModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FilterPatientsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FilterPatientModelToJson(FilterPatientModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

FilterPatientsData _$FilterPatientsDataFromJson(Map<String, dynamic> json) =>
    FilterPatientsData(
      id: (json['id'] as num?)?.toInt(),
      patient_name: json['patient_name'] as String?,
      phone_no: json['phone_no'] as String?,
      patient_image: json['patient_image'] as String?,
    );

Map<String, dynamic> _$FilterPatientsDataToJson(FilterPatientsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_name': instance.patient_name,
      'phone_no': instance.phone_no,
      'patient_image': instance.patient_image,
    };
