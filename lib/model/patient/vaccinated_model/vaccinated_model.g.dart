// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccinated_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VaccinatedModel _$VaccinatedModelFromJson(Map<String, dynamic> json) =>
    VaccinatedModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => VaccinatedData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$VaccinatedModelToJson(VaccinatedModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };

VaccinatedData _$VaccinatedDataFromJson(Map<String, dynamic> json) =>
    VaccinatedData(
      id: (json['id'] as num?)?.toInt(),
      vaccine_name: json['vaccine_name'] as String?,
      dose_number: json['dose_number'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      serial_number: json['serial_number'] as String?,
    );

Map<String, dynamic> _$VaccinatedDataToJson(VaccinatedData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vaccine_name': instance.vaccine_name,
      'dose_number': instance.dose_number,
      'date': instance.date,
      'time': instance.time,
      'serial_number': instance.serial_number,
    };
