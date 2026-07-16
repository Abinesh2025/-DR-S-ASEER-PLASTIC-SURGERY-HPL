import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_payroll_model/payroll_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class PayrollDetailsController extends GetxController {
  PayrollDetailsModel? payrollDetailsModel;
  RxBool isGetDetails = false.obs;

  void getPayrollDetails(int id) {
    StringUtils.client.getPayrollDetails(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        payrollDetailsModel = value;
        isGetDetails.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PayrollDetailsModel();
      });
  }
}
