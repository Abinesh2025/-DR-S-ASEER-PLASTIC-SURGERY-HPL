import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_phone_textfield.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/auth_controller/registration_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class HospitalSignUpScreen extends StatelessWidget {
  HospitalSignUpScreen({Key? key}) : super(key: key);

  final HospitalSignUpController hospitalSignUpController = Get.put(HospitalSignUpController());

  final FocusNode hospitalNameFocus = FocusNode();
  final FocusNode hospitalSlugFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorConst.bgGreyColor,
          body: ListView(
            //shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  /// top logo
                  Container(
                    alignment: Alignment.center,
                    height: height / 3.2,
                    color: ColorConst.bgGreyColor,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageUtils.hospitalSplashLogo),
                        ),
                      ),
                    ),
                  ),

                  /// bottom container
                  Container(
                    height: height / 1.53,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      bottom: mediaQuery.viewInsets.bottom,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConst.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConst.greyShadowColor,
                          blurRadius: 5,
                          spreadRadius: 3,
                          offset: const Offset(0, -5),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(60),
                        topLeft: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.06, left: 20, right: 20),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Sign up
                            Center(
                              child: Text(
                                StringUtils.hospitalRegistration,
                                style: TextStyleConst.boldTextStyle(
                                  Colors.black,
                                  width * 0.06,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.03),

                            /// Hospital Name TextField
                            CommonTextField(
                              controller: hospitalSignUpController.hospitalNameController,
                              keyBoardType: TextInputType.emailAddress,
                              validator: (value) {
                                return null;
                              },
                              hintText: "Hospital Name",
                              focusNode: hospitalNameFocus,
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(hospitalSlugFocus),

                            ),
                            SizedBox(height: height * 0.02),

                            /// Hospital Slug TextField
                            CommonTextField(
                              controller: hospitalSignUpController.hospitalSlugController,
                              keyBoardType: TextInputType.emailAddress,
                              validator: (value) {
                                return null;
                              },
                              hintText: "Hospital Slug",
                              focusNode: hospitalSlugFocus,
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(emailFocus),

                            ),
                            SizedBox(height: height * 0.02),

                            /// Email TextField
                            CommonTextField(
                              controller: hospitalSignUpController.emailController,
                              keyBoardType: TextInputType.emailAddress,
                              validator: (value) {
                                return null;
                              },
                              hintText: "Enter Email Address",
                              focusNode: emailFocus,
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(phoneFocus),

                            ),
                            SizedBox(height: height * 0.02),

                            /// Phone Number TextField
                            CommonPhoneTextField(
                              controller: hospitalSignUpController.phoneController,
                              initialCountryCode: 'IN',

                              onCountryChanged: (phoneCountry) {
                                hospitalSignUpController.prefixCodeController.text = phoneCountry.dialCode;
                              },
                              focusNode: phoneFocus,
                              onSubmitted: (_) => FocusScope.of(context).requestFocus(passwordFocus),
                            ),

                            SizedBox(height: height * 0.02),

                            /// Password TextField
                            Obx(
                              () => CommonTextField(
                                obscureText: !hospitalSignUpController.showPassword.value,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    hospitalSignUpController.showPassword.value = !hospitalSignUpController.showPassword.value;
                                  },
                                  child: !hospitalSignUpController.showPassword.value
                                      ? const Icon(Icons.visibility_off_outlined, color: Colors.black)
                                      : const Icon(Icons.visibility, color: Colors.black),
                                ),
                                controller: hospitalSignUpController.passwordController,
                                maxLine: 1,
                                keyBoardType: TextInputType.emailAddress,
                                validator: (value) {
                                  return null;
                                },
                                hintText: "Enter Password",
                                focusNode: passwordFocus,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(confirmPasswordFocus),

                              ),
                            ),
                            SizedBox(height: height * 0.02),

                            /// Confirm password TextField
                            Obx(
                              () => CommonTextField(
                                obscureText: !hospitalSignUpController.showConfirmPassword.value,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    hospitalSignUpController.showConfirmPassword.value = !hospitalSignUpController.showConfirmPassword.value;
                                  },
                                  child: !hospitalSignUpController.showConfirmPassword.value
                                      ? const Icon(Icons.visibility_off_outlined, color: Colors.black)
                                      : const Icon(Icons.visibility, color: Colors.black),
                                ),
                                controller: hospitalSignUpController.confirmPasswordController,
                                keyBoardType: TextInputType.emailAddress,
                                validator: (value) {
                                  return null;
                                },
                                maxLine: 1,
                                hintText: "Confirm Password",
                                focusNode: confirmPasswordFocus,
                                onSubmitted: (_) =>
                                    FocusScope.of(context).unfocus(),

                              ),
                            ),

                            SizedBox(height: height * 0.07),

                            /// Submit button
                            CommonButton(
                              textStyleConst: TextStyleConst.mediumTextStyle(
                                  ColorConst.whiteColor, width * 0.05),
                              onTap: () {
                                hospitalSignUpController.registerUser();
                              },
                              color: ColorConst.blueColor,
                              text: "Submit",
                              width: width,
                              height: 50,
                            ),
                            SizedBox(height: height * 0.02),

                            /// Sign in text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already User?",
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.hintGreyColor,
                                    width * 0.035,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    " Sign In",
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.blueColor,
                                      width * 0.035,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
