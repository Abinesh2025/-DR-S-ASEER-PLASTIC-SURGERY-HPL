// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_category_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineCategoryDetailModel _$MedicineCategoryDetailModelFromJson(
  Map<String, dynamic> json,
) => MedicineCategoryDetailModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : MedicineCategoryDetailData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  message: json['message'] as String?,
);

Map<String, dynamic> _$MedicineCategoryDetailModelToJson(
  MedicineCategoryDetailModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};

MedicineCategoryDetailData _$MedicineCategoryDetailDataFromJson(
  Map<String, dynamic> json,
) => MedicineCategoryDetailData(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  brands: (json['brands'] as List<dynamic>?)
      ?.map((e) => MedicineBrand.fromJson(e as Map<String, dynamic>))
      .toList(),
  medicines: (json['medicines'] as List<dynamic>?)
      ?.map((e) => Medicine.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MedicineCategoryDetailDataToJson(
  MedicineCategoryDetailData instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brands': instance.brands,
  'medicines': instance.medicines,
};

MedicineBrand _$MedicineBrandFromJson(Map<String, dynamic> json) =>
    MedicineBrand(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$MedicineBrandToJson(MedicineBrand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };

Medicine _$MedicineFromJson(Map<String, dynamic> json) => Medicine(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  sellingPrice: (json['selling_price'] as num?)?.toDouble(),
  buyingPrice: (json['buying_price'] as num?)?.toDouble(),
  brandId: (json['brand_id'] as num?)?.toInt(),
  brandName: json['brand_name'] as String?,
  sideEffects: json['side_effects'] as String?,
  saltComposition: json['salt_composition'] as String?,
  description: json['description'] as String?,
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$MedicineToJson(Medicine instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'selling_price': instance.sellingPrice,
  'buying_price': instance.buyingPrice,
  'brand_id': instance.brandId,
  'brand_name': instance.brandName,
  'side_effects': instance.sideEffects,
  'salt_composition': instance.saltComposition,
  'description': instance.description,
  'image_url': instance.imageUrl,
};
