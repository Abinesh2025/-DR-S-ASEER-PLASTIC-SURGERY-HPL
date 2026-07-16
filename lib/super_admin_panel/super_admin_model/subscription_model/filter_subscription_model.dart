// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'filter_subscription_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterSubscriptionModel {
  bool? success;
  List<FilterSubscriptionData>? data;
  String? message;

  FilterSubscriptionModel({this.success, this.data, this.message});

  factory FilterSubscriptionModel.fromJson(Map<String, dynamic> json) => _$FilterSubscriptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$FilterSubscriptionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FilterSubscriptionData {
  int? id;
  String? hospital_name;
  String? subscription_plan_name;
  int? amount;
  String? currency;
  String? plan_frequency;
  String? start_date;
  String? start_time;
  String? expire_date;
  String? expire_time;
  int? sms_limit;
  String? status;

  FilterSubscriptionData(
      {this.id,
        this.hospital_name,
        this.subscription_plan_name,
        this.amount,
        this.currency,
        this.plan_frequency,
        this.start_date,
        this.start_time,
        this.expire_date,
        this.expire_time,
        this.sms_limit,
        this.status
      });

  factory FilterSubscriptionData.fromJson(Map<String, dynamic> json) => _$FilterSubscriptionDataFromJson(json);
  Map<String, dynamic> toJson() => _$FilterSubscriptionDataToJson(this);
}
