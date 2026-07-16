import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/appointment_controller/appointment_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/cancel_appointment/cancel_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/delete_appointment/delete_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/filter/filter_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class PatientFilterAppointmentController extends GetxController {
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  FilterAppointmentModel? filterAppointmentModel;
  CancelAppointmentModel? cancelAppointmentModel;
  DeleteAppointmentModel? deleteAppointmentModel;
  RxBool isApiCall = false.obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   if (PreferenceUtils.getStringValue("role") == "Patient") {
  //     if (appointmentController.currentIndex.value == 0) {
  //       getAppointment("past");
  //     }
  //   }
  // }
  @override
  void onInit() {
    super.onInit();

    if (PreferenceUtils.getStringValue("role") == "Patient") {
      // Respect the existing index (e.g. from notification navigation)
      Future.delayed(Duration.zero, () {
        changeIndex(appointmentController.currentIndex.value);
      });
    }
  }

  // Future<void> changeIndex(int index) async {
  //   isApiCall.value = false;
  //   switch (index) {
  //     case 0:
  //       appointmentController.currentIndex.value = 0;
  //       await getAppointment("past");
  //       break;
  //     case 1:
  //       appointmentController.currentIndex.value = 1;
  //       await getAppointment("pending");
  //       break;
  //     case 2:
  //       appointmentController.currentIndex.value = 2;
  //       await getAppointment("cancelled");
  //       break;
  //     case 3:
  //       appointmentController.currentIndex.value = 3;
  //       await getAppointment("completed");
  //       break;
  //     case 4:
  //       appointmentController.currentIndex.value = 4;
  //       await getAppointment("checked_out");
  //       break;
  //   }
  // }
  Future<void> changeIndex(int index) async {
    isApiCall.value = false;
    appointmentController.currentIndex.value = index;

    switch (index) {
      case 0:
        await getAppointment("pending"); // 🔥 Upcoming
        break;
      case 1:
        await getAppointment("checked"); // 🔥 Confirmed -> maps to completed for user
        break;
      case 2:
        await getAppointment("checked_out"); // 🔥 Completed -> maps to checked_out for user
        break;
      case 3:
        await getAppointment("cancelled"); // 🔥 Cancelled
        break;
    }
  }

  Future<void> getAppointment(String filter) async {
    await StringUtils.client
        .getPastAppointments(PreferenceUtils.getStringValue("token"), filter)
        .then((value) {
      filterAppointmentModel = value;
      isApiCall.value = true;
    }).onError((DioException error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }

  void deleteAppointment(int id) {
    isApiCall.value = false;
    StringUtils.client
        .deleteAppointment(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteAppointmentModel = value;
        if (deleteAppointmentModel!.success == true) {
          int current = appointmentController.currentIndex.value;
          // Refresh the list based on current tab

          switch (current) {
            case 0:
              getAppointment("pending"); // ✅ Upcoming
              break;
            case 1:
              getAppointment("checked"); // ✅ Confirmed
              break;
            case 2:
              getAppointment("checked_out"); // ✅ Completed
              break;
            case 3:
              getAppointment("cancelled"); // ✅ Cancelled
              break;
          }
          // switch (current) {
          //   case 0:
          //     getAppointment("past");
          //     break;
          //   case 2:
          //     getAppointment("cancelled");
          //     break;
          //   case 3:
          //     getAppointment("completed");
          //     break;
          //   case 4:
          //     getAppointment("checked_out");
          //     break;
          //   // For pending (index 1), handled by deletePendingAppointment usually, but safety check:
          //   case 1:
          //     getAppointment("pending");
          //     break;
          // }
        }
        // Ensure dialog is closed if open
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DeleteAppointmentModel();
      });
  }

  void cancelledPendingAppointment(int id) {
    isApiCall.value = false;
    StringUtils.client
        .cancelAppointment(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        cancelAppointmentModel = value;
        if (cancelAppointmentModel!.success == true) {
          appointmentController.currentIndex.value = 0;
          getAppointment("pending");
        }
        // Ensure dialog is closed if open
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      })
      ..onError((DioException error, stackTrace) {
        // Close dialog on error too? Maybe better to show error.
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        CheckSocketException.checkSocketException(error);
        return CancelAppointmentModel();
      });
  }

  void deletePendingAppointment(int id) {
    isApiCall.value = false;
    StringUtils.client
        .deleteAppointment(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteAppointmentModel = value;
        if (deleteAppointmentModel!.success == true) {
          appointmentController.currentIndex.value = 0;
          getAppointment("pending");
        }
        // Ensure dialog is closed if open
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      })
      ..onError((DioException error, stackTrace) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        CheckSocketException.checkSocketException(error);
        return DeleteAppointmentModel();
      });
  }
}
