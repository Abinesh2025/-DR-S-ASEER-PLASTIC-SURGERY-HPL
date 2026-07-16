import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/diagnosis_controller/diagnosis_test_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/diagnosis/diagnosis_test_detail_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DiagnosisScreen extends StatelessWidget {
  DiagnosisScreen({Key? key}) : super(key: key);
  final DiagnosisTestController diagnosisTestController =
      Get.put(DiagnosisTestController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => PreferenceUtils.getStringValue("role") == "Doctor"
          ? diagnosisTestController.isDiagnosisTestApiCall.value == true
              ? diagnosisTestController.doctorDiagnosisTestModel!.data!.isEmpty
                  ? Container(
                      color: ColorConst.whiteColor,
                      child: Center(
                        child: Text(
                          "No diagnosis test found",
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.04,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.white,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          diagnosisTestController.isDiagnosisTestApiCall.value =
                              false;
                          diagnosisTestController.getDoctorDiagnosisTest();
                        },
                        child: AnimationLimiter(
                          child: ListView.builder(
                            itemCount: diagnosisTestController
                                .doctorDiagnosisTestModel!.data!.length,
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 1000),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                        extentRatio: 0.25,
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                    child: Container(
                                                      height: height / 2.7,
                                                      width: width / 1.12,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 60,
                                                            width: 60,
                                                            decoration:
                                                                const BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    ImageUtils
                                                                        .deleteIcon),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: height *
                                                                  0.03),
                                                          Text(
                                                            "Delete",
                                                            style: TextStyleConst
                                                                .boldTextStyle(
                                                              ColorConst
                                                                  .blackColor,
                                                              width * 0.05,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: height *
                                                                  0.01),
                                                          Text(
                                                            "Are you sure want to delete this\n appointment?",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyleConst
                                                                .mediumTextStyle(
                                                              ColorConst
                                                                  .hintGreyColor,
                                                              width * 0.042,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: height *
                                                                  0.03),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              CommonButton(
                                                                textStyleConst:
                                                                    TextStyleConst
                                                                        .mediumTextStyle(
                                                                  ColorConst
                                                                      .whiteColor,
                                                                  width * 0.05,
                                                                ),
                                                                onTap: () {
                                                                  Get.back();
                                                                  diagnosisTestController.deleteTest(
                                                                      diagnosisTestController
                                                                          .doctorDiagnosisTestModel!
                                                                          .data![
                                                                              index]
                                                                          .id!);
                                                                },
                                                                color: ColorConst
                                                                    .blueColor,
                                                                text:
                                                                    StringUtils
                                                                        .delete,
                                                                width:
                                                                    width / 2.5,
                                                                height: 50,
                                                              ),
                                                              CommonButton(
                                                                textStyleConst:
                                                                    TextStyleConst
                                                                        .mediumTextStyle(
                                                                  ColorConst
                                                                      .hintGreyColor,
                                                                  width * 0.05,
                                                                ),
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                color: ColorConst
                                                                    .borderGreyColor,
                                                                text:
                                                                    StringUtils
                                                                        .cancel,
                                                                width:
                                                                    width / 2.5,
                                                                height: 50,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            backgroundColor:
                                                const Color(0xFFFCE5E5),
                                            foregroundColor:
                                                ColorConst.redColor,
                                            label: StringUtils.delete,
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: index == 0 ? 15 : 8,
                                            bottom: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.04),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                          border: Border.all(
                                              color: Colors.grey.shade100),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            onTap: () {
                                              // Get.to(
                                              //   () =>
                                              //       DiagnosisTestDetailScreen(),
                                              //   transition:
                                              //       Transition.rightToLeft,
                                              //   arguments: diagnosisTestController
                                              //       .doctorDiagnosisTestModel!
                                              //       .data![index]
                                              //       .id,
                                              // );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Patient Avatar
                                                  Container(
                                                    height: 56,
                                                    width: 56,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: ColorConst
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.2),
                                                            width: 2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.05),
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2))
                                                        ]),
                                                    child: ClipOval(
                                                      child: diagnosisTestController
                                                                      .doctorDiagnosisTestModel!
                                                                      .data![
                                                                          index]
                                                                      .patient_image ==
                                                                  null ||
                                                              diagnosisTestController
                                                                  .doctorDiagnosisTestModel!
                                                                  .data![index]
                                                                  .patient_image!
                                                                  .isEmpty
                                                          ? Image.asset(
                                                              ImageUtils
                                                                  .patientIcon,
                                                              fit: BoxFit.cover)
                                                          : FadeInImage(
                                                              placeholder:
                                                                  const AssetImage(
                                                                      ImageUtils
                                                                          .patientIcon),
                                                              image: NetworkImage(
                                                                  diagnosisTestController
                                                                      .doctorDiagnosisTestModel!
                                                                      .data![
                                                                          index]
                                                                      .patient_image!),
                                                              imageErrorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Image.asset(
                                                                    ImageUtils
                                                                        .patientIcon,
                                                                    fit: BoxFit
                                                                        .cover);
                                                              },
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 14),

                                                  // Main Info Column
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Name & Download Row
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                diagnosisTestController
                                                                        .doctorDiagnosisTestModel!
                                                                        .data![
                                                                            index]
                                                                        .patient_name ??
                                                                    "N/A",
                                                                style: TextStyleConst
                                                                    .boldTextStyle(
                                                                        ColorConst
                                                                            .blackColor,
                                                                        width *
                                                                            0.042),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),

                                                            // Download Button
                                                            diagnosisTestController
                                                                    .isDownloading[
                                                                        index]
                                                                    .value
                                                                ?  SizedBox(
                                                                    height: 24,
                                                                    width: 24,
                                                                    child: CircularProgressIndicator(
                                                                        color: ColorConst
                                                                            .primaryColor,
                                                                        strokeWidth:
                                                                            2))
                                                                : InkWell(
                                                                    onTap: () {
                                                                      diagnosisTestController.downloadPDF(
                                                                          context,
                                                                          index);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              6),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: ColorConst
                                                                            .primaryColor
                                                                            .withOpacity(0.1),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Icon(
                                                                          Icons
                                                                              .file_download_outlined,
                                                                          color: ColorConst
                                                                              .primaryColor,
                                                                          size:
                                                                              18),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 4),

                                                        // Category
                                                        Text(
                                                          diagnosisTestController
                                                                  .doctorDiagnosisTestModel!
                                                                  .data![index]
                                                                  .category ??
                                                              "N/A",
                                                          style: TextStyleConst
                                                              .mediumTextStyle(
                                                                  Colors.grey
                                                                      .shade600,
                                                                  width *
                                                                      0.035),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),

                                                        // Bottom Row: Report Number Badge & Date
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            // Report Badge
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          4),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: ColorConst
                                                                    .bgGreyColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .assignment_outlined,
                                                                      size: 12,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade700),
                                                                  const SizedBox(
                                                                      width: 4),
                                                                  Text(
                                                                    diagnosisTestController
                                                                            .doctorDiagnosisTestModel!
                                                                            .data![index]
                                                                            .report_number ??
                                                                        "N/A",
                                                                    style: TextStyleConst.boldTextStyle(
                                                                        Colors
                                                                            .grey
                                                                            .shade800,
                                                                        width *
                                                                            0.03),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            // Date
                                                            Text(
                                                              diagnosisTestController
                                                                      .doctorDiagnosisTestModel!
                                                                      .data![
                                                                          index]
                                                                      .created_at ??
                                                                  "",
                                                              style: TextStyleConst
                                                                  .mediumTextStyle(
                                                                      ColorConst
                                                                          .primaryColor,
                                                                      width *
                                                                          0.032),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
              : const Center(child: CircularProgressIndicator())
          : diagnosisTestController.isDiagnosisTestApiCall.value == true
              ? diagnosisTestController.diagnosisTestModel!.data!.isEmpty
                  ? Container(
                      color: ColorConst.whiteColor,
                      child: Center(
                        child: Text(
                          "No diagnosis test found",
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.04,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.white,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          diagnosisTestController.isDiagnosisTestApiCall.value =
                              false;
                          diagnosisTestController.getDiagnosisTest();
                        },
                        child: AnimationLimiter(
                          child: ListView.builder(
                            itemCount: diagnosisTestController
                                .diagnosisTestModel!.data!.length,
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 1000),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: index == 0 ? 15 : 8,
                                          bottom: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.04),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                        border: Border.all(
                                            color: Colors.grey.shade100),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          onTap: () {
                                            Get.to(
                                              () => DiagnosisTestDetailScreen(),
                                              transition:
                                                  Transition.rightToLeft,
                                              arguments: diagnosisTestController
                                                  .diagnosisTestModel!
                                                  .data![index]
                                                  .id,
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Patient Avatar
                                                Container(
                                                  height: 56,
                                                  width: 56,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorConst
                                                              .primaryColor
                                                              .withOpacity(0.2),
                                                          width: 2),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.05),
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 2))
                                                      ]),
                                                  child: ClipOval(
                                                    child: diagnosisTestController
                                                                    .diagnosisTestModel!
                                                                    .data![
                                                                        index]
                                                                    .patient_image ==
                                                                null ||
                                                            diagnosisTestController
                                                                .diagnosisTestModel!
                                                                .data![index]
                                                                .patient_image!
                                                                .isEmpty
                                                        ? Image.asset(
                                                            ImageUtils
                                                                .patientIcon,
                                                            fit: BoxFit.cover)
                                                        : FadeInImage(
                                                            placeholder:
                                                                const AssetImage(
                                                                    ImageUtils
                                                                        .patientIcon),
                                                            image: NetworkImage(
                                                                diagnosisTestController
                                                                    .diagnosisTestModel!
                                                                    .data![
                                                                        index]
                                                                    .patient_image!),
                                                            imageErrorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image.asset(
                                                                  ImageUtils
                                                                      .patientIcon,
                                                                  fit: BoxFit
                                                                      .cover);
                                                            },
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                ),
                                                const SizedBox(width: 14),

                                                // Main Info Column
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Name & Download Row
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              diagnosisTestController
                                                                      .diagnosisTestModel!
                                                                      .data![
                                                                          index]
                                                                      .patient_name ??
                                                                  "N/A",
                                                              style: TextStyleConst
                                                                  .boldTextStyle(
                                                                      ColorConst
                                                                          .blackColor,
                                                                      width *
                                                                          0.042),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),

                                                          // Download Button
                                                          diagnosisTestController
                                                                  .isDownloading[
                                                                      index]
                                                                  .value
                                                              ?  SizedBox(
                                                                  height: 24,
                                                                  width: 24,
                                                                  child: CircularProgressIndicator(
                                                                      color: ColorConst
                                                                          .primaryColor,
                                                                      strokeWidth:
                                                                          2))
                                                              : InkWell(
                                                                  onTap: () {
                                                                    diagnosisTestController
                                                                        .downloadPDF(
                                                                            context,
                                                                            index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            6),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorConst
                                                                          .primaryColor
                                                                          .withOpacity(
                                                                              0.1),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Icon(
                                                                        Icons
                                                                            .file_download_outlined,
                                                                        color: ColorConst
                                                                            .primaryColor,
                                                                        size:
                                                                            18),
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),

                                                      // Category
                                                      Text(
                                                        diagnosisTestController
                                                                .diagnosisTestModel!
                                                                .data![index]
                                                                .category ??
                                                            "N/A",
                                                        style: TextStyleConst
                                                            .mediumTextStyle(
                                                                Colors.grey
                                                                    .shade600,
                                                                width * 0.035),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),

                                                      // Bottom Row: Report Number Badge & Date
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          // Report Badge
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        4),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ColorConst
                                                                  .bgGreyColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade200),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .assignment_outlined,
                                                                    size: 12,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700),
                                                                const SizedBox(
                                                                    width: 4),
                                                                Text(
                                                                  diagnosisTestController
                                                                          .diagnosisTestModel!
                                                                          .data![
                                                                              index]
                                                                          .report_number ??
                                                                      "N/A",
                                                                  style: TextStyleConst.boldTextStyle(
                                                                      Colors
                                                                          .grey
                                                                          .shade800,
                                                                      width *
                                                                          0.03),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          // Date
                                                          Text(
                                                            diagnosisTestController
                                                                    .diagnosisTestModel!
                                                                    .data![
                                                                        index]
                                                                    .created_at ??
                                                                "",
                                                            style: TextStyleConst
                                                                .mediumTextStyle(
                                                                    ColorConst
                                                                        .primaryColor,
                                                                    width *
                                                                        0.032),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
