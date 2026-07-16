// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BedDetailsModel _$BedDetailsModelFromJson(Map<String, dynamic> json) =>
    BedDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : BedDetailsData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BedDetailsModelToJson(BedDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

BedDetailsData _$BedDetailsDataFromJson(Map<String, dynamic> json) =>
    BedDetailsData(
      bed: json['bed'] as String?,
      bed_type: json['bed_type'] as String?,
      bed_id: json['bed_id'] as String?,
      charge: (json['charge'] as num?)?.toInt(),
      is_available: (json['is_available'] as num?)?.toInt(),
      created_on: json['created_on'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$BedDetailsDataToJson(BedDetailsData instance) =>
    <String, dynamic>{
      'bed': instance.bed,
      'bed_type': instance.bed_type,
      'bed_id': instance.bed_id,
      'charge': instance.charge,
      'is_available': instance.is_available,
      'created_on': instance.created_on,
      'description': instance.description,
    };
