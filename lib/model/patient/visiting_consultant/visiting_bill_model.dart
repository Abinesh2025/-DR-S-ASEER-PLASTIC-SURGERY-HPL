class VisitingConsultantBillModel {
  bool? success;
  String? message;
  VisitingBillData? data;

  VisitingConsultantBillModel({
    this.success,
    this.message,
    this.data,
  });

  factory VisitingConsultantBillModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return VisitingConsultantBillModel(
      success: json['success'] as bool? ?? true,
      message: json['message']?.toString(),
      data: rawData != null ? VisitingBillData.fromJson(rawData as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class VisitingBillData {
  int? id;
  int? requestId;
  String? billNumber;
  String? billDate;
  double? amount;
  double? tax;
  double? discount;
  double? netAmount;
  String? currency;
  String? paymentStatus; // "Paid", "Unpaid", "Pending"
  String? paymentMode; // "Cash", "UPI / Online", "Card", "Cheque"
  String? paidAt;
  String? notes;
  String? voucherUrl;
  List<VisitingBillItem>? items;

  VisitingBillData({
    this.id,
    this.requestId,
    this.billNumber,
    this.billDate,
    this.amount,
    this.tax,
    this.discount,
    this.netAmount,
    this.currency,
    this.paymentStatus,
    this.paymentMode,
    this.paidAt,
    this.notes,
    this.voucherUrl,
    this.items,
  });

  bool get isPaid => paymentStatus?.toLowerCase() == 'paid';

  factory VisitingBillData.fromJson(Map<String, dynamic> json) {
    List<VisitingBillItem>? itemList;
    if (json['items'] is List) {
      itemList = (json['items'] as List)
          .map((e) => VisitingBillItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (json['item_details'] is List) {
      itemList = (json['item_details'] as List)
          .map((e) => VisitingBillItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    double? parseD(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString());
    }

    return VisitingBillData(
      id: int.tryParse(json['id']?.toString() ?? ''),
      requestId: int.tryParse(json['visiting_consultant_request_id']?.toString() ?? json['request_id']?.toString() ?? ''),
      billNumber: json['bill_number']?.toString() ?? json['bill_id']?.toString() ?? json['invoice_no']?.toString(),
      billDate: json['bill_date']?.toString() ?? json['date']?.toString(),
      amount: parseD(json['amount'] ?? json['total']),
      tax: parseD(json['tax']),
      discount: parseD(json['discount']),
      netAmount: parseD(json['net_amount'] ?? json['final_amount'] ?? json['amount']),
      currency: json['currency']?.toString() ?? "₹",
      paymentStatus: json['payment_status']?.toString() ?? json['status']?.toString() ?? "Unpaid",
      paymentMode: json['payment_mode']?.toString(),
      paidAt: json['paid_at']?.toString(),
      notes: json['notes']?.toString(),
      voucherUrl: json['voucher_url']?.toString() ?? json['download_url']?.toString() ?? json['bill_download']?.toString(),
      items: itemList ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'request_id': requestId,
    'bill_number': billNumber,
    'bill_date': billDate,
    'amount': amount,
    'tax': tax,
    'discount': discount,
    'net_amount': netAmount,
    'currency': currency,
    'payment_status': paymentStatus,
    'payment_mode': paymentMode,
    'paid_at': paidAt,
    'notes': notes,
    'voucher_url': voucherUrl,
    'items': items?.map((e) => e.toJson()).toList(),
  };
}

class VisitingBillItem {
  String? itemName;
  double? itemPrice;
  int? quantity;
  double? total;

  VisitingBillItem({
    this.itemName,
    this.itemPrice,
    this.quantity,
    this.total,
  });

  factory VisitingBillItem.fromJson(Map<String, dynamic> json) {
    double? parseD(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString());
    }

    return VisitingBillItem(
      itemName: json['item_name']?.toString() ?? json['name']?.toString() ?? json['description']?.toString(),
      itemPrice: parseD(json['item_price'] ?? json['price']),
      quantity: int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,
      total: parseD(json['total'] ?? json['amount']),
    );
  }

  Map<String, dynamic> toJson() => {
    'item_name': itemName,
    'item_price': itemPrice,
    'quantity': quantity,
    'total': total,
  };
}

class RecordPaymentPayload {
  final String paymentMode; // "Cash", "UPI / Online", "Card", "Cheque", etc.
  final String? notes; // Optional: "Transaction ID: UPI123456789"

  RecordPaymentPayload({
    required this.paymentMode,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'payment_mode': paymentMode,
    };
    if (notes != null && notes!.isNotEmpty) {
      data['notes'] = notes;
    }
    return data;
  }
}
