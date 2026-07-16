import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/patient_model/filter_patient_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/patient_model/patient_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class PatientScreenController extends GetxController {
  PatientModel? patientModel;
  FilterPatientModel? filterPatientModel;
  RxBool isGetPatient = false.obs;

  RxList patientStatus = ["All", "Active", "Deactive"].obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (currentIndex.value == 0) {
      getFilterPatients("all");
    }
  }

  void changeIndex(int index) {
    isGetPatient.value = false;
    switch (index) {
      case 0:
        currentIndex.value = 0;
        getFilterPatients("all");
        break;
      case 1:
        currentIndex.value = 1;
        getFilterPatients("active");
        break;
      case 2:
        currentIndex.value = 2;
        getFilterPatients("deactive");
        break;
    }
  }

  void getFilterPatients(String filter) {
    StringUtils.client.getFilterPatients(PreferenceUtils.getStringValue("token"), filter).then((value) {
      filterPatientModel = value;
      isGetPatient.value = true;
    }).onError((DioException error, stackTrace) {
      //CheckSocketException.checkSocketException(error);
    });
  }

}
