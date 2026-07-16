import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_model/doctor_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_model/filter_doctors_models.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DoctorsController extends GetxController {
  DoctorsModel? doctorsModel;
  FilterDoctorsModel? filterDoctorsModel;
  RxBool isGetDoctor = false.obs;

  RxList doctorStatus = ["All", "Active", "Deactive"].obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (currentIndex.value == 0) {
      getFilterDoctors("all");
    }
  }

  void changeIndex(int index) {
    isGetDoctor.value = false;
    switch (index) {
      case 0:
        currentIndex.value = 0;
        getFilterDoctors("all");
        break;
      case 1:
        currentIndex.value = 1;
        getFilterDoctors("active");
        break;
      case 2:
        currentIndex.value = 2;
        getFilterDoctors("deactive");
        break;
    }
  }

  void getFilterDoctors(String filter) {
    StringUtils.client.getFilterDoctors(PreferenceUtils.getStringValue("token"), filter).then((value) {
      filterDoctorsModel = value;
      isGetDoctor.value = true;
    }).onError((DioException error, stackTrace) {
      //CheckSocketException.checkSocketException(error);
    });
  }


}
