import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';

import '../../../../utils/string_utils.dart';

class FilterDoctorSheet extends StatefulWidget {
  const FilterDoctorSheet({super.key});

  @override
  State<FilterDoctorSheet> createState() => _FilterDoctorSheetState();
}

class _FilterDoctorSheetState extends State<FilterDoctorSheet> {
  late String selectedGender;
  late RangeValues priceRange;
  int? selectedDepartmentId;
  late String selectedSort;

  // existing list removed, will use controller data
  final controller = Get.find<PatientHomeController>(); // Get the controller

  @override
  void initState() {
    super.initState();
    selectedGender = controller.currentGender ?? "Male";
    priceRange = RangeValues(
        controller.currentMinPrice ?? 100, controller.currentMaxPrice ?? 1000);
    selectedDepartmentId = controller.currentDepartmentId;
    selectedDepartmentId = controller.currentDepartmentId;

    // Map backend sort value to display value
    String backendSort = controller.currentSort ?? "popularity";
    if (backendSort == "popularity") {
      selectedSort = "Popularity (Highest First)";
    } else if (backendSort == "fees_asc") {
      selectedSort = "Fees (Low to High)";
    } else if (backendSort == "fees_desc") {
      selectedSort = "Fees (High to Low)";
    } else if (backendSort == "latest") {
      selectedSort = "Latest (Newest First)";
    } else {
      selectedSort = "Popularity (Highest First)";
    }
  }

  final List<String> sortOptions = [
    "Popularity (Highest First)",
    "Fees (Low to High)",
    "Fees (High to Low)",
    "Latest (Newest First)",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConst.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle Bar
          Center(
            child: Container(
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                color: ColorConst.lightGreyColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter Doctor Search",
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
              ),
              const Icon(Icons.help_outline,
                  color: ColorConst.hintGreyColor, size: 20),
            ],
          ),
          const SizedBox(height: 25),

          // Gender
          Text("Gender",
              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 14)),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildGenderButton("Male", Icons.male, selectedGender == "Male"),
              const SizedBox(width: 15),
              _buildGenderButton(
                  "Female", Icons.female, selectedGender == "Female"),
            ],
          ),

          const SizedBox(height: 25),

          // Price Range
          Text("Price Range",
              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 14)),
          Row(
            children: [
              // RangeSlider can be tricky to customize exactly like design without external packages,
              // using standard Material RangeSlider for now.
              Expanded(
                child: RangeSlider(
                  values: priceRange,
                  min: 0,
                  max: 5000, // Max price 5000
                  divisions: 50,
                  activeColor: ColorConst.primaryColor,
                  inactiveColor: ColorConst.lightGreyColor,
                  labels: RangeLabels("\₹${priceRange.start.round()}",
                      "\₹${priceRange.end.round()}"),
                  onChanged: (values) {
                    setState(() {
                      priceRange = values;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\₹${priceRange.start.round()}",
                  style: TextStyleConst.boldTextStyle(
                      ColorConst.blackColor.withOpacity(0.54), 14)),
              Text("\₹${priceRange.end.round()}",
                  style: TextStyleConst.boldTextStyle(
                      ColorConst.blackColor.withOpacity(0.54), 14)),
            ],
          ),

          const SizedBox(height: 25),
          // Department
          Text(StringUtils.department,
              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 14)),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: GetBuilder<PatientHomeController>(builder: (controller) {
              // Use controller.doctorDepartmentModel
              final departments = controller.doctorDepartmentModel?.data ?? [];
              if (departments.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("No departments found"),
                );
              }
              return Row(
                children: departments
                    .map((dept) => _buildSpecChip(dept.title ?? "", dept.id))
                    .toList(),
              );
            }),
          ),

          const SizedBox(height: 25),
          // Sort By
          Text("Sort By",
              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 14)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: ColorConst.bgGreyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedSort,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: ColorConst.blackColor),
                items: sortOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        const Icon(Icons.bar_chart,
                            color: ColorConst.blackColor, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          value,
                          style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor, 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedSort = newValue!;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final filterData = {
                  "gender": selectedGender, // Send "Male" or "Female" directly
                  "min_price": priceRange.start,
                  "max_price": priceRange.end,
                  "department_id": selectedDepartmentId,
                  "sort": selectedSort == "Popularity (Highest First)"
                      ? "popularity"
                      : selectedSort == "Fees (Low to High)"
                          ? "fees_asc"
                          : selectedSort == "Fees (High to Low)"
                              ? "fees_desc"
                              : "latest",
                };
                Get.back(result: filterData);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConst.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Apply",
                      style: TextStyleConst.boldTextStyle(
                          ColorConst.whiteColor, 16)),
                  const SizedBox(width: 10),
                  const Icon(Icons.tune,
                      color: ColorConst.whiteColor, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGenderButton(String label, IconData icon, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorConst.primaryColor.withOpacity(0.1)
                : ColorConst.bgGreyColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? ColorConst.primaryColor : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: isSelected
                      ? ColorConst.primaryColor
                      : ColorConst.blackColor.withOpacity(0.54),
                  size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyleConst.boldTextStyle(
                  isSelected
                      ? ColorConst.primaryColor
                      : ColorConst.blackColor.withOpacity(0.54),
                  14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecChip(String label, int? id) {
    bool isSelected = selectedDepartmentId == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          // Toggle selection
          if (isSelected) {
            selectedDepartmentId = null;
          } else {
            selectedDepartmentId = id;
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFC7F4EF)
              : ColorConst.bgGreyColor, // Teal-ish light for selected
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? Border.all(color: Colors.teal) : null,
        ),
        child: Row(
          children: [
            Icon(
              Icons.medical_services_outlined,
              size: 16,
              color: isSelected ? Colors.teal : Colors.grey,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyleConst.boldTextStyle(
                isSelected ? Colors.teal : ColorConst.blackColor,
                12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
