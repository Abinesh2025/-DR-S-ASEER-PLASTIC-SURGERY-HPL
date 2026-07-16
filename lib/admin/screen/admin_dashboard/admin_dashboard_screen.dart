import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/admin_dashboard_controller/admin_dashboard_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_container.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class AdminDashboardScreen extends StatelessWidget {
   AdminDashboardScreen({Key? key}) : super(key: key);

   final AdminDashboardController adminDashboardController = Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Obx(() {
      return adminDashboardController.isGetData.value == false
          ?  Center(
          child: CircularProgressIndicator(color: ColorConst.primaryColor))
          : RefreshIndicator(
          onRefresh: () async {
            adminDashboardController.isGetData.value = false;
            adminDashboardController.getAdminDashboardData();
      },
      child : SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics()
      ),
      child: Container(
        color: ColorConst.whiteColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Invoice amount
                  Expanded(
                    child: CommonContainer(
                      height: height / 6,
                      text: '${adminDashboardController.adminDashboardModel?.message?.currency_symbol} ${adminDashboardController.adminDashboardModel != null &&
                          adminDashboardController.adminDashboardModel!.message != null &&
                          adminDashboardController.adminDashboardModel!.message!.invoiceAmount != null
                          ? adminDashboardController.formatRevenues(
                          adminDashboardController.adminDashboardModel!.message!.invoiceAmount!)
                          : ''}',
                      icon: false,
                      image: ImageUtils.invoicesIcon,
                      description: StringUtils.invoiceAmount,
                    ),
                  ),
                  SizedBox(width: height * 0.02),

                  /// Bill Amount
                  Expanded(
                    child: CommonContainer(
                      height: height / 6,
                      text: '${adminDashboardController.adminDashboardModel?.message?.currency_symbol} ${adminDashboardController.adminDashboardModel != null &&
                          adminDashboardController.adminDashboardModel!.message != null &&
                          adminDashboardController.adminDashboardModel!.message!.billAmount != null
                          ? adminDashboardController.formatRevenues(
                          adminDashboardController.adminDashboardModel!.message!.billAmount!)
                          : ''}',
                      icon: false,
                      image: ImageUtils.billIcon,
                      description: StringUtils.billAmount,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Payment Amount
                  Expanded(
                    child: CommonContainer(
                      height: height / 6,
                      text: '${adminDashboardController.adminDashboardModel?.message?.currency_symbol} ${adminDashboardController.adminDashboardModel != null &&
                          adminDashboardController.adminDashboardModel!.message != null &&
                          adminDashboardController.adminDashboardModel!.message!.paymentAmount != null
                          ? adminDashboardController.formatRevenues(
                          adminDashboardController.adminDashboardModel!.message!.paymentAmount!)
                          : ''}',
                      icon: false,
                      image: ImageUtils.paymentIcon,
                      description: StringUtils.paymentAmount,
                    ),
                  ),
                  SizedBox(width: height * 0.02),

                  /// Adv. Payment amount
                  Expanded(
                    child: CommonContainer(
                      height: height / 6,
                      text: '${adminDashboardController.adminDashboardModel?.message?.currency_symbol} ${adminDashboardController.adminDashboardModel != null &&
                          adminDashboardController.adminDashboardModel!.message != null &&
                          adminDashboardController.adminDashboardModel!.message!.advancePaymentAmount != null
                          ? adminDashboardController.formatRevenues(
                          adminDashboardController.adminDashboardModel!.message!.advancePaymentAmount!)
                          : ''}',
                      icon: false,
                      image: ImageUtils.advPaymentIcon,
                      description: StringUtils.advPayment,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// doctors
                  Expanded(
                    child: CommonContainer(
                      height: height / 6,
                      text: adminDashboardController.adminDashboardModel?.message?.doctor.toString() ?? "",
                      icon: false,
                      image: ImageUtils.doctorIcon,
                      description: StringUtils.doctors,
                    ),
                  ),
                  SizedBox(width: height * 0.02),

                  ///patients
                  Expanded(
                    child: CommonContainer(
                      height: height / 6,
                      text:adminDashboardController.adminDashboardModel?.message?.patients.toString() ?? "",
                      icon: false,
                      image: ImageUtils.patientsIcon,
                      description: StringUtils.availablePatients,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Nurses
                  Expanded(
                    child: CommonContainer(
                      height: height / 6,
                      text: adminDashboardController.adminDashboardModel?.message?.nurses.toString() ?? "",
                      icon: false,
                      image: ImageUtils.nurseIcon,
                      description: StringUtils.nurses,
                    ),
                  ),
                  SizedBox(width: height * 0.02),

                  /// Available Beds
                  Expanded(
                    child: CommonContainer(
                      height: height / 6,
                      text: adminDashboardController.adminDashboardModel?.message?.availableBeds.toString() ?? "",
                      icon: false,
                      image: ImageUtils.availableBedsIcon,
                      description: StringUtils.availableBeds,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03,),
              Text(
                StringUtils.upcomingAppointments,
                style: TextStyleConst.boldTextStyle(
                  ColorConst.blackColor,
                  width * 0.047,
                ),
              ),
              SizedBox(height: height * 0.03,),
              AnimationLimiter(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: adminDashboardController.adminDashboardModel!.message!.upcomingAppointments!.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Column(
                            children: [
                                 Padding(
                                   padding: const EdgeInsets.only(bottom: 15),
                                   child: Container(
                                     decoration: BoxDecoration(
                                         color: ColorConst.bgGreyColor,
                                       borderRadius: BorderRadius.circular(10)
                                     ),
                                     child: ListTile(
                                      onTap: () {},
                                      contentPadding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                                      leading: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorConst.bgGreyColor,
                                        ),
                                        child: ClipOval(
                                          child: adminDashboardController.adminDashboardModel!.message!.upcomingAppointments![index].patine_image == null ||
                                                  adminDashboardController.adminDashboardModel!.message!.upcomingAppointments![index].patine_image!.isEmpty
                                              ? Image.asset(
                                                  ImageUtils.patientIcon,
                                                  fit: BoxFit.cover,
                                                )
                                              : FadeInImage(
                                                  placeholder: const AssetImage(ImageUtils.patientIcon),
                                                  image: NetworkImage(adminDashboardController.adminDashboardModel!.message!.upcomingAppointments![index].patine_image!),
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
                                      title: Text( adminDashboardController.adminDashboardModel?.message?.upcomingAppointments?[index].patient_name ?? "",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.044,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${adminDashboardController.adminDashboardModel!.message!.upcomingAppointments![index].appointment_time} - ${adminDashboardController.adminDashboardModel!.message!.upcomingAppointments![index].appointment_date}',
                                            style: TextStyleConst.mediumTextStyle(
                                              ColorConst.hintGreyColor,
                                              width * 0.036,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Doctor: ",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.hintGreyColor,
                                                  width * 0.036,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text('${adminDashboardController.adminDashboardModel!.message!.upcomingAppointments![index].doctor_name} (${adminDashboardController.adminDashboardModel!.message!.upcomingAppointments![index].doctor_department})',
                                                  overflow: TextOverflow.visible,
                                                  maxLines: 2,
                                                  style: TextStyleConst.mediumTextStyle(
                                                    ColorConst.blackColor,
                                                    width * 0.036,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          )
                                        ],
                                      ),
                                ),
                                   ),
                                 ),
                              index == adminDashboardController.adminDashboardModel!.message!.upcomingAppointments!.length - 1
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
            ],
          ),
        ),
      ),
    )
      );
    }
    );
  }
}
