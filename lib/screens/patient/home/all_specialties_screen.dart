import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/doctor_by_department_screen.dart';

import '../../../utils/string_utils.dart';

class AllSpecialtiesScreen extends StatelessWidget {
  const AllSpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PatientHomeController>();
    final departments = controller.doctorDepartmentModel?.data ?? [];
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      appBar: AppBar(
        title: Text(
          "All Specialties",
          style: TextStyleConst.boldTextStyle(
            ColorConst.blackColor,
            18,
          ),
        ),
        backgroundColor: ColorConst.bgGreyColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ColorConst.blackColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: GridView.builder(
          itemCount: departments.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                3, // 3 columns for full page view looks better usually, or keep 4
            childAspectRatio: 0.85,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            final dept = departments[index];
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => DoctorByDepartmentScreen(
                    departmentId: dept.id!,
                    departmentName: dept.title ?? StringUtils.department,
                  ),
                  transition: Transition.rightToLeft,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConst.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConst.greyShadowColor.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: width * 0.15,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: dept.doctorDepartmentImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                dept.doctorDepartmentImage!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.local_hospital,
                                        color: ColorConst.primaryColor,
                                        size: width * 0.075),
                              ),
                            )
                          : Icon(
                              Icons.local_hospital,
                              color: ColorConst.primaryColor,
                              size: width * 0.075,
                            ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        dept.title ?? "",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.blackColor,
                          width * 0.032,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
