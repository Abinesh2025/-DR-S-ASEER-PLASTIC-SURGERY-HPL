// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'invoice_model.g.dart';

@JsonSerializable()
class InvoiceModel {
  bool? success;
  List<InvoiceData>? data;
  String? message;

  InvoiceModel({
    this.success,
    this.data,
    this.message,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => _$InvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);
}

@JsonSerializable()
class InvoiceData {
  int? id;
  String? invoice_id;
  String? invoice_date;
  dynamic amount;
  bool? status;
  String? currency;

  InvoiceData({
    this.id,
    this.invoice_id,
    this.invoice_date,
    this.amount,
    this.status,
    this.currency,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) => _$InvoiceDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDataToJson(this);
}
