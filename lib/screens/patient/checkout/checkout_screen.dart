import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/cart_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/home_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/checkout/location_picker_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text("Checkout",
            style: TextStyleConst.boldTextStyle(Colors.black, 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Section
            Text("Delivery Address",
                style: TextStyleConst.boldTextStyle(Colors.black, 16)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
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
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.location_on, color: Colors.orange),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Home",
                            style:
                                TextStyleConst.boldTextStyle(Colors.black, 14)),
                        Obx(() => Text(
                            "${VariableUtils.address.value}, ${VariableUtils.city.value}, ${VariableUtils.pincode.value}",
                            style: TextStyleConst.mediumTextStyle(
                                Colors.grey, 12))),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var result =
                          await Get.to(() => const LocationPickerScreen());
                      if (result != null) {
                        VariableUtils.address.value = result['address'] ?? "";
                        VariableUtils.city.value = result['city'] ?? "";
                        VariableUtils.pincode.value = result['pincode'] ?? "";
                      }
                    },
                    child: const Icon(Icons.edit, color: Colors.grey, size: 20),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Payment Method
            // Text("Payment Method",
            //     style: TextStyleConst.boldTextStyle(Colors.black, 16)),
            // const SizedBox(height: 10),
            // _paymentOption("Credit Card", Icons.credit_card, true),
            // _paymentOption("PayPal", Icons.paypal, false),
            // _paymentOption("Apple Pay", Icons.apple, false),
            //
            // const SizedBox(height: 25),

            // Order Summary
            Text("Order Summary",
                style: TextStyleConst.boldTextStyle(Colors.black, 16)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Obx(() => Column(
                    children: [
                      // _summaryRow("Subtotal",
                      //     "\$${controller.subtotal.value.toStringAsFixed(2)}"),
                      // const SizedBox(height: 10),
                      // _summaryRow("Tax",
                      //     "\$${controller.tax.value.toStringAsFixed(2)}"),
                      // const SizedBox(height: 10),
                      // _summaryRow("Delivery",
                      //     "\$${controller.deliveryCharge.value.toStringAsFixed(2)}"),
                      // const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",
                              style: TextStyleConst.boldTextStyle(
                                  Colors.black, 16)),
                          Text(
                              "\₹${controller.grandTotal.value.toStringAsFixed(2)}",
                              style: TextStyleConst.boldTextStyle(
                                  ColorConst.primaryColor, 18)),
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))
          ]),
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                controller.placeOrder(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConst.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: Text("Place Order",
                  style: TextStyleConst.boldTextStyle(Colors.white, 16)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _paymentOption(String name, IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: ColorConst.primaryColor)
            : Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? ColorConst.primaryColor : Colors.grey),
          const SizedBox(width: 15),
          Expanded(
              child: Text(name,
                  style: TextStyleConst.mediumTextStyle(Colors.black87, 14))),
          if (isSelected)
             Icon(Icons.check_circle,
                color: ColorConst.primaryColor, size: 20)
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyleConst.mediumTextStyle(Colors.grey, 14)),
        Text(value, style: TextStyleConst.boldTextStyle(Colors.black, 14)),
      ],
    );
  }
}
