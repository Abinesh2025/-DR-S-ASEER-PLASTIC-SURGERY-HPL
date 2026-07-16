import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/patient_controller/patient_detail_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class PatientDetailsScreen extends StatelessWidget {
  PatientDetailsScreen({Key? key}) : super(key: key);
  final PatientDetailController patientDetailController = Get.put(PatientDetailController());

  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)!.settings.arguments;
    patientDetailController.id = res;
    patientDetailController.getPatientDetail();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            title: StringUtils.patientsDetails,
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body: Obx(() {
            return patientDetailController.isGetDetail.value != true
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
                        titleText: "Patients Name:",
                        descriptionText: patientDetailController.patientsDetailModel!.data!.patient_name!,
                      ),
                      SizedBox(height: height * 0.015),
                      CommonDetailText(
                        width: width,
                        titleText: "Email Address:",
                        descriptionText: patientDetailController.patientsDetailModel!.data!.email_id!,
                      ),
                      SizedBox(height: height * 0.015),
                      CommonDetailText(
                        width: width,
                        titleText: "Phone Number:",
                        descriptionText: patientDetailController.patientsDetailModel!.data!.phone_no!,
                      ),
                      SizedBox(height: height * 0.015),
                      CommonDetailText(
                        width: width,
                        titleText: "Blood Group:",
                        descriptionText: patientDetailController.patientsDetailModel!.data!.blood_group!,
                      ),
                    ],
                  ),
                ),
              ),
            );
          })
  ),
    );
  }
}
