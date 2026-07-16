import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/bills_model/bill_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class BillsController extends GetxController {
  BillsModel? billsModel;
  RxBool isGetBills = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     getBill();
  }

  void getBill() {
    StringUtils.client.getBills(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        billsModel = value;
        isGetBills.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return BillsModel();
      });
  }
}
