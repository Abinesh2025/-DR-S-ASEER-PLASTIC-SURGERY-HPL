import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/patient_admission_model/delete_admission_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/patient_admission_model/patient_admission_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class PatientAdmissionController extends GetxController {
  PatientAdmissionModel? patientAdmissionModel;
  DeleteAdmissionModel? deleteAdmissionModel;
  RxBool isGotAdmission = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPatientAdmission();
  }

  void getPatientAdmission() {
    StringUtils.client.getPatientAdmission(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        patientAdmissionModel = value;
        if (patientAdmissionModel!.success == true) {
          isGotAdmission.value = true;
        }
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PatientAdmissionModel();
      });
  }

  void deleteAdmission(int id) {
    isGotAdmission.value = false;
    StringUtils.client.deleteAdmission(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteAdmissionModel = value;
        if (deleteAdmissionModel!.success == true) {
          getPatientAdmission();
        }
      })
      ..onError((DioException error, stackTrace) {
        getPatientAdmission();
        CheckSocketException.checkSocketException(error);
        return DeleteAdmissionModel();
      });
  }
}
