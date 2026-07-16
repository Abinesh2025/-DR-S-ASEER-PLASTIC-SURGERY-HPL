import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/prescriptions_model/prescription_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/pdf_utils.dart';

@pragma('vm:entry-point')
class PrescriptionDetailsController extends GetxController {
  PrescriptionDetailsModel? prescriptionDetailsModel;
  RxBool isGotDetails = false.obs;
  RxBool isDownloading = false.obs;

  RxInt progress = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void downloadPDF(String url) async {
    isDownloading.value = true;
    try {
      await PDFUtils.downloadPDF(url);
    } finally {
      isDownloading.value = false;
    }
  }

  void getPrescriptionDetails(int id) {
    StringUtils.client
        .getPrescriptionDetails(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        prescriptionDetailsModel = value;
        isGotDetails.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PrescriptionDetailsModel();
      });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
