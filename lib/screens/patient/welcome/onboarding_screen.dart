import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/intro_controller/onboarding_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/login_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/welcome/language_selection_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/widget/onboarding/first_onboarding_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/widget/onboarding/second_onboarding_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/widget/onboarding/third_onboarding_screen.dart';
import 'package:onboarding_animation/onboarding_animation.dart';

import '../../../utils/string_utils.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final OnBoardingController onBoardingController = Get.put(OnBoardingController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConst.whiteColor,
      body: WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            // Static Curved teal background
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.55,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff147a5b),
                      Color(0xff09503b),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.elliptical(300, 100),
                  ),
                ),
              ),
            ),

            // Sliding Content
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: OnBoardingAnimation(
                controller: onBoardingController.controller,
                pages: [
                  /// First page
                  const FirstOnBoardingScreen(),

                  /// Second page
                  const SecondOnBoardingScreen(),

                  /// Third page
                  const ThirdOnBoardingScreen(),
                ],
                indicatorDotHeight: 0.0,
                indicatorDotWidth: 0.0,
                indicatorType: IndicatorType.scrollingDots,
                indicatorActiveDotColor: Colors.transparent,
                indicatorPosition: IndicatorPosition.bottomCenter,
              ),
            ),

            // Top Navigation (Indicators and Skip)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40),
                    Obx(() => Row(
                          children: [
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: onBoardingController.index.value == 0.0 ? ColorConst.primaryColor : ColorConst.borderGreyColor,
                            ),
                            const SizedBox(width: 8),
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: onBoardingController.index.value == 1.0 ? ColorConst.primaryColor : ColorConst.borderGreyColor,
                            ),
                            const SizedBox(width: 8),
                            CircleAvatar(
                                radius: 4,
                                backgroundColor: onBoardingController.index.value == 2.0 ? ColorConst.primaryColor : ColorConst.borderGreyColor),
                          ],
                        )),
                    GestureDetector(
                      onTap: () {
                        PreferenceUtils.setBoolValue("isShowOnBoarding", false);
                        Get.to(() => const LanguageSelectionScreen(), transition: Transition.rightToLeft);
                      },
                      child: Text(
                        "Skip",
                        style: TextStyleConst.mediumTextStyle(ColorConst.primaryColor, 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Static Bottom Navigation Buttons
            Positioned(
              bottom: height * 0.05,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Obx(() => ElevatedButton(
                        onPressed: () {
                          if (onBoardingController.index.value != 2.0) {
                            onBoardingController.controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            PreferenceUtils.setBoolValue("isShowOnBoarding", false);
                            Get.to(() => const LanguageSelectionScreen(), transition: Transition.rightToLeft);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: ColorConst.primaryColor,
                          minimumSize: Size(width * 0.7, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          onBoardingController.index.value == 2.0 ? "Get Started" : "Next",
                          style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 18),
                        ),
                      )),
                  const SizedBox(height: 20),
                  Obx(() => onBoardingController.index.value != 0.0
                      ? GestureDetector(
                          onTap: () {
                            onBoardingController.controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            "Back",
                            style: TextStyleConst.mediumTextStyle(Colors.white, 16),
                          ),
                        )
                      : const SizedBox(height: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
