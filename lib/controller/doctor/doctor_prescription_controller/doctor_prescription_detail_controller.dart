import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_prescription_model/doctor_prescription_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/pdf_utils.dart';

@pragma('vm:entry-point')
class DoctorPrescriptionDetailController extends GetxController {
  RxBool isGetDetail = false.obs;
  RxBool isDownloading = false.obs;
  DoctorPrescriptionDetailModel? doctorPrescriptionDetailModel;

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

  // void getDoctorPrescriptionDetail() async {
  //   try {
  //     final value = await StringUtils.client.getDoctorsPrescriptionDetail(PreferenceUtils.getStringValue("token"), id);
  //     doctorPrescriptionDetailModel = value;
  //     isGetDetail.value = true;
  //   } catch (e) {
  //     if (e is DioException) {
  //       isGetDetail.value = false;
  //       print('DioException: $e');
  //       } else {
  //       }
  //   }
  // }

  void getDoctorPrescriptionDetail(int id) {
    StringUtils.client.getDoctorsPrescriptionDetail(
        PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        doctorPrescriptionDetailModel = value;
        isGetDetail.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorPrescriptionDetailModel();
      });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
