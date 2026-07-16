// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'subscription_models.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscriptionModel {
  bool? success;
  List<SubscriptionDetails>? data;
  String? message;

  SubscriptionModel({this.success, this.data, this.message});

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => _$SubscriptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SubscriptionDetails {
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

  SubscriptionDetails(
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

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) => _$SubscriptionDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionDetailsToJson(this);
}
