import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/main.dart'; // Ensure router is accessible from here

// 1. ADDED IMPORT FOR LOGIN MODEL
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/login_model.dart';

import '../../../services/notification_service.dart';
import '../../app_setting_controller.dart';

class GoogleAuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;
  final String _webClientId = ConfigUtils.googleClientId;
  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      // Pass the serverClientId during initialization
      await _googleSignIn.initialize(
        serverClientId: _webClientId,
      );
      _isGoogleSignInInitialized = true;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      CommonLoader.showLoader();

      // Ensure the plugin is initialized (Required in v7+)
      await _ensureGoogleSignInInitialized();

      // Safely disconnect first to ensure the user gets the "Choose Account" popup
      try {
        await _googleSignIn.disconnect();
      } catch (_) {
        // Ignore if the user isn't signed in yet
      }

      // 1. Trigger Authentication (Identify the user)
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      // 2. Trigger Authorization (Get the Access Token)
      var authorization = await googleUser.authorizationClient.authorizationForScopes(['email', 'profile']);
      authorization ??= await googleUser.authorizationClient.authorizeScopes(['email', 'profile']);

      final String? accessToken = authorization.accessToken;

      if (accessToken == null) {
        CommonLoader.hideLoader();
        DisplaySnackBar.displaySnackBar("Failed to retrieve Google Access Token.", 3, ColorConst.redColor);
        return;
      }

      // 3. Prepare the data for your API
      String hospitalSku = ConfigUtils.hospitalSku;
      String? fcmToken = await NotificationService().getToken();
      Map<String, dynamic> requestData = {
        "token": accessToken,
        "fcm_token":fcmToken ?? PreferenceUtils.getStringValue("fcm_token"),
      };

      // 4. Call the API
      StringUtils.client.loginWithGoogle(requestData,hospitalSku)
        ..then((value) async {
          if (value.success == true) {
            // Save User Data to Preferences
            await PreferenceUtils.setStringValue("token", "Bearer ${value.data!.token!}");
            await PreferenceUtils.setStringValue("first_name", value.data!.user!.first_name!);
            await PreferenceUtils.setStringValue("last_name", value.data!.user!.last_name ?? "");
            await PreferenceUtils.setStringValue("email", value.data!.user!.email!);
            await PreferenceUtils.setStringValue("phone_number", value.data!.user!.phone_number ?? "");
            await PreferenceUtils.setStringValue("image_url", StringUtils.fixImageUrl(value.data!.user!.image_url ?? ""));
            await PreferenceUtils.setStringValue("id", "${value.data!.user!.id}");
            
            // Populate VariableUtils to pre-fill CompleteProfileScreen
            String prefillFirstName = value.data!.user!.first_name ?? "";
            String prefillLastName = value.data!.user!.last_name ?? "";
            // Always prioritize the email from the Google account so the user sees the right one!
            String prefillEmail = googleUser.email;
            String prefillImageUrl = StringUtils.fixImageUrl(value.data!.user!.image_url ?? "");

            if (prefillFirstName.trim().isEmpty || prefillFirstName.trim().toUpperCase() == "N/A") {
                if (googleUser.displayName != null && googleUser.displayName!.isNotEmpty) {
                    List<String> nameParts = googleUser.displayName!.trim().split(" ");
                    prefillFirstName = nameParts.first;
                    if (nameParts.length > 1) {
                        prefillLastName = nameParts.sublist(1).join(" ");
                    }
                }
            }
            
            if (prefillImageUrl.trim().isEmpty || prefillImageUrl.trim().toUpperCase() == "N/A") {
                prefillImageUrl = googleUser.photoUrl ?? "";
            }

            VariableUtils.firstName.value = prefillFirstName;
            VariableUtils.lastName.value = prefillLastName;
            VariableUtils.email.value = prefillEmail;
            VariableUtils.phoneNo.value = value.data!.user!.phone_number ?? "";
            VariableUtils.imageUrl.value = prefillImageUrl;
            VariableUtils.patientId.value = "${value.data!.user!.id}";
            VariableUtils.userId.value = "${value.data!.user!.id}";
            
            await PreferenceUtils.setStringValue("role", value.data!.role!);

            // Setup Home Controllers
            final patientHomeController = Get.put(PatientHomeController(), permanent: true);
            patientHomeController.refreshData();

            if (Get.isRegistered<AppSettingController>()) {
              await Get.find<AppSettingController>().fetchSettings();
            }

            final mainHomeController = Get.put(HomeController(), permanent: true);
            mainHomeController.getHomePageWidget();
            mainHomeController.getAppBarTitle();

            CommonLoader.hideLoader();
            DisplaySnackBar.displaySnackBar("Google Login successful", 3, ColorConst.greenColor);

            // Navigate to Home Dashboard
            // inside loginPatient success block
            bool isMissingInfo =
                (value.data!.user!.first_name == null ||
                    value.data!.user!.first_name!.trim().isEmpty ||
                    value.data!.user!.first_name!.trim() == "N/A") ||
                    (value.data!.user!.phone_number == null ||
                        value.data!.user!.phone_number!.trim().isEmpty ||
                        value.data!.user!.phone_number!.trim() == "N/A");

            print("DEBUG: first_name: ${value.data!.user!.first_name}");
            print("DEBUG: phone_number: ${value.data!.user!.phone_number}");
            print("DEBUG: isMissingInfo: $isMissingInfo");

            CommonLoader.hideLoader();

            if (isMissingInfo) {
              print("DEBUG: Navigating to /phone");
              // Try using Get.offAll for a forced redirect if router.go is failing
              // Get.offAll(() => const CompleteProfileScreen());
              router.go('/phone');
            } else {
              print("DEBUG: Navigating to /home");
              router.go('/home');
              // emailController.clear();
              // passwordController.clear();
            }
          } else {
            CommonLoader.hideLoader();
            DisplaySnackBar.displaySnackBar(value.message ?? "Google Login failed", 3, ColorConst.redColor);
          }
        })
        ..onError((DioException error, stackTrace) {
          CommonLoader.hideLoader();
          CheckSocketException.checkSocketException(error);

          // 2. ADDED RETURN STATEMENT HERE TO FIX THE ERROR
          return LoginModel();
        });

    } catch (error) {
      CommonLoader.hideLoader();
      print('Google Sign-In Cancelled or Errored: $error');

      if (error.toString().contains('canceled') || error.toString().contains('sign_in_canceled')) {
        return;
      }

      DisplaySnackBar.displaySnackBar("Google Sign-In failed: $error", 3, ColorConst.redColor);
    }
  }
}