// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'payroll_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PayrollModel {
  bool? success;
  List<PayrollData>? data;
  String? message;

  PayrollModel({
    this.success,
    this.data,
    this.message,
  });

  factory PayrollModel.fromJson(Map<String, dynamic> json) => _$PayrollModelFromJson(json);

  Map<String, dynamic> toJson() => _$PayrollModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PayrollData {
  int? id;
  String? payroll_id;
  String? month;
  int? year;
  String? status;

  PayrollData({
    this.id,
    this.payroll_id,
    this.month,
    this.year,
    this.status,
  });

  factory PayrollData.fromJson(Map<String, dynamic> json) => _$PayrollDataFromJson(json);

  Map<String, dynamic> toJson() => _$PayrollDataToJson(this);
}
