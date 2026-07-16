import 'package:json_annotation/json_annotation.dart';

part 'income_chart_model.g.dart';

@JsonSerializable()
class IncomeModel {
  bool? success;
  List<IncomeData>? data;
  String? message;

  IncomeModel({
    this.success,
    this.data,
    this.message
  });

  factory IncomeModel.fromJson(Map<String, dynamic> json) => _$IncomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeModelToJson(this);
}

@JsonSerializable()
class IncomeData {
  String? days;
  double? income;

  IncomeData({
    this.days,
    this.income
  });

  factory IncomeData.fromJson(Map<String, dynamic> json) => _$IncomeDataFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeDataToJson(this);
}
