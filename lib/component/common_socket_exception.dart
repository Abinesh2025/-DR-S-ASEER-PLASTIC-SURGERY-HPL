import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/login_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';

class CheckSocketException {
  static void checkSocketException(DioException error, [int? sec, String? showError]) {
    CommonLoader.hideLoader();
    if (error.error is SocketException) {
      DisplaySnackBar.displaySnackBar(
          "Please check internet connection", sec ?? 5);
    } else if (error.response.toString().contains("Token Expired")) {
      PreferenceUtils.setStringValue("token", "");
      Get.to(() => LoginScreen());
      DisplaySnackBar.displaySnackBar("Session expired");
    } else {
      String errorMessage = showError ?? error.message ?? "Something went wrong";
      
      if (error.response?.data != null) {
        if (error.response!.data is Map && error.response!.data["message"] != null) {
          errorMessage = error.response!.data["message"].toString();
        } else if (error.response!.data is String) {
           // If the response is a simple string (like "Endpoint offline"), use it.
           // But check length to avoid showing huge HTML pages in snackbar.
           if (error.response!.data.toString().length < 200) {
             errorMessage = error.response!.data.toString();
           } else {
             errorMessage = "Server Error: ${error.response?.statusCode ?? ''}";
           }
        }
      }

      DisplaySnackBar.displaySnackBar(errorMessage, sec ?? 5);
    }
  }
}
