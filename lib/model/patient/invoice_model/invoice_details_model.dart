// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'invoice_details_model.g.dart';

@JsonSerializable()
class InvoiceDetailsModel {
  bool? success;
  InvoiceDetailsData? data;
  String? message;

  InvoiceDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory InvoiceDetailsModel.fromJson(Map<String, dynamic> json) => _$InvoiceDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDetailsModelToJson(this);
}

@JsonSerializable()
class InvoiceDetailsData {
  int? id;
  String? invoice_id;
  String? invoice_date;
  String? patient_name;
  String? issued_by;
  String? hospital_address;
  String? address;
  String? city;
  String? zip;
  String? currencySymbol;
  String? invoice_download;
  List<InvoiceItemList>? invoice_items;
  dynamic sub_total;
  dynamic discount;
  dynamic total_amount;
  String? app_logo;

  InvoiceDetailsData({
    this.id,
    this.invoice_id,
    this.invoice_date,
    this.patient_name,
    this.issued_by,
    this.hospital_address,
    this.address,
    this.city,
    this.zip,
    this.currencySymbol,
    this.invoice_download,
    this.invoice_items,
    this.sub_total,
    this.discount,
    this.total_amount,
    this.app_logo
  });

  factory InvoiceDetailsData.fromJson(Map<String, dynamic> json) => _$InvoiceDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDetailsDataToJson(this);
}

@JsonSerializable()
class InvoiceItemList {
  int? id;
  String? account_name;
  String? description;
  int? quantity;
  dynamic price;
  dynamic total;

  InvoiceItemList({
    this.id,
    this.account_name,
    this.description,
    this.quantity,
    this.price,
    this.total,
  });

  factory InvoiceItemList.fromJson(Map<String, dynamic> json) => _$InvoiceItemListFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceItemListToJson(this);
}
