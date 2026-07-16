import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/sigup_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/services/notification_service.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpController extends GetxController {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxInt currentIndex = 0.obs;

  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  SignUpModel? signUpModel;

  // 1. Initialize Google Sign-In using the v7.0.0+ Singleton pattern
  // final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  // bool _isGoogleSignInInitialized = false;
  //
  // /// In google_sign_in v7+, initialization is absolutely mandatory
  // Future<void> _ensureGoogleSignInInitialized() async {
  //   if (!_isGoogleSignInInitialized) {
  //     await _googleSignIn.initialize();
  //     _isGoogleSignInInitialized = true;
  //   }
  // }

  // 1. Initialize Google Sign-In
  // final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  // SignUpModel? signUpModel;

  void registerUser() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    String hospitalSku = ConfigUtils.hospitalSku;
    if (firstController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter first name", 3, ColorConst.redColor);
    } else if (lastController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter last name", 3, ColorConst.redColor);
    } else if (emailController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter email address", 3, ColorConst.redColor);
    } else if (!regExp.hasMatch(emailController.text.trim())) {
      DisplaySnackBar.displaySnackBar(
          "Please enter valid email address", 3, ColorConst.redColor);
    } else if (phoneController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter mobile number", 3, ColorConst.redColor);
    } else if (passwordController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter password", 3, ColorConst.redColor);
    } else if (passwordController.text.trim().length < 6) {
      DisplaySnackBar.displaySnackBar(
          "Please enter password more then 6 characters",
          3,
          ColorConst.redColor);
    } else if (confirmPasswordController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter confirm password", 3, ColorConst.redColor);
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      DisplaySnackBar.displaySnackBar(
          "Password and Confirm password does not match",
          3,
          ColorConst.redColor);
    } else {
      CommonLoader.showLoader();
      NotificationService().getToken().then((fcmToken) {
        StringUtils.client.patientRegistration(
          hospitalSku,
          firstController.text,
          lastController.text,
          emailController.text,
          phoneController.text,
          currentIndex.value == 0 ? "male" : "female",
          passwordController.text,
          confirmPasswordController.text,
          fcmToken ?? PreferenceUtils.getStringValue("fcm_token"),
        )
          ..then((value) {
            signUpModel = value;
            CommonLoader.hideLoader();
            Get.back();
            DisplaySnackBar.displaySnackBar(
                "Patient registered successfully", 3, ColorConst.greenColor);
          })
          ..onError((DioException error, stackTrace) {
            CommonLoader.hideLoader();
            CheckSocketException.checkSocketException(error);
            return SignUpModel();
          });
      });
    }
  }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     CommonLoader.showLoader();
  //
  //     // Ensure the plugin is initialized (Required in v7+)
  //     await _ensureGoogleSignInInitialized();
  //
  //     // Safely disconnect first to ensure the user gets the "Choose Account" popup
  //     try {
  //       await _googleSignIn.disconnect();
  //     } catch (_) {
  //       // Ignore if the user isn't signed in yet
  //     }
  //
  //     // 1. Trigger Authentication (Identify the user)
  //     final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
  //       scopeHint: ['email', 'profile'],
  //     );
  //
  //     // 2. Trigger Authorization (Get the Access Token - NEW WAY)
  //     // First, try to get the authorization silently
  //     var authorization = await googleUser.authorizationClient.authorizationForScopes(['email', 'profile']);
  //
  //     // If silent authorization returns null, request it explicitly
  //     authorization ??= await googleUser.authorizationClient.authorizeScopes(['email', 'profile']);
  //
  //     final String? accessToken = authorization.accessToken;
  //
  //     if (accessToken == null) {
  //       CommonLoader.hideLoader();
  //       DisplaySnackBar.displaySnackBar("Failed to retrieve Google Access Token.", 3, ColorConst.redColor);
  //       return;
  //     }
  //
  //     // 3. Prepare the data for your new API
  //     String hospitalSku = ConfigUtils.hospitalSku;
  //
  //     Map<String, dynamic> requestData = {
  //       "token": accessToken,
  //       "tenant_id": hospitalSku,
  //     };
  //
  //     // 4. Call the new dedicated Google Login API
  //     StringUtils.client.loginWithGoogle(requestData)
  //       ..then((value) {
  //         CommonLoader.hideLoader();
  //
  //         // TODO: Save the  token and user info from 'value' to PreferenceUtils here
  //
  //         Get.back();
  //         DisplaySnackBar.displaySnackBar("Google Login successful", 3, ColorConst.greenColor);
  //       })
  //       ..onError((DioException error, stackTrace) {
  //         CommonLoader.hideLoader();
  //         CheckSocketException.checkSocketException(error);
  //       });
  //
  //   } catch (error) {
  //     CommonLoader.hideLoader();
  //     print('Google Sign-In Cancelled or Errored: $error');
  //
  //     // If the user simply tapped outside the popup to close it, ignore it silently.
  //     if (error.toString().contains('canceled') || error.toString().contains('sign_in_canceled')) {
  //       return;
  //     }
  //
  //     DisplaySnackBar.displaySnackBar("Google Sign-In failed", 3, ColorConst.redColor);
  //   }
  // }


}
