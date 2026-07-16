// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'bill_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BillDetailModel {
  bool? success;
  BillDetailData? data;
  String? message;

  BillDetailModel({
    this.success,
    this.data,
    this.message,
  });

  factory BillDetailModel.fromJson(Map<String, dynamic> json) => _$BillDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillDetailModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BillDetailData {
  int? id;
  String? bill_id;
  String? bill_time;
  String? bill_date;
  String? currency;
  int? amount;
  String? patient_admission_id;
  AdmissionDetail? admission_detail;
  InsuranceDetail? insurance_detail;
  List<ItemDetails>? item_details;
  String? bill_download;
  String? app_logo;

  BillDetailData({
    this.id,
    this.bill_id,
    this.bill_time,
    this.bill_date,
    this.currency,
    this.amount,
    this.patient_admission_id,
    this.admission_detail,
    this.insurance_detail,
    this.item_details,
    this.bill_download,
    this.app_logo
  });
  factory BillDetailData.fromJson(Map<String, dynamic> json) => _$BillDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$BillDetailDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AdmissionDetail {
  String? phone;
  String? doctor;
  String? admission_date;
  String? admission_time;
  String? discharge_date;
  String? discharge_time;
  String? created_at;

  AdmissionDetail({
    this.phone,
    this.doctor,
    this.admission_date,
    this.admission_time,
    this.discharge_date,
    this.discharge_time,
    this.created_at,
  });

  factory AdmissionDetail.fromJson(Map<String, dynamic> json) => _$AdmissionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AdmissionDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InsuranceDetail {
  String? package_name;
  String? insurance_name;
  int? total_days;
  String? policy_no;

  InsuranceDetail({
    this.package_name,
    this.insurance_name,
    this.total_days,
    this.policy_no,
  });
  factory InsuranceDetail.fromJson(Map<String, dynamic> json) => _$InsuranceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemDetails {
  int? id;
  String? item_name;
  int? quantity;
  int? total;
  int? price;

  ItemDetails({
    this.id,
    this.item_name,
    this.quantity,
    this.total,
    this.price,
  });
  factory ItemDetails.fromJson(Map<String, dynamic> json) => _$ItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsToJson(this);
}
