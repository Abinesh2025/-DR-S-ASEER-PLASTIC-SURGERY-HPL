import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/forgot_password_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  ForgotPasswordModel? forgotPasswordModel;
  RxBool isSendLink = true.obs;

  forgotPassword(BuildContext context) {
    isSendLink.value = false;
    StringUtils.client.forgotPassword({"email": emailController.text, "url_domain": Platform.isAndroid?'http:':'myHMS:'})
      ..then((value) {
        forgotPasswordModel = value;
        if (forgotPasswordModel!.success == true) {
          isSendLink.value = true;
          StringUtils.sendEmail = emailController.text;
          emailController.clear();
          DisplaySnackBar.displaySnackBar(forgotPasswordModel!.message!, 3, ColorConst.greenColor);
        }
      })
      ..onError((DioException error, stackTrace) {
        isSendLink.value = true;
        DisplaySnackBar.displaySnackBar("${error.response?.data["message"] ?? error.message}", 3, ColorConst.redColor);
        return ForgotPasswordModel();
      });
  }
}
