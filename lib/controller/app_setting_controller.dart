import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/common/setting_model.dart';

class AppSettingController extends GetxController {
  RxBool isLoading = false.obs;
  SettingData? settingData;

  @override
  void onInit() {
    super.onInit();
    loadSettingsFromPrefs();
  }

  void loadSettingsFromPrefs() {
    String? savedColor = PreferenceUtils.getStringValue("primary_color");
    if (savedColor.isNotEmpty) {
      applyThemeColor(savedColor);
    }
  }

  Future<void> fetchSettings({bool? isPatient}) async {
    isLoading.value = true;
    update();

    try {
      SettingModel response = await StringUtils.client.getThemeSettings(ConfigUtils.hospitalSku);

      if (response.success == true && response.data != null) {
        settingData = response.data;
        if (settingData?.theme_color != null) {
          applyThemeColor(settingData!.theme_color!);
          await PreferenceUtils.setStringValue("primary_color", settingData!.theme_color!);
        }
        if (settingData?.app_logo != null) {
          await PreferenceUtils.setStringValue("app_logo", settingData!.app_logo!);
        }
        if (settingData?.app_name != null) {
          await PreferenceUtils.setStringValue("app_name", settingData!.app_name!);
        }
      }
    } catch (e) {
      debugPrint("Error fetching settings: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void applyThemeColor(String hexColor) {
    try {
      if (hexColor.startsWith('#')) {
        hexColor = hexColor.replaceFirst('#', '');
      }
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      Color color = Color(int.parse(hexColor, radix: 16));
      ColorConst.primaryColor = color;
      
      // Update theme dynamically
      Get.changeTheme(ThemeData(
        useMaterial3: true,
        primaryColor: color,
        colorScheme: ColorScheme.fromSeed(seedColor: color),
      ));
      
      update();
    } catch (e) {
      debugPrint("Error applying theme color: $e");
    }
  }
}
