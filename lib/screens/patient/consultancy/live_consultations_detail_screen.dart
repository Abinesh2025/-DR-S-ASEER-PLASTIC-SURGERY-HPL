import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/live_consultancy_controller/live_consultancy_details_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class LiveConsultationsDetailScreen extends StatelessWidget {
  LiveConsultationsDetailScreen({Key? key}) : super(key: key);

  final LiveConsultancyDetailsController liveConsultationsController = Get.put(LiveConsultancyDetailsController());

  @override
  Widget build(BuildContext context) {

    var res =  ModalRoute.of(context)!.settings.arguments as int;
    liveConsultationsController.getConsultDetail(res);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: StringUtils.liveConsultationsDetails,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Obx(() {
            return liveConsultationsController.gotDetailsOfConsultation.value == false
                ?  Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.02),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.consultationTitle,
                          descriptionText: PreferenceUtils.getStringValue("role") == "Doctor"
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.consultation_title ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.consultation_title ?? "N/A",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.consultationDate,
                          descriptionText: PreferenceUtils.getStringValue("role") == "Doctor"
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.consultation_date ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.consultation_date ?? "N/A",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.durationMinute,
                          descriptionText: PreferenceUtils.getStringValue("role") == "Doctor"
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.duration_minutes ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.duration ?? "N/A",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: PreferenceUtils.getStringValue("role") == "Doctor" ? StringUtils.patientName : StringUtils.doctorName,
                          descriptionText: PreferenceUtils.getStringValue("role") == "Doctor"
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.patient_name ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.dostor_name ?? "N/A",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.type,
                          descriptionText: PreferenceUtils.getStringValue("role") == "Doctor"
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.type ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.type ?? "N/A",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.typeNumber,
                          descriptionText: PreferenceUtils.getStringValue("role") == "Doctor"
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.type_number ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.type_number ?? "N/A",
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
