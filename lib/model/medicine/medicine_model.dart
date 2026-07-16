import 'package:json_annotation/json_annotation.dart';

part 'medicine_model.g.dart';

class MedicineListResponse {
  final bool success;
  final List<MedicineModel> data;
  final String message;

  MedicineListResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory MedicineListResponse.fromJson(Map<String, dynamic> json) {
    return MedicineListResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => MedicineModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      message: json['message'] ?? '',
    );
  }
}

@JsonSerializable()
class MedicineModel {
  final int id;
  final String name;
  @JsonKey(name: 'selling_price')
  final double? sellingPrice;
  @JsonKey(name: 'available_quantity')
  final int? availableQuantity;
  final String? description;
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @JsonKey(name: 'brand_name')
  final String? brandName;
  @JsonKey(name: 'salt_composition')
  final String? saltComposition;
  @JsonKey(name: 'side_effects')
  final String? sideEffects;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'category_id')
  final int? categoryId;

  MedicineModel({
    required this.id,
    required this.name,
    this.sellingPrice,
    this.availableQuantity,
    this.description,
    this.categoryName,
    this.brandName,
    this.saltComposition,
    this.sideEffects,
    this.imageUrl,
    this.categoryId,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineModelToJson(this);
}
