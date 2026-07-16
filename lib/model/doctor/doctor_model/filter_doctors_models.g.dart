// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_doctors_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterDoctorsModel _$FilterDoctorsModelFromJson(Map<String, dynamic> json) =>
    FilterDoctorsModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FilterDoctorsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FilterDoctorsModelToJson(FilterDoctorsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

FilterDoctorsData _$FilterDoctorsDataFromJson(Map<String, dynamic> json) =>
    FilterDoctorsData(
      id: (json['id'] as num?)?.toInt(),
      doctor_name: json['doctor_name'] as String?,
      doctor_department: json['doctor_department'] as String?,
      doctor_image: json['doctor_image'] as String?,
      doctor_specialist: json['doctor_specialist'] as String?,
    );

Map<String, dynamic> _$FilterDoctorsDataToJson(FilterDoctorsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_name': instance.doctor_name,
      'doctor_department': instance.doctor_department,
      'doctor_image': instance.doctor_image,
      'doctor_specialist': instance.doctor_specialist,
    };
