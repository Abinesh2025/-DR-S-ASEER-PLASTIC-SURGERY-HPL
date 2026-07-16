import 'package:json_annotation/json_annotation.dart';

part 'doctor_detail_model.g.dart';

@JsonSerializable()
class DoctorDetailModel {
  bool? success;
  DoctorDetailData? data;
  String? message;

  DoctorDetailModel({this.success, this.data, this.message});

  factory DoctorDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDetailModelToJson(this);
}
@JsonSerializable()
class SpecialToken {
  int? id;

  @JsonKey(name: 'tokenType')
  String? tokenType;

  SpecialToken({
    this.id,
    this.tokenType,
  });

  factory SpecialToken.fromJson(Map<String, dynamic> json) =>
      _$SpecialTokenFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SpecialTokenToJson(this);
}
@JsonSerializable()
class DoctorDetailData {
  int? id;
  @JsonKey(name: 'doctor_name')
  String? doctorName;
  String? email;
  String? phone;
  String? designation;
  @JsonKey(name: 'doctor_department')
  String? doctorDepartment;
  @JsonKey(name: 'doctor_department_id')
  int? doctorDepartmentId;
  String? qualification;
  @JsonKey(name: 'blood_group')
  String? bloodGroup;
  @JsonKey(name: 'date_of_birth')
  String? dateOfBirth;
  String? gender;
  String? specialist;
  String? address1;
  String? address2;
  String? city;
  String? zip;
  String? description;
  @JsonKey(name: 'doctor_image')
  String? doctorImage;
  @JsonKey(name: 'special_tokens')
  List<SpecialToken>? specialTokens;

  @JsonKey(name: 'average_rating')
  dynamic averageRating;
  @JsonKey(name: 'reviews_count')
  int? reviewsCount;
  List<DoctorReview>? reviews;

  DoctorDetailData({
    this.id,
    this.doctorName,
    this.email,
    this.phone,
    this.designation,
    this.doctorDepartment,
    this.doctorDepartmentId,
    this.qualification,
    this.bloodGroup,
    this.dateOfBirth,
    this.gender,
    this.specialist,
    this.address1,
    this.address2,
    this.city,
    this.zip,
    this.description,
    this.doctorImage,
    this.specialTokens,
    this.averageRating,
    this.reviewsCount,
    this.reviews,
  });

  factory DoctorDetailData.fromJson(Map<String, dynamic> json) =>
      _$DoctorDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDetailDataToJson(this);
}

@JsonSerializable()
class DoctorReview {
  int? id;
  @JsonKey(name: 'patient_name')
  String? patientName;
  @JsonKey(name: 'patient_image')
  String? patientImage;
  dynamic rating;
  String? review;
  @JsonKey(name: 'created_at')
  String? createdAt;

  DoctorReview({
    this.id,
    this.patientName,
    this.patientImage,
    this.rating,
    this.review,
    this.createdAt,
  });

  factory DoctorReview.fromJson(Map<String, dynamic> json) =>
      _$DoctorReviewFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorReviewToJson(this);
}
