import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/medicine_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/medicine_details_screen.dart';

class SearchMedicineScreen extends StatefulWidget {
  const SearchMedicineScreen({super.key});

  @override
  State<SearchMedicineScreen> createState() => _SearchMedicineScreenState();
}

class _SearchMedicineScreenState extends State<SearchMedicineScreen> {
  final TextEditingController _searchController = TextEditingController();
  late MedicineController _medicineController;

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<MedicineController>()) {
      Get.put(MedicineController());
    }
    _medicineController = Get.find<MedicineController>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    // Reset filter when leaving
    _medicineController.searchMedicines('');
    super.dispose();
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
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: (query) {
            _medicineController.searchMedicines(query);
            setState(() {}); // For clear button visibility
          },
          decoration: InputDecoration(
            hintText: "Search Medicines...",
            border: InputBorder.none,
            hintStyle: TextStyleConst.mediumTextStyle(Colors.grey, 16),
          ),
          style: TextStyleConst.mediumTextStyle(Colors.black, 16),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _searchController.clear();
                _medicineController.searchMedicines('');
                setState(() {});
              },
            ),
        ],
      ),
      body: Obx(() {
        if (_medicineController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final medicines = _medicineController.filteredMedicines;

        if (medicines.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  "No medicines found",
                  style: TextStyleConst.mediumTextStyle(Colors.grey, 16),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: medicines.length,
          itemBuilder: (context, index) {
            final medicine = medicines[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => MedicineDetailsScreen(medicine: medicine));
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
                            medicine.name,
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
