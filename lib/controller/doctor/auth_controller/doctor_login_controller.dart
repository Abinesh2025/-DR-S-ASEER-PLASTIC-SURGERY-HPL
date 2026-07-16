import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/login_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/main.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/services/notification_service.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';

import '../../app_setting_controller.dart';

class DoctorLoginController extends GetxController {
  LoginModel? loginModel;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool showPassword = false.obs;

  void hideAndShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> loginDoctor(BuildContext context) async {
    String hospitalSku = ConfigUtils.hospitalSku;

    if (emailController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter email address", 3, ColorConst.redColor);
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter password", 3, ColorConst.redColor);
      return;
    }

    CommonLoader.showLoader();

    try {
      String? fcmToken = await NotificationService().getToken();

      final value = await StringUtils.client.loginDoctor(
        {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "fcm_token": fcmToken ?? PreferenceUtils.getStringValue("fcm_token"),
        },
        hospitalSku,
      );

      if (value.success == true) {
        final role = value.data!.role;

        // BLOCK PATIENTS FROM USING DOCTOR PORTAL
        if (role == "Patient") {
          CommonLoader.hideLoader();
          DisplaySnackBar.displaySnackBar(
              "Account error. Please use the Patient Login Portal.",
              3,
              ColorConst.redColor);
          return;
        }

        await PreferenceUtils.setStringValue(
            "token", "Bearer ${value.data!.token!}");
        await PreferenceUtils.setStringValue(
            "first_name", value.data!.user!.first_name!);
        await PreferenceUtils.setStringValue(
            "last_name", value.data!.user!.last_name!);
        await PreferenceUtils.setStringValue("email", value.data!.user!.email!);
        await PreferenceUtils.setStringValue(
            "phone_number", value.data!.user!.phone_number!);
        await PreferenceUtils.setStringValue(
            "image_url", StringUtils.fixImageUrl(value.data!.user!.image_url!));
        await PreferenceUtils.setStringValue(
            "password", passwordController.text);
        await PreferenceUtils.setStringValue("id", "${value.data!.user!.id}");

        VariableUtils.patientId.value = "${value.data!.user!.id}";
        VariableUtils.userId.value = "${value.data!.user!.id}";
        await PreferenceUtils.setStringValue("role", role!);

        // Using standard HomeController to load the correct dashboard based on role
        final mainHomeController = Get.put(HomeController(), permanent: true);
        mainHomeController.getHomePageWidget();
        mainHomeController.getAppBarTitle();

        // Fetch app settings for doctor
        if (Get.isRegistered<AppSettingController>()) {
          await Get.find<AppSettingController>().fetchSettings();
        }

        CommonLoader.hideLoader();

        router.go('/home');
        emailController.clear();
        passwordController.clear();
      } else {
        DisplaySnackBar.displaySnackBar(
            value.message ?? "Login failed", 3, ColorConst.redColor);
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 422) {
        DisplaySnackBar.displaySnackBar(
          error.response?.data["message"] ?? "Invalid email or password",
          3,
          ColorConst.redColor,
        );
      } else {
        CheckSocketException.checkSocketException(error);
      }
    } catch (e) {
      debugPrint("Doctor Login error: $e");
      DisplaySnackBar.displaySnackBar(
          "Something went wrong", 3, ColorConst.redColor);
    } finally {
      Future.delayed(Duration.zero, () {
        CommonLoader.hideLoader();
      });
    }
  }
}
