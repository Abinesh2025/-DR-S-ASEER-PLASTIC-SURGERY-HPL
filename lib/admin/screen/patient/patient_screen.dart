import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/patient_controller/patient_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/screen/patient/patient_details_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class PatientsScreen extends StatelessWidget {
  PatientsScreen({Key? key}) : super(key: key);
  final PatientScreenController patientController = Get.put(PatientScreenController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        color: ColorConst.whiteColor,
        child: Column(
          children: [
            Container(
              height: 70,
              margin: EdgeInsets.only(top: height * 0.01),
              width: double.infinity,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: patientController.patientStatus.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Center(
                    child: Obx(
                          () => GestureDetector(
                        onTap: () {
                          patientController.changeIndex(index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: width * 0.03, right: index == 2 ? 10 : 0),
                          height: 50,
                          decoration:
                          index == patientController.currentIndex.value
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
                                patientController.patientStatus[index],
                                style: TextStyleConst.mediumTextStyle(
                                  index == patientController.currentIndex.value
                                      ? ColorConst.whiteColor
                                      : ColorConst.hintGreyColor,
                                  width * 0.04,
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
            Obx(() {
              return patientController.isGetPatient.value != true
                  ? const Expanded(child: Center(child: CircularProgressIndicator()))
                  : patientController.filterPatientModel!.data!.isEmpty
                  ? Expanded(
                child: Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No patient data found",
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.blackColor,
                        width * 0.04,
                      ),
                    ),
                  ),
                ),
              )
                  : Expanded(
                    child: RefreshIndicator(
                onRefresh: () async {
                    patientController.isGetPatient.value = false;
                    patientController.changeIndex(patientController.currentIndex.value);
                },
                child: AnimationLimiter(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: patientController.filterPatientModel!.data!.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.only(top: index == 0 ? 5 : 0, left: 15, right: 15),
                                    onTap: () {
                                      Get.to(
                                            () => PatientDetailsScreen(),
                                        transition: Transition.rightToLeft,
                                        arguments: patientController.filterPatientModel!.data![index].id,
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
                                        child: patientController.filterPatientModel?.data?[index].patient_image == null ||
                                                patientController.filterPatientModel!.data![index].patient_image!.isEmpty
                                            ? Image.asset(
                                                ImageUtils.patientIcon,
                                                fit: BoxFit.cover,
                                              )
                                            : FadeInImage(
                                                placeholder: const AssetImage(ImageUtils.patientIcon),
                                                image: NetworkImage(patientController.filterPatientModel!.data![index].patient_image!),
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
                                    title: Text(patientController.filterPatientModel?.data?[index].patient_name ?? "",
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.blackColor,
                                        width * 0.045,
                                      ),
                                    ),
                                    subtitle: Text(patientController.filterPatientModel?.data?[index].phone_no ?? "",
                                      style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.036),
                                    ),
                                  ),
                                  index == patientController.filterPatientModel!.data!.length - 1
                                      ? const SizedBox(
                                    height: 70,
                                  )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ),
              ),
                  );
            }),
          ],
        )
  );
  }
}
