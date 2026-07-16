import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/diagnosis_controller/diagnosis_test_details_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DiagnosisTestDetailScreen extends StatelessWidget {
  DiagnosisTestDetailScreen({Key? key}) : super(key: key);
  final DiagnosisTestDetailsController diagnosisTestDetailsController =
  Get.put(DiagnosisTestDetailsController());

  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)!.settings.arguments as int;
    diagnosisTestDetailsController.getDiagnosisDetail(res);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        appBar: CommonAppBar(
          title: StringUtils.diagnosisTestsDetails,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Obx(
              () => diagnosisTestDetailsController.isDetailsGet.value == true
              ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // --- 1. Hero Section ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: ColorConst.primaryColor.withOpacity(0.03),
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                                color: ColorConst.primaryColor
                                    .withOpacity(0.2),
                                width: 3),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4))
                            ]),
                        child: Center(
                          child: Icon(
                            PreferenceUtils.getStringValue("role") ==
                                "Doctor"
                                ? Icons.person_outline
                                : Icons.medical_services_outlined,
                            size: 40,
                            color: ColorConst.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        PreferenceUtils.getStringValue("role") == "Doctor"
                            ? diagnosisTestDetailsController
                            .doctorDiagnosisTestDetailsModel!
                            .data!
                            .patient_name ?? "-"
                            : diagnosisTestDetailsController
                            .diagnosisTestDetailsModel!
                            .data!
                            .patient_name ?? "-",
                        style: TextStyleConst.boldTextStyle(
                            ColorConst.blackColor, width * 0.06),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: ColorConst.bgGreyColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.assignment_outlined,
                                size: 14, color: Colors.grey.shade700),
                            const SizedBox(width: 6),
                            Text(
                              "Report: ${PreferenceUtils.getStringValue("role") == "Doctor" ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.report_number ?? "-" : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.report_number ?? "-"}",
                              style: TextStyleConst.boldTextStyle(
                                  Colors.grey.shade800, width * 0.035),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "General Information",
                      //   style: TextStyleConst.boldTextStyle(
                      //       ColorConst.blackColor, width * 0.045),
                      // ),
                      // const SizedBox(height: 15),
                      //
                      // // --- 2. Vitals Grid ---
                      // GridView.count(
                      //   crossAxisCount: 2,
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   crossAxisSpacing: 15,
                      //   mainAxisSpacing: 15,
                      //   childAspectRatio: 2.2,
                      //   children: [
                      //     _buildVitalCard(
                      //         "Category",
                      //         PreferenceUtils.getStringValue("role") ==
                      //                 "Doctor"
                      //             ? diagnosisTestDetailsController
                      //                 .doctorDiagnosisTestDetailsModel!
                      //                 .data!
                      //                 .category ?? "-"
                      //             : diagnosisTestDetailsController
                      //                 .diagnosisTestDetailsModel!
                      //                 .data!
                      //                 .category ?? "-",
                      //         Icons.category_outlined,
                      //         width),
                      //     if (PreferenceUtils.getStringValue("role") ==
                      //         "Doctor")
                      //     _buildVitalCard(
                      //           "Age",
                      //           diagnosisTestDetailsController
                      //               .doctorDiagnosisTestDetailsModel!
                      //               .data!
                      //               .patient_diagnosis?.age ?? "-",
                      //           Icons.cake_outlined,
                      //           width),
                      //     _buildVitalCard(
                      //         "Height",
                      //         PreferenceUtils.getStringValue("role") ==
                      //                 "Doctor"
                      //             ? diagnosisTestDetailsController
                      //                 .doctorDiagnosisTestDetailsModel!
                      //                 .data!
                      //                 .patient_diagnosis?.height ?? "-"
                      //             : diagnosisTestDetailsController
                      //                 .diagnosisTestDetailsModel!
                      //                 .data!
                      //                 .patient_diagnosis?.height ?? "-",
                      //         Icons.height,
                      //         width),
                      //     _buildVitalCard(
                      //         "Weight",
                      //         PreferenceUtils.getStringValue("role") ==
                      //                 "Doctor"
                      //             ? diagnosisTestDetailsController
                      //                 .doctorDiagnosisTestDetailsModel!
                      //                 .data!
                      //                 .patient_diagnosis?.weight ?? "-"
                      //             : diagnosisTestDetailsController
                      //                 .diagnosisTestDetailsModel!
                      //                 .data!
                      //                 .patient_diagnosis?.weight ?? "-",
                      //         Icons.monitor_weight_outlined,
                      //         width),
                      //     _buildVitalCard(
                      //         "Blood Pressure",
                      //         PreferenceUtils.getStringValue("role") ==
                      //                 "Doctor"
                      //             ? diagnosisTestDetailsController
                      //                 .doctorDiagnosisTestDetailsModel!
                      //                 .data!
                      //                 .patient_diagnosis?.blood_pressure ?? "-"
                      //             : diagnosisTestDetailsController
                      //                 .diagnosisTestDetailsModel!
                      //                 .data!
                      //                 .patient_diagnosis?.blood_pressure ?? "-",
                      //         Icons.favorite_border,
                      //         width),
                      //     _buildVitalCard(
                      //         "Date",
                      //         PreferenceUtils.getStringValue("role") ==
                      //                 "Doctor"
                      //             ? diagnosisTestDetailsController
                      //                 .doctorDiagnosisTestDetailsModel!
                      //                 .data!
                      //                 .created_on ?? "-"
                      //             : diagnosisTestDetailsController
                      //                 .diagnosisTestDetailsModel!
                      //                 .data!
                      //                 .created_on ?? "-",
                      //         Icons.calendar_today_outlined,
                      //         width),
                      //   ],
                      // ),
                      //
                      // const SizedBox(height: 30),
                      // Text(
                      //   "Lab Results",
                      //   style: TextStyleConst.boldTextStyle(
                      //       ColorConst.blackColor, width * 0.045),
                      // ),
                      // const SizedBox(height: 15),
                      //
                      // // --- 3. Medical Results Card ---
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue.shade50.withOpacity(0.5),
                      //     borderRadius: BorderRadius.circular(16),
                      //     border: Border.all(color: Colors.blue.shade100),
                      //   ),
                      //   padding: const EdgeInsets.all(20),
                      //   child: Column(
                      //     children: [
                      //       _buildResultRow(
                      //           "Average Glucose",
                      //           PreferenceUtils.getStringValue("role") ==
                      //                   "Doctor"
                      //               ? diagnosisTestDetailsController
                      //                   .doctorDiagnosisTestDetailsModel!
                      //                   .data!
                      //                   .patient_diagnosis?.average_glucose ?? "-"
                      //               : diagnosisTestDetailsController
                      //                   .diagnosisTestDetailsModel!
                      //                   .data!
                      //                   .patient_diagnosis?.average_glucose ?? "-",
                      //           width),
                      //       const Padding(
                      //           padding:
                      //               EdgeInsets.symmetric(vertical: 12),
                      //           child: Divider(height: 1, thickness: 1)),
                      //       _buildResultRow(
                      //           "Fasting Blood Sugar",
                      //           PreferenceUtils.getStringValue("role") ==
                      //                   "Doctor"
                      //               ? diagnosisTestDetailsController
                      //                   .doctorDiagnosisTestDetailsModel!
                      //                   .data!
                      //                   .patient_diagnosis?.fasting_blood_sugar ?? "-"
                      //               : diagnosisTestDetailsController
                      //                   .diagnosisTestDetailsModel!
                      //                   .data!
                      //                   .patient_diagnosis?.fasting_blood_sugar ?? "-",
                      //           width),
                      //       const Padding(
                      //           padding:
                      //               EdgeInsets.symmetric(vertical: 12),
                      //           child: Divider(height: 1, thickness: 1)),
                      //       _buildResultRow(
                      //           "Urine Sugar",
                      //           PreferenceUtils.getStringValue("role") ==
                      //                   "Doctor"
                      //               ? diagnosisTestDetailsController
                      //                   .doctorDiagnosisTestDetailsModel!
                      //                   .data!
                      //                   .patient_diagnosis?.urine_sugar ?? "-"
                      //               : diagnosisTestDetailsController
                      //                   .diagnosisTestDetailsModel!
                      //                   .data!
                      //                   .patient_diagnosis?.urine_sugar ?? "-",
                      //           width),
                      //       const Padding(
                      //           padding:
                      //               EdgeInsets.symmetric(vertical: 12),
                      //           child: Divider(height: 1, thickness: 1)),
                      //       _buildResultRow(
                      //           "Diabetes",
                      //           PreferenceUtils.getStringValue("role") ==
                      //                   "Doctor"
                      //               ? diagnosisTestDetailsController
                      //                   .doctorDiagnosisTestDetailsModel!
                      //                   .data!
                      //                   .patient_diagnosis?.diabetes ?? "-"
                      //               : diagnosisTestDetailsController
                      //                   .diagnosisTestDetailsModel!
                      //                   .data!
                      //                   .patient_diagnosis?.diabetes ?? "-",
                      //           width),
                      //       const Padding(
                      //           padding:
                      //               EdgeInsets.symmetric(vertical: 12),
                      //           child: Divider(height: 1, thickness: 1)),
                      //       _buildResultRow(
                      //           "Cholesterol",
                      //           PreferenceUtils.getStringValue("role") ==
                      //                   "Doctor"
                      //               ? diagnosisTestDetailsController
                      //                   .doctorDiagnosisTestDetailsModel!
                      //                   .data!
                      //                   .patient_diagnosis?.cholesterol ?? "-"
                      //               : diagnosisTestDetailsController
                      //                   .diagnosisTestDetailsModel!
                      //                   .data!
                      //                   .patient_diagnosis?.cholesterol ?? "-",
                      //           width),
                      //     ],
                      //   ),
                      // ),

                      // SizedBox(height: height * 0.05),

                      // --- 4. Download Action ---
                      Center(
                        child: Obx(
                              () => diagnosisTestDetailsController
                              .isDownloading.value ==
                              true
                              ?  CircularProgressIndicator(
                              color: ColorConst.primaryColor)
                              : SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                diagnosisTestDetailsController
                                    .downloadPDF(PreferenceUtils
                                    .getStringValue(
                                    "role") ==
                                    "Doctor"
                                    ? diagnosisTestDetailsController
                                    .doctorDiagnosisTestDetailsModel!
                                    .data!
                                    .pdf_url ?? ""
                                    : diagnosisTestDetailsController
                                    .diagnosisTestDetailsModel!
                                    .data!
                                    .pdf_url ?? "");
                              },
                              icon: const Icon(
                                  Icons.download_rounded,
                                  color: Colors.white),
                              label: Text(
                                StringUtils.downloadDiagnosisTest,
                                style: TextStyleConst.boldTextStyle(
                                    Colors.white, width * 0.045),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                ColorConst.primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ),
              ],
            ),
          )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildVitalCard(
      String title, String value, IconData icon, double width) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: ColorConst.primaryColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyleConst.mediumTextStyle(
                      Colors.grey.shade600, width * 0.032),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyleConst.boldTextStyle(
                ColorConst.blackColor, width * 0.038),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(String title, String value, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyleConst.mediumTextStyle(
              Colors.grey.shade700, width * 0.038),
        ),
        Text(
          value,
          style:
          TextStyleConst.boldTextStyle(ColorConst.blackColor, width * 0.04),
        ),
      ],
    );
  }
}
