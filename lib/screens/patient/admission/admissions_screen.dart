import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/admission_controller/admission_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/admission/admission_detail_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class AdmissionScreen extends StatelessWidget {
  AdmissionScreen({Key? key}) : super(key: key);
  final AdmissionController admissionController =
      Get.put(AdmissionController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => admissionController.isGetAdmission.value == true
          ? admissionController.admissionModel!.data!.isEmpty
              ? Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No admission found",
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
                      admissionController.isGetAdmission.value = false;
                      admissionController.getAdmission();
                    },
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount:
                            admissionController.admissionModel!.data!.length,
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
                                          () => AdmissionDetailScreen(
                                            doctorImage: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .doctor_image!,
                                            dischargeTime: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .discharge_time!,
                                            admissionTime: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .admission_time!,
                                            admissionDate: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .admission_date!,
                                            admissionId: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .patient_admission_id!,
                                            agentName: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .insurance_detail!
                                                .agent_name!,
                                            bed: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .bed_id!,
                                            createOn: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .created_on!,
                                            dischargeDate: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .discharge_time!,
                                            doctor: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .doctor_name!,
                                            guardianAddress: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .guardian_address!,
                                            guardianContact: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .guardian_contact!,
                                            guardianName: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .guardian_name!,
                                            guardianRelation:
                                                admissionController
                                                    .admissionModel!
                                                    .data![index]
                                                    .guardian_relation!,
                                            insuranceName: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .insurance_detail!
                                                .insurance_name!,
                                            packageName: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .insurance_detail!
                                                .package_name!,
                                            policyNo: admissionController
                                                .admissionModel!
                                                .data![index]
                                                .insurance_detail!
                                                .policy_no!,
                                          ),
                                          transition: Transition.rightToLeft,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Left: Doctor Avatar with subtle border
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
                                                child: admissionController
                                                                .admissionModel!
                                                                .data![index]
                                                                .doctor_image ==
                                                            null ||
                                                        admissionController
                                                            .admissionModel!
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
                                                            admissionController
                                                                .admissionModel!
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
                                                    admissionController
                                                            .admissionModel!
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
                                                          "${admissionController.admissionModel!.data![index].admission_date!} • ${admissionController.admissionModel!.data![index].admission_time!}",
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

                                            // Right: Admission ID Pill
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxWidth: width * 0.28),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
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
                                                      "ID: ${admissionController.admissionModel!.data![index].patient_admission_id!}",
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
