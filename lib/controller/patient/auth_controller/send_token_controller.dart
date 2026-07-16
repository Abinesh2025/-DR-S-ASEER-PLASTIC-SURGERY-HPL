import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/send_token_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/login_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class SendTokenController extends GetxController {
  SendTokenModel? sendTokenModel;
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  void sendToken(BuildContext context, String email, String token) {
    if (newPassword.text.isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter password", 3 , ColorConst.redColor);
    } else if (newPassword.text.length < 6) {
      DisplaySnackBar.displaySnackBar("Please enter minimum 6 character", 3 , ColorConst.redColor);
    } else if (confirmPassword.text.isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter confirm password", 3 , ColorConst.redColor);
    } else if (newPassword.text != confirmPassword.text) {
      DisplaySnackBar.displaySnackBar("Password doesn't match", 3 , ColorConst.redColor);
    } else {
      StringUtils.client.sendToken(token, newPassword.text, confirmPassword.text, email)
        ..then((value) {
          sendTokenModel = value;
          if (sendTokenModel!.success == true) {
            Get.to(() => LoginScreen());
            DisplaySnackBar.displaySnackBar(sendTokenModel!.message!, 3 ,ColorConst.greenColor);
          }
        })
        ..onError((DioException error, stackTrace) {
          CheckSocketException.checkSocketException(error);
          return SendTokenModel();
        });
    }
  }
}
