// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillDetailModel _$BillDetailModelFromJson(Map<String, dynamic> json) =>
    BillDetailModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : BillDetailData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BillDetailModelToJson(BillDetailModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

BillDetailData _$BillDetailDataFromJson(Map<String, dynamic> json) =>
    BillDetailData(
      id: (json['id'] as num?)?.toInt(),
      bill_id: json['bill_id'] as String?,
      bill_time: json['bill_time'] as String?,
      bill_date: json['bill_date'] as String?,
      currency: json['currency'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      patient_admission_id: json['patient_admission_id'] as String?,
      admission_detail: json['admission_detail'] == null
          ? null
          : AdmissionDetail.fromJson(
              json['admission_detail'] as Map<String, dynamic>,
            ),
      insurance_detail: json['insurance_detail'] == null
          ? null
          : InsuranceDetail.fromJson(
              json['insurance_detail'] as Map<String, dynamic>,
            ),
      item_details: (json['item_details'] as List<dynamic>?)
          ?.map((e) => ItemDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      bill_download: json['bill_download'] as String?,
      app_logo: json['app_logo'] as String?,
    );

Map<String, dynamic> _$BillDetailDataToJson(BillDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bill_id': instance.bill_id,
      'bill_time': instance.bill_time,
      'bill_date': instance.bill_date,
      'currency': instance.currency,
      'amount': instance.amount,
      'patient_admission_id': instance.patient_admission_id,
      'admission_detail': instance.admission_detail?.toJson(),
      'insurance_detail': instance.insurance_detail?.toJson(),
      'item_details': instance.item_details?.map((e) => e.toJson()).toList(),
      'bill_download': instance.bill_download,
      'app_logo': instance.app_logo,
    };

AdmissionDetail _$AdmissionDetailFromJson(Map<String, dynamic> json) =>
    AdmissionDetail(
      phone: json['phone'] as String?,
      doctor: json['doctor'] as String?,
      admission_date: json['admission_date'] as String?,
      admission_time: json['admission_time'] as String?,
      discharge_date: json['discharge_date'] as String?,
      discharge_time: json['discharge_time'] as String?,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$AdmissionDetailToJson(AdmissionDetail instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'doctor': instance.doctor,
      'admission_date': instance.admission_date,
      'admission_time': instance.admission_time,
      'discharge_date': instance.discharge_date,
      'discharge_time': instance.discharge_time,
      'created_at': instance.created_at,
    };

InsuranceDetail _$InsuranceDetailFromJson(Map<String, dynamic> json) =>
    InsuranceDetail(
      package_name: json['package_name'] as String?,
      insurance_name: json['insurance_name'] as String?,
      total_days: (json['total_days'] as num?)?.toInt(),
      policy_no: json['policy_no'] as String?,
    );

Map<String, dynamic> _$InsuranceDetailToJson(InsuranceDetail instance) =>
    <String, dynamic>{
      'package_name': instance.package_name,
      'insurance_name': instance.insurance_name,
      'total_days': instance.total_days,
      'policy_no': instance.policy_no,
    };

ItemDetails _$ItemDetailsFromJson(Map<String, dynamic> json) => ItemDetails(
  id: (json['id'] as num?)?.toInt(),
  item_name: json['item_name'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toInt(),
);

Map<String, dynamic> _$ItemDetailsToJson(ItemDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_name': instance.item_name,
      'quantity': instance.quantity,
      'total': instance.total,
      'price': instance.price,
    };
