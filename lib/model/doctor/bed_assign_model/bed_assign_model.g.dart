// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed_assign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BedAssignFilterModel _$BedAssignFilterModelFromJson(
  Map<String, dynamic> json,
) => BedAssignFilterModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => BedAssignData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$BedAssignFilterModelToJson(
  BedAssignFilterModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

BedAssignData _$BedAssignDataFromJson(Map<String, dynamic> json) =>
    BedAssignData(
      id: (json['id'] as num?)?.toInt(),
      patient_name: json['patient_name'] as String?,
      bed: json['bed'] as String?,
      case_id: json['case_id'] as String?,
      bed_id: (json['bed_id'] as num?)?.toInt(),
      assign_date: json['assign_date'] as String?,
      assign_time: json['assign_time'] as String?,
      patient_image: json['patient_image'] as String?,
    );

Map<String, dynamic> _$BedAssignDataToJson(BedAssignData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_name': instance.patient_name,
      'bed': instance.bed,
      'case_id': instance.case_id,
      'bed_id': instance.bed_id,
      'assign_date': instance.assign_date,
      'assign_time': instance.assign_time,
      'patient_image': instance.patient_image,
    };
