import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_error.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/login_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/home_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/main.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/services/notification_service.dart';

import '../../app_setting_controller.dart';
import '../home_controller/patient_home_controller.dart';

class LogInController extends GetxController {
  LoginModel? loginModel;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isRememberMe = false.obs;
  RxBool showPassword = false.obs;

  void hideAndShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> loginPatient(BuildContext context) async {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
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

    // if (!regExp.hasMatch(emailController.text)) {
    //   DisplaySnackBar.displaySnackBar(
    //       "Please enter valid email address", 3, ColorConst.redColor);
    //   return;
    // }

    CommonLoader.showLoader();

    try {
      String? fcmToken = await NotificationService().getToken();
      
      final value = await StringUtils.client.loginPatient(
        {
          "login": emailController.text,
          "password": passwordController.text,
          "fcm_token": fcmToken ?? PreferenceUtils.getStringValue("fcm_token"),
        },
        hospitalSku,
      );

      if (value.success == true) {
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
        await PreferenceUtils.setStringValue("role", value.data!.role!);

        // Initialize PatientHomeController for data
        final patientHomeController =
            Get.put(PatientHomeController(), permanent: true);
        patientHomeController
            .refreshData(); // 🔥 Force initial data fetch immediately!

        // Fetch app settings for patient
        if (Get.isRegistered<AppSettingController>()) {
          await Get.find<AppSettingController>().fetchSettings();
        }

        // Initialize Global HomeController for navigation state
        final mainHomeController = Get.put(HomeController(), permanent: true);
        mainHomeController.getHomePageWidget();
        mainHomeController.getAppBarTitle();

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
      debugPrint("Login error: $e");
      DisplaySnackBar.displaySnackBar(
          "Something went wrong", 3, ColorConst.redColor);
    } finally {
      Future.delayed(Duration.zero, () {
        CommonLoader.hideLoader();
      });
    }
  }
  // void loginPatient(BuildContext context) {
  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regExp = RegExp(pattern);
  //   String hospitalSku = ConfigUtils.hospitalSku;
  //   if (emailController.text.trim().isEmpty) {
  //     DisplaySnackBar.displaySnackBar(
  //         "Please enter email address", 3, ColorConst.redColor);
  //   } else if (passwordController.text.trim().isEmpty) {
  //     DisplaySnackBar.displaySnackBar(
  //         "Please enter password", 3, ColorConst.redColor);
  //   } else if (!regExp.hasMatch(emailController.text)) {
  //     DisplaySnackBar.displaySnackBar(
  //         "Please enter valid email address", 3, ColorConst.redColor);
  //   } else {
  //     CommonLoader.showLoader();
  //     StringUtils.client.loginPatient(
  //       {
  //         "login": emailController.text,
  //         "password": passwordController.text,
  //         "fcm_token": PreferenceUtils.getStringValue("fcm_token"),
  //       },
  //       hospitalSku,
  //     )
  //       ..then((value) {
  //         loginModel = value;
  //         if (loginModel!.success == true) {
  //           PreferenceUtils.setStringValue(
  //               "token", " ${loginModel!.data!.token!}");
  //           PreferenceUtils.setStringValue(
  //               "first_name", loginModel!.data!.user!.first_name!);
  //           PreferenceUtils.setStringValue(
  //               "last_name", loginModel!.data!.user!.last_name!);
  //           PreferenceUtils.setStringValue(
  //               "email", loginModel!.data!.user!.email!);
  //           PreferenceUtils.setStringValue(
  //               "phone_number", loginModel!.data!.user!.phone_number!);
  //           PreferenceUtils.setStringValue("image_url",
  //               StringUtils.fixImageUrl(loginModel!.data!.user!.image_url!));
  //           PreferenceUtils.setStringValue("password", passwordController.text);
  //           PreferenceUtils.setStringValue(
  //               "id", "${loginModel!.data!.user!.id}");
  //           VariableUtils.patientId.value = "${loginModel!.data!.user!.id}";
  //           VariableUtils.userId.value = "${loginModel!.data!.user!.id}";
  //           PreferenceUtils.setStringValue("role", loginModel!.data!.role!);
  //           Get.put(PatientHomeController(), permanent: true);
  //           Get.offAll(() => const HomeScreen());
  //           emailController.clear();
  //           passwordController.clear();
  //         } else {
  //           CommonError().showMaterialBanner(context, "${value.message}");
  //           //DisplaySnackBar.displaySnackBar("${value.message}", 3 , ColorConst.redColor);
  //         }
  //       })
  //       ..onError((DioException error, stackTrace) {
  //         if (Get.isDialogOpen == true) {
  //           Get.close(1); // close only loader
  //         }
  //
  //         if (error.response?.statusCode == 422) {
  //           DisplaySnackBar.displaySnackBar(
  //             error.response?.data["message"] ?? "Invalid credentials",
  //             3,
  //             ColorConst.redColor,
  //           );
  //         } else {
  //           CheckSocketException.checkSocketException(error);
  //         }
  //
  //         return LoginModel();
  //       });
  //   }
  // }
}
