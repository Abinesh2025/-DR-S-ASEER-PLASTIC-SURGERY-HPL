import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_screen_controller/doctor_detail_controller.dart';

class DoctorDetailsScreen extends StatelessWidget {
  DoctorDetailsScreen({Key? key}) : super(key: key);
  final DoctorDetailController doctorDetailController = Get.put(DoctorDetailController());

  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)!.settings.arguments;
    doctorDetailController.id = res;
    doctorDetailController.getDoctorDetail();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ColorConst.whiteColor,
        appBar: CommonAppBar(
          title: "Doctor Details",
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Obx(() {
          return doctorDetailController.isGetDetail.value != true
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.03),
                          CommonDetailText(
                            width: width,
                            titleText: "Doctor:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.doctor_name!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Email:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.email!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Phone:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.phone!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Designation:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.designation!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Doctor Department:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.doctor_department!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Qualification:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.qualification!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Blood Group:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.blood_group!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Date Of Birth:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.date_of_birth!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Gender:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.gender!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Specialist:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.specialist!,
                          ),
                          SizedBox(height: height * 0.02),
                          CommonText(width: width, text: "Address Details"),
                          SizedBox(height: height * 0.02),
                          CommonDetailText(
                            width: width,
                            titleText: "Address 1:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.address1!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Address 2:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.address2!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "City:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.city!,
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Zip:",
                            descriptionText: doctorDetailController.doctorsDetailModel!.data!.zip!,
                          ),
                          SizedBox(height: height * 0.015),
                        ],
                      ),
                    ),
                  ),
                );
        }));
  }
}
