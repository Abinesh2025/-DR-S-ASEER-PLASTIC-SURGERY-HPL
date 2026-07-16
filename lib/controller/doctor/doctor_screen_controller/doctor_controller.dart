import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_model/doctor_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DoctorScreenController extends GetxController {
  DoctorsModel? doctorsModel;
  RxBool isGetDoctor = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDoctors();
  }

  void getDoctors() {
    StringUtils.client.getDoctors(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorsModel = value;
        isGetDoctor.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorsModel();
      });
  }
}
