import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/admission_model/admission_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class AdmissionController extends GetxController {
  AdmissionModel? admissionModel;
  RxBool isGetAdmission = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAdmission();
  }

  void getAdmission() {
    StringUtils.client.getAdmission(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        admissionModel = value;
        isGetAdmission.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return AdmissionModel();
      });
  }
}
