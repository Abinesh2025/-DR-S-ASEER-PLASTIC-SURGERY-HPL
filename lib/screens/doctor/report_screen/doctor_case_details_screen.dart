import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/report_controller/doctor_case_details_controller.dart';

class DoctorCaseDetailsScreen extends StatelessWidget {
  DoctorCaseDetailsScreen({Key? key}) : super(key: key);
  final DoctorCaseDetailsController caseDetailsController = Get.put(DoctorCaseDetailsController());

  @override
  Widget build(BuildContext context) {

    var res = ModalRoute.of(context)!.settings.arguments as String;
    caseDetailsController.getDoctorCaseDetails(res);


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Case Details",
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Obx(
          () => caseDetailsController.isGotDetails.value == false
              ? const Center(child: CircularProgressIndicator())
              : caseDetailsController.doctorCaseDetailsModel?.data == null
                  ? Center(
                      child: Text(
                        "No case found",
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.blackColor,
                          width * 0.04,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.02),
                            CommonDetailText(
                                width: width,
                                titleText: "Case ID:",
                                descriptionText: caseDetailsController.doctorCaseDetailsModel?.data?.case_id ?? ""),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                                width: width,
                                titleText: "Case Date:",
                                descriptionText: caseDetailsController.doctorCaseDetailsModel?.data?.case_date ?? ""),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                                width: width,
                                titleText: "Patient:",
                                descriptionText: caseDetailsController.doctorCaseDetailsModel?.data?.patient ?? ""),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                                width: width, titleText: "Phone:", descriptionText: caseDetailsController.doctorCaseDetailsModel?.data?.phone ?? ""),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                                width: width,
                                titleText: "Fee:",
                                descriptionText:
                                    "${caseDetailsController.doctorCaseDetailsModel?.data?.currency ?? ""} ${caseDetailsController.doctorCaseDetailsModel?.data?.fee ?? ""}"),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                                width: width,
                                titleText: "Created On:",
                                descriptionText: caseDetailsController.doctorCaseDetailsModel?.data?.created_on ?? ""),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                                width: width,
                                titleText: "Description:",
                                descriptionText: caseDetailsController.doctorCaseDetailsModel?.data?.description ?? ""),
                            SizedBox(height: height * 0.015),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
