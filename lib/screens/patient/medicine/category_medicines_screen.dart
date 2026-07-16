import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/medicine_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/medicine_details_screen.dart';

class CategoryMedicinesScreen extends StatefulWidget {
  final int categoryId;
  final String? initialCategoryName;

  const CategoryMedicinesScreen({
    super.key,
    required this.categoryId,
    this.initialCategoryName,
  });

  @override
  State<CategoryMedicinesScreen> createState() =>
      _CategoryMedicinesScreenState();
}

class _CategoryMedicinesScreenState extends State<CategoryMedicinesScreen> {
  final MedicineController _controller = Get.find<MedicineController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchCategoryDetails(widget.categoryId);
      // Ensure we have medicines loaded, if likely not, we might want to fetch them but usually home loads them.
      if (_controller.medicines.isEmpty) {
        _controller.fetchMedicines();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Obx(() {
          final details = _controller.selectedCategoryDetails.value;
          final name =
              details?.name ?? widget.initialCategoryName ?? "Category";

          if (_controller.isCategoryDetailsLoading.value && details == null) {
            return Text(widget.initialCategoryName ?? "Loading...",
                style: TextStyleConst.boldTextStyle(Colors.black, 20));
          }

          return Text(
            name,
            style: TextStyleConst.boldTextStyle(Colors.black, 20),
          );
        }),
      ),
      body: Obx(() {
        if (_controller.isCategoryDetailsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final details = _controller.selectedCategoryDetails.value;
        final medicinesList = details?.medicines ?? [];

        if (medicinesList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.medication_outlined,
                    size: 64, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  "No medicines found in this category",
                  style: TextStyleConst.mediumTextStyle(Colors.grey, 16),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: medicinesList.length,
          itemBuilder: (context, index) {
            final medicine = medicinesList[index];
            return GestureDetector(
              onTap: () {
                // Map the Medicine (from Category Detail) to MedicineModel (expected by Details Screen)
                final medicineModel = MedicineModel(
                  id: medicine.id ?? 0,
                  name: medicine.name ?? "",
                  sellingPrice: medicine.sellingPrice,
                  description: medicine.description,
                  brandName: medicine.brandName,
                  saltComposition: medicine.saltComposition,
                  sideEffects: medicine.sideEffects,
                  imageUrl: medicine.imageUrl,
                  categoryId: widget.categoryId,
                  categoryName: details?.name,
                  availableQuantity: 10, // Default for now
                );

                Get.to(() => MedicineDetailsScreen(medicine: medicineModel));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade50,
                      ),
                      child: medicine.imageUrl != null &&
                              medicine.imageUrl!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                medicine.imageUrl!,
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
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicine.name ?? "Unknown",
                            style:
                                TextStyleConst.boldTextStyle(Colors.black, 16),
                          ),
                          const SizedBox(height: 4),
                          if (medicine.brandName?.isNotEmpty ?? false)
                            Text(
                              medicine.brandName!,
                              style: TextStyleConst.mediumTextStyle(
                                  Colors.grey, 12),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            "₹${(medicine.sellingPrice ?? 0.0).toStringAsFixed(0)}",
                            style: TextStyleConst.boldTextStyle(
                                ColorConst.primaryColor, 14),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
