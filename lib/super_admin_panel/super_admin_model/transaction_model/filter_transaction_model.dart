// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'filter_transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterTransactionModel {
  bool? success;
  List<FilterTransactionData>? data;
  String? message;

  FilterTransactionModel({
    this.success,
    this.data,
    this.message
  });

  factory FilterTransactionModel.fromJson(Map<String, dynamic> json) => _$FilterTransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$FilterTransactionModelToJson(this);

}

@JsonSerializable(explicitToJson: true)
class FilterTransactionData {
  int? id;
  String? hospital_name;
  String? payment_type;
  String? amount;
  int? is_manual_payment;
  String? status;
  String? transaction_date;
  String? currency_symbol;
  String? start_date;
  String? start_time;
  String? expire_date;
  String? expire_time;

  FilterTransactionData(
      {this.id,
        this.hospital_name,
        this.payment_type,
        this.amount,
        this.is_manual_payment,
        this.status,
        this.transaction_date,
        this.currency_symbol,
        this.start_date,
        this.start_time,
        this.expire_date,
        this.expire_time
      });

  factory FilterTransactionData.fromJson(Map<String, dynamic> json) => _$FilterTransactionDataFromJson(json);
  Map<String, dynamic> toJson() => _$FilterTransactionDataToJson(this);
}
