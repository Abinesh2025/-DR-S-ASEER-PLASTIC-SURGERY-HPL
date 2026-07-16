import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_diagnosis_test_model/doctor_diagnosis_test_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/diagnosis_model/diagnosis_test_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/pdf_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DiagnosisTestDetailsController extends GetxController {
  DiagnosisTestDetailsModel? diagnosisTestDetailsModel;
  DoctorDiagnosisTestDetailsModel? doctorDiagnosisTestDetailsModel;
  RxBool isDetailsGet = false.obs;
  RxBool isDownloading = false.obs;

  void getDiagnosisDetail(int id) {
    PreferenceUtils.getStringValue("role") == "Doctor"
        ? getDoctorDiagnosisTestDetails(id)
        : getDiagnosisTestDetails(id);
  }

  void downloadPDF(String url) async {
    isDownloading.value = true;
    try {
      await PDFUtils.downloadPDF(url);
    } finally {
      isDownloading.value = false;
    }
  }

  void getDiagnosisTestDetails(int id) {
    StringUtils.client
        .getDiagnosisTestDetails(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        diagnosisTestDetailsModel = value;
        isDetailsGet.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DiagnosisTestDetailsModel();
      });
  }

  void getDoctorDiagnosisTestDetails(int id) {
    StringUtils.client.getDoctorsDiagnosisTestDetails(
        PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        doctorDiagnosisTestDetailsModel = value;
        isDetailsGet.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorDiagnosisTestDetailsModel();
      });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
