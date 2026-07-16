// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_consultation_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveConsultationFilter _$LiveConsultationFilterFromJson(
  Map<String, dynamic> json,
) => LiveConsultationFilter(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map(
        (e) => LiveConsultationFilterData.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$LiveConsultationFilterToJson(
  LiveConsultationFilter instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

LiveConsultationFilterData _$LiveConsultationFilterDataFromJson(
  Map<String, dynamic> json,
) => LiveConsultationFilterData(
  id: (json['id'] as num?)?.toInt(),
  consultation_title: json['consultation_title'] as String?,
  consultation_date: json['consultation_date'] as String?,
  consultation_time: json['consultation_time'] as String?,
  status: json['status'] as String?,
  doctor_image: json['doctor_image'] as String?,
);

Map<String, dynamic> _$LiveConsultationFilterDataToJson(
  LiveConsultationFilterData instance,
) => <String, dynamic>{
  'id': instance.id,
  'consultation_title': instance.consultation_title,
  'consultation_date': instance.consultation_date,
  'consultation_time': instance.consultation_time,
  'status': instance.status,
  'doctor_image': instance.doctor_image,
};
