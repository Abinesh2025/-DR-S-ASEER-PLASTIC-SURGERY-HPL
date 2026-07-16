// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDetailsModel _$InvoiceDetailsModelFromJson(Map<String, dynamic> json) =>
    InvoiceDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : InvoiceDetailsData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$InvoiceDetailsModelToJson(
  InvoiceDetailsModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

InvoiceDetailsData _$InvoiceDetailsDataFromJson(Map<String, dynamic> json) =>
    InvoiceDetailsData(
      id: (json['id'] as num?)?.toInt(),
      invoice_id: json['invoice_id'] as String?,
      invoice_date: json['invoice_date'] as String?,
      patient_name: json['patient_name'] as String?,
      issued_by: json['issued_by'] as String?,
      hospital_address: json['hospital_address'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      zip: json['zip'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
      invoice_download: json['invoice_download'] as String?,
      invoice_items: (json['invoice_items'] as List<dynamic>?)
          ?.map((e) => InvoiceItemList.fromJson(e as Map<String, dynamic>))
          .toList(),
      sub_total: json['sub_total'],
      discount: json['discount'],
      total_amount: json['total_amount'],
      app_logo: json['app_logo'] as String?,
    );

Map<String, dynamic> _$InvoiceDetailsDataToJson(InvoiceDetailsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_id': instance.invoice_id,
      'invoice_date': instance.invoice_date,
      'patient_name': instance.patient_name,
      'issued_by': instance.issued_by,
      'hospital_address': instance.hospital_address,
      'address': instance.address,
      'city': instance.city,
      'zip': instance.zip,
      'currencySymbol': instance.currencySymbol,
      'invoice_download': instance.invoice_download,
      'invoice_items': instance.invoice_items,
      'sub_total': instance.sub_total,
      'discount': instance.discount,
      'total_amount': instance.total_amount,
      'app_logo': instance.app_logo,
    };

InvoiceItemList _$InvoiceItemListFromJson(Map<String, dynamic> json) =>
    InvoiceItemList(
      id: (json['id'] as num?)?.toInt(),
      account_name: json['account_name'] as String?,
      description: json['description'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price: json['price'],
      total: json['total'],
    );

Map<String, dynamic> _$InvoiceItemListToJson(InvoiceItemList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_name': instance.account_name,
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'total': instance.total,
    };
