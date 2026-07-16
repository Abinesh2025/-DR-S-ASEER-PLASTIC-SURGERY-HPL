import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_alert_box.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_prescription_controller/doctor_prescription_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/doctor_prescription/doctor_prescription_detail_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DoctorPrescriptionScreen extends StatelessWidget {
  DoctorPrescriptionScreen({Key? key}) : super(key: key);
  final DoctorPrescriptionController doctorPrescriptionController = Get.put(DoctorPrescriptionController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        color: ColorConst.whiteColor,
        child: Obx(() {
          return doctorPrescriptionController.isGetPrescription.value == true
              ? doctorPrescriptionController.doctorPrescriptionModel!.data!.isEmpty
                  ? Container(
                      color: ColorConst.whiteColor,
                      child: Center(
                        child: Text(
                          "No prescription found",
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
                        doctorPrescriptionController.isGetPrescription.value = false;
                        doctorPrescriptionController.getDoctorPrescription();
                      },
                      child: AnimationLimiter(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                            itemCount: doctorPrescriptionController.doctorPrescriptionModel!.data!.length,
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
                                              ContentOfDialog contentOfDialog = ContentOfDialog(
                                                height: height,
                                                width: width,
                                                image: ImageUtils.deleteIcon,
                                                title: "Delete",
                                                description: "Are you sure want to delete\nthis prescription?",
                                                leftText: StringUtils.delete,
                                                rightText: StringUtils.cancel,
                                                leftTapEvent: () {
                                                  Get.back();
                                                  doctorPrescriptionController
                                                      .deletePrescription(doctorPrescriptionController.doctorPrescriptionModel!.data![index].id!);
                                                },
                                                rightTapEvent: () {
                                                  Get.back();
                                                },
                                              );
                                              CommonAlertDialog.commonAlertDialog(context, contentOfDialog);
                                            },
                                            backgroundColor: const Color(0xFFFCE5E5),
                                            foregroundColor: ColorConst.redColor,
                                            label: StringUtils.delete,
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.only(top: index == 0 ? 5 : 0, left: 15, right: 15),
                                        onTap: () {
                                          Get.to(
                                            () => DoctorPrescriptionDetailScreen(),
                                            transition: Transition.rightToLeft,
                                            arguments: doctorPrescriptionController.doctorPrescriptionModel!.data![index].id,
                                          );
                                        },
                                        leading: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorConst.borderGreyColor,
                                          ),
                                          child: ClipOval(
                                            child: doctorPrescriptionController.doctorPrescriptionModel!.data![index].patient_image == null ||
                                                    doctorPrescriptionController.doctorPrescriptionModel!.data![index].patient_image!.isEmpty
                                                ? Image.asset(
                                                    ImageUtils.patientIcon,
                                                    fit: BoxFit.cover,
                                                  )
                                                : FadeInImage(
                                                    placeholder: const AssetImage(ImageUtils.patientIcon),
                                                    image: NetworkImage(doctorPrescriptionController.doctorPrescriptionModel!.data![index].patient_image!),
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
                                        title: Text(
                                          doctorPrescriptionController.doctorPrescriptionModel!.data![index].patient_name!,
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.blackColor,
                                            width * 0.045,
                                          ),
                                        ),
                                        subtitle: Text(
                                          doctorPrescriptionController.doctorPrescriptionModel!.data![index].created_date!,
                                          style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.036),
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
              : const Center(child: CircularProgressIndicator());
        }));
  }
}
