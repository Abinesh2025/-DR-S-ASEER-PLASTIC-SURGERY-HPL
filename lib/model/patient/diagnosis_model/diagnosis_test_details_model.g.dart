// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_test_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiagnosisTestDetailsModel _$DiagnosisTestDetailsModelFromJson(
  Map<String, dynamic> json,
) => DiagnosisTestDetailsModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : DiagnosisTestDetailsData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DiagnosisTestDetailsModelToJson(
  DiagnosisTestDetailsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.toJson(),
  'message': instance.message,
};

DiagnosisTestDetailsData _$DiagnosisTestDetailsDataFromJson(
  Map<String, dynamic> json,
) => DiagnosisTestDetailsData(
  id: (json['id'] as num?)?.toInt(),
  patient_name: json['patient_name'] as String?,
  patient_image: json['patient_image'] as String?,
  doctor_name: json['doctor_name'] as String?,
  doctor_image: json['doctor_image'] as String?,
  category: json['category'] as String?,
  report_number: json['report_number'] as String?,
  patient_diagnosis: json['patient_diagnosis'] == null
      ? null
      : PatientDiagnosis.fromJson(
          json['patient_diagnosis'] as Map<String, dynamic>,
        ),
  created_on: json['created_on'] as String?,
  pdf_url: json['pdf_url'] as String?,
);

Map<String, dynamic> _$DiagnosisTestDetailsDataToJson(
  DiagnosisTestDetailsData instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_name': instance.patient_name,
  'patient_image': instance.patient_image,
  'doctor_name': instance.doctor_name,
  'doctor_image': instance.doctor_image,
  'category': instance.category,
  'report_number': instance.report_number,
  'patient_diagnosis': instance.patient_diagnosis?.toJson(),
  'created_on': instance.created_on,
  'pdf_url': instance.pdf_url,
};

PatientDiagnosis _$PatientDiagnosisFromJson(Map<String, dynamic> json) =>
    PatientDiagnosis(
      age: json['age'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      average_glucose: json['average_glucose'] as String?,
      fasting_blood_sugar: json['fasting_blood_sugar'] as String?,
      urine_sugar: json['urine_sugar'] as String?,
      blood_pressure: json['blood_pressure'] as String?,
      diabetes: json['diabetes'] as String?,
      cholesterol: json['cholesterol'] as String?,
      demo_key: json['demo_key'] as String?,
    );

Map<String, dynamic> _$PatientDiagnosisToJson(PatientDiagnosis instance) =>
    <String, dynamic>{
      'age': instance.age,
      'height': instance.height,
      'weight': instance.weight,
      'average_glucose': instance.average_glucose,
      'fasting_blood_sugar': instance.fasting_blood_sugar,
      'urine_sugar': instance.urine_sugar,
      'blood_pressure': instance.blood_pressure,
      'diabetes': instance.diabetes,
      'cholesterol': instance.cholesterol,
      'demo_key': instance.demo_key,
    };
