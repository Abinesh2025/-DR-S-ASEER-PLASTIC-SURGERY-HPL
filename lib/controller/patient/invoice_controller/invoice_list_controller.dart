import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/invoice_model/invoice_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class InvoiceListController extends GetxController {
  InvoiceModel? invoiceModel;
  RxBool isGotInvoice = false.obs;

  void getInvoices() {
    StringUtils.client.getInvoices(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        invoiceModel = value;
        if (invoiceModel!.success == true) {
          isGotInvoice.value = true;
        }
      })
      ..onError((DioException error, stackTrace) {
        isGotInvoice.value = true;
        CheckSocketException.checkSocketException(error);
        return InvoiceModel();
      });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInvoices();
  }
}
