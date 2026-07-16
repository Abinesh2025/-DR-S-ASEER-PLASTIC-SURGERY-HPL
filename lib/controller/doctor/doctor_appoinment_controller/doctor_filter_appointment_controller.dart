import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_appoinment_controller/doctor_appoinment_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_appointment_model/confirm_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_appointment_model/doctor_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';

class DoctorFilterAppointmentController extends GetxController {
  DoctorAppointmentController doctorAppointmentController =
      Get.put(DoctorAppointmentController());
  Rxn<DoctorAppointmentModel> doctorAppointmentModel = Rxn<DoctorAppointmentModel>();
  ConfirmAppointmentModel? confirmAppointmentModel;

  RxBool isDoctorFilterApiCall = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (PreferenceUtils.getStringValue("role") == "Doctor") {
      if (doctorAppointmentController.currentIndex.value == 0) {
        getPendingAppointment();
      }
    }
  }

  Future<void> getPendingAppointment() async {
    isDoctorFilterApiCall.value = false;
    try {
      var value = await StringUtils.client.getDoctorAppointments(
          PreferenceUtils.getStringValue("token"), "pending");
      doctorAppointmentModel.value = value;
      isDoctorFilterApiCall.value = true;
      update();
    } catch (error) {
      isDoctorFilterApiCall.value = true;
      update();
      if (error is DioException) {
        // CheckSocketException.checkSocketException(error);
      }
    }
  }

  Future<void> getCancelledAppointment() async {
    isDoctorFilterApiCall.value = false;
    try {
      var value = await StringUtils.client.getDoctorAppointments(
          PreferenceUtils.getStringValue("token"), "cancelled");
      doctorAppointmentModel.value = value;
      isDoctorFilterApiCall.value = true;
      update();
    } catch (error) {
      isDoctorFilterApiCall.value = true;
      update();
      if (error is DioException) {
        CheckSocketException.checkSocketException(error);
      }
    }
  }

  Future<void> getConfirmedAppointment() async {
    isDoctorFilterApiCall.value = false;
    try {
      var value = await StringUtils.client.getDoctorAppointments(
          PreferenceUtils.getStringValue("token"), "checked");
      if (value.data != null) {
        for (var e in value.data!) {
          e.is_completed = "Confirmed";
        }
      }
      doctorAppointmentModel.value = value;
      isDoctorFilterApiCall.value = true;
      update();
    } catch (error) {
      isDoctorFilterApiCall.value = true;
      update();
    }
  }

  Future<void> getInQueueAppointment() async {
    isDoctorFilterApiCall.value = false;
    try {
      var value = await StringUtils.client.getDoctorAppointments(
          PreferenceUtils.getStringValue("token"), "checked_in");
      if (value.data != null) {
        for (var e in value.data!) {
          e.is_completed = "Check In";
        }
      }
      doctorAppointmentModel.value = value;
      isDoctorFilterApiCall.value = true;
      update();
    } catch (error) {
      isDoctorFilterApiCall.value = true;
      update();
    }
  }

  Future<void> getCompletedData() async {
    isDoctorFilterApiCall.value = false;
    try {
      var value = await StringUtils.client.getDoctorAppointments(
          PreferenceUtils.getStringValue("token"), "checked_out");
      if (value.data != null) {
        for (var e in value.data!) {
          e.is_completed = "Completed";
        }
      }
      doctorAppointmentModel.value = value;
      isDoctorFilterApiCall.value = true;
      update();
    } catch (error) {
      isDoctorFilterApiCall.value = true;
      update();
    }
  }

  Future<void> changeDoctorIndex(int index) async {
    doctorAppointmentModel.value = null;
    isDoctorFilterApiCall.value = false;
    doctorAppointmentController.currentIndex.value = index;
    switch (index) {
      case 0:
        await getPendingAppointment();
        break;
      case 1:
        await getConfirmedAppointment();
        break;
      case 2:
        await getInQueueAppointment();
        break;
      case 3:
        await getCompletedData();
        break;
      case 4:
        await getCancelledAppointment();
        break;
    }
  }

  void confirmAppointment(int id) {
    Get.back();
    isDoctorFilterApiCall.value = false;
    StringUtils.client
        .confirmAppointment(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        confirmAppointmentModel = value;
        if (confirmAppointmentModel!.success == true) {
          getPendingAppointment();
        }
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return ConfirmAppointmentModel();
      });
  }

  Future<bool> hasOngoingAppointment(int? currentId) async {
    try {
      final response = await StringUtils.client.getDoctorAppointments(
          PreferenceUtils.getStringValue("token"), "checked_in");
      if (response.success == true && response.data != null) {
        return response.data!.any((e) => e.id != currentId);
      }
    } catch (e) {
      print("Error checking ongoing appointments: $e");
    }
    return false;
  }

  void changeStatus(int id, String status) async {
    if (status.toLowerCase() == "checked in" ||
        status.toLowerCase() == "checked_in") {
      isDoctorFilterApiCall.value = false;
      bool isBlocked = await hasOngoingAppointment(id);
      if (isBlocked) {
        DisplaySnackBar.displaySnackBar(
          "One appointment is already in ongoing state",
          3,
          ColorConst.redColor,
        );
        isDoctorFilterApiCall.value = true;
        return;
      }
    }

    isDoctorFilterApiCall.value = false;

    StringUtils.client
        .updateAppointmentStatus(
            PreferenceUtils.getStringValue("token"), id, status)
        .then((value) {
      if (value.success == true) {
        DisplaySnackBar.displaySnackBar("Appointment status updated to $status",
            3, ColorConst.greenColor);
        if (doctorAppointmentController.currentIndex.value == 0) {
          getPendingAppointment();
        } else if (doctorAppointmentController.currentIndex.value == 1) {
          getConfirmedAppointment();
        } else if (doctorAppointmentController.currentIndex.value == 2) {
          getInQueueAppointment();
        } else if (doctorAppointmentController.currentIndex.value == 3) {
          getCompletedData();
        } else if (doctorAppointmentController.currentIndex.value == 4) {
          getCancelledAppointment();
        }
      } else {
        DisplaySnackBar.displaySnackBar(
            value.message ?? "Failed to update status", 3, ColorConst.redColor);
        isDoctorFilterApiCall.value = true;
      }
    }).catchError((error, stackTrace) {
      isDoctorFilterApiCall.value = true;
      if (error is DioException) {
        CheckSocketException.checkSocketException(error);
      }
    });
  }

  DateTime _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return DateTime(1900);
    try {
      return DateFormat("dd-MM-yyyy").parse(dateStr);
    } catch (e) {
      try {
        String cleaned = dateStr.replaceAll(RegExp(r'(st|nd|rd|th)'), '');
        return DateFormat("dd MMM, yy").parse(cleaned);
      } catch (e2) {
        return DateTime.tryParse(dateStr) ?? DateTime(1900);
      }
    }
  }

  DateTime _parseTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return DateTime(1900);
    try {
      return DateFormat.jm().parse(timeStr);
    } catch (e) {
      try {
        return DateFormat("HH:mm").parse(timeStr);
      } catch (e2) {
        return DateTime(1900, 1, 1, 12, 0);
      }
    }
  }
}
