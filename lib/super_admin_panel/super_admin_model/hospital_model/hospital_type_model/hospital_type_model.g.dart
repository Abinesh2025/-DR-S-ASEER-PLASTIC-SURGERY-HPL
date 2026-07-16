// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalTypeModel _$HospitalTypeModelFromJson(Map<String, dynamic> json) =>
    HospitalTypeModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HospitalTypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$HospitalTypeModelToJson(HospitalTypeModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

HospitalTypeData _$HospitalTypeDataFromJson(Map<String, dynamic> json) =>
    HospitalTypeData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$HospitalTypeDataToJson(HospitalTypeData instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
