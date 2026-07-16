class CartItemModel {
  final int medicineId;
  final String name;
  final String image;
  final double unitPrice;
  int quantity;

  CartItemModel({
    required this.medicineId,
    required this.name,
    required this.image,
    required this.unitPrice,
    required this.quantity,
  });

  double get serviceTax => 0.0; // Implement if needed
  double get totalPrice => unitPrice * quantity;

  // JSON Serialization for Shared Preferences
  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'name': name,
      'image': image,
      'unitPrice': unitPrice,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      medicineId: json['medicineId'],
      name: json['name'],
      image: json['image'] ?? '',
      unitPrice: (json['unitPrice'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }
}
