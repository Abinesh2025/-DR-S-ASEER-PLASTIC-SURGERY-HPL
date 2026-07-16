import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/disease_details_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/string_utils.dart';

class CommonHealthIssuesWidget extends StatelessWidget {
  const CommonHealthIssuesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Colors and Icons to cycle through
    final List<Color> cardColors = [
      const Color(0xFF9E95F6), // Periwinkle Blue
      const Color(0xFF81D4C3), // Teal/Green
      const Color(0xFFEC7868), // Salmon/Red
      const Color(0xFFF7B95C), // Orange/Yellow
      const Color(0xFF4DB6AC), // Teal
      const Color(0xFFBA68C8), // Purple
    ];

    final List<IconData> cardIcons = [
      Icons.sick_outlined,
      Icons.female_outlined,
      Icons.monitor_heart_outlined,
      Icons.bloodtype_outlined,
      Icons.medication_outlined,
      Icons.healing_outlined,
    ];

    final controller = Get.find<PatientHomeController>();

    return Obx(() {
      if (!controller.isDiseasesLoading.value && controller.diseases.isEmpty) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                StringUtils.commonHealthIssues,
                style: TextStyleConst.boldTextStyle(
                  ColorConst.blackColor,
                  width * 0.045,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 120, // Reduced height as price is removed
              child: controller.isDiseasesLoading.value
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 140,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.diseases.length,
                      itemBuilder: (context, index) {
                        final disease = controller.diseases[index];
                        final color = cardColors[index % cardColors.length];
                        final icon = cardIcons[index % cardIcons.length];

                        return GestureDetector(
                          onTap: () {
                            if (disease.id != null) {
                              Get.to(
                                () => DiseaseDetailsScreen(
                                  diseaseId: disease.id!,
                                  diseaseName:
                                      disease.name ?? StringUtils.diseaseDetails,
                                ),
                                transition: Transition.rightToLeft,
                              );
                            }
                          },
                          child: Container(
                            width: 140,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              children: [
                                // Content
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        disease.name ?? StringUtils.diseaseDetails,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyleConst.boldTextStyle(
                                          ColorConst.whiteColor,
                                          16, // Increased font size
                                        ),
                                      ),
                                      // Price removed
                                    ],
                                  ),
                                ),

                                // Icon/Illustration Placement
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: ColorConst.whiteColor
                                          .withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      icon,
                                      color: ColorConst.whiteColor,
                                      size: 30,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: -10,
                                  left: -10,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        ColorConst.whiteColor.withOpacity(0.1),
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
