import 'package:json_annotation/json_annotation.dart';

part 'reset_password_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ResetPasswordModel {
  bool? success;
  String? message;

  ResetPasswordModel({
    this.success,
    this.message,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) => _$ResetPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordModelToJson(this);
}
