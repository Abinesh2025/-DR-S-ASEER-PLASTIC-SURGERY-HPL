// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BedStatusModel _$BedStatusModelFromJson(Map<String, dynamic> json) =>
    BedStatusModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BedList.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BedStatusModelToJson(BedStatusModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

BedList _$BedListFromJson(Map<String, dynamic> json) => BedList(
  bed_title: json['bed_title'] as String?,
  bed: (json['bed'] as List<dynamic>?)
      ?.map((e) => BedData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BedListToJson(BedList instance) => <String, dynamic>{
  'bed_title': instance.bed_title,
  'bed': instance.bed,
};

BedData _$BedDataFromJson(Map<String, dynamic> json) => BedData(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  status: json['status'] as bool?,
);

Map<String, dynamic> _$BedDataToJson(BedData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': instance.status,
};
