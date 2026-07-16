import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/home_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/login_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/welcome/onboarding_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:flutter/foundation.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/main.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/app_setting_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.put(AppSettingController());
    _initSplash();
  }

  Future<void> _initSplash() async {
    // Attempt to check and perform update if on Android
    if (!kIsWeb && GetPlatform.isAndroid) {
      try {
        final info = await InAppUpdate.checkForUpdate();
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          await InAppUpdate.performImmediateUpdate();
        }
      } catch (e) {
        debugPrint("InAppUpdate Error: $e");
      }
    }

    // Fetch app settings
    final appSettingController = Get.find<AppSettingController>();
    await appSettingController.fetchSettings();

    // Still maintain a minimum 3-5 seconds delay for splash
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (PreferenceUtils.getBoolValue("isShowOnBoarding")) {
          Get.to(() => OnBoardingScreen(), transition: Transition.fade);
        } else {
          if (PreferenceUtils.getStringValue("token") != "") {
            router.go('/home');
          } else {
            router.go('/login');
          }
        }
      },
    );
  }
}
