import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/reset_password_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  ResetPasswordModel? resetPasswordModel;

  void changePassword(BuildContext context) {
    if (currentPasswordController.text.isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter current password", 3 , ColorConst.redColor);
    } else if (currentPasswordController.text != PreferenceUtils.getStringValue("password")) {
      DisplaySnackBar.displaySnackBar("Please enter correct current password", 3 , ColorConst.redColor);
    } else if (newPasswordController.text.isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter new password", 3 , ColorConst.redColor);
    } else if (newPasswordController.text.length < 6) {
      DisplaySnackBar.displaySnackBar("Please enter minimum 6 character password", 3 , ColorConst.redColor);
    } else if (confirmPasswordController.text.isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter confirm password", 3 , ColorConst.redColor);
    } else if (newPasswordController.text != confirmPasswordController.text) {
      DisplaySnackBar.displaySnackBar("Password doesn't match", 3 , ColorConst.redColor);
    } else {
      StringUtils.client.resetPassword(PreferenceUtils.getStringValue("token"), {
        "email": VariableUtils.email.value,
        "old_password": currentPasswordController.text,
        "password": newPasswordController.text,
        "password_confirmation": confirmPasswordController.text,
      }).then((value) {
        resetPasswordModel = value;
        if (resetPasswordModel!.success == true) {

          PreferenceUtils.setStringValue("password", newPasswordController.text);

          update();

          Get.back();
          clearController();
        }
        DisplaySnackBar.displaySnackBar("Password updated successfully", 3, ColorConst.greenColor);
      }).onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
      });
    }
  }

  void clearController() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
