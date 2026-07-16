import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/filter_doctor_sheet.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/search_doctor_card.dart';

import '../../../utils/string_utils.dart';

class SearchDoctorScreen extends StatelessWidget {
  const SearchDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We can use the existing PatientHomeController or create a separate one.
    // For now, reusing/finding existing might be easiest if we want to share data,
    // but a search screen usually has its own state. Let's use Get.find or init checks.
    final controller = Get.put(PatientHomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back, Search, Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back_ios,
                        color: Colors.black87, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Colors.deepPurple.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: controller.searchController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "${StringUtils.searchHint} ${StringUtils.doctor}...",
                                hintStyle: TextStyleConst.mediumTextStyle(
                                    Colors.grey, 16),
                                border: InputBorder.none,
                              ),
                              onChanged: (val) {
                                controller.searchDoctors(query: val);
                              },
                            ),
                          ),
                          // Filter Icon
                          GestureDetector(
                            onTap: () async {
                              final result = await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => SafeArea(child: const FilterDoctorSheet()),
                              );

                              if (result != null && result is Map) {
                                controller.searchDoctors(
                                  query: controller.searchController
                                      .text, // Use current text
                                  gender: result['gender'],
                                  minPrice: result['min_price'],
                                  maxPrice: result['max_price'],
                                  departmentId: result['department_id'],
                                  sort: result['sort'],
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child:
                                  const Icon(Icons.tune, color: Colors.black87),
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Results Count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Obx(() {
                    final dynamic searchModel = controller.searchResults.value;

                    if (searchModel != null) {
                      return Text(
                        "${searchModel.data?.length ?? 0} Results Found.",
                        style: TextStyleConst.boldTextStyle(Colors.black87, 16),
                      );
                    } else {
                      // Default view: show up to 2 doctors
                      final defaultCount = controller.allDoctors.take(2).length;
                      return Text(
                        "$defaultCount Results Found.",
                        style: TextStyleConst.boldTextStyle(Colors.black87, 16),
                      );
                    }
                  }),
                ],
              ),
            ),

            // List
            Expanded(
              child: Obx(() {
                final dynamic searchModel = controller.searchResults.value;

                if (controller.isSearching.value) {
                  return  Center(
                      child: CircularProgressIndicator(
                          color: ColorConst.primaryColor));
                }

                List<dynamic> itemsToDisplay = [];

                if (searchModel != null) {
                  // User performed a search
                  if (searchModel.data == null || searchModel.data!.isEmpty) {
                    return Center(child: Text(StringUtils.noDoctorsAvailable));
                  }
                  itemsToDisplay = searchModel.data!;
                } else {
                  // Default view: show up to 2 doctors from allDoctors
                  itemsToDisplay = controller.allDoctors.take(2).toList();
                  if (itemsToDisplay.isEmpty) {
                    return Center(child: Text(StringUtils.noDoctorsAvailable));
                  }
                }

                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  itemCount: itemsToDisplay.length,
                  itemBuilder: (context, index) {
                    final dynamic doctor = itemsToDisplay[index];
                    return SearchDoctorCard(
                      doctor: doctor,
                      onTap: () {
                        int? docId;

                        // Extract ID and Dept based on type
                        if (doctor.runtimeType.toString() == 'DoctorListData') {
                          docId = doctor.id;
                        } else {
                          // Assume GetDoctorData
                          try {
                            docId = doctor.id;
                          } catch (e) {/* ignore */}
                        }

                        context.push('/doctor-details', extra: {
                          'doctor': doctor,
                          'doctorId': docId!,
                        });
                      },
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
