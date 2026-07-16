// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_live_consultations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorLiveConsultationsModel _$DoctorLiveConsultationsModelFromJson(
  Map<String, dynamic> json,
) => DoctorLiveConsultationsModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map(
        (e) => DoctorLiveConsultationsData.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorLiveConsultationsModelToJson(
  DoctorLiveConsultationsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

DoctorLiveConsultationsData _$DoctorLiveConsultationsDataFromJson(
  Map<String, dynamic> json,
) => DoctorLiveConsultationsData(
  id: (json['id'] as num?)?.toInt(),
  consultation_title: json['consultation_title'] as String?,
  status: json['status'] as String?,
  consultation_time: json['consultation_time'] as String?,
  consultation_date: json['consultation_date'] as String?,
  patient_image: json['patient_image'] as String?,
);

Map<String, dynamic> _$DoctorLiveConsultationsDataToJson(
  DoctorLiveConsultationsData instance,
) => <String, dynamic>{
  'id': instance.id,
  'consultation_title': instance.consultation_title,
  'status': instance.status,
  'consultation_time': instance.consultation_time,
  'consultation_date': instance.consultation_date,
  'patient_image': instance.patient_image,
};
