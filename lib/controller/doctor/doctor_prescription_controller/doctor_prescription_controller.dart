import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_prescription_model/doctor_prescription_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/report_model/common_report_model/delete_common_report_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DoctorPrescriptionController extends GetxController {
  RxBool isGetPrescription = false.obs;
  DoctorPrescriptionModel? doctorPrescriptionModel;
  DeleteCommonReportModel? deleteCommonReportModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDoctorPrescription();
  }

  void getDoctorPrescription() {
    StringUtils.client.getDoctorsPrescription(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorPrescriptionModel = value;
        isGetPrescription.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorPrescriptionModel();
      });
  }

  void deletePrescription(int id) {
    isGetPrescription.value = false;
    StringUtils.client.deletePrescriptionReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          getDoctorPrescription();
        }
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }
}
