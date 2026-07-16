import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/auth_controller/sign_up_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

import '../../../controller/patient/auth_controller/google_auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final SignUpController signUpController = Get.put(SignUpController());
  final GoogleAuthController googleAuthController = Get.put(GoogleAuthController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              /// Logo Section
              // Container(
              //   alignment: Alignment.center,
              //   height: height / 4,
              //   // Inheriting transparent logo background from Login's logic
              //   child: Container(
              //     height: 100,
              //     width: 100,
              //     decoration: const BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage(ImageUtils.hospitalSplashLogo),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: height * 0.1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    /// Welcome Text
                    Text(
                      "Sign up and Improve Your Health Today",
                      textAlign: TextAlign.center,
                      style: TextStyleConst.boldTextStyle(
                        ColorConst.blackColor,
                        width * 0.07,
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    /// First Name TextField
                    CommonTextField(
                      controller: signUpController.firstController,
                      validator: (value) => null,
                      hintText: "Enter your first name",
                      borderRadius: 30,
                      prefixIcon: const Icon(Icons.person_outline,
                          color: ColorConst.hintGreyColor),
                    ),
                    SizedBox(height: height * 0.01),

                    /// Last Name TextField
                    CommonTextField(
                      controller: signUpController.lastController,
                      validator: (value) => null,
                      hintText: "Enter your last name",
                      borderRadius: 30,
                      prefixIcon: const Icon(Icons.person_outline,
                          color: ColorConst.hintGreyColor),
                    ),
                    SizedBox(height: height * 0.01),

                    /// Email TextField
                    CommonTextField(
                      controller: signUpController.emailController,
                      keyBoardType: TextInputType.emailAddress,
                      validator: (value) => null,
                      hintText: "Enter your email",
                      borderRadius: 30,
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: ColorConst.hintGreyColor),
                    ),
                    SizedBox(height: height * 0.01),

                    /// Mobile Number TextField
                    CommonTextField(
                      controller: signUpController.phoneController,
                      keyBoardType: TextInputType.phone,
                      validator: (value) => null,
                      hintText: "Enter your mobile number",
                      borderRadius: 30,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      prefixIcon: const Icon(Icons.phone_android_outlined,
                          color: ColorConst.hintGreyColor),

                    ),
                    SizedBox(height: height * 0.01),

                    /// Password TextField
                    Obx(() => CommonTextField(
                          obscureText: !signUpController.showPassword.value,
                          borderRadius: 30,
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: ColorConst.hintGreyColor),
                          suffixIcon: InkWell(
                            onTap: () => signUpController.showPassword.value =
                                !signUpController.showPassword.value,
                            child: Icon(
                              signUpController.showPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: ColorConst.hintGreyColor,
                            ),
                          ),
                          maxLine: 1,
                          controller: signUpController.passwordController,
                          validator: (value) => null,
                          hintText: "Enter your password",
                        )),
                    SizedBox(height: height * 0.01),

                    /// Confirm Password TextField
                    Obx(() => CommonTextField(
                          obscureText:
                              !signUpController.showConfirmPassword.value,
                          borderRadius: 30,
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: ColorConst.hintGreyColor),
                          suffixIcon: InkWell(
                            onTap: () => signUpController
                                    .showConfirmPassword.value =
                                !signUpController.showConfirmPassword.value,
                            child: Icon(
                              signUpController.showConfirmPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: ColorConst.hintGreyColor,
                            ),
                          ),
                          maxLine: 1,
                          controller: signUpController.confirmPasswordController,
                          validator: (value) => null,
                          hintText: "Enter your confirm password",
                        )),
                    SizedBox(height: height * 0.01),

                    /// Remember Me
                    Row(
                      children: [
                        Obx(() => Checkbox(
                              value: signUpController.currentIndex.value == 0,
                              onChanged: (value) {
                                signUpController.currentIndex.value =
                                    value! ? 0 : 1;
                              },
                              activeColor: ColorConst.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            )),
                        const Text(
                          "Remember me",
                          style: TextStyle(
                            color: ColorConst.hintGreyColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.01),

                    /// Sign Up Button
                    CommonButton(
                      textStyleConst: TextStyleConst.mediumTextStyle(
                          ColorConst.whiteColor, width * 0.045),
                      onTap: () => signUpController.registerUser(),
                      color: ColorConst.primaryColor,
                      text: "Sign up",
                      width: width,
                      height: 55,
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: ColorConst.borderGreyColor, thickness: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or sign up with",
                            style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 14),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: ColorConst.borderGreyColor, thickness: 1),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.03),

                    /// --- ADDED: Google Sign-In Button ---
                    InkWell(
                      onTap: () => googleAuthController.signInWithGoogle(),
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 55,
                        width: width,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConst.borderGreyColor, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Using a Flutter icon. If you have a Google logo asset,
                            // replace this Icon with: Image.asset('assets/image/google.png', height: 24),
                            // Icon(Icons.g_mobiledata, color: Colors.redAccent, size: 32),
                            SvgPicture.asset(
                              "assets/icon/icons8-google.svg",
                              height: 25,
                              width: 25,
                              // colorFilter: const ColorFilter.mode(
                              //   Colors.redAccent,
                              //   BlendMode.srcIn,
                              // ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Continue with Google",
                              style: TextStyleConst.boldTextStyle(
                                ColorConst.blackColor,
                                width * 0.042,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    /// Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyleConst.regularTextStyle(
                            ColorConst.hintGreyColor,
                            14,
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.back(),
                          child: Text(
                            "Login",
                            style: TextStyleConst.boldTextStyle(
                              ColorConst.blackColor,
                              14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
