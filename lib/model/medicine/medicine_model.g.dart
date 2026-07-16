// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineModel _$MedicineModelFromJson(Map<String, dynamic> json) =>
    MedicineModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      sellingPrice: (json['selling_price'] as num?)?.toDouble(),
      availableQuantity: (json['available_quantity'] as num?)?.toInt(),
      description: json['description'] as String?,
      categoryName: json['category_name'] as String?,
      brandName: json['brand_name'] as String?,
      saltComposition: json['salt_composition'] as String?,
      sideEffects: json['side_effects'] as String?,
      imageUrl: json['image_url'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MedicineModelToJson(MedicineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'selling_price': instance.sellingPrice,
      'available_quantity': instance.availableQuantity,
      'description': instance.description,
      'category_name': instance.categoryName,
      'brand_name': instance.brandName,
      'salt_composition': instance.saltComposition,
      'side_effects': instance.sideEffects,
      'image_url': instance.imageUrl,
      'category_id': instance.categoryId,
    };
