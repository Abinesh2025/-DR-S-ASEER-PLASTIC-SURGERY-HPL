import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/auth_controller/doctor_login_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/forgot_password_screen.dart';

class DoctorLoginScreen extends StatelessWidget {
  DoctorLoginScreen({Key? key}) : super(key: key);

  final DoctorLoginController doctorLoginController =
      Get.put(DoctorLoginController());

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Get.back();
            return false;
          },
          child: Stack(
            children: [
              // --- Premium Gradient Background ---
              Container(
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0A5C3E), // Dark Green
                      ColorConst.primaryColor, // Primary Green
                      ColorConst.lightGreen, // Light Green
                    ],
                    stops: [0.0, 0.4, 1.0],
                  ),
                ),
              ),

              // --- Floating Decorative Blurs ---
              Positioned(
                top: -height * 0.1,
                right: -width * 0.2,
                child: _buildBlurCircle(
                    width * 0.8, Colors.white.withOpacity(0.12)),
              ),
              Positioned(
                bottom: height * 0.1,
                left: -width * 0.3,
                child: _buildBlurCircle(
                    width * 0.9, Colors.white.withOpacity(0.08)),
              ),

              // --- Main Content ---
              Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // --- Logo ---
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            ImageUtils.hospitalSplashLogo,
                            height: 60,
                            width: 60,
                          ),
                        ),
                        const SizedBox(height: 30),

                        Text(
                          "Doctor / Hospital ",
                          style: TextStyleConst.boldTextStyle(
                              Colors.white, width * 0.07),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Please enter your details to sign in",
                          style: TextStyleConst.mediumTextStyle(
                              Colors.white.withOpacity(0.9), width * 0.04),
                        ),
                        const SizedBox(height: 35),

                        // --- Login Card ---
                        Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Sign In",
                                style: TextStyleConst.boldTextStyle(
                                    Colors.black87, width * 0.055),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 25),
                              CommonTextField(
                                controller:
                                    doctorLoginController.emailController,
                                keyBoardType: TextInputType.emailAddress,
                                hintText: "Email Address",
                                validator: (value) => null,
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Colors.grey.shade400, size: 20),
                                focusNode: emailFocus,
                                onEditingComplete: () =>
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocus),
                              ),
                              const SizedBox(height: 20),
                              Obx(() => CommonTextField(
                                    obscureText: !doctorLoginController
                                        .showPassword.value,
                                    maxLine: 1,
                                    validator: (value) => null,
                                    suffixIcon: InkWell(
                                      onTap: () => doctorLoginController
                                          .hideAndShowPassword(),
                                      child: Icon(
                                        doctorLoginController
                                                .showPassword.value
                                            ? Icons.visibility
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    controller: doctorLoginController
                                        .passwordController,
                                    hintText: "Password",
                                    prefixIcon: Icon(
                                        Icons.lock_outline_rounded,
                                        color: Colors.grey.shade400,
                                        size: 20),
                                    focusNode: passwordFocus,
                                    onEditingComplete: () =>
                                        FocusScope.of(context).unfocus(),
                                  )),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    doctorLoginController.emailController
                                        .clear();
                                    doctorLoginController.passwordController
                                        .clear();
                                    Get.to(() => ForgotPasswordScreen(),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyleConst.boldTextStyle(
                                        ColorConst.primaryColor, 14),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              CommonButton(
                                onTap: () => doctorLoginController
                                    .loginDoctor(context),
                                color: ColorConst.primaryColor,
                                text: "Sign In",
                                width: double.infinity,
                                height: 54,
                                textStyleConst: TextStyleConst.boldTextStyle(
                                    Colors.white, 16),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        // --- Footer ---
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Don't have an account? Please contact your admin",
                            textAlign: TextAlign.center,
                            style: TextStyleConst.mediumTextStyle(
                                Colors.white.withOpacity(0.9), 15),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlurCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
