// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyResponseModel _$EmergencyResponseModelFromJson(
  Map<String, dynamic> json,
) => EmergencyResponseModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : EmergencyData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$EmergencyResponseModelToJson(
  EmergencyResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

EmergencyData _$EmergencyDataFromJson(Map<String, dynamic> json) =>
    EmergencyData(
      patientId: (json['patient_id'] as num?)?.toInt(),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      status: (json['status'] as num?)?.toInt(),
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
      voiceNoteUrl: json['voice_note_url'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$EmergencyDataToJson(EmergencyData instance) =>
    <String, dynamic>{
      'patient_id': instance.patientId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status': instance.status,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
      'voice_note_url': instance.voiceNoteUrl,
      'phone': instance.phone,
    };
