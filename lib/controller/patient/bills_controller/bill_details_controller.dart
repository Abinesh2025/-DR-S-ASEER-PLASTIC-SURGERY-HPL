import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/bills_model/bill_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/pdf_utils.dart';

@pragma('vm:entry-point')
class BillDetailsController extends GetxController {
  BillDetailModel? billDetailModel;
  RxBool isGetBillsDetails = false.obs;
  RxInt totalPrice = 0.obs;

  RxBool isDownloading = false.obs;

  void downloadPDF(String url) async {
    isDownloading.value = true;
    try {
      await PDFUtils.downloadPDF(url);
    } finally {
      isDownloading.value = false;
    }
  }

  void getBillsDetails(int argumentData) {
    StringUtils.client
        .getBillsDetails(PreferenceUtils.getStringValue("token"), argumentData)
        .then((value) {
      billDetailModel = value;
      if (billDetailModel!.success == true) {
        isGetBillsDetails.value = true;
      }
    }).onError((DioException error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }
}
