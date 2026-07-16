import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_screen_controller/doctor_detail_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DoctorDetailScreen extends StatelessWidget {
  DoctorDetailScreen({Key? key}) : super(key: key);
  final DoctorDetailController doctorDetailController = Get.put(DoctorDetailController());

  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)!.settings.arguments;
    doctorDetailController.id = res;
    doctorDetailController.getDoctorDetail();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            title: StringUtils.doctorDetails,
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body:
          Obx(() {
            return doctorDetailController.isGetDetail.value != true
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.03),
                      CommonDetailText(
                        width: width,
                        titleText: "Doctor Name:",
                        descriptionText: doctorDetailController.doctorsDetailModel!.data!.doctor_name!,
                      ),
                      SizedBox(height: height * 0.015),
                      CommonDetailText(
                        width: width,
                        titleText: "Email Address:",
                        descriptionText: doctorDetailController.doctorsDetailModel!.data!.email!,
                      ),
                      SizedBox(height: height * 0.015),
                      CommonDetailText(
                        width: width,
                        titleText: "Specialist:",
                        descriptionText: doctorDetailController.doctorsDetailModel!.data!.specialist!,
                      ),
                      SizedBox(height: height * 0.015),
                      CommonDetailText(
                        width: width,
                        titleText: "Qualification:",
                        descriptionText: doctorDetailController.doctorsDetailModel!.data!.qualification!,
                      ),

                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
