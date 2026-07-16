import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/medicine_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/wellness_product_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/search_medicine_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/category_medicines_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/all_categories_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/skeleton_loading_widgets.dart';

import '../../../utils/string_utils.dart';

class MedicinesScreen extends StatefulWidget {
  const MedicinesScreen({super.key});

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  late final MedicineController controller;

  @override
  void initState() {
    super.initState();

    // Register only if not registered
    if (!Get.isRegistered<MedicineController>()) {
      controller = Get.put(MedicineController());
    } else {
      controller = Get.find<MedicineController>();
    }

    // Refresh automatically when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });
  }

  Future<void> _refreshPage() async {
    await controller.fetchCategories();
    await controller.fetchMedicines();
  }

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.find<HomeController>().scaffoldKey.currentState?.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConst.blackColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.menu,
                  color: ColorConst.blackColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          StringUtils.medicines,
          style: TextStyleConst.boldTextStyle(Colors.black, 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              Get.to(() => const SearchMedicineScreen());
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _refreshPage(); // Fetch both on pull-to-refresh
        },
        color: ColorConst.primaryColor,
        child: Obx(() {
          // Check if BOTH medicines and categories are empty
          final isCategoriesEmpty = controller.categories.isEmpty && !controller.isCategoriesLoading.value;

          // Assuming you have a 'medicines' list in your controller.
          // If you have an `isMedicinesLoading` boolean, you can add it to this condition too!
          final isMedicinesEmpty = controller.medicines.isEmpty;

          if (isCategoriesEmpty && isMedicinesEmpty) {
            // DISPLAY "NO MEDICINE FOUND" IF BOTH ARE EMPTY
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          Icons.medical_information_outlined,
                          size: 80,
                          color: Colors.grey.shade300
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No medicines found",
                        style: TextStyleConst.mediumTextStyle(Colors.grey.shade600, 16),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          // NORMAL UI DISPLAY
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Browse Medicines Section
                _buildBrowseMedicines(context),

                const SizedBox(height: 20),

                // Wellness Product Section (Pharmacy Products)
                const WellnessProductWidget(),

                const SizedBox(height: 120),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBrowseMedicines(BuildContext context) {
    final controller = Get.find<MedicineController>();

    // Reset selection so WellnessProductWidget shows all products
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.selectedCategoryId.value != null) {
        controller.selectCategory(null);
      }
    });

    // Wrapped the entire column in Obx so the Title row hides too
    return Obx(() {
      // HIDE THE CATEGORY SECTION COMPLETELY IF EMPTY
      if (controller.categories.isEmpty && !controller.isCategoriesLoading.value) {
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
                Text(
                  StringUtils.categories,
                  style: TextStyleConst.boldTextStyle(Colors.black, 18),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const AllCategoriesScreen());
                  },
                  child: Text(
                    StringUtils.viewAll,
                    style: TextStyleConst.mediumTextStyle(
                        ColorConst.primaryColor, 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),

          if (controller.isCategoriesLoading.value)
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.8,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: 4,
              itemBuilder: (context, index) => const Skeleton(borderRadius: 20),
            )
          else
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.8,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: controller.categories.length > 4
                  ? 4
                  : controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];

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
                        Positioned(
                          right: -15,
                          bottom: -15,
                          child: Icon(
                            bgIcon,
                            size: 90,
                            color: Colors.white.withOpacity(0.15),
                          ),
                        ),
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
        ],
      );
    });
  }
}