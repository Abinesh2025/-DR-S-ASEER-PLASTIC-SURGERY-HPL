import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_registration/hospital_registration_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class HospitalSignUpController extends GetxController {
  TextEditingController hospitalNameController = TextEditingController();
  TextEditingController hospitalSlugController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController prefixCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxInt currentIndex = 0.obs;

  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  HospitalSignupModel? hospitalSignupModel;

  void registerUser() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (hospitalNameController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter hospital name", 3 , ColorConst.redColor);
    } else if (hospitalSlugController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter hospital slug", 3 , ColorConst.redColor);
    } else if (emailController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter email address", 3 , ColorConst.redColor);
    } else if (!regExp.hasMatch(emailController.text.trim())) {
      DisplaySnackBar.displaySnackBar("Please enter valid email address", 3 , ColorConst.redColor);
    }else if (prefixCodeController.text.isEmpty) {
      DisplaySnackBar.displaySnackBar("Please select country code", 3 , ColorConst.redColor);
    }else if (phoneController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter phone number", 3 , ColorConst.redColor);
    } else if (passwordController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter password", 3 , ColorConst.redColor);
    } else if (passwordController.text.trim().length < 6) {
      DisplaySnackBar.displaySnackBar("Please enter password more then 6 characters", 3 , ColorConst.redColor);
    } else if (confirmPasswordController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter confirm password", 3 , ColorConst.redColor);
    } else if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      DisplaySnackBar.displaySnackBar("Password and Confirm password does not match", 3 , ColorConst.redColor);
    } else {
      CommonLoader.showLoader();
      StringUtils.client.hospitalRegistration(
        hospitalNameController.text,
        hospitalSlugController.text,
        emailController.text,
        prefixCodeController.text,
        phoneController.text,
        passwordController.text,
        confirmPasswordController.text,
      )
        ..then((value) {
          hospitalSignupModel = value;
          Get.back();
          Get.back();
          DisplaySnackBar.displaySnackBar("Hospital registered successfully", 3, ColorConst.greenColor);
        })
        ..onError((DioException error, stackTrace) {
          CheckSocketException.checkSocketException(error);
          return HospitalSignupModel();
        });
    }
  }
}
