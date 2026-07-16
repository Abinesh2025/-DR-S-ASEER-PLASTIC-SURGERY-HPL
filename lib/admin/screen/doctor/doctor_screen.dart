import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/doctor_controller/doctors_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/screen/doctor/doctor_detail_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class DoctorsScreen extends StatelessWidget {
  DoctorsScreen({Key? key}) : super(key: key);
  final DoctorsController doctorController = Get.put(DoctorsController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                itemCount: doctorController.doctorStatus.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Center(
                    child: Obx(
                          () => GestureDetector(
                        onTap: () {
                          doctorController.changeIndex(index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: width * 0.03, right: index == 2 ? 10 : 0),
                          height: 50,
                          decoration:
                          index == doctorController.currentIndex.value
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
                                doctorController.doctorStatus[index],
                                style: TextStyleConst.mediumTextStyle(
                                  index == doctorController.currentIndex.value
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
              return doctorController.isGetDoctor.value != true
                  ? const Expanded(child: Center(child: CircularProgressIndicator()))
                  : doctorController.filterDoctorsModel!.data!.isEmpty
                  ? Expanded(
                child: Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No Doctor found",
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
                    doctorController.isGetDoctor.value = false;
                    doctorController.changeIndex(doctorController.currentIndex.value);
                },
                child: AnimationLimiter(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: doctorController.filterDoctorsModel!.data!.length,
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
                                            () => DoctorDetailScreen(),
                                        transition: Transition.rightToLeft,
                                        arguments: doctorController.filterDoctorsModel!.data![index].id,
                                      );
                                    },
                                    leading: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: ClipOval(
                                        child: doctorController.filterDoctorsModel?.data?[index].doctor_image == null ||
                                                doctorController.filterDoctorsModel!.data![index].doctor_image!.isEmpty
                                            ? Image.asset(
                                                ImageUtils.doctorIcon,
                                                fit: BoxFit.cover,
                                              )
                                            : FadeInImage(
                                                placeholder: const AssetImage(ImageUtils.doctorIcon),
                                                image: NetworkImage(
                                                  doctorController.filterDoctorsModel!.data![index].doctor_image!,
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
                                    title: Text(doctorController.filterDoctorsModel?.data?[index].doctor_name ?? "",
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.blackColor,
                                        width * 0.045,
                                      ),
                                    ),
                                    subtitle: Text("Specialist: ${doctorController.filterDoctorsModel?.data?[index].doctor_specialist ?? ""}",
                                      style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.036),
                                    ),
                                  ),
                                  index == doctorController.filterDoctorsModel!.data!.length - 1
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
