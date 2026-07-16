import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/vaccinated_model/vaccinated_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class VaccinationController extends GetxController {
  VaccinatedModel? vaccinatedModel;
  RxBool isGetVaccination = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVaccination();
  }

  void getVaccination() {
    StringUtils.client.getVaccinated(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        vaccinatedModel = value;
        isGetVaccination.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return VaccinatedModel();
      });
  }
}
