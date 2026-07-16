import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/case_model/case_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class CaseController extends GetxController {
  CaseModel? caseModel;
  RxBool isGetCase = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCase();
  }

  getCase() {
    StringUtils.client.getCase(PreferenceUtils.getStringValue("token")).then((value) {
      caseModel = value;
      isGetCase.value = true;
    }).onError((DioException error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }
}
