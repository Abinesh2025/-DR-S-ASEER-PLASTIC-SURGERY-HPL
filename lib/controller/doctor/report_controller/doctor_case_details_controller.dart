import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/report_model/doctor_case_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DoctorCaseDetailsController extends GetxController {
  DoctorCaseDetailsModel? doctorCaseDetailsModel;
  RxBool isGotDetails = false.obs;

  void getDoctorCaseDetails(String caseId) {
    StringUtils.client.getDoctorCaseDetails(PreferenceUtils.getStringValue("token"), caseId)
      ..then((value) {
        doctorCaseDetailsModel = value;
        if (doctorCaseDetailsModel!.success == true) {
          isGotDetails.value = true;
        }
      })
      ..onError((DioException error, stackTrace) {
        isGotDetails.value = true;
        CheckSocketException.checkSocketException(error);
        return DoctorCaseDetailsModel();
      });
  }
}
