// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_live_consultations_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorLiveConsultationsDetailsModel
_$DoctorLiveConsultationsDetailsModelFromJson(Map<String, dynamic> json) =>
    DoctorLiveConsultationsDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : DoctorLiveConsultationsDetailsData.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DoctorLiveConsultationsDetailsModelToJson(
  DoctorLiveConsultationsDetailsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.toJson(),
  'message': instance.message,
};

DoctorLiveConsultationsDetailsData _$DoctorLiveConsultationsDetailsDataFromJson(
  Map<String, dynamic> json,
) => DoctorLiveConsultationsDetailsData(
  id: (json['id'] as num?)?.toInt(),
  consultation_title: json['consultation_title'] as String?,
  consultation_date: json['consultation_date'] as String?,
  duration_minutes: json['duration_minutes'] as String?,
  patient_name: json['patient_name'] as String?,
  type: json['type'] as String?,
  type_number: json['type_number'] as String?,
);

Map<String, dynamic> _$DoctorLiveConsultationsDetailsDataToJson(
  DoctorLiveConsultationsDetailsData instance,
) => <String, dynamic>{
  'id': instance.id,
  'consultation_title': instance.consultation_title,
  'consultation_date': instance.consultation_date,
  'duration_minutes': instance.duration_minutes,
  'patient_name': instance.patient_name,
  'type': instance.type,
  'type_number': instance.type_number,
};
