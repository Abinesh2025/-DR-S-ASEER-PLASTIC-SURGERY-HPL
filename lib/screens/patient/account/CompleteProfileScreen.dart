import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_phone_textfield.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_required_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/my_account_controller/edit_profile_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileScreen extends StatelessWidget {
  CompleteProfileScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            isGradient: true,
            title: StringUtils.completeYourProfile,
            // Since this is a mandatory step after login, we usually hide the back button
            leadIcon: const Icon(
              Icons.arrow_back,
              color: Colors.transparent, // Makes it invisible
            ),
            leadOnTap: () {
              // Instead of popping, navigate specifically to login
              context.go('/login');
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form( // 1. ADD THIS FORM WIDGET
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),
                    Text(
                      StringUtils.almostThereDetails,
                      style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.04),
                    ),
                    SizedBox(height: height * 0.04),
              
                    CommonRequiredText(width: width, text: StringUtils.firstName),
                    SizedBox(height: 8),
                    CommonTextField(
                      controller: controller.firstNameController,
                      hintText: StringUtils.enterFirstName,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return StringUtils.errFirstNameRequired;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CommonRequiredText(width: width, text: StringUtils.lastName),
                    SizedBox(height: 8),
                    CommonTextField(
                      controller: controller.lastNameController,
                      hintText: StringUtils.enterLastName,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return StringUtils.errLastNameRequired;
                        }
                        return null;
                      },
                    ),
              
                    SizedBox(height: 20),
                    // CommonRequiredText(width: width, text: StringUtils.email),
                    // SizedBox(height: 8),
                    // CommonTextField(
                    //   controller: controller.emailController,
                    //   hintText: "Enter Email Address",
                    //   validator: (value) {
                    //     if (value == null || value.trim().isEmpty) {
                    //       return "Email is required";
                    //     } else if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)) {
                    //       return "Enter a valid email address";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    //
                    // SizedBox(height: 20),
                    CommonRequiredText(width: width, text: StringUtils.phone),
                    SizedBox(height: 8),
                    CommonPhoneTextField(
                      initialCountryCode: 'IN',
                      controller: controller.phoneController,
                      onCountryChanged: (phoneCountry) {
                        controller.regionCodeController.text = phoneCountry.dialCode;
                        controller.update();
                      },
                    ),
              
                    SizedBox(height: height * 0.05),
                    CommonButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        if (!_formKey.currentState!.validate()) {
                          return; // ❌ stop here if validation fails
                        }

                        controller.updateProfile(
                          onSuccess: () {
                            context.go('/home');
                          },
                        );
                      },
                      color: ColorConst.primaryColor,
                      text: StringUtils.submitAndContinue,
                      width: width,
                      height: 50,
                      isLoading: controller.isLoading,
                      textStyleConst: TextStyleConst.mediumTextStyle(
                          ColorConst.whiteColor, width * 0.05),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}