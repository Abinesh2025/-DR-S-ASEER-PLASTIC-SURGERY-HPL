// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionModel {
  bool? success;
  List<TransactionData>? data;
  String? message;

  TransactionModel({this.success, this.data, this.message});

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

}

@JsonSerializable(explicitToJson: true)
class TransactionData {
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

  TransactionData(
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

  factory TransactionData.fromJson(Map<String, dynamic> json) => _$TransactionDataFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionDataToJson(this);
}
