import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/cart_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/checkout/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text("My Cart",
            style: TextStyleConst.boldTextStyle(Colors.black, 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined,
                    size: 80, color: Colors.grey.shade300),
                const SizedBox(height: 20),
                Text("Your Cart is Empty",
                    style: TextStyleConst.mediumTextStyle(Colors.grey, 16)),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Cart Items List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4))
                        ]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: item.image.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item.image,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, o, s) => const Icon(
                                        Icons.medication,
                                        size: 40,
                                        color: Colors.grey),
                                  ),
                                )
                              : const Icon(Icons.medication,
                                  size: 40, color: Colors.grey),
                        ),
                        const SizedBox(width: 15),
                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name,
                                  style: TextStyleConst.boldTextStyle(
                                      Colors.black87, 16),
                                  maxLines: 2),
                              const SizedBox(height: 10),
                              Text("₹${item.unitPrice.toStringAsFixed(0)}",
                                  style: TextStyleConst.boldTextStyle(
                                      ColorConst.primaryColor, 16)),
                            ],
                          ),
                        ),
                        // Quantity
                        Column(
                          children: [
                            IconButton(
                              onPressed: () => controller.removeItem(index),
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.grey, size: 20),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        controller.decrementQuantity(index),
                                    child:  Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(Icons.remove,
                                          size: 16,
                                          color: ColorConst.primaryColor),
                                    ),
                                  ),
                                  Text("${item.quantity}",
                                      style: TextStyleConst.boldTextStyle(
                                          Colors.black, 14)),
                                  InkWell(
                                    onTap: () =>
                                        controller.incrementQuantity(index),
                                    child:  Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(Icons.add,
                                          size: 16,
                                          color: ColorConst.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bill Details
         
          ],
        );
      }),
      bottomNavigationBar: SafeArea(child:    Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, -5))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // _billRow("Subtotal",
            //     "\$${controller.subtotal.value.toStringAsFixed(2)}"),
            // const SizedBox(height: 10),
            // _billRow("Tax (5%)",
            //     "\$${controller.tax.value.toStringAsFixed(2)}"),
            // const SizedBox(height: 10),
            // _billRow("Delivery Charge",
            //     "\$${controller.deliveryCharge.value.toStringAsFixed(2)}"),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 15),
            //   child: Divider(),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                    style:
                    TextStyleConst.boldTextStyle(Colors.black, 18)),
                Text(
                    "\₹${controller.grandTotal.value.toStringAsFixed(2)}",
                    style: TextStyleConst.boldTextStyle(
                        ColorConst.primaryColor, 20)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const CheckoutScreen());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: Text("Checkout",
                    style:
                    TextStyleConst.boldTextStyle(Colors.white, 16)),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget _billRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyleConst.mediumTextStyle(Colors.grey.shade600, 14)),
        Text(value, style: TextStyleConst.boldTextStyle(Colors.black, 14)),
      ],
    );
  }
}
