import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/patient_admission_model/patient_admission_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class PatientAdmissionDetailsController extends GetxController {
  PatientAdmissionDetailsModel? patientAdmissionDetailsModel;
  RxBool isGotDetails = false.obs;

  void getPatientAdmissionDetails(int id) {
    StringUtils.client.getPatientAdmissionDetails(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        patientAdmissionDetailsModel = value;
        isGotDetails.value = true;
      })
      ..onError((DioException error, stackTrace) {
        isGotDetails.value = true;
        CheckSocketException.checkSocketException(error);
        return PatientAdmissionDetailsModel();
      });
  }
}
