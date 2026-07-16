// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_department_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorDepartmentModel _$DoctorDepartmentModelFromJson(
  Map<String, dynamic> json,
) => DoctorDepartmentModel(
  success: json['success'] as bool?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => DoctorDepartmentData.fromJson(e as Map<String, dynamic>))
      .toList(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$DoctorDepartmentModelToJson(
  DoctorDepartmentModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'message': instance.message,
};

DoctorDepartmentData _$DoctorDepartmentDataFromJson(
  Map<String, dynamic> json,
) => DoctorDepartmentData(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  doctorDepartmentImage: json['doctor_department_image'] as String?,
);

Map<String, dynamic> _$DoctorDepartmentDataToJson(
  DoctorDepartmentData instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'doctor_department_image': instance.doctorDepartmentImage,
};
