// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'dashboard_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DashBoardModel {
  bool? success;
  DashboardData? data;
  String? message;

  DashBoardModel({
    this.success,
    this.data,
    this.message
  });

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => _$DashBoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashBoardModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DashboardData {
  int? users;
  double? revenue;
  Currency? currency;
  int? activeHospitalPlan;
  int? deActiveHospitalPlan;

  DashboardData({
    this.users,
    this.revenue,
    this.currency,
    this.activeHospitalPlan,
    this.deActiveHospitalPlan,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) => _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Currency {
  int? id;
  String? currency_name;
  String? currency_code;
  String? currency_icon;
  dynamic deleted_at;

  Currency({
    this.id,
    this.currency_name,
    this.currency_code,
    this.currency_icon,
    this.deleted_at,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}