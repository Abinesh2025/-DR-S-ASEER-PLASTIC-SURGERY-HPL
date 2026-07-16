import 'package:json_annotation/json_annotation.dart';

part 'update_subscription_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateSubscriptionModel {
  bool? success;
  String? message;

  UpdateSubscriptionModel({
    this.success,
    this.message,
  });

  factory UpdateSubscriptionModel.fromJson(Map<String, dynamic> json) => _$UpdateSubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSubscriptionModelToJson(this);
}