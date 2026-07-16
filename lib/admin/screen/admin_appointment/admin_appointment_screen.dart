import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/appointment_controller/appointment_controllers.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/appointment_controller/filter_appointments_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_alert_box.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class AdminAppointmentsScreen extends StatelessWidget {
  AdminAppointmentsScreen({Key? key}) : super(key: key);

  final AdminAppointmentController appointmentController = Get.put(AdminAppointmentController());
  final AdminFilterAppointmentController filterAppointmentController = Get.put(AdminFilterAppointmentController());
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
              physics: const BouncingScrollPhysics(),
              itemCount: appointmentController.appointmentStatus.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Center(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () {
                        filterAppointmentController.changeIndex(index);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: width * 0.03, right: index == 3 ? 10 : 0),
                        height: 50,
                        decoration:
                            index == appointmentController.currentIndex.value
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
                              appointmentController.appointmentStatus[index],
                              style: TextStyleConst.mediumTextStyle(
                                index == appointmentController.currentIndex.value
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
            return filterAppointmentController.isApiCall.value != false
                ? filterAppointmentController.filterAdminAppointmentModel!.data!.isNotEmpty
                    ? Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            filterAppointmentController.changeIndex(appointmentController.currentIndex.value);
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemCount: filterAppointmentController.filterAdminAppointmentModel!.data!.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Column(
                                        children: [
                                          appointmentController.currentIndex.value == 0 ||
                                              appointmentController.currentIndex.value == 1
                                              ? Slidable(
                                      startActionPane: filterAppointmentController
                                          .filterAdminAppointmentModel!
                                          .data![index]
                                          .is_completed == "Pending"? ActionPane(
                                                    extentRatio: 0.25,
                                                    motion: const ScrollMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        onPressed: (context) {
                                                          if (filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed != "Completed") {
                                                            if (filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed != "Cancelled") {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return Center(
                                                                    child: Container(
                                                                      height: height / 2.7,
                                                                      width: width / 1.12,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(15),
                                                                        color: Colors.white,
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            height: 60,
                                                                            width: 60,
                                                                            decoration: const BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: AssetImage(ImageUtils.alertIcon),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: height * 0.03),
                                                                          Text("Cancel Appointment",
                                                                            style: TextStyleConst.boldTextStyle(
                                                                              ColorConst.blackColor,
                                                                              width * 0.05,
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: height * 0.01),
                                                                          Text("Are you sure want to cancel\n Appointment?",
                                                                            textAlign: TextAlign.center,
                                                                            style: TextStyleConst.mediumTextStyle(
                                                                              ColorConst.hintGreyColor,
                                                                              width * 0.042,
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: height * 0.03),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              CommonButton(
                                                                                textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                                                                onTap: () {
                                                                                  Get.back();
                                                                                  filterAppointmentController.cancelledPendingAppointment(filterAppointmentController.filterAdminAppointmentModel!.data![index].id!);
                                                                                },
                                                                                color: ColorConst.blueColor,
                                                                                text: StringUtils.yes,
                                                                                width: width / 2.5,
                                                                                height: 50,
                                                                              ),
                                                                              CommonButton(
                                                                                textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
                                                                                onTap: () {
                                                                                  Get.back();
                                                                                },
                                                                                color: ColorConst.borderGreyColor,
                                                                                text: StringUtils.no,
                                                                                width: width / 2.5,
                                                                                height: 50,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              DisplaySnackBar.displaySnackBar("This appointment is already cancelled", 3, ColorConst.redColor);
                                                            }
                                                          } else {
                                                            DisplaySnackBar.displaySnackBar("This appointment can't be cancelled", 3, ColorConst.redColor);
                                                          }
                                                        },
                                                        backgroundColor: ColorConst.borderGreyColor,
                                                        foregroundColor: ColorConst.blackColor,
                                                        label: StringUtils.cancel,
                                                        // lableColor: ColorConst.hintGreyColor,
                                                      ),
                                                    ],
                                                  ) : null,
                                            endActionPane: filterAppointmentController
                                                .filterAdminAppointmentModel!
                                                .data![index]
                                                .is_completed == "Pending"
                                                ?ActionPane(
                                                    extentRatio: 0.25,
                                                    motion: const ScrollMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        onPressed: (context) {
                                                          if (filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed != "Completed") {
                                                            if(filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed != "Cancelled") {
                                                              ContentOfDialog contentOfDialog = ContentOfDialog(
                                                                height: height,
                                                                width: width,
                                                                image: ImageUtils.confirmIcon,
                                                                title: "Confirm Appointment",
                                                                description: "Are you sure want to confirm this \nAppointment?",
                                                                leftText: StringUtils.confirm,
                                                                rightText: StringUtils.cancel,
                                                                leftTapEvent: () {
                                                                  Get.back();
                                                                  filterAppointmentController.confirmAppointment(filterAppointmentController.filterAdminAppointmentModel!.data![index].id!,);
                                                                },
                                                                rightTapEvent: () {

                                                                  Get.back();
                                                                },
                                                              );
                                                              CommonAlertDialog.commonAlertDialog(context, contentOfDialog);
                                                            } else {
                                                              DisplaySnackBar.displaySnackBar("This appointment can't be confirmed", 3, ColorConst.redColor);
                                                            }
                                                          } else {
                                                            DisplaySnackBar.displaySnackBar("This appointment is already confirmed", 3, ColorConst.redColor);
                                                          }
                                                        },
                                                        backgroundColor: const Color(0xFFE5F6EA),
                                                        foregroundColor: ColorConst.greenColor,
                                                        label: StringUtils.confirm,
                                                      ),
                                                    ],
                                                  ) : null,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 10),
                                                    child: ListTile(
                                                      title: Padding(
                                                        padding: EdgeInsets.only(bottom: height * 0.01),
                                                        child: Text(
                                                          filterAppointmentController.filterAdminAppointmentModel!.data![index].patient_name!,
                                                          style: TextStyleConst.mediumTextStyle(
                                                            ColorConst.blackColor,
                                                            width * 0.045,
                                                          ),
                                                        ),
                                                      ),
                                                      subtitle: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed! == "Completed"
                                                                    ? "Confirmed"
                                                                    : filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed!,
                                                                style: TextStyleConst.mediumTextStyle(
                                                                  filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed! == "Completed"
                                                                      ? ColorConst.greenColor
                                                                      : filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed! == "Pending"
                                                                          ? ColorConst.orangeColor
                                                                          : ColorConst.redColor,
                                                                  width * 0.036,
                                                                ),
                                                              ),
                                                              Text(
                                                                " | ${filterAppointmentController.filterAdminAppointmentModel!.data![index].appointment_time!} - ",
                                                                style: TextStyleConst.mediumTextStyle(
                                                                  ColorConst.hintGreyColor,
                                                                  width * 0.036,
                                                                ),
                                                              ),
                                                              Text(
                                                                filterAppointmentController.filterAdminAppointmentModel!.data![index].appointment_date!,
                                                                style: TextStyleConst.mediumTextStyle(
                                                                  ColorConst.hintGreyColor,
                                                                  width * 0.036,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * 0.006,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Doctor: ",
                                                                style: TextStyleConst.mediumTextStyle(
                                                                  ColorConst.hintGreyColor,
                                                                  width * 0.036,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  '${filterAppointmentController.filterAdminAppointmentModel!.data![index].doctor_name!} (${filterAppointmentController.filterAdminAppointmentModel!.data![index].doctor_department!})',
                                                                  overflow: TextOverflow.visible,
                                                                  maxLines: 2,
                                                                  style: TextStyleConst.mediumTextStyle(
                                                                    ColorConst.blackColor,
                                                                    width * 0.036,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      leading: Container(
                                                        height: 60,
                                                        width: 60,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                          ),
                                                            child: ClipOval(
                                                              child: filterAppointmentController.filterAdminAppointmentModel!.data![index].patient_image == null ||
                                                                      filterAppointmentController.filterAdminAppointmentModel!.data![index].patient_image!.isEmpty
                                                                  ? Image.asset(
                                                                      ImageUtils.patientIcon,
                                                                      fit: BoxFit.cover,
                                                                    )
                                                                  : FadeInImage(
                                                                      placeholder: const AssetImage(ImageUtils.patientIcon),
                                                                      image: NetworkImage(
                                                                        filterAppointmentController.filterAdminAppointmentModel!.data![index].patient_image!,
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
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: ListTile(
                                                    title: Padding(
                                                      padding: EdgeInsets.only(bottom: height * 0.01),
                                                      child: Text(
                                                        filterAppointmentController.filterAdminAppointmentModel!.data![index].patient_name!,
                                                        style: TextStyleConst.mediumTextStyle(
                                                          ColorConst.blackColor,
                                                          width * 0.045,
                                                        ),
                                                      ),
                                                    ),
                                                    subtitle: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed! == "Completed"
                                                                  ? "Confirmed"
                                                                  : filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed!,
                                                              style: TextStyleConst.mediumTextStyle(
                                                                filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed! == "Completed"
                                                                    ? ColorConst.greenColor
                                                                    : filterAppointmentController.filterAdminAppointmentModel!.data![index].is_completed! == "Pending"
                                                                        ? ColorConst.orangeColor
                                                                        : ColorConst.redColor,
                                                                width * 0.036,
                                                              ),
                                                            ),
                                                            Text(
                                                              " | ${filterAppointmentController.filterAdminAppointmentModel!.data![index].appointment_time!} - ",
                                                              style: TextStyleConst.mediumTextStyle(
                                                                ColorConst.hintGreyColor,
                                                                width * 0.036,
                                                              ),
                                                            ),
                                                            Text(
                                                              filterAppointmentController.filterAdminAppointmentModel!.data![index].appointment_date!,
                                                              style: TextStyleConst.mediumTextStyle(
                                                                ColorConst.hintGreyColor,
                                                                width * 0.036,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.006,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Doctor: ",
                                                              style: TextStyleConst.mediumTextStyle(
                                                                ColorConst.hintGreyColor,
                                                                width * 0.036,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '${filterAppointmentController.filterAdminAppointmentModel!.data![index].doctor_name!} (${filterAppointmentController.filterAdminAppointmentModel!.data![index].doctor_department!})',
                                                                overflow: TextOverflow.visible,
                                                                maxLines: 2,
                                                                style: TextStyleConst.mediumTextStyle(
                                                                  ColorConst.blackColor,
                                                                  width * 0.036,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    leading: Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                            child: ClipOval(
                                                              child: filterAppointmentController.filterAdminAppointmentModel!.data![index].patient_image == null ||
                                                                      filterAppointmentController.filterAdminAppointmentModel!.data![index].patient_image!.isEmpty
                                                                  ? Image.asset(
                                                                      ImageUtils.patientIcon,
                                                                      fit: BoxFit.cover,
                                                                    )
                                                                  : FadeInImage(
                                                                      placeholder: const AssetImage(ImageUtils.patientIcon),
                                                                      image: NetworkImage(
                                                                        filterAppointmentController.filterAdminAppointmentModel!.data![index].patient_image!,
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
                                                  ),
                                                ),
                                          index == filterAppointmentController.filterAdminAppointmentModel!.data!.length - 1
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
                      )
                    : Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Appointment not found",
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor,
                              width * 0.04,
                            ),
                          ),
                        ),
                      )
                : const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
