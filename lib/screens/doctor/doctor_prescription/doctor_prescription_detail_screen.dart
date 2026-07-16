import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_prescription_controller/doctor_prescription_detail_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class DoctorPrescriptionDetailScreen extends StatelessWidget {
  DoctorPrescriptionDetailScreen({Key? key}) : super(key: key);
  final DoctorPrescriptionDetailController doctorPrescriptionDetailController = Get.put(DoctorPrescriptionDetailController());

  @override
  Widget build(BuildContext context) {

    var res = ModalRoute.of(context)!.settings.arguments as int;
    doctorPrescriptionDetailController.getDoctorPrescriptionDetail(res);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            title: StringUtils.prescriptionDetails,
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body: Obx(
            () {
              return doctorPrescriptionDetailController.isGetDetail.value == false
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.03),
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConst.borderGreyColor,
                                  ),
                                  child: ClipOval(
                                    child: doctorPrescriptionDetailController.doctorPrescriptionDetailModel?.data?.app_logo == null ||
                                            doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.app_logo!.isEmpty
                                        ? Image.asset(
                                            ImageUtils.appLogo,
                                            fit: BoxFit.cover,
                                          )
                                        : FadeInImage(
                                            placeholder: const AssetImage(ImageUtils.appLogo),
                                            image: NetworkImage(doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.app_logo!),
                                            imageErrorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                ImageUtils.appLogo,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                SizedBox(width: width * 0.04),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.doctor_name}",
                                      style: TextStyleConst.boldTextStyle(
                                        ColorConst.blackColor,
                                        width * 0.05,
                                      ),
                                    ),
                                    Text(
                                      doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.specialist!,
                                      style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.04),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            Divider(
                              thickness: 1.5,
                              color: ColorConst.greyShadowColor,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonText(
                              width: width,
                              text: StringUtils.patientDetails,
                            ),
                            SizedBox(height: height * 0.025),
                            CommonDetailText(
                              width: width,
                              titleText: "Patient Name:",
                              descriptionText: doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.patient_name!,
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Date:",
                              descriptionText: doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.created_date!,
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Age:",
                              descriptionText: "${doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.patient_age!}",
                            ),
                            SizedBox(height: height * 0.02),
                            // CommonText(
                            //   width: width,
                            //   text: StringUtils.overview,
                            // ),
                            // SizedBox(height: height * 0.025),
                            // CommonDetailText(
                            //   width: width,
                            //   titleText: "Overview",
                            //   descriptionText: doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.patient_name!,
                            // ),
                            // SizedBox(height: height * 0.015),
                            // CommonDetailText(
                            //   width: width,
                            //   titleText: "Problem:",
                            //   descriptionText: doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.problem!,
                            // ),
                            // SizedBox(height: height * 0.015),
                            // CommonDetailText(
                            //   width: width,
                            //   titleText: "Test:",
                            //   descriptionText: doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.test!,
                            // ),
                            // SizedBox(height: height * 0.015),
                            // CommonDetailText(
                            //   width: width,
                            //   titleText: "Advice:",
                            //   descriptionText: doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.advice!,
                            // ),
                            SizedBox(
                              height: doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.medicine!.isEmpty
                                  ? height * 0.04
                                  : height * 0.02,
                            ),
                            doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.medicine!.isEmpty
                                ? Center(
                                    child: CommonText(
                                      width: width,
                                      text: "No Medicine Available",
                                      color: ColorConst.redColor,
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ColorConst.bgGreyColor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                                          child: Text(
                                            StringUtils.rx,
                                            style: TextStyleConst.mediumTextStyle(
                                              ColorConst.blackColor,
                                              width * 0.04,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height * 0.01),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 15, left: 15),
                                          child: Divider(
                                            color: ColorConst.dividerColor,
                                            thickness: 1.5,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.01),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 15, left: 15),
                                          child: Column(
                                            children: List.generate(
                                                doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.medicine!.length, (index) {
                                              return Padding(
                                                padding: EdgeInsets.only(bottom: height * 0.01),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          doctorPrescriptionDetailController
                                                              .doctorPrescriptionDetailModel!.data!.medicine![index].name!,
                                                          style: TextStyleConst.mediumTextStyle(
                                                            ColorConst.blackColor,
                                                            width * 0.045,
                                                          ),
                                                        ),
                                                        // SizedBox(height: height * 0.003),
                                                        // Text(
                                                        //   "${doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.medicine![index].dosage!}(${doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.medicine![index].time!})",
                                                        //   style: TextStyleConst.mediumTextStyle(
                                                        //     ColorConst.hintGreyColor,
                                                        //     width * 0.04,
                                                        //   ),
                                                        // ),
                                                        SizedBox(height: height * 0.01),
                                                      ],
                                                    ),
                                                    Text(
                                                      doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.medicine![index].days!,
                                                      style: TextStyleConst.mediumTextStyle(
                                                        ColorConst.blackColor,
                                                        width * 0.045,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(height: height * 0.04),
                            Center(
                              child: Obx(() {
                                return doctorPrescriptionDetailController.isDownloading.value == true
                                    ?  Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                                    : CommonButton(
                                        width: width / 1.45,
                                        height: 50,
                                        text: StringUtils.downloadPrescription,
                                        color: ColorConst.blueColor,
                                        onTap: () {
                                          doctorPrescriptionDetailController.downloadPDF(
                                              doctorPrescriptionDetailController.doctorPrescriptionDetailModel!.data!.download_prescription!);
                                        },
                                        textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                      );
                              }),
                            ),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ),
                    );
                  //: const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
