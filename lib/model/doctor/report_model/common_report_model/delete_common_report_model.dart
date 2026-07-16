import 'package:json_annotation/json_annotation.dart';

part 'delete_common_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeleteCommonReportModel {
  bool? success;
  String? message;

  DeleteCommonReportModel({
    this.success,
    this.message,
  });

  factory DeleteCommonReportModel.fromJson(Map<String, dynamic> json) => _$DeleteCommonReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteCommonReportModelToJson(this);
}
