import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/medicine_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/medicine_details_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/search_medicine_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/widgets/horizontal_medicine_card.dart';

import '../../../utils/string_utils.dart';

class AllMedicinesScreen extends StatelessWidget {
  const AllMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MedicineController>()) {
      Get.put(MedicineController());
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: Text(
          StringUtils.pharmacyProducts,
          style: TextStyleConst.boldTextStyle(Colors.black87, 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () => Get.to(() => const SearchMedicineScreen()),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: GetX<MedicineController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return  Center(
              child: CircularProgressIndicator(
                color: ColorConst.primaryColor,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.fetchMedicines(),
            color: ColorConst.primaryColor,
            child: controller.filteredMedicines.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.medication_outlined,
                            size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          "No products found",
                          style:
                              TextStyleConst.mediumTextStyle(Colors.grey, 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemCount: controller.filteredMedicines.length,
                    itemBuilder: (context, index) {
                      final medicine = controller.filteredMedicines[index];
                      return HorizontalMedicineCard(
                        medicine: medicine,
                        onTap: () {
                          Get.to(
                              () => MedicineDetailsScreen(medicine: medicine));
                        },
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
