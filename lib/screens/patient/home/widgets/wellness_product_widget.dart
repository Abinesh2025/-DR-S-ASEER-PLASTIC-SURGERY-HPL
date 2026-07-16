import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/medicine_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/all_medicines_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/medicine_details_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/skeleton_loading_widgets.dart';

import '../../../../utils/string_utils.dart';

class WellnessProductWidget extends StatelessWidget {
  const WellnessProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MedicineController>()) {
      Get.put(MedicineController());
    }
    final controller = Get.find<MedicineController>();

    return Obx(() {
      // Hide the entire section if it's done loading and there's no data
      if (!controller.isLoading.value && controller.filteredMedicines.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(builder: (context) {
                  final selectedId = controller.selectedCategoryId.value;
                  String title = StringUtils.pharmacyProducts;
                  if (selectedId != null) {
                    final category = controller.categories
                        .firstWhereOrNull((c) => c.id == selectedId);
                    if (category != null) {
                      if (category.name != null) {
                        if (category.name!.toLowerCase() == "pharmacy products" ||
                            category.name!.toLowerCase() == "wellness") {
                          title = StringUtils.pharmacyProducts;
                        } else {
                          title = category.name ?? StringUtils.products;
                        }
                      } else {
                        title = StringUtils.products;
                      }
                    }
                  }
                  return Text(
                    title,
                    style: TextStyleConst.boldTextStyle(
                      ColorConst.blackColor,
                      18,
                    ),
                  );
                }),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const AllMedicinesScreen());
                  },
                  child: Text(
                    StringUtils.viewAll,
                    style: TextStyleConst.mediumTextStyle(
                      ColorConst.primaryColor,
                      14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 220, // Reduced height for tighter card
            child: controller.isLoading.value
                ? ListView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) => const ProductSkeleton(),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.filteredMedicines.length > 4
                        ? 4
                        : controller.filteredMedicines.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredMedicines[index];
                      return _buildProductCard(product);
                    },
                  ),
          ),
        ],
      );
    });
  }

  Widget _buildProductCard(MedicineModel product) {
    return GestureDetector(
      onTap: () {
        Get.to(() => MedicineDetailsScreen(medicine: product));
      },
      child: Container(
        width: 160, // Increased width
        margin: const EdgeInsets.only(right: 15, bottom: 8, top: 4, left: 2),
        decoration: BoxDecoration(
          color: ColorConst.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.15), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 120, // Taller image section
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: product.imageUrl != null &&
                              product.imageUrl!.isNotEmpty
                          ? Image.network(
                              product.imageUrl!,
                              fit: BoxFit.contain,
                              errorBuilder: (c, o, s) => const Icon(
                                  Icons.medication_liquid_rounded,
                                  size: 40,
                                  color: Colors.grey),
                            )
                          : const Icon(Icons.medication_liquid_rounded,
                              size: 40, color: Colors.grey),
                    ),
                  ),
                  if (product.categoryName?.isNotEmpty ?? false)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color:  ColorConst.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          product.categoryName!.capitalizeFirst ?? '',
                          style: TextStyleConst.boldTextStyle(
                              ColorConst.primaryColor, 9),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8), // Reduced vertical padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Changed to start to reduce spacing
                  children: [
                    if (product.brandName?.isNotEmpty ?? false)
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 2), // Tighten spacing
                        child: Text(
                          product.brandName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConst.mediumTextStyle(
                              Colors.grey.shade500, 10),
                        ),
                      ),
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConst.boldTextStyle(
                              ColorConst.blackColor, 14)
                          .copyWith(height: 1.1),
                    ),
                    const SizedBox(height: 8), // Reduced fixed spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "₹${(product.sellingPrice ?? 0.0).toStringAsFixed(0)}",
                          style: TextStyleConst.boldTextStyle(
                              ColorConst.blackColor, 16),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration:  BoxDecoration(
                            color: ColorConst.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
