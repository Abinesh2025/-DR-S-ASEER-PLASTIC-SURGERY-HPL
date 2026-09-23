import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/visiting_consultant/visiting_consultant_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/create_visiting_request_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/visiting_consultant_details_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/visiting_requests_list_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/widgets/visiting_consultant_card.dart';

class VisitingConsultantDirectoryScreen extends StatefulWidget {
  const VisitingConsultantDirectoryScreen({super.key});

  @override
  State<VisitingConsultantDirectoryScreen> createState() => _VisitingConsultantDirectoryScreenState();
}

class _VisitingConsultantDirectoryScreenState extends State<VisitingConsultantDirectoryScreen> {
  final VisitingConsultantController controller = Get.put(VisitingConsultantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      appBar: CommonAppBar(
        title: "Visiting Specialists",
        leadIcon: const Icon(Icons.arrow_back_rounded, color: ColorConst.blackColor),
        leadOnTap: () => Navigator.of(context).maybePop(),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined, color: ColorConst.blackColor),
            tooltip: "My Requests",
            onPressed: () {
              Get.to(() => const VisitingRequestsListScreen());
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchConsultants(),
        color: ColorConst.primaryColor,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          slivers: [
            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: ColorConst.borderGreyColor),
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: controller.onSearchChanged,
                    decoration: InputDecoration(
                      hintText: "Search doctor, specialty, department...",
                      hintStyle: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 13),
                      prefixIcon: const Icon(Icons.search, color: ColorConst.hintGreyColor, size: 20),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                controller.searchController.clear();
                                controller.onSearchChanged("");
                              },
                            )
                          : const SizedBox.shrink()),
                    ),
                  ),
                ),
              ),
            ),

            // Department Horizontal Filter Buttons
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.departments.length <= 1) return const SizedBox.shrink();
                return Container(
                  height: 38,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.departments.length,
                    itemBuilder: (context, index) {
                      final dept = controller.departments[index];
                      final isSelected = controller.selectedDepartment.value.toLowerCase() == dept.toLowerCase();
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => controller.selectDepartment(dept),
                            borderRadius: BorderRadius.circular(20),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? ColorConst.primaryColor : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? ColorConst.primaryColor : ColorConst.borderGreyColor,
                                  width: 1,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: ColorConst.primaryColor.withOpacity(0.28),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                dept,
                                style: TextStyleConst.mediumTextStyle(
                                  isSelected ? Colors.white : ColorConst.blackColor,
                                  12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),

            // Consultant List
            Obx(() {
              if (controller.isLoading.value) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: ColorConst.greenColor),
                  ),
                );
              }

              if (controller.filteredConsultants.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_search_outlined, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 14),
                          Text(
                            controller.selectedDepartment.value != "All"
                                ? "No Specialists in ${controller.selectedDepartment.value}"
                                : "No Visiting Specialists Found",
                            style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            controller.selectedDepartment.value != "All"
                                ? "Try selecting 'All' or request a consultation."
                                : "Try searching with another keyword or request a specialist visit.",
                            textAlign: TextAlign.center,
                            style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 13),
                          ),
                          const SizedBox(height: 16),
                          if (controller.selectedDepartment.value != "All" || controller.searchQuery.value.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  controller.searchController.clear();
                                  controller.onSearchChanged("");
                                  controller.selectDepartment("All");
                                },
                                icon: Icon(Icons.refresh, size: 16, color: ColorConst.primaryColor),
                                label: Text(
                                  "Show All Specialists",
                                  style: TextStyleConst.mediumTextStyle(ColorConst.primaryColor, 13),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: ColorConst.primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Get.to(() => const CreateVisitingRequestScreen());
                            },
                            icon: const Icon(Icons.add_task_rounded, color: Colors.white, size: 18),
                            label: Text(
                              "Request Consultation",
                              style: TextStyleConst.boldTextStyle(Colors.white, 13),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConst.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final doc = controller.filteredConsultants[index];
                      return VisitingConsultantCard(
                        consultant: doc,
                        onTap: () {
                          Get.to(() => VisitingConsultantDetailsScreen(consultant: doc));
                        },
                        onBookTap: () {
                          Get.to(() => CreateVisitingRequestScreen(initialConsultant: doc));
                        },
                      );
                    },
                    childCount: controller.filteredConsultants.length,
                  ),
                ),
              );
            }),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const CreateVisitingRequestScreen());
        },
        backgroundColor: ColorConst.primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          "Request Visit",
          style: TextStyleConst.boldTextStyle(Colors.white, 14),
        ),
      ),
    );
  }
}
