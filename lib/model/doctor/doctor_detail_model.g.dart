// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorDetailModel _$DoctorDetailModelFromJson(Map<String, dynamic> json) =>
    DoctorDetailModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : DoctorDetailData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DoctorDetailModelToJson(DoctorDetailModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

SpecialToken _$SpecialTokenFromJson(Map<String, dynamic> json) => SpecialToken(
  id: (json['id'] as num?)?.toInt(),
  tokenType: json['tokenType'] as String?,
);

Map<String, dynamic> _$SpecialTokenToJson(SpecialToken instance) =>
    <String, dynamic>{'id': instance.id, 'tokenType': instance.tokenType};

DoctorDetailData _$DoctorDetailDataFromJson(Map<String, dynamic> json) =>
    DoctorDetailData(
      id: (json['id'] as num?)?.toInt(),
      doctorName: json['doctor_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      designation: json['designation'] as String?,
      doctorDepartment: json['doctor_department'] as String?,
      doctorDepartmentId: (json['doctor_department_id'] as num?)?.toInt(),
      qualification: json['qualification'] as String?,
      bloodGroup: json['blood_group'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      specialist: json['specialist'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String?,
      zip: json['zip'] as String?,
      description: json['description'] as String?,
      doctorImage: json['doctor_image'] as String?,
      specialTokens: (json['special_tokens'] as List<dynamic>?)
          ?.map((e) => SpecialToken.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageRating: json['average_rating'],
      reviewsCount: (json['reviews_count'] as num?)?.toInt(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => DoctorReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorDetailDataToJson(DoctorDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_name': instance.doctorName,
      'email': instance.email,
      'phone': instance.phone,
      'designation': instance.designation,
      'doctor_department': instance.doctorDepartment,
      'doctor_department_id': instance.doctorDepartmentId,
      'qualification': instance.qualification,
      'blood_group': instance.bloodGroup,
      'date_of_birth': instance.dateOfBirth,
      'gender': instance.gender,
      'specialist': instance.specialist,
      'address1': instance.address1,
      'address2': instance.address2,
      'city': instance.city,
      'zip': instance.zip,
      'description': instance.description,
      'doctor_image': instance.doctorImage,
      'special_tokens': instance.specialTokens,
      'average_rating': instance.averageRating,
      'reviews_count': instance.reviewsCount,
      'reviews': instance.reviews,
    };

DoctorReview _$DoctorReviewFromJson(Map<String, dynamic> json) => DoctorReview(
  id: (json['id'] as num?)?.toInt(),
  patientName: json['patient_name'] as String?,
  patientImage: json['patient_image'] as String?,
  rating: json['rating'],
  review: json['review'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$DoctorReviewToJson(DoctorReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_name': instance.patientName,
      'patient_image': instance.patientImage,
      'rating': instance.rating,
      'review': instance.review,
      'created_at': instance.createdAt,
    };
