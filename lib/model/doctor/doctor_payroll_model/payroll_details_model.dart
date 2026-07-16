// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'payroll_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PayrollDetailsModel {
  bool? success;
  PayrollDetailsData? data;
  String? message;

  PayrollDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory PayrollDetailsModel.fromJson(Map<String, dynamic> json) => _$PayrollDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PayrollDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PayrollDetailsData {
  int? id;
  int? sr_no;
  String? payroll_id;
  String? month;
  int? year;
  int? net_salary;
  String? status;
  int? basic_salary;
  int? allowance;
  int? deductions;
  String? created_on;
  String? currency_symbol;
  String? app_logo;

  PayrollDetailsData({
    this.id,
    this.sr_no,
    this.payroll_id,
    this.month,
    this.year,
    this.net_salary,
    this.status,
    this.basic_salary,
    this.allowance,
    this.deductions,
    this.created_on,
    this.currency_symbol,
    this.app_logo,
  });

  factory PayrollDetailsData.fromJson(Map<String, dynamic> json) => _$PayrollDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PayrollDetailsDataToJson(this);
}
