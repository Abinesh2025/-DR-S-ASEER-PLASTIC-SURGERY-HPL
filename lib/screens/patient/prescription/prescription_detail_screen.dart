import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/prescription_controller/prescription_details_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class PrescriptionsDetailScreen extends StatelessWidget {
  PrescriptionsDetailScreen({Key? key}) : super(key: key);
  final PrescriptionDetailsController prescriptionDetailsController =
  Get.put(PrescriptionDetailsController());

  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)!.settings.arguments as int;
    prescriptionDetailsController.getPrescriptionDetails(res);
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(
          title: "Prescriptions Details",
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Obx(() {
          if (prescriptionDetailsController.isGotDetails.value == false) {
            return const Center(child: CircularProgressIndicator());
          }
          final data =
              prescriptionDetailsController.prescriptionDetailsModel?.data;
          if (data == null) {
            return const Center(child: Text("No details found"));
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // 1. Hero Profile Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                    Border(bottom: BorderSide(color: Colors.grey.shade100)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                              color: ColorConst.primaryColor.withOpacity(0.15),
                              width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConst.primaryColor.withOpacity(0.12),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: data.app_logo == null || data.app_logo!.isEmpty
                              ? Image.asset(ImageUtils.doctorIcon,
                              fit: BoxFit.cover)
                              : FadeInImage(
                            placeholder:
                            const AssetImage(ImageUtils.doctorIcon),
                            image: NetworkImage(data.app_logo!),
                            imageErrorBuilder: (context, error,
                                stackTrace) =>
                                Image.asset(ImageUtils.doctorIcon,
                                    fit: BoxFit.cover),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        data.doctor_name ?? "Doctor Name",
                        style: TextStyleConst.boldTextStyle(
                            ColorConst.blackColor, width * 0.055),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.specialist ?? "Specialist",
                        style: TextStyleConst.mediumTextStyle(
                            Colors.grey.shade500, width * 0.038),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // 2. Overview Card
                      // _buildInfoCard(
                      //   width,
                      //   title: StringUtils.overview,
                      //   icon: Icons.info_outline_rounded,
                      //   content: Column(
                      //     children: [
                      //       // _buildDataRow(
                      //       //     width, "Problem", data.problem ?? "N/A"),
                      //       // Padding(
                      //       //   padding: const EdgeInsets.symmetric(vertical: 12),
                      //       //   child: Divider(
                      //       //       height: 1, color: ColorConst.greyShadowColor),
                      //       // ),
                      //       // _buildDataRow(width, "Test", data.test ?? "N/A"),
                      //       // Padding(
                      //       //   padding: const EdgeInsets.symmetric(vertical: 12),
                      //       //   child: Divider(
                      //       //       height: 1, color: ColorConst.greyShadowColor),
                      //       // ),
                      //       // _buildDataRow(
                      //       //     width, "Advice", data.advice ?? "N/A"),
                      //     ],
                      //   ),
                      // ),

                      const SizedBox(height: 20),

                      // 3. Medicine Card
                      _buildInfoCard(
                        width,
                        title: "Medication",
                        icon: Icons.medication_rounded,
                        content: data.medicine == null || data.medicine!.isEmpty
                            ? Center(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "No Medicine Available",
                              style: TextStyleConst.mediumTextStyle(
                                  ColorConst.redColor, width * 0.038),
                            ),
                          ),
                        )
                            : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.medicine!.length,
                          separatorBuilder: (context, index) => Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 12),
                            child: Divider(
                                height: 1,
                                color: ColorConst.greyShadowColor),
                          ),
                          itemBuilder: (context, index) {
                            final med = data.medicine![index];
                            return Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: ColorConst.primaryColor
                                        .withOpacity(0.08),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child:  Icon(
                                      Icons.vaccines_rounded,
                                      color: ColorConst.primaryColor,
                                      size: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        med.name ?? "",
                                        style:
                                        TextStyleConst.boldTextStyle(
                                            ColorConst.blackColor,
                                            width * 0.04),
                                      ),
                                      const SizedBox(height: 4),
                                      // Text(
                                      //   "${med.dosage ?? ""} • ${med.time ?? ""}",
                                      //   style: TextStyleConst
                                      //       .mediumTextStyle(
                                      //           Colors.grey.shade600,
                                      //           width * 0.035),
                                      // ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    med.days ?? "",
                                    style: TextStyleConst.boldTextStyle(
                                        ColorConst.blackColor,
                                        width * 0.032),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 4. Download Button
                      Obx(() {
                        return prescriptionDetailsController
                            .isDownloading.value ==
                            true
                            ?  Center(
                            child: CircularProgressIndicator(
                                color: ColorConst.primaryColor))
                            : Container(
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConst.primaryColor
                                    .withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              prescriptionDetailsController.downloadPDF(
                                  data.download_prescription ?? "");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConst.primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16)),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.file_download_outlined),
                                const SizedBox(width: 8),
                                Text(
                                  StringUtils.downloadPrescription,
                                  style: TextStyleConst.boldTextStyle(
                                      Colors.white, width * 0.04),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInfoCard(double width,
      {required String title,
        required IconData icon,
        required Widget content}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Icon(icon, color: ColorConst.primaryColor, size: 22),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyleConst.boldTextStyle(
                      ColorConst.blackColor, width * 0.042),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: ColorConst.greyShadowColor),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(double width, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyleConst.mediumTextStyle(
              Colors.grey.shade500, width * 0.028),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyleConst.mediumTextStyle(
              ColorConst.blackColor, width * 0.038),
        ),
      ],
    );
  }
}