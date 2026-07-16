import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_dropdown_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_phone_textfield.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/setting_controller/setting_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SettingController settingController = Get.put(SettingController());

  final FocusNode appNameFocus = FocusNode();
  final FocusNode planExpireFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Obx(() {
      return RefreshIndicator(
        onRefresh: () async {
          settingController.isGetSettings.value = false;
          settingController.getSettings();
        },
        child: settingController.isGetSettings.value == false
            ?  Center(
                child: CircularProgressIndicator(color: ColorConst.primaryColor))
            : Container(
                color: ColorConst.whiteColor,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///app Name textfield
                        CommonText(
                          width: width,
                          text: StringUtils.appName,
                        ),
                        SizedBox(height: height * 0.01),
                        CommonTextField(
                          validator: (value) {
                            return null;
                          },
                          controller: settingController.appNameController,
                          focusNode: appNameFocus,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(planExpireFocus),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),

                        ///planExpire Notification TextField
                        CommonText(
                          width: width,
                          text: StringUtils.planExpireNotification,
                        ),
                        SizedBox(height: height * 0.01),
                        CommonTextField(
                          validator: (value) {
                            return null;
                          },
                          controller: settingController.planExpireNotificationController,
                          focusNode: planExpireFocus,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(phoneFocus),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),

                        ///Default Country Code TextField
                        CommonText(
                          width: width,
                          text: StringUtils.defaultCountryCode,
                        ),
                        SizedBox(height: height * 0.01),
                        CommonPhoneTextField(
                          initialCountryCode: settingController.defaultCountryCodeController.text,
                          controller: settingController.phoneController,
                          onCountryChanged: (phoneCountry) {
                            settingController.defaultCountryCodeController.text = phoneCountry.code;
                          },
                          focusNode: phoneFocus,
                          onSubmitted: (_) =>
                              FocusScope.of(context).unfocus(),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),

                        ///Current Currency textfield
                        CommonText(
                          width: width,
                          text: StringUtils.currentCurrency,
                        ),
                        SizedBox(height: height * 0.01),
                        CommonDropDown(
                          value: settingController.currencyId ?? "usd",
                          onChange: (value) {
                            settingController.currencyId = value;
                          },
                          dropdownItems: settingController.settingsModel?.data?.currency?.map((currency) {
                            return DropdownMenuItem(
                              value: currency.currency_code?.toLowerCase(),
                              child: Text('${currency.currency_icon} ${currency.currency_name}'),
                            );
                          }).toList() ?? [],
                        ),

                        SizedBox(
                          height: height * 0.02,
                        ),

                        ///language textfield
                        CommonText(
                          width: width,
                          text: StringUtils.language,
                        ),
                        SizedBox(height: height * 0.01),
                        CommonDropDown(
                          value: settingController.languageId ?? "en",
                          onChange: (value) {
                            settingController.languageId = value;
                          },
                          dropdownItems: settingController.settingsModel?.data?.language?.map((lang) {
                            return DropdownMenuItem(
                              value: lang.id,
                              child: Text('${lang.name}'),
                            );
                          }).toList() ?? [],
                        ),
                        SizedBox(height: height * 0.02),

                        ///appLogo
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                      width: width, text: StringUtils.appLogo),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        settingController.pickImage1(context);
                                      },
                                      child: settingController.showFile1.value == true
                                          ? Container(
                                              height: height * 0.14,
                                              width: height * 0.14,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(File(settingController.file1?.path ?? "")))),
                                            )
                                          : Container(
                                              height: height * 0.14,
                                              width: height * 0.14,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    (settingController.settingsModel?.data?.app_logo == null ||
                                                            settingController.settingsModel!.data!.app_logo!.isEmpty)
                                                        ? Image.asset(
                                                            ImageUtils.appLogo,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : FadeInImage(
                                                            placeholder: const AssetImage(ImageUtils.appLogo),
                                                            image: NetworkImage(
                                                                settingController.settingsModel!.data!.app_logo!),
                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                              return Image.asset(
                                                                ImageUtils.appLogo,
                                                                fit: BoxFit.cover,
                                                              );
                                                            },
                                                            fit: BoxFit.cover,
                                                          ),
                                                    Center(
                                                      child: SizedBox(
                                                        height: height * 0.03,
                                                        width: height * 0.04,
                                                        child: Image.asset(ImageUtils.cameraIcon),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                      width: width,
                                      text: StringUtils.favicon
                                  ),
                                  SizedBox(height: height * 0.01,),
                                  GestureDetector(
                                      onTap: () {
                                        settingController.pickImage2(context);
                                      },
                                      child: settingController.showFile2.value == true
                                          ? Container(
                                              height: height * 0.14,
                                              width: height * 0.14,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(File(settingController.file2?.path ?? "")))),
                                            )
                                          : Container(
                                              height: height * 0.14,
                                              width: height * 0.14,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    (settingController.settingsModel?.data?.favicon == null ||
                                                            settingController.settingsModel!.data!.favicon!.isEmpty)
                                                        ? Image.asset(
                                                            ImageUtils.favIcon,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : FadeInImage(
                                                            placeholder: const AssetImage(ImageUtils.favIcon),
                                                            image: NetworkImage(
                                                                settingController.settingsModel!.data!.favicon!),
                                                            imageErrorBuilder: (context, error, stackTrace) {
                                                              return Image.asset(
                                                                ImageUtils.favIcon,
                                                                fit: BoxFit.cover,
                                                              );
                                                            },
                                                            fit: BoxFit.cover,
                                                          ),
                                                    Center(
                                                      child: SizedBox(
                                                        height: height * 0.03,
                                                        width: height * 0.04,
                                                        child: Image.asset(ImageUtils.cameraIcon),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonButton(
                              textStyleConst: TextStyleConst.mediumTextStyle(
                                  ColorConst.whiteColor, width * 0.05),
                              onTap: () {
                                  settingController.updateSettings();
                              },
                              color: ColorConst.blueColor,
                              text: StringUtils.save,
                              width: width / 2.3,
                              height: 50,
                            ),
                            CommonButton(
                              textStyleConst: TextStyleConst.mediumTextStyle(
                                  ColorConst.hintGreyColor, width * 0.05),
                              onTap: () {
                                settingController.resetChanges();
                                Get.back();
                              },
                              color: ColorConst.borderGreyColor,
                              text: StringUtils.cancel,
                              width: width / 2.3,
                              height: 50,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
