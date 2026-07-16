import 'dart:convert';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/cart/cart_item_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/order_model/order_create_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/main.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import './home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/checkout/order_success_screen.dart';

class CartController extends GetxController {
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  RxDouble subtotal = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble deliveryCharge = 5.0.obs;
  RxDouble discount = 0.0.obs;
  RxDouble grandTotal = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  CartItemModel? getItemByMedicineId(dynamic medicineId) {
    final idx = cartItems.indexWhere((e) => e.medicineId == medicineId);
    if (idx == -1) return null;
    return cartItems[idx];
  }

  int getQuantityByMedicineId(dynamic medicineId) {
    return getItemByMedicineId(medicineId)?.quantity ?? 0;
  }

// ✅ set exact quantity (if not exist, add it)
  void setQuantityFromDetails(MedicineModel medicine, int qty) {
    final idx = cartItems.indexWhere((e) => e.medicineId == medicine.id);

    if (idx != -1) {
      cartItems[idx].quantity = qty;
      cartItems.refresh();
    } else {
      cartItems.add(CartItemModel(
        medicineId: medicine.id,
        name: medicine.name,
        image: medicine.imageUrl ?? '',
        unitPrice: medicine.sellingPrice ?? 0.0,
        quantity: qty,
      ));
    }

    saveCart();
  }

// ✅ increment/decrement by medicine id (used from details screen)
  void incrementByMedicine(MedicineModel medicine) {
    final current = getQuantityByMedicineId(medicine.id);
    final next = current == 0 ? 1 : current + 1;
    setQuantityFromDetails(medicine, next);
  }

  void decrementByMedicine(MedicineModel medicine) {
    final current = getQuantityByMedicineId(medicine.id);
    if (current <= 1) {
      // optional: keep min 1 if already in cart, OR remove item
      // remove if you want:
      // final idx = cartItems.indexWhere((e) => e.medicineId == medicine.id);
      // if (idx != -1) cartItems.removeAt(idx);
      // saveCart();
      return;
    }
    setQuantityFromDetails(medicine, current - 1);
  }

  void loadCart() {
    String? cartJson = PreferenceUtils.getStringValue("user_cart");
    if (cartJson.isNotEmpty) {
      try {
        List<dynamic> decoded = jsonDecode(cartJson);
        cartItems.value =
            decoded.map((e) => CartItemModel.fromJson(e)).toList();
        calculateTotals();
      } catch (e) {
        print("Error loading cart: $e");
        cartItems.clear();
      }
    }
  }

  void saveCart() {
    String cartJson = jsonEncode(cartItems.map((e) => e.toJson()).toList());
    PreferenceUtils.setStringValue("user_cart", cartJson);
    calculateTotals();
  }

  void addToCart(MedicineModel medicine, int quantity) {
    // Check if same medicine already exists in cart
    int existingIndex =
        cartItems.indexWhere((item) => item.medicineId == medicine.id);

    if (existingIndex != -1) {
      // Update quantity
      cartItems[existingIndex].quantity += quantity;
      cartItems.refresh();
    } else {
      // Add new
      cartItems.add(CartItemModel(
        medicineId: medicine.id,
        name: medicine.name,
        image: medicine.imageUrl ?? '',
        unitPrice: medicine.sellingPrice ?? 0.0,
        quantity: quantity,
      ));
    }

    saveCart();
    DisplaySnackBar.displaySnackBar(
        "${medicine.name} added successfully.", 3, ColorConst.primaryColor);
  }

  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
    saveCart();
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    }
    saveCart();
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
    saveCart();
  }

  void clearCart() {
    cartItems.clear();
    saveCart();
  }

  void calculateTotals() {
    double sub = 0.0;
    for (var item in cartItems) {
      sub += item.totalPrice;
    }
    subtotal.value = sub;

    // Simple tax logic, 5%
    tax.value = sub * 0.05;

    //grandTotal.value = sub + tax.value + deliveryCharge.value - discount.value;
    grandTotal.value = sub;
  }

  void placeOrder(context) {
    if (cartItems.isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Your cart is empty", 3, ColorConst.redColor);
      return;
    }

    if (VariableUtils.address.value.trim().isEmpty ||
        VariableUtils.city.value.trim().isEmpty ||
        VariableUtils.pincode.value.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter a valid delivery address, city and pincode",
          3,
          ColorConst.redColor);
      return;
    }

    CommonLoader.showLoader();

    final request = OrderCreateRequest(
      items: cartItems
          .map((e) => OrderItemRequest(
                medicineId: e.medicineId,
                quantity: e.quantity,
              ))
          .toList(),
      totalAmount: grandTotal.value,
      address: VariableUtils.address.value,
      city: VariableUtils.city.value,
      pincode: VariableUtils.pincode.value,
    );

    StringUtils.client
        .orderCreate(
      PreferenceUtils.getStringValue("token"),
      request,
    )
        .then((value) {
      CommonLoader.hideLoader();
      if (value.success == true) {
        clearCart();
        Get.offAll(() => OrderSuccessScreen(
          message: value.message ?? "Your order has been placed successfully.",
          orderId: value.data?.orderId?.toString() ?? "",
        ));
      } else {
        DisplaySnackBar.displaySnackBar(
            value.message ?? "Failed to place order", 3, ColorConst.redColor);
      }
    }).onError((DioException error, stackTrace) {
      CommonLoader.hideLoader();
      DisplaySnackBar.displaySnackBar(
          error.message ?? "An error occurred", 3, ColorConst.redColor);
    });
  }

  void _refreshHomeData() {
    if (Get.isRegistered<HomeController>()) {
      final hc = Get.find<HomeController>();
      hc.changeBottomNavIndex(0);
    }
    if (Get.isRegistered<PatientHomeController>()) {
      Get.find<PatientHomeController>().refreshData();
    }
  }
}
