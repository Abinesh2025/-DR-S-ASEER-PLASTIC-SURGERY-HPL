import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'appointment_card_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';

class UpcomingAppointmentsWidget extends StatelessWidget {
  final PatientHomeController controller;

  const UpcomingAppointmentsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Assuming you store the fetched API list in controller.todayAppointments
      if (controller.todayAppointments.isEmpty) {
        return const SizedBox.shrink();
      }
      final activeId = controller.activeAppointmentId.value;

      // 2. Find the appointment that matches the active ID.
      // If none is found (or if activeId is null/empty), fallback to the first appointment.
      final appointmentToShow = controller.todayAppointments.firstWhere(
            (appointment) => appointment.id == activeId,
        orElse: () => controller.todayAppointments.first,
      );
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Appointments",
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
                ),
                GestureDetector(
                  onTap: () => _showAllAppointmentsBottomSheet(context),
                  child: Text(
                    "View All",
                    style: TextStyleConst.mediumTextStyle(const Color(0xFF166974), 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Display only the first one on the home screen
            AppointmentCardWidget(
              appointment: appointmentToShow,
              // isSelected: activeId == appointmentToShow.id,
            ),
          ],
        ),
      );
    });
  }

  void _showAllAppointmentsBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Appointments",
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: const Icon(Icons.close, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey[200]),
            const SizedBox(height: 10),
            
            // List of all appointments
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.todayAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = controller.todayAppointments[index];
                    // Check if this is the currently tracked/active appointment for the socket
                    bool isSelected = controller.activeAppointmentId.value == appointment.id;

                    return AppointmentCardWidget(
                      appointment: appointment,
                      isSelected: isSelected,
                      onTap: () {
                        Get.back(); // Close bottom sheet
                        // Trigger the API and Socket
                        controller.selectAndBroadcastAppointment(appointment.id);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true, // Required for custom height constraints
      backgroundColor: Colors.transparent, // Ensures the top rounded corners look perfect
      ignoreSafeArea: false,
    );
  }
}