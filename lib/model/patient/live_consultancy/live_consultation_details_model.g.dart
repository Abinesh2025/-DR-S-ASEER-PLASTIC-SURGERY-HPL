// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_consultation_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveConsultationDetailsModel _$LiveConsultationDetailsModelFromJson(
  Map<String, dynamic> json,
) => LiveConsultationDetailsModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : LiveConsultationDetailsData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  message: json['message'] as String?,
);

Map<String, dynamic> _$LiveConsultationDetailsModelToJson(
  LiveConsultationDetailsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

LiveConsultationDetailsData _$LiveConsultationDetailsDataFromJson(
  Map<String, dynamic> json,
) => LiveConsultationDetailsData(
  id: (json['id'] as num?)?.toInt(),
  consultation_title: json['consultation_title'] as String?,
  consultation_date: json['consultation_date'] as String?,
  duration: json['duration'] as String?,
  dostor_name: json['dostor_name'] as String?,
  type: json['type'] as String?,
  type_number: json['type_number'] as String?,
);

Map<String, dynamic> _$LiveConsultationDetailsDataToJson(
  LiveConsultationDetailsData instance,
) => <String, dynamic>{
  'id': instance.id,
  'consultation_title': instance.consultation_title,
  'consultation_date': instance.consultation_date,
  'duration': instance.duration,
  'dostor_name': instance.dostor_name,
  'type': instance.type,
  'type_number': instance.type_number,
};
