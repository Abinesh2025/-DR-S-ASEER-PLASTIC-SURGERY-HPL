import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/medicine_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/category_medicines_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MedicineController>()) {
      Get.put(MedicineController());
    }
    final controller = Get.find<MedicineController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "All Categories",
          style: TextStyleConst.boldTextStyle(Colors.black, 20),
        ),
      ),
      body: Obx(() {
        if (controller.isCategoriesLoading.value) {
          return  Center(
              child: CircularProgressIndicator(color: ColorConst.primaryColor));
        }

        if (controller.categories.isEmpty) {
          return Center(
            child: Text(
              "No categories available",
              style:
                  TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 16),
            ),
          );
        }

        // We wrap GridView in a RefreshIndicator matching the design paradigms
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchMedicines();
          },
          color: ColorConst.primaryColor,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.8, // Rectangular aspect ratio for wider cards
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];

              // Vibrant gradient color palettes
              final gradients = [
                const LinearGradient(
                  colors: [Color(0xFF8A2BE2), Color(0xFF6A5ACD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                const LinearGradient(
                  colors: [Color(0xFFFFA000), Color(0xFFFFCA28)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                const LinearGradient(
                  colors: [Color(0xFFFF4081), Color(0xFFFF80AB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                const LinearGradient(
                  colors: [Color(0xFF03A9F4), Color(0xFF4FC3F7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                const LinearGradient(
                  colors: [Color(0xFF00C853), Color(0xFF69F0AE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                const LinearGradient(
                  colors: [Color(0xFFFF5252), Color(0xFFFF8A80)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ];

              final gradient = gradients[index % gradients.length];

              final icons = [
                Icons.medical_services_rounded,
                Icons.favorite_rounded,
                Icons.local_pharmacy_rounded,
                Icons.medication_liquid_rounded,
                Icons.healing_rounded,
                Icons.sanitizer_rounded,
              ];
              final bgIcon = icons[index % icons.length];

              return GestureDetector(
                onTap: () {
                  Get.to(() => CategoryMedicinesScreen(
                        categoryId: category.id ?? 0,
                        initialCategoryName: category.name,
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: gradient.colors.first.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      // Large Watermark Icon
                      Positioned(
                        right: -15,
                        bottom: -15,
                        child: Icon(
                          bgIcon,
                          size: 90,
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, right: 8, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              category.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleConst.boldTextStyle(
                                  Colors.white, 16),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 3,
                              width: 20,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
