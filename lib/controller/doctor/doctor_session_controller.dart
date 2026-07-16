import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_session_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class DoctorSessionController extends GetxController {
  var isLoading = false.obs;
  var sessionData = Rxn<DoctorSessionData>();
  
  @override
  void onInit() {
    super.onInit();
    fetchSessionStatus();
  }

  Future<void> fetchSessionStatus() async {
    try {
      isLoading(true);
      String token = PreferenceUtils.getStringValue("token");
      final response = await StringUtils.client.getDoctorSession(" $token");
      if (response.success == true) {
        sessionData.value = response.data;
      }
    } catch (e) {
      print("Error fetching session status: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> startSession() async {
    try {
      isLoading(true);
      String token = PreferenceUtils.getStringValue("token");
      final response = await StringUtils.client.startDoctorSession(" $token");
      if (response.success == true) {
        sessionData.value = response.data;
        Get.snackbar(
            StringUtils.success, response.message ?? StringUtils.sessionStartedSuccess,
            backgroundColor: ColorConst.greenColor,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar(StringUtils.error, StringUtils.failedToStartError,
          backgroundColor: ColorConst.redColor, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  Future<void> pauseSession(int delayTime, String reason) async {
    try {
      isLoading(true);
      String token = PreferenceUtils.getStringValue("token");
      final response = await StringUtils.client.pauseDoctorSession(" $token", {
        "delay_time": delayTime,
        "reason": reason, // Confirmed: API usually uses 'reason' in POST body even if response field is 'delay_reason'
      });
      if (response.success == true) {
        sessionData.value = response.data;
        Get.snackbar(
            StringUtils.success, response.message ?? StringUtils.sessionPausedSuccess,
            backgroundColor: ColorConst.greenColor,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar(StringUtils.error, StringUtils.failedToPauseError,
          backgroundColor: ColorConst.redColor, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  Future<void> stopSession() async {
    try {
      isLoading(true);
      String token = PreferenceUtils.getStringValue("token");
      final response = await StringUtils.client.stopDoctorSession(" $token");
      if (response.success == true) {
        sessionData.value = response.data;
        Get.snackbar(
            StringUtils.success, response.message ?? StringUtils.sessionStoppedSuccess,
            backgroundColor: ColorConst.greenColor,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar(StringUtils.error, StringUtils.failedToStopError,
          backgroundColor: ColorConst.redColor, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  String get currentStatus => sessionData.value?.sessionStatus?.toLowerCase() ?? "not_started";

  Color get statusColor {
    switch (currentStatus) {
      case 'started':
      case 'active':
        return ColorConst.greenColor;
      case 'paused':
        return Colors.orange;
      case 'not_started':
      case 'stopped':
      default:
        return ColorConst.redColor;
    }
  }
}
