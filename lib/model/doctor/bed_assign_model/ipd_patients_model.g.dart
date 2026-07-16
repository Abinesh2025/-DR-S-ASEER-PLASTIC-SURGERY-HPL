// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipd_patients_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IPDPatientsModel _$IPDPatientsModelFromJson(Map<String, dynamic> json) =>
    IPDPatientsModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => IPDPatientsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$IPDPatientsModelToJson(IPDPatientsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

IPDPatientsData _$IPDPatientsDataFromJson(Map<String, dynamic> json) =>
    IPDPatientsData(
      id: (json['id'] as num?)?.toInt(),
      ipd_number: json['ipd_number'] as String?,
    );

Map<String, dynamic> _$IPDPatientsDataToJson(IPDPatientsData instance) =>
    <String, dynamic>{'id': instance.id, 'ipd_number': instance.ipd_number};
