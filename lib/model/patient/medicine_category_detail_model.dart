import 'package:json_annotation/json_annotation.dart';

part 'medicine_category_detail_model.g.dart';

@JsonSerializable()
class MedicineCategoryDetailModel {
  bool? success;
  MedicineCategoryDetailData? data;
  String? message;

  MedicineCategoryDetailModel({this.success, this.data, this.message});

  factory MedicineCategoryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineCategoryDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineCategoryDetailModelToJson(this);
}

@JsonSerializable()
class MedicineCategoryDetailData {
  int? id;
  String? name;
  List<MedicineBrand>? brands;
  List<Medicine>? medicines;

  MedicineCategoryDetailData({this.id, this.name, this.brands, this.medicines});

  factory MedicineCategoryDetailData.fromJson(Map<String, dynamic> json) =>
      _$MedicineCategoryDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineCategoryDetailDataToJson(this);
}

@JsonSerializable()
class MedicineBrand {
  int? id;
  String? name;
  String? email;
  String? phone;

  MedicineBrand({this.id, this.name, this.email, this.phone});

  factory MedicineBrand.fromJson(Map<String, dynamic> json) =>
      _$MedicineBrandFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineBrandToJson(this);
}

@JsonSerializable()
class Medicine {
  int? id;
  String? name;
  @JsonKey(name: 'selling_price')
  double? sellingPrice;
  @JsonKey(name: 'buying_price')
  double? buyingPrice;
  @JsonKey(name: 'brand_id')
  int? brandId;
  @JsonKey(name: 'brand_name')
  String? brandName;
  @JsonKey(name: 'side_effects')
  String? sideEffects;
  @JsonKey(name: 'salt_composition')
  String? saltComposition;
  String? description;
  @JsonKey(name: 'image_url')
  String? imageUrl;

  Medicine({
    this.id,
    this.name,
    this.sellingPrice,
    this.buyingPrice,
    this.brandId,
    this.brandName,
    this.sideEffects,
    this.saltComposition,
    this.description,
    this.imageUrl,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineToJson(this);
}
