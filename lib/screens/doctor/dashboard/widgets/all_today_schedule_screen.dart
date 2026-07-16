import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/dashboard/widgets/schedule_item_widget.dart';

import '../../../../controller/doctor/doctor_dashboard/doctor_dashboard_controller.dart';
// Adjust the import path for your controller

class AllTodayScheduleScreen extends StatelessWidget {
  const AllTodayScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the existing controller (don't use Get.put here so we reuse the loaded data)
    final controller = Get.isRegistered<DoctorDashboardController>()
        ? Get.find<DoctorDashboardController>()
        : Get.put(DoctorDashboardController());

    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "All Today's Schedule",
          style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
        ),
      ),
      body: Obx(() {
        if (controller.todayScheduleList.isEmpty) {
          return Center(
            child: Text(
              "No appointments scheduled.",
              style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 14),
            ),
          );
        }

        // Display the full list here without any limit
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(), // Scrollable list
          itemCount: controller.todayScheduleList.length,
          itemBuilder: (context, index) {
            final scheduleData = controller.todayScheduleList[index];
            return ScheduleItemWidget(
              data: scheduleData,
              isLoading: false,
            );
          },
        );
      }),
    );
  }
}