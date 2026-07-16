import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/patient_model/patient_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class PatientDetailController extends GetxController {
  PatientsDetailModel? patientsDetailModel;
  var id = Get.arguments;
  RxBool isGetDetail = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getPatientDetail();
  }

  void getPatientDetail() {
    StringUtils.client.getPatientDetail(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        patientsDetailModel = value;
        isGetDetail.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PatientsDetailModel();
      });
  }
}
