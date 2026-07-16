import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_payroll_model/payroll_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class PayrollController extends GetxController {
  PayrollModel? payrollModel;
  RxBool isGetPayroll = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPayroll();
  }

  void getPayroll() {
    StringUtils.client.getPayroll(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        payrollModel = value;
        isGetPayroll.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PayrollModel();
      });
  }
}
