import 'dart:math' as math;

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/dashboard/widgets/all_today_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';

import '../../../controller/doctor/doctor_dashboard/doctor_dashboard_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/dashboard/widgets/schedule_item_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/dashboard/widgets/summary_card_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/dashboard/widgets/recent_patient_item_widget.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final controller = Get.put(DoctorDashboardController());

    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      body: Obx(() {
        final data = controller.dashboardData.value;

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          color: ColorConst.primaryColor,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            controller: controller.scrollController, // The getter is now defined!
            physics: const AlwaysScrollableScrollPhysics(), // Required for pull-to-refresh
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // --- Greeting Section ---
                  Text(
                    "Hello, Dr. ${VariableUtils.firstName.value} ${VariableUtils.lastName.value}".trim().isEmpty || VariableUtils.firstName.value.isEmpty
                        ? "Hello, Dr. Health Center"
                        : "Hello, Dr. ${VariableUtils.firstName.value} ${VariableUtils.lastName.value}",
                    style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 24),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "How is your day going?",
                    style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 16),
                  ),
                  const SizedBox(height: 25),

                  // --- Summary Cards ---
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCardWidget(
                          title: "Total Appointments",
                          count: data?.data?.totalAppointments ?? "0",
                          icon: Icons.calendar_today_outlined,
                          color: const Color(0xFF4FA9F2),
                          isLoading: controller.isStatsLoading.value,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCardWidget(
                          title: "Total Patients",
                          count: data?.data?.totalPatients ?? "0", // FIXED: Was using activeIpd
                          icon: Icons.people_outline,
                          color: const Color(0xFF0FA66A),
                          isLoading: controller.isStatsLoading.value,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: SummaryCardWidget(
                          title: "Active IPD",
                          count: data?.data?.activeIpd ?? "0",
                          icon: Icons.hotel_outlined,
                          color: Colors.purple,
                          isLoading: controller.isStatsLoading.value,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // --- Today's Schedule Header ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Schedule",
                        style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 20),
                      ),
                      if (controller.todayScheduleList.length > 0)
                        GestureDetector(
                          onTap: () {
                            // Navigate to the new page showing all items
                            Get.to(() => const AllTodayScheduleScreen());
                          },
                          child: Text(
                            "View All",
                            style: TextStyleConst.mediumTextStyle(ColorConst.primaryColor, 16),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 15),
// --- Dynamic Schedule List ---
                  if (controller.isScheduleLoading.value)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) => const ScheduleItemWidget(isLoading: true),
                    )
                  else if (controller.todayScheduleList.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "No appointments scheduled for today.",
                          style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 14),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // LIMIT TO MAXIMUM OF 5 ITEMS
                      itemCount: math.min(controller.todayScheduleList.length, 5),
                      itemBuilder: (context, index) {
                        final scheduleData = controller.todayScheduleList[index];
                        return ScheduleItemWidget(
                          data: scheduleData,
                          isLoading: false,
                        );
                      },
                    ),
                  // --- Dynamic Schedule List ---
                  // if (controller.isScheduleLoading.value)
                  //   ListView.builder(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount: 3,
                  //     itemBuilder: (context, index) => const ScheduleItemWidget(isLoading: true),
                  //   )
                  // else if (controller.todayScheduleList.isEmpty)
                  //   Center(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(20.0),
                  //       child: Text(
                  //         "No appointments scheduled for today.",
                  //         style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 14),
                  //       ),
                  //     ),
                  //   )
                  // else
                  //   ListView.builder(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount: controller.todayScheduleList.length,
                  //     itemBuilder: (context, index) {
                  //       final scheduleData = controller.todayScheduleList[index];
                  //       return ScheduleItemWidget(
                  //         data: scheduleData,
                  //         isLoading: false,
                  //       );
                  //     },
                  //   ),

                  const SizedBox(height: 10),

                  // --- Recent Patients Header ---
                  Text(
                    "Recent Patients",
                    style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 20),
                  ),
                  const SizedBox(height: 15),

                  // --- Dynamic Recent Patients List ---
                  if (controller.isRecentPatientsLoading.value)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) => const RecentPatientItemWidget(isLoading: true),
                    )
                  else if (controller.recentPatientsList.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "No recent patients found.",
                          style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 14),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.recentPatientsList.length,
                      itemBuilder: (context, index) {
                        final patientData = controller.recentPatientsList[index];
                        return RecentPatientItemWidget(
                          data: patientData,
                          isLoading: false,
                        );
                      },
                    ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}