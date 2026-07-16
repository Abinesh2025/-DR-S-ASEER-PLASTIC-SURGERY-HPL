import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_live_consultations_model/doctor_live_consultations_meeting_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_live_consultations_model/doctor_live_consultations_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/live_consultancy/live_consultation_filter.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/live_consultancy/live_consultation_meeting_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/widget/live_consul_status.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveConsultationsController extends GetxController {
  LiveConsultationMeetingModel? liveConsultationMeetingModel;
  LiveConsultationFilter? liveConsultationFilter;
  DoctorLiveConsultationsModel? doctorLiveConsultationsModel;
  DoctorLiveConsultationsMeetingModel? doctorLiveConsultationsMeetingModel;
  RxList consultationsStatus = ["All", "Awaited", "Cancelled", "Finished"].obs;
  RxInt currentIndex = 0.obs;

  RxBool gotConsultationData = false.obs;
  RxBool gotMeetingData = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    PreferenceUtils.getStringValue("role") == "Doctor" ? getDoctorConsultancy("all") : getConsultancy("all");
  }

  void changeIndex(int index) {
    gotConsultationData.value = false;
    switch (index) {
      case 0:
        currentIndex.value = 0;
        PreferenceUtils.getStringValue("role") == "Doctor" ? getDoctorConsultancy("all") : getConsultancy("all");
        break;
      case 1:
        currentIndex.value = 1;
        PreferenceUtils.getStringValue("role") == "Doctor" ? getDoctorConsultancy("awaited") : getConsultancy("awaited");
        break;
      case 2:
        currentIndex.value = 2;
        PreferenceUtils.getStringValue("role") == "Doctor" ? getDoctorConsultancy("cancelled") : getConsultancy("cancelled");
        break;
      case 3:
        currentIndex.value = 3;
        PreferenceUtils.getStringValue("role") == "Doctor" ? getDoctorConsultancy("finished") : getConsultancy("finished");
        break;
    }
  }

  void getConsultancy(String status) {
    StringUtils.client.liveConsultationFilter(PreferenceUtils.getStringValue("token"), status)
      ..then((value) {
        liveConsultationFilter = value;
        gotConsultationData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        // gotConsultationData.value = true;
        CheckSocketException.checkSocketException(error);
        return LiveConsultationFilter();
      });
  }

  void getDoctorConsultancy(String status) {
    StringUtils.client.liveDoctorConsultationFilter(PreferenceUtils.getStringValue("token"), status)
      ..then((value) {
        doctorLiveConsultationsModel = value;
        gotConsultationData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        gotConsultationData.value = true;
        CheckSocketException.checkSocketException(error);

        return DoctorLiveConsultationsModel();
      });
  }

  void launchConsultationURL(String url) {
    try {
      launchUrl(Uri.parse(url));
    } catch (e) {
      DisplaySnackBar.displaySnackBar("Can't launch URL", 3 ,ColorConst.redColor);
    }
  }

  void getLiveMeeting(int consultationId, BuildContext context, double height, double width) {
    CommonLoader.showLoader();
    StringUtils.client.liveConsultationMeetingData(PreferenceUtils.getStringValue("token"), consultationId)
      ..then((value) {
        liveConsultationMeetingModel = value;
        if (liveConsultationMeetingModel!.success == true) {
          gotMeetingData.value = true;
          Get.back();
          showModalBottomSheet(
            backgroundColor: ColorConst.whiteColor,
            shape: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              borderSide: BorderSide.none,
            ),
            context: context,
            builder: (context) {
              return Container(
                color: ColorConst.whiteColor,
                margin: const EdgeInsets.only(right: 25, top: 20, left: 25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xffE7E9EB),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        "${liveConsultationMeetingModel!.data!.consultation_title}",
                        style: TextStyleConst.boldTextStyle(
                          ColorConst.blackColor,
                          width * 0.045,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      statusText("${liveConsultationMeetingModel!.data!.status}", width),
                      SizedBox(height: height * 0.02),
                      CommonDetailText(
                        width: width,
                        titleText: "Host Video:",
                        descriptionText: "${liveConsultationMeetingModel!.data!.host_video}",
                      ),
                      SizedBox(height: height * 0.01),
                      CommonDetailText(
                        width: width,
                        titleText: "Consultation Date:",
                        descriptionText: "${liveConsultationMeetingModel!.data!.consultation_date}",
                      ),
                      SizedBox(height: height * 0.01),
                      CommonDetailText(
                        width: width,
                        titleText: "Duration:",
                        descriptionText: "${liveConsultationMeetingModel!.data!.duration_minutes} Minutes",
                      ),
                      SizedBox(height: height * 0.03),
                      Center(
                        child: CommonButton(
                          isIcon: true,
                          width: width / 2,
                          height: 50,
                          text: "Join Now",
                          color: ColorConst.blueColor,
                          onTap: () {
                            launchConsultationURL(liveConsultationMeetingModel!.data!.meta!);
                          },
                          textStyleConst: TextStyleConst.mediumTextStyle(
                            ColorConst.whiteColor,
                            width * 0.05,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              );
            },
          );
        }
      })
      ..onError((DioException error, stackTrace) {
        gotMeetingData.value = true;
        CheckSocketException.checkSocketException(error);
        return LiveConsultationMeetingModel();
      });
  }

  void getDoctorLiveMeeting(int consultationId, BuildContext context, double height, double width) {
    CommonLoader.showLoader();
    StringUtils.client.liveDoctorConsultationMeetingData(PreferenceUtils.getStringValue("token"), consultationId)
      ..then((value) {
        doctorLiveConsultationsMeetingModel = value;
        if (doctorLiveConsultationsMeetingModel!.success == true) {
          gotMeetingData.value = true;
          Get.back();
          showModalBottomSheet(
            backgroundColor: ColorConst.whiteColor,
            shape: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              borderSide: BorderSide.none,
            ),
            context: context,
            builder: (context) {
              return Container(
                color: ColorConst.whiteColor,
                margin: const EdgeInsets.only(right: 25, top: 20, left: 25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xffE7E9EB),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        "${doctorLiveConsultationsMeetingModel!.data!.consultation_title}",
                        style: TextStyleConst.boldTextStyle(
                          ColorConst.blackColor,
                          width * 0.045,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      statusText("${doctorLiveConsultationsMeetingModel!.data!.status}", width),
                      SizedBox(height: height * 0.02),
                      CommonDetailText(
                        width: width,
                        titleText: "Host Video:",
                        descriptionText: "${doctorLiveConsultationsMeetingModel!.data!.host_video}",
                      ),
                      SizedBox(height: height * 0.01),
                      CommonDetailText(
                        width: width,
                        titleText: "Consultation Date:",
                        descriptionText: "${doctorLiveConsultationsMeetingModel!.data!.consultation_date}",
                      ),
                      SizedBox(height: height * 0.01),
                      CommonDetailText(
                        width: width,
                        titleText: "Duration:",
                        descriptionText: "${doctorLiveConsultationsMeetingModel!.data!.duration_minutes} Minutes",
                      ),
                      SizedBox(height: height * 0.03),
                      Center(
                        child: CommonButton(
                          isIcon: true,
                          width: width / 2,
                          height: 50,
                          text: "Start Now",
                          color: ColorConst.blueColor,
                          onTap: () {
                            launchConsultationURL(doctorLiveConsultationsMeetingModel!.data!.meta!);
                          },
                          textStyleConst: TextStyleConst.mediumTextStyle(
                            ColorConst.whiteColor,
                            width * 0.05,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              );
            },
          );
        }
      })
      ..onError((DioException error, stackTrace) {
        gotMeetingData.value = true;
        CheckSocketException.checkSocketException(error);
        return DoctorLiveConsultationsMeetingModel();
      });
  }
}
