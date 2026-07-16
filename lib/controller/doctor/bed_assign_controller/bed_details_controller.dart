import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/bed_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class BedDetailsController extends GetxController {
  BedDetailsModel? bedDetailsModel;
  RxBool isBedDetailsApiCalled = false.obs;

  void getBedDetails(String id) {
    StringUtils.client.getBedDataDetails(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        bedDetailsModel = value;
        isBedDetailsApiCalled.value = true;
      })
      ..onError((DioException error, stackTrace) {
        bedDetailsModel = BedDetailsModel(data: null);
        isBedDetailsApiCalled.value = true;
        CheckSocketException.checkSocketException(error);
        return BedDetailsModel();
      });
  }
}
