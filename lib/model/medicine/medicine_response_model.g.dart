// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineResponseModel _$MedicineResponseModelFromJson(
  Map<String, dynamic> json,
) => MedicineResponseModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => MedicineModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$MedicineResponseModelToJson(
  MedicineResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};
