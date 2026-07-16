import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/appointment_model.dart';

class AppointmentCardWidget extends StatelessWidget {
  final AppointmentData appointment; // Replace 'dynamic' with AppointmentData
  final bool isSelected;
  final VoidCallback? onTap;

  const AppointmentCardWidget({
    super.key,
    required this.appointment,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Colors based on your UI images
    const Color cardColor = Color(0xFFF3EBE1);
    const Color bottomRowColor = Color(0xFFE6DBCB);
    const Color badgeColor = Color(0xFF166974);

    // Display appointment type in the badge
    String badgeName = appointment.appointment_type ?? "Appointment";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xFF2D6A4F), width: 1.5) // Active green border
              : Border.all(color: Colors.transparent, width: 1.5),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Top Section (Doctor Info)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: NetworkImage(appointment.doctor_image_url ?? ''),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr. ${appointment.doctor_name}",
                              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              appointment.doctor_department ?? "Specialist",
                              style: TextStyleConst.mediumTextStyle(Colors.grey[700]!, 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Bottom Row (Date, Time, Token)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: bottomRowColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBottomInfo(Icons.calendar_today_outlined, appointment.appointment_date ?? ''),
                      _buildBottomInfo(
                        appointment.token_number != null
                            ? Icons.local_activity_outlined
                            : Icons.access_time_outlined,
                        appointment.token_number != null
                            ? "${appointment.token_number}"
                            : (appointment.appointment_time ?? ''),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Top Right Patient Badge
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: const BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  badgeName,
                  style: TextStyleConst.boldTextStyle(Colors.white, 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF333333)),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyleConst.mediumTextStyle(const Color(0xFF333333), 12),
        ),
      ],
    );
  }
}