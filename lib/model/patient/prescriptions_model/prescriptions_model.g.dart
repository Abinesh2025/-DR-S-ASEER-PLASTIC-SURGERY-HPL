// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescriptions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionsModel _$PrescriptionsModelFromJson(Map<String, dynamic> json) =>
    PrescriptionsModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PrescriptionsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PrescriptionsModelToJson(PrescriptionsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

PrescriptionsData _$PrescriptionsDataFromJson(Map<String, dynamic> json) =>
    PrescriptionsData(
      id: (json['id'] as num?)?.toInt(),
      doctor_name: json['doctor_name'] as String?,
      doctor_image: json['doctor_image'] as String?,
      created_date: json['created_date'] as String?,
      created_time: json['created_time'] as String?,
    );

Map<String, dynamic> _$PrescriptionsDataToJson(PrescriptionsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_name': instance.doctor_name,
      'doctor_image': instance.doctor_image,
      'created_date': instance.created_date,
      'created_time': instance.created_time,
    };
