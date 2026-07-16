import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/country_code_list.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/edit_hospital_model/edit_hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/hospital_type_model/hospital_type_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class EditHospitalController extends GetxController {
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController hospitalSlugController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController prefixCodeController = TextEditingController();

  HospitalModel? hospitalModel;
  UpdateHospitalModel? updateHospitalModel;
  HospitalTypeModel? hospitalTypeModel;

  RxBool gotData = false.obs;

  var arguments = Get.arguments;

  String? hospTypeId;

  void editHospitals(int hospitalID) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (hospitalNameController.text.trim().isEmpty){
      DisplaySnackBar.displaySnackBar("Please enter hospital name", 3 , ColorConst.redColor);
    } else if(hospTypeId == "N/A") {
      DisplaySnackBar.displaySnackBar("Please select hospital type", 3 , ColorConst.redColor);
    } else if(emailController.text.trim().isEmpty){
      DisplaySnackBar.displaySnackBar("Please enter email address", 3 , ColorConst.redColor);
    }else if (!regExp.hasMatch(emailController.text)) {
      DisplaySnackBar.displaySnackBar("Please enter valid email address", 3 , ColorConst.redColor);
    } else if(cityController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter city", 3 , ColorConst.redColor);
    } else if(phoneController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter phone number", 3 , ColorConst.redColor);
    } else {
      CommonLoader.showLoader();
      StringUtils.client.updateHospitals(
          PreferenceUtils.getStringValue("token"),
          hospitalID,
          hospitalNameController.text.trim(),
          hospTypeId ?? "",
          emailController.text.trim(),
          cityController.text.trim(),
          phoneController.text.trim(),
          prefixCodeController.text.trim()
      )

        ..then((value) {
          Get.back();
          Get.back(result: "Call API");
          DisplaySnackBar.displaySnackBar("Hospital updated successfully", 3, ColorConst.greenColor);
          gotData.value = true;
        })
        ..onError((DioException error, stackTrace) {
          Get.back();
          Get.back();
          CheckSocketException.checkSocketException(error);
          return UpdateHospitalModel();
        });
    }
  }

  void getHospitalType() {
    StringUtils.client.getHospitalType(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        hospitalTypeModel = value;
        hospitalNameController.text = arguments["hospital_name"];
        hospitalSlugController.text = arguments["hospital_slug"];
        hospTypeId = '${arguments["hospital_type_id"]}';
        emailController.text = arguments["email"];
        cityController.text = arguments["city"];
        phoneController.text = arguments["phone_no"];
        prefixCodeController.text = arguments["region_code"];
        gotData.value = true;
      })
      ..onError((error, stackTrace) {
        gotData.value = true;
        return HospitalTypeModel();
      });
  }

  String getCountryCodeFromDialCode(String dialCode) {
    for (Map<String, String> country in countryList) {
      if (country['dialCode'] == dialCode) {
        return country['code']!;
      }
    }
    return 'IN';
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHospitalType();
  }
}
