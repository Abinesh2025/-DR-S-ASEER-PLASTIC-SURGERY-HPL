import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/prescriptions_model/prescriptions_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class PrescriptionController extends GetxController {
  PrescriptionsModel? prescriptionsModel;
  RxBool isGetPrescription = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPrescription();
  }

  void getPrescription() {
    StringUtils.client.getPrescription(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        prescriptionsModel = value;
        isGetPrescription.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PrescriptionsModel();
      });
  }
}
