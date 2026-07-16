import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/color_const.dart';
import '../../../../constant/text_style_const.dart';
import '../../../../controller/patient/language_controller/language_controller.dart';
import '../../../../utils/string_utils.dart';


class LanguageButton extends StatelessWidget {

  // LanguageController get controller => Get.find<LanguageController>();

  LanguageButton({super.key});
  final LanguageController controller =
  Get.isRegistered<LanguageController>()
      ? Get.find<LanguageController>()
      : Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showLanguageDialog();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          children: [
            Icon(CupertinoIcons.globe, size: 24, color: Colors.black87.withOpacity(0.7)),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                StringUtils.changeLanguage,
                style: TextStyleConst.mediumTextStyle(Colors.black87, 18),
              ),
            ),
            Icon(CupertinoIcons.chevron_forward,
                size: 18, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
  void showLanguageDialog() {
    // Get the current language code to highlight the active option.
    // Replace this with your controller's variable if you track it differently.
    final String currentLangCode = Get.locale?.languageCode ?? 'en';

    Get.bottomSheet(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wraps to the content's height
            children: [
              /// Top Drag Handle
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),
        
              /// Header Text
               Text(
                StringUtils.selectLanguage,
                style: TextStyleConst.mediumTextStyle(Colors.black87, 22),
                // TextStyle(
                //   fontSize: 22,
                //   fontWeight: FontWeight.bold,
                //   color: Color(0xFF2C435C), // Premium dark text color
                // ),
              ),
              const SizedBox(height: 6),
              Text(
                StringUtils.choosePreferredLanguage,
                style:TextStyleConst.mediumTextStyle(Colors.grey.shade500, 14) ,),
              const SizedBox(height: 24),
        
              /// Language Options
              _languageTile("English", "English", "en", currentLangCode),
              _languageTile("Hindi", "हिन्दी", "hi", currentLangCode),
              _languageTile("Tamil", "தமிழ்", "ta", currentLangCode),
              _languageTile("Malayalam", "മലയാളം", "ml", currentLangCode),
        
              // Extra bottom padding for safe area
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      isScrollControlled: true, // Allows smooth sizing
      backgroundColor: Colors.transparent, // Important so the rounded corners show
      elevation: 0,
    );
  }

  /// Premium Custom Language Tile
  Widget _languageTile(String title, String nativeName, String code, String currentLangCode) {
    bool isSelected = currentLangCode == code;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () {
          controller.changeLanguage(code);
          Get.back();
        },
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            // Slight background tint if selected
            color: isSelected ? ColorConst.primaryColor.withOpacity(0.08) : Colors.transparent,
            border: Border.all(
              color: isSelected ? ColorConst.primaryColor : Colors.grey.shade200,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              /// First Letter Avatar Indicator
              // Container(
              //   width: 42,
              //   height: 42,
              //   decoration: BoxDecoration(
              //     color: isSelected ? ColorConst.primaryColor : Colors.grey.shade100,
              //     shape: BoxShape.circle,
              //   ),
              //   alignment: Alignment.center,
              //   child: Text(
              //     title[0], // Displays 'E', 'H', 'T', 'M'
              //     style: TextStyle(
              //       color: isSelected ? Colors.white : Colors.grey.shade600,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
              const SizedBox(width: 16),

              /// Language Names
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyleConst.mediumTextStyle(
                        isSelected ? ColorConst.primaryColor : Colors.black87,
                        16,

                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      nativeName,
                      style: TextStyleConst.regularTextStyle(
                        isSelected
                            ? ColorConst.primaryColor.withOpacity(0.8)
                            : Colors.grey.shade500,
                        13,
                      ),
                    ),
                  ],
                ),
              ),
              /// Checkmark for selected item
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: ColorConst.primaryColor,
                  size: 26,
                ),
            ],
          ),
        ),
      ),
    );
  }}