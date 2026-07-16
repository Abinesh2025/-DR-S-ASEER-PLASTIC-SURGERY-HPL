import 'package:json_annotation/json_annotation.dart';

part 'emergency_model.g.dart';

@JsonSerializable()
class EmergencyResponseModel {
  bool? success;
  EmergencyData? data;
  String? message;

  EmergencyResponseModel({this.success, this.data, this.message});

  factory EmergencyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EmergencyResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyResponseModelToJson(this);
}

@JsonSerializable()
class EmergencyData {
  @JsonKey(name: 'patient_id')
  int? patientId;
  String? latitude;
  String? longitude;
  int? status;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'created_at')
  String? createdAt;
  int? id;
  @JsonKey(name: 'voice_note_url')
  String? voiceNoteUrl;
  String? phone;

  EmergencyData({
    this.patientId,
    this.latitude,
    this.longitude,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.voiceNoteUrl,
    this.phone,
  });

  factory EmergencyData.fromJson(Map<String, dynamic> json) =>
      _$EmergencyDataFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyDataToJson(this);
}
