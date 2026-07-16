import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_live_consultations_model/doctor_live_consultations_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/live_consultancy/live_consultation_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class LiveConsultancyDetailsController extends GetxController {
  LiveConsultationDetailsModel? liveConsultationDetailsModel;
  DoctorLiveConsultationsDetailsModel? doctorLiveConsultationsDetailsModel;
  RxBool gotDetailsOfConsultation = false.obs;

  getConsultDetail(int id){
    PreferenceUtils.getStringValue("role") == "Doctor" ? getDoctorDetailsOfConsultation(id) : getDetailsOfConsultation(id);
  }

  void getDetailsOfConsultation(int id) {
    gotDetailsOfConsultation.value = false;
    StringUtils.client.liveConsultationData(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        liveConsultationDetailsModel = value;
        gotDetailsOfConsultation.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return LiveConsultationDetailsModel();
      });
  }

  void getDoctorDetailsOfConsultation(int id) {
    StringUtils.client.liveDoctorConsultationData(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        doctorLiveConsultationsDetailsModel = value;
        gotDetailsOfConsultation.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorLiveConsultationsDetailsModel();
      });
  }
}
