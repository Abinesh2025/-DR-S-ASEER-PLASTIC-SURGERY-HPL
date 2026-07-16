import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/appointment_controller/appointment_controllers.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/admin_appointment_model/cancel/cancel_admin_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/admin_appointment_model/confirm/confirm_admin_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/admin_appointment_model/filter_model/filter_admin_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class AdminFilterAppointmentController extends GetxController {
  AdminAppointmentController appointmentController = Get.put(AdminAppointmentController());
  FilterAdminAppointmentModel? filterAdminAppointmentModel;
  CancelAdminAppointmentModel? cancelAdminAppointmentModel;
  ConfirmAdminAppointmentModel? confirmAdminAppointmentModel;
  RxBool isApiCall = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
      if (appointmentController.currentIndex.value == 0) {
        getAllAppointment("all");
      }
  }

  void changeIndex(int index) {
    isApiCall.value = false;
    switch (index) {
      case 0:
        appointmentController.currentIndex.value = 0;
        getAllAppointment("all");
        break;
      case 1:
        appointmentController.currentIndex.value = 1;
        getAllAppointment("pending");
        break;
      case 2:
        appointmentController.currentIndex.value = 2;
        getAllAppointment("cancelled");
        break;
      case 3:
        appointmentController.currentIndex.value = 3;
        getAllAppointment("completed");
        break;
    }
  }

  void getAllAppointment(String filter) {
    StringUtils.client.getAllAppointments(PreferenceUtils.getStringValue("token"), filter).then((value) {
      filterAdminAppointmentModel = value;
      isApiCall.value = true;
    }).onError((DioException error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }

  void cancelledPendingAppointment(int id) {
    isApiCall.value = false;
    StringUtils.client.cancelAdminAppointment(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        cancelAdminAppointmentModel = value;
        if (cancelAdminAppointmentModel!.success == true) {
          appointmentController.currentIndex.value = 0;
          getAllAppointment("all");
        }
        // Get.back();
        DisplaySnackBar.displaySnackBar("Appointment is successfully cancelled", 3 , ColorConst.greenColor);
      })
      ..onError((DioException error, stackTrace) {
        Get.back();
        CheckSocketException.checkSocketException(error);
        return CancelAdminAppointmentModel();
      });
  }

  void confirmAppointment(int id) {
    isApiCall.value = false;
    StringUtils.client.confirmAdminAppointment(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        confirmAdminAppointmentModel = value;
        if (confirmAdminAppointmentModel!.success == true) {
          appointmentController.currentIndex.value = 0;
          getAllAppointment("all");
        }
        // Get.back();
        DisplaySnackBar.displaySnackBar("Appointment is successfully confirmed",3 ,ColorConst.greenColor);
      })
      ..onError((DioException error, stackTrace) {
        Get.back();
        CheckSocketException.checkSocketException(error);
        return ConfirmAdminAppointmentModel();
      });
  }
}
