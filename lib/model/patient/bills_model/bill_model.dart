// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'bill_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BillsModel {
  bool? success;
  List<BillsData>? data;
  String? message;

  BillsModel({
    this.success,
    this.data,
    this.message,
  });

  factory BillsModel.fromJson(Map<String, dynamic> json) => _$BillsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BillsData {
  int? id;
  String? bill_id;
  String? bill_time;
  String? bill_date;
  int? amount;
  String? currency;

  BillsData({
    this.id,
    this.bill_id,
    this.bill_date,
    this.bill_time,
    this.amount,
    this.currency,
  });

  factory BillsData.fromJson(Map<String, dynamic> json) => _$BillsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BillsDataToJson(this);
}
