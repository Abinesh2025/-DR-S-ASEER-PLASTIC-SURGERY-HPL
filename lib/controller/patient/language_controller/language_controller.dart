import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    String savedLang = PreferenceUtils.getStringValue(PreferenceUtils.languageCode, "en");
    if (savedLang.isNotEmpty) {
      Get.updateLocale(Locale(savedLang));
    }
  }

  void changeLanguage(String langCode) {
    Locale locale = Locale(langCode);
    Get.updateLocale(locale);
    _saveLanguage(langCode);
  }

  Future<void> _saveLanguage(String langCode) async {
    await PreferenceUtils.setStringValue(PreferenceUtils.languageCode, langCode);
  }
}