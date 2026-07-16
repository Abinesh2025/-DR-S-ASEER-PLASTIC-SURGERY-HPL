import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/patient_admission_controller/patient_admission_details_controller.dart';

class PatientAdmissionDetailsScreen extends StatelessWidget {
  PatientAdmissionDetailsScreen({Key? key}) : super(key: key);

  final PatientAdmissionDetailsController patientAdmissionDetailsController = Get.put(PatientAdmissionDetailsController());

  @override
  Widget build(BuildContext context) {

    var res = ModalRoute.of(context)!.settings.arguments as int;
    patientAdmissionDetailsController.getPatientAdmissionDetails(res);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            title: "Patient Admission Details",
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body: Obx(
            () {
              return patientAdmissionDetailsController.isGotDetails.value == false
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.02),
                            CommonText(
                              width: width,
                              text: "Admission Details",
                            ),
                            SizedBox(height: height * 0.02),
                            CommonDetailText(
                              width: width,
                              titleText: "Admission ID:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.admission_id ?? "",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Patient:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.patient ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Admission Date:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.admission_date ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Discharge Date:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.discharge_date ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Bed:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.bed ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Guardian Name:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.guardian_name ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Guardian Relation:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.guardian_relation ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Guardian Contact:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.guardian_contact ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Guardian Address:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.guardian_address ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Created On:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.created_on ?? "N/A",
                            ),
                            SizedBox(height: height * 0.04),
                            CommonText(
                              width: width,
                              text: "Insurance Details",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Package Name:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.package_name ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Insurance Name:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.insurance_name ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Agent Name:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.agent_name ?? "N/A",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: "Policy No:",
                              descriptionText: patientAdmissionDetailsController.patientAdmissionDetailsModel?.data?.policy_number ?? "N/A",
                            ),
                          ],
                        ),
                      ),
                    );
            },
          )),
    );
  }
}
