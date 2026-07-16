import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/doctor_by_department_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/all_specialties_screen.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/skeleton_loading_widgets.dart';

import '../../../../utils/image_utils.dart';
import '../../../../utils/string_utils.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientHomeController>(builder: (controller) {
      if (controller.isDoctorsLoading) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Find your doctor",
                    style: TextStyleConst.boldTextStyle(
                      ColorConst.blackColor,
                      18,
                    ),
                  ),
                  // Text(
                  //   "See All >",
                  //   style: TextStyleConst.mediumTextStyle(
                  //     ColorConst.blackColor.withOpacity(0.7),
                  //     14,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                      width: 70,
                      child: CategorySkeleton(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      var departments = controller.doctorDepartmentModel?.data ?? [];
      if (departments.length > 7) {
        departments = departments.sublist(0, 7);
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Find your doctor",
                    style: TextStyleConst.boldTextStyle(
                      ColorConst.blackColor,
                      18,
                    ),
                  ),
                  // Removed See All per user request
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 110, // Increased height to accommodate larger icons
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: departments.length + 1,
                itemBuilder: (context, index) {
                  if (index == departments.length) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const AllSpecialtiesScreen(),
                            transition: Transition.rightToLeft);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Color(
                                    0xffF2F8F7), // Light green tint based on design
                                shape: BoxShape.circle,
                              ),
                              child:  Icon(
                                Icons.grid_view_rounded,
                                color: ColorConst.primaryColor,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              StringUtils.viewAll,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                              color: Color(
                                  0xffF2F8F7), // Light green tint based on design
                              shape: BoxShape.circle,
                            ),
                            // Providing padding inside the circle so the image doesn't stretch to the edges
                            padding: const EdgeInsets.all(
                                8), // Reduced padding so image is bigger
                            child: dept.doctorDepartmentImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.network(
                                      dept.doctorDepartmentImage!,
                                      fit: BoxFit
                                          .contain, // Contain within padding
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Image.asset(
                                            ImageUtils.hospitalSplashLogo, // Replace with your asset path
                                            fit: BoxFit.cover,
                                          ), // Increased fallback icon size
                                    ),
                                  )
                                :  ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child:
                                    Image.asset(
                                      ImageUtils.hospitalSplashLogo, // Replace with your asset path
                                      fit: BoxFit.cover,
                                    ), // Increased fallback icon size

                            )
                          ),
                          const SizedBox(height: 6), // Adjusted spacing
                          SizedBox(
                            width: 80,
                            child: Text(
                              dept.title ?? "",
                              textAlign: TextAlign.center,
                              maxLines: 1, // Restrict to 1 line to match design
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                13,
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
          ],
        ),
      );
    });
  }
}
