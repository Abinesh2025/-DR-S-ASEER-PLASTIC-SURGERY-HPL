import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/auth_controller/send_token_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key,required this.state,}) : super(key: key);
  final GoRouterState state;
  final SendTokenController sendTokenController = Get.put(SendTokenController());

  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        Container(
                          height: height / 3.2,
                          width: width,
                          color: ColorConst.bgGreyColor,
                        ),
                        Container(
                          height: height / 1.54,
                          width: double.infinity,
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
                            padding: EdgeInsets.only(top: height * 0.06, left: 20, right: 20),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  /// SignIn
                                  Text(
                                    StringUtils.resetPassword,
                                    style: TextStyleConst.boldTextStyle(Colors.black, width * 0.06),
                                  ),
                                  SizedBox(height: height * 0.03),

                                  /// Email TextField
                                  CommonTextField(
                                    controller: sendTokenController.newPassword,
                                    keyBoardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      return null;
                                    },
                                    hintText: StringUtils.enterNewPassword,
                                    focusNode: passwordFocus,
                                    onEditingComplete: () =>
                                        FocusScope.of(context).requestFocus(confirmPasswordFocus),
                                  ),
                                  SizedBox(height: height * 0.02),

                                  /// password TextField
                                  CommonTextField(
                                    maxLine: 1,
                                    controller: sendTokenController.confirmPassword,
                                    validator: (value) {
                                      return null;
                                    },
                                    hintText: StringUtils.enterNewPassword,
                                    focusNode: confirmPasswordFocus,
                                    onEditingComplete: () =>
                                        FocusScope.of(context).unfocus(),
                                  ),
                                  SizedBox(height: height * 0.06),

                                  /// Login button
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonButton(
                                        textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                        onTap: () {
                                          String token = state.uri.toString().split('token=').last.split('&').first;
                                          String email = state.uri.toString().split('email=').last.split('&').first;
                                          sendTokenController.sendToken(context, email, token);
                                        },
                                        color: ColorConst.blueColor,
                                        text: StringUtils.save,
                                        width: width / 2.3,
                                        height: 50,
                                      ),
                                      CommonButton(
                                        textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
                                        onTap: () {
                                         Get.back();
                                        },
                                        color: ColorConst.borderGreyColor,
                                        text: StringUtils.cancel,
                                        width: width / 2.3,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.04)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
