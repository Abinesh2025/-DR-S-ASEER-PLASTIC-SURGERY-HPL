import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/settings_model/settings_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/settings_model/update_settings_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  final TextEditingController appNameController = TextEditingController();
  final TextEditingController planExpireNotificationController = TextEditingController();
  final TextEditingController defaultCountryCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? currencyId;
  String? languageId;

  SettingsModel originalSettings = SettingsModel();

  var arguments = Get.arguments;
  SettingsModel? settingsModel;
  UpdateSettingsModel? updateSettingModel;
  RxBool isGetSettings = false.obs;

  ImagePicker imagePicker = ImagePicker();
  XFile? file1;
  XFile? file2;
  RxBool showFile1 = false.obs;
  RxBool showFile2 = false.obs;
  String filePath1 = "";
  String filePath2 = "";

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
    planExpireNotificationController.text = originalSettings.data?.plan_expire_notification ?? "";
    defaultCountryCodeController.text = originalSettings.data?.default_country_code ?? "";
    phoneController.text = originalSettings.data?.phone ?? "";
    currencyId = originalSettings.data?.super_admin_currency ?? "";
    languageId = originalSettings.data?.default_language ?? "";
    file1 = null;
    file2 = null;
    showFile1.value = false;
    showFile2.value = false;
    update();
  }

  void updateSettings() async {
    if (appNameController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter app name", 3 , ColorConst.redColor);
    }else if(planExpireNotificationController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter plan expire notifications(in Days)", 3 , ColorConst.redColor);
    }else if(defaultCountryCodeController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please select Default country code", 3 , ColorConst.redColor);
    }else if(phoneController.text.trim().isEmpty){
      DisplaySnackBar.displaySnackBar("Please enter phone number", 3 , ColorConst.redColor);
    }else if(currencyId == null) {
      DisplaySnackBar.displaySnackBar("Please select current currency", 3 , ColorConst.redColor);
    }else if(languageId == null) {
      DisplaySnackBar.displaySnackBar("Please select language", 3 , ColorConst.redColor);
    } else {

      StringUtils.client.updateSettings(PreferenceUtils.getStringValue("token"),
          appNameController.text,
          planExpireNotificationController.text,
          defaultCountryCodeController.text,
          phoneController.text,
          currencyId ?? "",
          languageId ?? "",
          file1 == null ? null : File(file1!.path),
          file2 == null ? null : File(file2!.path)

      ).then((value) {
        updateSettingModel = value;
        DisplaySnackBar.displaySnackBar("Settings updated successfully", 3, ColorConst.greenColor);
      }).onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
      });
      update();
    }
  }

  Future<void> fetchUpdatedSettings() async {
    try {
      SettingsModel? updatedSettings = await StringUtils.client.getSettings(
        PreferenceUtils.getStringValue("token"),
      );
      originalSettings = updatedSettings ?? SettingsModel();
        settingsModel = updatedSettings;
        appNameController.text = settingsModel?.data?.app_name ?? "";
        planExpireNotificationController.text = settingsModel?.data?.plan_expire_notification ?? "";
        defaultCountryCodeController.text = settingsModel?.data?.default_country_code ?? "";
        phoneController.text = settingsModel?.data?.phone ?? "";
        currencyId = settingsModel?.data?.super_admin_currency ?? "";
        languageId = settingsModel?.data?.default_language ?? "";
        isGetSettings.value = true;
        update();

    } catch (error) {
      isGetSettings.value = false;
    }
  }

  void getSettings() {
    fetchUpdatedSettings();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    appNameController.text = VariableUtils.appName.value;
    filePath1 = VariableUtils.appLogo.value;
    filePath2 = VariableUtils.favicon.value;
    planExpireNotificationController.text = VariableUtils.planExpire.value;
    defaultCountryCodeController.text = VariableUtils.defaultCountryCode.value;
    phoneController.text = VariableUtils.phone.value;
    currencyId = VariableUtils.currentCurrency.value;
    languageId = VariableUtils.currentCurrency.value;
    getSettings();
  }

}
