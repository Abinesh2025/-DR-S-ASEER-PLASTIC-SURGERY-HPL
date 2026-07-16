// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_prescription_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorPrescriptionDetailModel _$DoctorPrescriptionDetailModelFromJson(
  Map<String, dynamic> json,
) => DoctorPrescriptionDetailModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : DoctorPrescriptionDetailData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorPrescriptionDetailModelToJson(
  DoctorPrescriptionDetailModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.toJson(),
  'message': instance.message,
};

DoctorPrescriptionDetailData _$DoctorPrescriptionDetailDataFromJson(
  Map<String, dynamic> json,
) => DoctorPrescriptionDetailData(
  id: (json['id'] as num?)?.toInt(),
  doctor_id: (json['doctor_id'] as num?)?.toInt(),
  doctor_name: json['doctor_name'] as String?,
  specialist: json['specialist'] as String?,
  patient_name: json['patient_name'] as String?,
  patient_age: (json['patient_age'] as num?)?.toInt(),
  created_date: json['created_date'] as String?,
  created_time: json['created_time'] as String?,
  problem: json['problem'] as String?,
  test: json['test'] as String?,
  advice: json['advice'] as String?,
  medicine: (json['medicine'] as List<dynamic>?)
      ?.map((e) => Medicine.fromJson(e as Map<String, dynamic>))
      .toList(),
  download_prescription: json['download_prescription'] as String?,
  app_logo: json['app_logo'] as String?,
);

Map<String, dynamic> _$DoctorPrescriptionDetailDataToJson(
  DoctorPrescriptionDetailData instance,
) => <String, dynamic>{
  'id': instance.id,
  'doctor_id': instance.doctor_id,
  'doctor_name': instance.doctor_name,
  'specialist': instance.specialist,
  'patient_name': instance.patient_name,
  'patient_age': instance.patient_age,
  'created_date': instance.created_date,
  'created_time': instance.created_time,
  'problem': instance.problem,
  'test': instance.test,
  'advice': instance.advice,
  'medicine': instance.medicine?.map((e) => e.toJson()).toList(),
  'download_prescription': instance.download_prescription,
  'app_logo': instance.app_logo,
};

Medicine _$MedicineFromJson(Map<String, dynamic> json) => Medicine(
  name: json['name'] as String?,
  dosage: json['dosage'] as String?,
  time: json['time'] as String?,
  days: json['days'] as String?,
);

Map<String, dynamic> _$MedicineToJson(Medicine instance) => <String, dynamic>{
  'name': instance.name,
  'dosage': instance.dosage,
  'days': instance.days,
  'time': instance.time,
};
