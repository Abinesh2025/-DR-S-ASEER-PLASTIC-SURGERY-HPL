import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_model.dart';

import '../../../controller/patient/cart_controller.dart';
import '../cart/cart_screen.dart';
import '../../../component/common_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MedicineDetailsScreen extends StatefulWidget {
  final MedicineModel medicine;
  const MedicineDetailsScreen({super.key, required this.medicine});

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  late final CartController cartController;
  Worker? _cartWorker;

  int _quantity = 1;

  // double get _totalAmount =>
  //     (widget.medicine.sellingPrice ?? 0.0) * _quantity;
  //
  // void _increment() => setState(() => _quantity++);
  //
  // void _decrement() {
  //   if (_quantity > 1) setState(() => _quantity--);
  // }

  @override
  void initState() {
    super.initState();
    cartController = Get.put(CartController());

    // ✅ initial quantity from cart
    final q = cartController.getQuantityByMedicineId(widget.medicine.id);
    _quantity = (q == 0) ? 1 : q;

    // ✅ whenever cart changes, update details quantity
    _cartWorker = ever(cartController.cartItems, (_) {
      final newQ = cartController.getQuantityByMedicineId(widget.medicine.id);
      final updated = (newQ == 0) ? 1 : newQ;

      if (mounted && updated != _quantity) {
        setState(() => _quantity = updated);
      }
    });
  }

  @override
  void dispose() {
    _cartWorker?.dispose();
    super.dispose();
  }
  double get _totalAmount =>
      (widget.medicine.sellingPrice ?? 0.0) * _quantity;

  void _increment() {
    // ✅ if item already in cart => update cart (syncs cart screen)
    final inCart = cartController.getQuantityByMedicineId(widget.medicine.id) > 0;
    if (inCart) {
      cartController.incrementByMedicine(widget.medicine);
    } else {
      setState(() => _quantity++);
    }
  }

  void _decrement() {
    final inCart = cartController.getQuantityByMedicineId(widget.medicine.id) > 0;
    if (inCart) {
      cartController.decrementByMedicine(widget.medicine);
    } else {
      if (_quantity > 1) setState(() => _quantity--);
    }
  }
  void safeBack() {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
    }
  }
  @override
  Widget build(BuildContext context) {
    final medicine = widget.medicine;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => safeBack(),
        ),
        actions: [
          Obx(() {
            final controller = Get.find<CartController>();
            final count = controller.cartItems.length;

            return Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.black),
                  onPressed: () {
                    Get.to(() => const CartScreen());
                  },
                ),

                // 🔴 Badge
                if (count > 0)
                  Positioned(
                    right:7,
                    top: 7,
                    child: Container(
                      width: 14,
                      height: 14,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 6,
                        minHeight: 6,
                      ),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 6,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Center(
                    child: Hero(
                      tag: "med_${medicine.id}",
                      child: medicine.imageUrl != null &&
                          medicine.imageUrl!.isNotEmpty
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          medicine.imageUrl!,
                          height: 200,
                          fit: BoxFit.contain,
                          errorBuilder: (c, o, s) => Container(
                              height: 200,
                              width: 200,
                              color: Colors.grey.shade100,
                              child: const Icon(Icons.medication,
                                  size: 80, color: Colors.grey)),
                        ),
                      )
                          : Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(Icons.medication,
                              size: 80, color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Name and Brand
                  Text(
                    medicine.name,
                    style: TextStyleConst.boldTextStyle(Colors.black, 22),
                  ),
                  if (medicine.brandName?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 5),
                    Text(
                      "by ${medicine.brandName}",
                      style: TextStyleConst.mediumTextStyle(Colors.grey, 14),
                    ),
                  ],
                  const SizedBox(height: 15),

                  // Price and Stock
                  Row(
                    children: [
                      Text(
                        "₹${(medicine.sellingPrice ?? 0.0).toStringAsFixed(0)}",
                        style: TextStyleConst.boldTextStyle(
                            ColorConst.primaryColor, 24),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: (medicine.availableQuantity ?? 0) > 0
                              ?  ColorConst.primaryColor.withOpacity(0.1)
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          (medicine.availableQuantity ?? 0) > 0
                              ? "In Stock (${medicine.availableQuantity})"
                              : "Out of Stock",
                          style: TextStyleConst.mediumTextStyle(
                            (medicine.availableQuantity ?? 0) > 0
                                ?  ColorConst.primaryColor
                                : Colors.red.shade700,
                            12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Category
                  if (medicine.categoryName?.isNotEmpty ?? false) ...[
                    _buildInfoRow(
                        Icons.category, "Category", medicine.categoryName!),
                    const SizedBox(height: 12),
                  ],

                  const Divider(height: 30),

                  // Description
                  Text(
                    "Description",
                    style: TextStyleConst.boldTextStyle(Colors.black87, 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    medicine.description ?? 'No description available.',
                    style: TextStyleConst.regularTextStyle(
                        Colors.grey.shade600, 14),
                  ),
                  const SizedBox(height: 30),

                ],
              ),
            ),
          ),
          // ─── Fixed Bottom: Add To Cart ───────────────────────────────────

        ],
      ),
      bottomNavigationBar: SafeArea(child:  Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Total Amount row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Amount:",
                  style: TextStyleConst.boldTextStyle(
                      ColorConst.primaryColor, 15),
                ),
                Text(
                  "₹${_totalAmount.toStringAsFixed(2)}",
                  style: TextStyleConst.boldTextStyle(
                      ColorConst.primaryColor, 15),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Quantity selector + Add To Cart button
            Row(
              children: [
                // Decrement button
                GestureDetector(
                  onTap: _decrement,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.grey.shade300, width: 1.5),
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.remove,
                        size: 18, color: Colors.black87),
                  ),
                ),

                // Quantity display
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "$_quantity",
                    style: TextStyleConst.boldTextStyle(
                        Colors.black, 16),
                  ),
                ),

                // Increment button
                GestureDetector(
                  onTap: _increment,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConst.primaryColor,
                    ),
                    child: const Icon(Icons.add,
                        size: 18, color: Colors.white),
                  ),
                ),

                const SizedBox(width: 16),

                // Add To Cart button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // ❌ Quantity check
                        if (_quantity <= 0) {
                          DisplaySnackBar.displaySnackBar(
                            "Please select quantity",
                            2,
                            Colors.red,
                          );
                          return;
                        }

                        // ❌ Stock check
                        if ((medicine.availableQuantity ?? 0) <= 0) {
                          DisplaySnackBar.displaySnackBar(
                            "Out of stock",
                            2,
                            Colors.orange,
                          );
                          return;
                        }

                        // ❌ Price check
                        // if ((medicine.sellingPrice ?? 0) <= 0) {
                        //   DisplaySnackBar.displaySnackBar(
                        //     "Please add the valid price",
                        //     2,
                        //     Colors.red,
                        //   );
                        //   return;
                        // }

                        // ✅ Add to cart
                        cartController.setQuantityFromDetails(medicine, _quantity);
                        Get.to(() => const CartScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConst.primaryColor,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Add To Cart",
                        style: TextStyleConst.boldTextStyle(
                          Colors.white,
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: ColorConst.primaryColor),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: TextStyleConst.mediumTextStyle(Colors.grey, 14),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyleConst.boldTextStyle(Colors.black87, 14),
          ),
        ),
      ],
    );
  }
}