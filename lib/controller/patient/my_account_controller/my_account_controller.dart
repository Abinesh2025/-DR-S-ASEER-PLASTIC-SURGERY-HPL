import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/main.dart';

class MyAccountController extends GetxController {
  void logout() async {
    Get.back(); // Close the dialog
    CommonLoader.showLoader();
    try {
      final value = await StringUtils.client
          .logout(PreferenceUtils.getStringValue("token"));
      if (value.success == true) {
        await PreferenceUtils.clear();
        PreferenceUtils.setStringValue("role", ""); // Reset role explicitly

        VariableUtils.reset();

        // Reset HomeController state safely
        try {
          final homeController = Get.find<HomeController>();
          homeController.currentBottomIndex.value = 0;
          homeController.currentWidget = null;
        } catch (e) {
          debugPrint("HomeController not found during logout reset: $e");
        }

        Get.deleteAll(force: true);
        router.go('/login');
      }
    } on DioException catch (error) {
      debugPrint("Logout error: $error");
      CheckSocketException.checkSocketException(error);
    } finally {
      CommonLoader.hideLoader();
    }
  }
}
