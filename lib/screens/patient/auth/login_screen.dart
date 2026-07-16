import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/auth_controller/login_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/auth/doctor_login_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/forgot_password_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/sign_up_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/screen/hospital_auth/registration.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

import '../../../component/dot_divider.dart';
import '../../../controller/patient/auth_controller/google_auth_controller.dart';
import '../../../controller/patient/auth_controller/sign_up_controller.dart';
import '../../../controller/patient/language_controller/language_controller.dart';
import '../account/language_button/language_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LogInController logInController = Get.put(LogInController());

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final GoogleAuthController googleAuthController = Get.put(GoogleAuthController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        body: WillPopScope(
          onWillPop: () async => false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: height * 0.05),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        LanguageButton().showLanguageDialog();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade50,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.language,
                              size: 18,
                              color: Colors.black87,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "EN", // you can make this dynamic
                              style: TextStyleConst.mediumTextStyle(
                                Colors.black87,
                                13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                  ],
                ),
                /// Logo Section
                Container(
                  alignment: Alignment.center,
                  height: height / 4.2,
                  //color: ColorConst.bgGreyColor,
                  child: Container(
                    height: 100,
                    width: 100,

                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage(ImageUtils.hospitalSplashLogo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      // SizedBox(height: height * 0.02),

                      /// Welcome back text
                      Text(
                        StringUtils.welcomeBack,
                        style: TextStyleConst.boldTextStyle(
                          ColorConst.blackColor,
                          width * 0.08,
                        ),
                      ),
                      SizedBox(height: height * 0.04),

                      /// Email TextField
                      CommonTextField(
                        controller: logInController.emailController,
                        keyBoardType: TextInputType.emailAddress,
                        validator: (value) => null,
                        hintText: StringUtils.enterYourEmail,
                        focusNode: emailFocus,
                        borderRadius: 30,
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: ColorConst.hintGreyColor),
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(passwordFocus),
                      ),
                      SizedBox(height: height * 0.02),

                      /// Password TextField
                      Obx(() => CommonTextField(
                            obscureText: !logInController.showPassword.value,
                            borderRadius: 30,
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: ColorConst.hintGreyColor),
                            suffixIcon: InkWell(
                              onTap: () => logInController.hideAndShowPassword(),
                              child: Icon(
                                logInController.showPassword.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: ColorConst.hintGreyColor,
                              ),
                            ),
                            maxLine: 1,
                            controller: logInController.passwordController,
                            validator: (value) => null,
                            hintText: StringUtils.enterYourPassword,
                            focusNode: passwordFocus,
                            onEditingComplete: () =>
                                FocusScope.of(context).unfocus(),
                          )),
                      SizedBox(height: height * 0.010),

                      /// Remember Me & Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(() => Checkbox(
                                    value: logInController.isRememberMe.value,
                                    onChanged: (value) {
                                      logInController.isRememberMe.value =
                                          value!;
                                    },
                                    activeColor: ColorConst.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  )),
                              Text(
                                StringUtils.rememberPassword,
                                style: TextStyleConst.mediumTextStyle(
                                    ColorConst.hintGreyColor,
                                    width * 0.035
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              logInController.emailController.clear();
                              logInController.passwordController.clear();
                              Get.to(() => ForgotPasswordScreen(),
                                  transition: Transition.rightToLeft);
                            },
                            child: Text(
                              StringUtils.forgotPassword,
                              style: TextStyleConst.mediumTextStyle(
                            ColorConst.hintGreyColor,
                                  width * 0.035
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),

                      /// Login Button
                      CommonButton(
                        textStyleConst: TextStyleConst.mediumTextStyle(
                            ColorConst.whiteColor, width * 0.045),
                        onTap: () => logInController.loginPatient(context),
                        color: ColorConst.primaryColor,
                        text: StringUtils.login,
                        width: width,
                        height: 55,
                      ),
                      SizedBox(height: height * 0.02),

                      /// Create Account link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text(
                              StringUtils.dontHaveAccount,
                              style: TextStyleConst.regularTextStyle(
                                ColorConst.hintGreyColor,
                                14,
                              ),
                            ),

                          InkWell(
                            onTap: () {
                              logInController.emailController.clear();
                              logInController.passwordController.clear();
                              Get.to(() => SignUpScreen());
                            },
                            child: Text(
                              StringUtils.createAccount,
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(color: ColorConst.borderGreyColor, thickness: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              StringUtils.orSignInWith,
                              style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 14),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: ColorConst.borderGreyColor, thickness: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),

                      InkWell(
                        onTap: () => googleAuthController.signInWithGoogle(), // Points to the new separate controller
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 50,
                          width: width,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorConst.borderGreyColor, width: 1.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                StringUtils.continueWithGoogle,
                                style: TextStyleConst.boldTextStyle(
                                  ColorConst.blackColor,
                                  width * 0.042,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),    /// Doctor/Hospital Login Redesign

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2.0), // Adds a slight lift from the bottom screen edge
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// --- Refined Dashed Divider ---
                DashDivider(
                  color: Colors.grey.withOpacity(0.5), // Softer, more elegant color
                  dashWidth: 5.0,
                  dashHeight: 1.0,  // Thinner line looks more premium
                  dashSpacing: 4.0,
                ),

                // const SizedBox(height: 12), // Breathing room between divider and button

                /// --- Professional TextButton with Ripple Effect ---
                TextButton(
                  onPressed: () {
                    logInController.emailController.clear();
                    logInController.passwordController.clear();
                    Get.to(() => DoctorLoginScreen(),
                        transition: Transition.rightToLeft);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Smooth rounded corners for the tap ripple
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Hugs the contents tightly in the center
                    children: [
                      // A clean, professional icon to replace the gradient box
                      const Icon(
                        Icons.business_center_outlined, // Or use Icons.local_hospital_outlined
                        color: Color(0xFF2C435C),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        StringUtils.doctorHospitalLogin,
                        style: TextStyleConst.mediumTextStyle(
                          const Color(0xFF2C435C),
                          16, // Slightly larger for readability
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Subtle arrow to indicate navigation
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF2C435C),
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // Scaffold closing bracket
    ); // GestureDetector closing bracket
  }
}