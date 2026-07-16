import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_diagnosis_test_model/delete_test_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_diagnosis_test_model/doctor_diagnosis_test_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/diagnosis_model/diagnosis_test_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/pdf_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DiagnosisTestController extends GetxController {
  DiagnosisTestModel? diagnosisTestModel;
  DoctorDiagnosisTestModel? doctorDiagnosisTestModel;
  RxBool isDiagnosisTestApiCall = false.obs;
  DeleteTestModel? deleteTestModel;

  int? currentIndex;

  List<RxBool> isDownloading = <RxBool>[];
  RxInt progress = 0.obs;

  @override
  void onInit() {
    super.onInit();
    PreferenceUtils.getStringValue("role") == "Doctor"
        ? getDoctorDiagnosisTest()
        : getDiagnosisTest();
  }

  void downloadPDF(context, int index) async {
    if (!isDownloading.any((e) => e.value)) {
      String url;
      if (PreferenceUtils.getStringValue("role") == "Doctor") {
        url = doctorDiagnosisTestModel?.data?[index].pdf_url ?? "";
      } else {
        url = diagnosisTestModel?.data?[index].pdf_url ?? "";
      }

      currentIndex = index;
      isDownloading[index].value = true;
      try {
        await PDFUtils.downloadPDF(url);
      } finally {
        isDownloading[index].value = false;
      }
    }
  }

  void getDiagnosisTest() {
    StringUtils.client.getDiagnosisTest(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        diagnosisTestModel = value;

        isDownloading = List.generate(value.data?.length ?? 1, (index) {
          return false.obs;
        });
        isDiagnosisTestApiCall.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DiagnosisTestModel();
      });
  }

  void getDoctorDiagnosisTest() {
    isDiagnosisTestApiCall.value = false;
    StringUtils.client
        .getDoctorsDiagnosisTest(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorDiagnosisTestModel = value;
        isDownloading = List.generate(value.data?.length ?? 1, (index) {
          return false.obs;
        });
        isDiagnosisTestApiCall.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorDiagnosisTestModel();
      });
  }

  void deleteTest(int id) {
    isDiagnosisTestApiCall.value = false;
    StringUtils.client
        .deleteTest(PreferenceUtils.getStringValue("token"), id)
        .then((value) {
      deleteTestModel = value;
      if (deleteTestModel!.success == true) {
        PreferenceUtils.getStringValue("role") == "Doctor"
            ? getDoctorDiagnosisTest()
            : getDiagnosisTest();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
