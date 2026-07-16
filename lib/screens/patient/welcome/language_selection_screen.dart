import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/language_controller/language_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/login_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final LanguageController languageController = Get.find<LanguageController>();
  String selectedCode = "en";

  final List<Map<String, String>> languages = [
    {"name": "English", "code": "en", "flag": "🇺🇸"},
    {"name": "हिन्दी (Hindi)", "code": "hi", "flag": "🇮🇳"},
    {"name": "தமிழ் (Tamil)", "code": "ta", "flag": "🇮🇳"},
    {"name": "മലയാളം (Malayalam)", "code": "ml", "flag": "🇮🇳"},
  ];

  @override
  void initState() {
    super.initState();
    selectedCode = PreferenceUtils.getStringValue(PreferenceUtils.languageCode, "en");
    if(selectedCode.isEmpty) selectedCode = "en";
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConst.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),
              Center(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: ColorConst.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.language_rounded,
                    color: ColorConst.primaryColor,
                    size: 40,
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              Center(
                child: Text(
                  StringUtils.selectLanguage, // "Choose Your Language" / "Select Language"
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 26),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Text(
                  StringUtils.choosePreferredLanguage, // "Select your preferred language to customize your healthcare experience."
                  style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.05),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: languages.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    final lang = languages[index];
                    final isSelected = selectedCode == lang["code"];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCode = lang["code"]!;
                        });
                        languageController.changeLanguage(selectedCode);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: isSelected ? ColorConst.primaryColor.withOpacity(0.08) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? ColorConst.primaryColor : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: ColorConst.primaryColor.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              lang["flag"]!,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                lang["name"]!,
                                style: TextStyleConst.boldTextStyle(
                                  isSelected ? ColorConst.primaryColor : ColorConst.blackColor,
                                  18,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: ColorConst.primaryColor,
                                size: 28,
                              )
                            else
                              Icon(
                                Icons.circle_outlined,
                                color: Colors.grey.shade400,
                                size: 28,
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              CommonButton(
                textStyleConst: TextStyleConst.boldTextStyle(ColorConst.whiteColor, 18),
                onTap: () {
                  languageController.changeLanguage(selectedCode);
                  Get.to(() => LoginScreen(), transition: Transition.rightToLeft);
                },
                color: ColorConst.primaryColor,
                text: "Continue",
                width: width,
                height: 55,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
