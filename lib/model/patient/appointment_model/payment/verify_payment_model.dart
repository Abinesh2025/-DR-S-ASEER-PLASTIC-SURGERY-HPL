class VerifyPaymentModel {
  bool? success;
  String? message;
  VerifyPaymentData? data;

  VerifyPaymentModel({this.success, this.message, this.data});

  VerifyPaymentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? VerifyPaymentData.fromJson(json['data']) : null;
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

class VerifyPaymentData {
  String? paymentStatus;

  VerifyPaymentData({this.paymentStatus});

  VerifyPaymentData.fromJson(Map<String, dynamic> json) {
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_status'] = paymentStatus;
    return data;
  }
}
