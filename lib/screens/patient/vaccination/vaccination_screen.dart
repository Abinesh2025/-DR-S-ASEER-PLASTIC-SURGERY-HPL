import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/vaccination_controller/vaccination_controller.dart';

class VaccinationScreen extends StatelessWidget {
  VaccinationScreen({Key? key}) : super(key: key);
  final VaccinationController vaccinationController =
      Get.put(VaccinationController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => vaccinationController.isGetVaccination.value == true
          ? vaccinationController.vaccinatedModel!.data!.isEmpty
              ? Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No vaccinations found",
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
                      vaccinationController.isGetVaccination.value = false;
                      vaccinationController.getVaccination();
                    },
                    child: AnimationLimiter(
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        itemCount:
                            vaccinationController.vaccinatedModel!.data!.length,
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        // Left: Icon Box
                                        Container(
                                          height: 48,
                                          width: 48,
                                          decoration: BoxDecoration(
                                            color: ColorConst.primaryColor
                                                .withOpacity(0.08),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child:  Icon(
                                            Icons.vaccines_rounded,
                                            color: ColorConst.primaryColor,
                                            size: 24,
                                          ),
                                        ),
                                        const SizedBox(width: 14),

                                        // Center: Vaccine Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      vaccinationController
                                                              .vaccinatedModel!
                                                              .data![index]
                                                              .vaccine_name ??
                                                          "Vaccine Name",
                                                      style: TextStyleConst
                                                          .boldTextStyle(
                                                              ColorConst
                                                                  .blackColor,
                                                              width * 0.042),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  // Right: Dose Badge
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: ColorConst
                                                          .primaryColor
                                                          .withOpacity(0.08),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Text(
                                                      "Dose ${vaccinationController.vaccinatedModel!.data![index].dose_number}",
                                                      style: TextStyleConst
                                                          .boldTextStyle(
                                                              ColorConst
                                                                  .primaryColor,
                                                              width * 0.028),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                "SN: ${vaccinationController.vaccinatedModel!.data![index].serial_number}",
                                                style: TextStyleConst
                                                    .mediumTextStyle(
                                                        Colors.green.shade600,
                                                        width * 0.033),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons.access_time_rounded,
                                                      size: 12,
                                                      color:
                                                          Colors.grey.shade500),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    "${vaccinationController.vaccinatedModel!.data![index].time} • ${vaccinationController.vaccinatedModel!.data![index].date}",
                                                    style: TextStyleConst
                                                        .mediumTextStyle(
                                                            Colors
                                                                .grey.shade500,
                                                            width * 0.032),
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
