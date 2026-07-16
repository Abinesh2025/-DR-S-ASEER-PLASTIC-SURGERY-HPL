
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/add_hospital_model/add_hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/hospital_type_model/hospital_type_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class AddHospitalController extends GetxController {
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController hospitalSlugController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController prefixCodeController = TextEditingController();

 HospitalModel? hospitalModel;
 HospitalTypeModel? hospitalTypeModel;

  RxBool gotData = false.obs;
  var arguments = Get.arguments;
  String? hospitalTypeId;

  void createHospital() async {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (hospitalNameController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter hospital name", 3 , ColorConst.redColor);
    } else if (hospitalSlugController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter hospital slug", 3 , ColorConst.redColor);
    }else if(hospitalTypeId == null){
      DisplaySnackBar.displaySnackBar("Please select hospital type", 3 , ColorConst.redColor);
    } else if (emailController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter email address", 3 , ColorConst.redColor);
    } else if (!regExp.hasMatch(emailController.text)) {
      DisplaySnackBar.displaySnackBar("Please enter valid email address", 3 , ColorConst.redColor);
    } else if (cityController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter city name", 3 , ColorConst.redColor);
    } else if (phoneController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter phone number", 3 , ColorConst.redColor);
    } else if (passwordController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter password", 3 , ColorConst.redColor);
    } else if (passwordController.text.trim().length < 6) {
      DisplaySnackBar.displaySnackBar("Please enter minimum 6 character password", 3 , ColorConst.redColor);
    } else if (confirmPasswordController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter confirm password", 3 , ColorConst.redColor);
    } else if (passwordController.text != confirmPasswordController.text) {
      DisplaySnackBar.displaySnackBar("Password doesn't match", 3 , ColorConst.redColor);
    } else {
      CommonLoader.showLoader();

        StringUtils.client.createNewHospital(
          PreferenceUtils.getStringValue("token"),
           hospitalNameController.text.trim(),
           hospitalSlugController.text,
           hospitalTypeId ?? "",
           emailController.text,
           cityController.text,
          "+${prefixCodeController.text}",
            phoneController.text,
           passwordController.text,
           confirmPasswordController.text,

        )
          ..then((value) {
            gotData.value = true;
              Get.back();
              Get.back(result: "Call API");
              DisplaySnackBar.displaySnackBar("Hospital Added successfully", 3, ColorConst.greenColor);
          })
          ..onError((DioException error, stackTrace) {
            Get.back();
            Get.back();
            CheckSocketException.checkSocketException(error);
            return AddHospitalModel();
          });
      }
  }

  void getHospitalType() {
    StringUtils.client.getHospitalType(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        hospitalTypeModel = value;
        gotData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        gotData.value = true;
        CheckSocketException.checkSocketException(error);
        return HospitalTypeModel();
      });
  }

   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHospitalType();
  }
}
