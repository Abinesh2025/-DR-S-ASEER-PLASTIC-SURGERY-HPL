import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/live_consultancy_controller/live_consultations_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/consultancy/live_consultations_detail_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/widget/live_consul_status.dart';

class LiveConsultationsScreen extends StatelessWidget {
  LiveConsultationsScreen({Key? key}) : super(key: key);
  final LiveConsultationsController liveConsultationsController = Get.put(LiveConsultationsController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConst.whiteColor,
      child: Column(
        children: [
          Container(
            height: 70,
            margin: EdgeInsets.only(top: height * 0.01),
            width: double.infinity,
            child: ListView.builder(
              itemCount: liveConsultationsController.consultationsStatus.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Center(child: Obx(() {
                  return GestureDetector(
                    onTap: () {
                      liveConsultationsController.changeIndex(index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: width * 0.03, right: index == 3 ? 10 : 0),
                      height: 45,
                      decoration: index == liveConsultationsController.currentIndex.value
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConst.primaryColor,
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2,
                                color: ColorConst.borderGreyColor,
                              ),
                            ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            liveConsultationsController.consultationsStatus[index],
                            style: TextStyleConst.mediumTextStyle(
                              index == liveConsultationsController.currentIndex.value ? ColorConst.whiteColor : ColorConst.hintGreyColor,
                              width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }));
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (PreferenceUtils.getStringValue("role") == "Doctor") {
                return !liveConsultationsController.gotConsultationData.value
                    ?  Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                    : liveConsultationsController.doctorLiveConsultationsModel?.data?.isEmpty ?? true
                        ? Center(
                            child: Text(
                              "No consultations found",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.04,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              liveConsultationsController.changeIndex(liveConsultationsController.currentIndex.value);
                            },
                            child: AnimationLimiter(
                              child: ListView.builder(
                                itemCount: liveConsultationsController.doctorLiveConsultationsModel?.data?.length ?? 0,
                                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 1000),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: ListTile(
                                          onTap: () {
                                            Get.to(
                                              () => LiveConsultationsDetailScreen(),
                                              transition: Transition.rightToLeft,
                                              arguments: liveConsultationsController.doctorLiveConsultationsModel!.data![index].id,
                                            );
                                          },
                                          contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 10, left: 15, right: 15),
                                          leading: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipOval(
                                              child: liveConsultationsController.doctorLiveConsultationsModel?.data?[index].patient_image == null ||
                                                      liveConsultationsController.doctorLiveConsultationsModel!.data![index].patient_image!.trim().isEmpty
                                                  ? Image.asset(
                                                      ImageUtils.patientIcon,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : FadeInImage(
                                                      placeholder: const AssetImage(ImageUtils.patientIcon),
                                                      image: NetworkImage(
                                                        liveConsultationsController.doctorLiveConsultationsModel!.data![index].patient_image!.replaceAll(" ", ""),
                                                      ),
                                                      imageErrorBuilder: (context, error, stackTrace) {
                                                        return Image.asset(
                                                          ImageUtils.patientIcon,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          trailing: liveConsultationsController.doctorLiveConsultationsModel!.data![index].status == "Awaited"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    liveConsultationsController.getDoctorLiveMeeting(
                                                      liveConsultationsController.doctorLiveConsultationsModel!.data![index].id!,
                                                      context,
                                                      height,
                                                      width,
                                                    );
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.only(right: 10),
                                                    width: 30,
                                                    height: 30,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(ImageUtils.videoIcon),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                          title: Text(
                                            liveConsultationsController.doctorLiveConsultationsModel?.data?[index].consultation_title ?? "",
                                            style: TextStyleConst.mediumTextStyle(
                                              ColorConst.blackColor,
                                              width * 0.045,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: height * 0.002),
                                              statusText("${liveConsultationsController.doctorLiveConsultationsModel!.data![index].status}", width),
                                              SizedBox(height: height * 0.004),
                                              Text(
                                                "${liveConsultationsController.doctorLiveConsultationsModel?.data?[index].consultation_time ?? ""} - ${liveConsultationsController.doctorLiveConsultationsModel?.data?[index].consultation_date ?? ""}",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.hintGreyColor,
                                                  width * 0.036,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
              } else {
                return !liveConsultationsController.gotConsultationData.value
                    ?  Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                    : liveConsultationsController.liveConsultationFilter?.data?.isEmpty ?? true
                        ? Center(
                            child: Text(
                              "No consultations founds",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.04,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              liveConsultationsController.changeIndex(liveConsultationsController.currentIndex.value);
                            },
                            child: AnimationLimiter(
                              child: ListView.builder(
                                itemCount: liveConsultationsController.liveConsultationFilter?.data?.length ?? 0,
                                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 1000),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: ListTile(
                                          onTap: () {
                                            Get.to(
                                              () => LiveConsultationsDetailScreen(),
                                              transition: Transition.rightToLeft,
                                              arguments: liveConsultationsController.liveConsultationFilter!.data![index].id,
                                            );
                                          },
                                          contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 10, left: 15, right: 15),
                                          leading: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipOval(
                                              child: liveConsultationsController.liveConsultationFilter?.data?[index].doctor_image == null ||
                                                      liveConsultationsController.liveConsultationFilter!.data![index].doctor_image!.trim().isEmpty
                                                  ? Image.asset(
                                                      ImageUtils.doctorIcon,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : FadeInImage(
                                                      placeholder: const AssetImage(ImageUtils.doctorIcon),
                                                      image: NetworkImage(
                                                        liveConsultationsController.liveConsultationFilter!.data![index].doctor_image!.replaceAll(" ", ""),
                                                      ),
                                                      imageErrorBuilder: (context, error, stackTrace) {
                                                        return Image.asset(
                                                          ImageUtils.doctorIcon,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          trailing: liveConsultationsController.liveConsultationFilter?.data?[index].status == "Awaited"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    liveConsultationsController.getLiveMeeting(
                                                      liveConsultationsController.liveConsultationFilter!.data![index].id!,
                                                      context,
                                                      height,
                                                      width,
                                                    );
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.only(right: 10),
                                                    width: 30,
                                                    height: 30,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(ImageUtils.videoIcon),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                          title: Text(
                                            liveConsultationsController.liveConsultationFilter?.data?[index].consultation_title ?? "",
                                            style: TextStyleConst.mediumTextStyle(
                                              ColorConst.blackColor,
                                              width * 0.045,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: height * 0.002),
                                              statusText(liveConsultationsController.liveConsultationFilter?.data?[index].status ?? "", width),
                                              SizedBox(height: height * 0.004),
                                              Text(
                                                "${liveConsultationsController.liveConsultationFilter?.data?[index].consultation_time ?? ""} - ${liveConsultationsController.liveConsultationFilter?.data?[index].consultation_date ?? ""}",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.hintGreyColor,
                                                  width * 0.036,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
              }
            }),
          ),
        ],
      ),
    );
  }
}
