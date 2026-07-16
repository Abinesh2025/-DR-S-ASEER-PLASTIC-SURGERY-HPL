import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/search_doctor_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/voice_search_bottom_sheet.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class StickySearchBarDelegate extends SliverPersistentHeaderDelegate {
  final PatientHomeController controller;

  StickySearchBarDelegate(this.controller);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: ColorConst
          .bgGreyColor, // Match background to avoid transparency issues
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                var result = await Get.to(() => const SearchDoctorScreen());
                if (result != null && result is String) {
                  controller.updateSearchText(result);
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: ColorConst.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConst.blueColor.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                    BoxShadow(
                      color: ColorConst.blackColor.withOpacity(0.02),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border:
                      Border.all(color: ColorConst.blueColor.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                     Icon(Icons.search, color: ColorConst.primaryColor),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: controller.searchController,
                        builder: (context, value, _) {
                          if (value.text.isNotEmpty) {
                            return Text(
                              value.text,
                              style: TextStyleConst.mediumTextStyle(
                                  ColorConst.blackColor, 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          } else {
                            return SizedBox(
                              height: 20,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    StringUtils.searchHint, // "Search  "
                                    style: TextStyleConst.mediumTextStyle(
                                        ColorConst.hintGreyColor, 14),
                                  ),
                                  DefaultTextStyle(
                                    style: TextStyleConst.mediumTextStyle(
                                        ColorConst.hintGreyColor, 14),
                                    child: AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        RotateAnimatedText(StringUtils.cardiologist),
                                        RotateAnimatedText(StringUtils.dentist),
                                        RotateAnimatedText(StringUtils.generalPhysician),
                                        RotateAnimatedText(StringUtils.dermatologist),
                                      ],
                                      onTap: () async {
                                        var result = await Get.to(
                                            () => const SearchDoctorScreen());
                                        if (result != null &&
                                            result is String) {
                                          controller.updateSearchText(result);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Voice Search Button
          Obx(() => GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    const VoiceSearchBottomSheet(),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  ).whenComplete(() {
                    controller.stopListening();
                  });
                  // Start listening immediately when sheet opens
                  if (!controller.isListening.value) {
                    controller.startListening();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: controller.isListening.value
                        ? ColorConst.redColor
                        : ColorConst.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: controller.isListening.value
                            ? ColorConst.redColor.withOpacity(0.3)
                            : ColorConst.blueColor.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    controller.isListening.value ? Icons.mic : Icons.mic_none,
                    color: controller.isListening.value
                        ? ColorConst.whiteColor
                        : ColorConst.primaryColor,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 70.0; // 50 height + 20 vertical padding

  @override
  double get minExtent => 70.0;

  @override
  bool shouldRebuild(covariant StickySearchBarDelegate oldDelegate) {
    return true; // Simple rebuild strategy
  }
}
