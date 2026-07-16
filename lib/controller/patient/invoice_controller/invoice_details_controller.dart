import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/invoice_model/invoice_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/pdf_utils.dart';

@pragma('vm:entry-point')
class InvoiceDetailsController extends GetxController {
  InvoiceDetailsModel? invoiceDetailsModel;
  RxBool isApiCall = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  RxBool isDownloading = false.obs;
  RxInt progress = 0.obs;

  void downloadPDF(String url) async {
    isDownloading.value = true;
    try {
      await PDFUtils.downloadPDF(url);
    } finally {
      isDownloading.value = false;
    }
  }

  void getInvoiceDetails(int invoiceId) {
    StringUtils.client
        .getInvoiceData(PreferenceUtils.getStringValue("token"), invoiceId)
        .then((value) {
      invoiceDetailsModel = value;
      if (invoiceDetailsModel!.success == true) {
        isApiCall.value = true;
      }
    }).onError((DioException error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
