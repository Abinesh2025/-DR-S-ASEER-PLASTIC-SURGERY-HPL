import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/setting_screen_model/edit_setting_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/setting_screen_model/setting_screen_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/country_code_list.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:image_picker/image_picker.dart';


class AdminSettingController extends GetxController {
  final TextEditingController appNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController hospitalEmailController = TextEditingController();
  final TextEditingController prefixCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? enableGoogleRecaptcha;

  var arguments = Get.arguments;
  AdminSettingModel? adminSettingModel;
  EditSettingModel? editSettingModel;
  RxBool isGetSettings = false.obs;

  AdminSettingModel originalSettings = AdminSettingModel();

  ImagePicker imagePicker = ImagePicker();
  XFile? file1;
  XFile? file2;
  RxBool showFile1 = false.obs;
  RxBool showFile2 = false.obs;
  String filePath1 = "";
  String filePath2 = "";

  final _switchValue = true.obs;

  bool get switchValue => _switchValue.value;

  void toggleSwitch() {
    _switchValue.toggle();
  }

  void pickImage1(BuildContext context) async {
    try {
      file1 = await imagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      DisplaySnackBar.displaySnackBar(
          "Please give access to photos from settings", 5);
    }
    if ((file1?.path ?? "") != "") {
      showFile1.value = true;
      update();
    }
  }

  void pickImage2(BuildContext context) async {
    try {
      file2 = await imagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      DisplaySnackBar.displaySnackBar(
          "Please give access to photos from settings", 5);
    }
    if ((file2?.path ?? "") != "") {
      showFile2.value = true;
      update();
    }
  }

  void resetChanges() {
    appNameController.text = originalSettings.data?.app_name ?? "";
    companyNameController.text = originalSettings.data?.company_name ?? "";
    hospitalEmailController.text = originalSettings.data?.hospital_email ?? "";
    prefixCodeController.text = originalSettings.data?.country_code ?? "";
    phoneController.text = originalSettings.data?.hospital_phone ?? "";
    enableGoogleRecaptcha = originalSettings.data?.enable_google_recaptcha ?? "";
    _switchValue.value = enableGoogleRecaptcha == "1";
    file1 = null;
    file2 = null;
    showFile1.value = false;
    showFile2.value = false;
    update();
  }


  void updateSettings() async {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (appNameController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter appname", 3, ColorConst.redColor);
    }else if(companyNameController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter company name", 3, ColorConst.redColor);
    }else if(hospitalEmailController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter email address", 3, ColorConst.redColor);
    }else if (!regExp.hasMatch(hospitalEmailController.text)) {
      DisplaySnackBar.displaySnackBar("Please enter valid email address", 3, ColorConst.redColor);
    } else if(phoneController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter phone number", 3, ColorConst.redColor);
    } else {

      StringUtils.client.updateAdminSettings(PreferenceUtils.getStringValue("token"),
          appNameController.text,
          companyNameController.text,
          hospitalEmailController.text,
          prefixCodeController.text,
          phoneController.text,
          enableGoogleRecaptcha ?? "",
          file1 == null ? null : File(file1!.path),
          file2 == null ? null : File(file2!.path)

      ).then((value) {
        editSettingModel = value;
        DisplaySnackBar.displaySnackBar("Settings updated successfully", 3, ColorConst.greenColor);
      }).onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
      });
      update();
    }
  }

  Future<void> fetchUpdatedSettings() async {
    try {
      AdminSettingModel? updatedSettings = await StringUtils.client.getAdminSettings(
        PreferenceUtils.getStringValue("token"),
      );
      originalSettings = updatedSettings ?? AdminSettingModel();
      adminSettingModel = updatedSettings;
      appNameController.text = adminSettingModel?.data?.app_name ?? "";
      companyNameController.text = adminSettingModel?.data?.company_name ?? "";
      hospitalEmailController.text = adminSettingModel?.data?.hospital_email ?? "";
      prefixCodeController.text = adminSettingModel?.data?.country_code ?? "";
      phoneController.text = adminSettingModel?.data?.hospital_phone ?? "";
      enableGoogleRecaptcha = adminSettingModel?.data?.enable_google_recaptcha ?? "";

      _switchValue.value = enableGoogleRecaptcha == "1";

      isGetSettings.value = true;
      update();

    } catch (error) {
      isGetSettings.value = false;
    }
  }

  void getSettings() {
    fetchUpdatedSettings();
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
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    appNameController.text = VariableUtils.adminAppName.value;
    filePath1 = VariableUtils.adminAppLogo.value;
    filePath2 = VariableUtils.adminAppLogo.value;
    companyNameController.text = VariableUtils.companyName.value;
    hospitalEmailController.text = VariableUtils.hospitalEmail.value;
    prefixCodeController.text = VariableUtils.prefixCountryCode.value;
    phoneController.text = VariableUtils.hospitalPhone.value;
    enableGoogleRecaptcha = VariableUtils.enableGoogleRecaptcha.value;
    getSettings();
  }

}
