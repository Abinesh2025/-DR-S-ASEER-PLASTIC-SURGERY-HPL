import 'package:json_annotation/json_annotation.dart';

part 'send_token_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SendTokenModel {
  bool? success;
  String? message;

  SendTokenModel({
    this.success,
    this.message,
  });

  factory SendTokenModel.fromJson(Map<String, dynamic> json) => _$SendTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendTokenModelToJson(this);
}
