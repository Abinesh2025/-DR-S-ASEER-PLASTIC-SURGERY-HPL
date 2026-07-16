class CreatePaymentModel {
  bool? success;
  String? message;
  CreatePaymentData? data;

  CreatePaymentModel({this.success, this.message, this.data});

  CreatePaymentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? CreatePaymentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CreatePaymentData {
  bool? success;
  String? orderId;
  int? amount;
  String? currency;

  CreatePaymentData({this.success, this.orderId, this.amount, this.currency});

  CreatePaymentData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    orderId = json['order_id'];
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['order_id'] = orderId;
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }
}
