import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/case_controller/case_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/case/case_detail_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class CaseScreen extends StatelessWidget {
  CaseScreen({Key? key}) : super(key: key);
  final CaseController caseController = Get.put(CaseController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => caseController.isGetCase.value == true
          ? caseController.caseModel!.data!.isEmpty
              ? Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No cases found",
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.blackColor,
                        width * 0.04,
                      ),
                    ),
                  ),
                )
              : Container(
                  color: ColorConst.whiteColor,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      caseController.isGetCase.value = false;
                      caseController.getCase();
                    },
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: caseController.caseModel!.data!.length,
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
                                    top: index == 0 ? 15 : 6,
                                    bottom: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                    border:
                                        Border.all(color: Colors.grey.shade100),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: () {
                                        Get.to(
                                          () => const CaseDetailScreen(),
                                          transition: Transition.rightToLeft,
                                          arguments: {
                                            "case_id": caseController.caseModel!
                                                .data![index].case_id,
                                            "case_date": caseController
                                                .caseModel!
                                                .data![index]
                                                .case_date,
                                            "doctor_name": caseController
                                                .caseModel!
                                                .data![index]
                                                .doctor_name,
                                            "case_time": caseController
                                                .caseModel!
                                                .data![index]
                                                .case_time,
                                            "fee": caseController
                                                .caseModel!.data![index].fee,
                                            "created_on": caseController
                                                .caseModel!
                                                .data![index]
                                                .created_on,
                                            "status": caseController
                                                .caseModel!.data![index].status,
                                            "currency": caseController
                                                .caseModel!
                                                .data![index]
                                                .currency,
                                            "description": caseController
                                                .caseModel!
                                                .data![index]
                                                .description,
                                            "app_logo": caseController
                                                .caseModel!
                                                .data![index]
                                                .app_logo,
                                            "doctor_image": caseController
                                                .caseModel!
                                                .data![index]
                                                .doctor_image,
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Left: Patient/Doctor Avatar with subtle border
                                            Container(
                                              height: 56,
                                              width: 56,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ColorConst
                                                        .primaryColor
                                                        .withOpacity(0.15),
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: ColorConst
                                                        .primaryColor
                                                        .withOpacity(0.1),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: ClipOval(
                                                child: caseController
                                                                .caseModel!
                                                                .data![index]
                                                                .doctor_image ==
                                                            null ||
                                                        caseController
                                                            .caseModel!
                                                            .data![index]
                                                            .doctor_image!
                                                            .isEmpty
                                                    ? Image.asset(
                                                        ImageUtils.doctorIcon,
                                                        fit: BoxFit.cover)
                                                    : FadeInImage(
                                                        placeholder:
                                                            const AssetImage(
                                                                ImageUtils
                                                                    .doctorIcon),
                                                        image: NetworkImage(
                                                            caseController
                                                                .caseModel!
                                                                .data![index]
                                                                .doctor_image!),
                                                        imageErrorBuilder:
                                                            (context, error,
                                                                stackTrace) {
                                                          return Image.asset(
                                                              ImageUtils
                                                                  .doctorIcon,
                                                              fit:
                                                                  BoxFit.cover);
                                                        },
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            const SizedBox(width: 14),

                                            // Center: Name and Date Details
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    caseController
                                                            .caseModel!
                                                            .data![index]
                                                            .doctor_name ??
                                                        "Doctor Name",
                                                    style: TextStyleConst
                                                        .boldTextStyle(
                                                            ColorConst
                                                                .blackColor,
                                                            width * 0.042),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .calendar_today_rounded,
                                                          size: 14,
                                                          color: Colors
                                                              .grey.shade500),
                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          "${caseController.caseModel!.data![index].case_date!} • ${caseController.caseModel!.data![index].case_time!}",
                                                          style: TextStyleConst
                                                              .mediumTextStyle(
                                                                  Colors.grey
                                                                      .shade600,
                                                                  width *
                                                                      0.033),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Right: Case ID Pill and Status
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxWidth: width * 0.28),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  // Case ID Pill
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: ColorConst
                                                          .primaryColor
                                                          .withOpacity(0.08),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          color: ColorConst
                                                              .primaryColor
                                                              .withOpacity(
                                                                  0.1)),
                                                    ),
                                                    child: Text(
                                                      "ID: ${caseController.caseModel!.data![index].case_id!}",
                                                      style: TextStyleConst
                                                          .boldTextStyle(
                                                              ColorConst
                                                                  .primaryColor,
                                                              width * 0.03),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  // Status text
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        height: 6,
                                                        width: 6,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: ColorConst
                                                              .greenColor,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Flexible(
                                                        child: Text(
                                                          caseController
                                                                  .caseModel!
                                                                  .data![index]
                                                                  .status ??
                                                              "",
                                                          style: TextStyleConst
                                                              .mediumTextStyle(
                                                                  ColorConst
                                                                      .greenColor,
                                                                  width *
                                                                      0.033),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
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
