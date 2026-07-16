import 'package:json_annotation/json_annotation.dart';

part 'sigup_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SignUpModel {
  bool? success;
  String? message;

  SignUpModel({
    this.success,
    this.message,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}
