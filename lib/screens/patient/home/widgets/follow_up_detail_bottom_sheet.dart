import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/follow_up_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FollowUpDetailBottomSheet extends StatelessWidget {
  final FollowUpData data;

  const FollowUpDetailBottomSheet({super.key, required this.data});

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "-";
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Header: Doctor Info
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: ColorConst.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  (data.doctorName ?? "D").isNotEmpty
                      ? (data.doctorName ?? "D")[0].toUpperCase()
                      : "D",
                  style: TextStyleConst.boldTextStyle(
                    ColorConst.primaryColor,
                    24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.doctorName ?? "Doctor Name",
                      style: TextStyleConst.boldTextStyle(Colors.black87, 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Patient: ${data.patientName ?? "Patient"}",
                      style: TextStyleConst.mediumTextStyle(Colors.grey, 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Details Grid-like list
          _buildDetailRow(
            Icons.calendar_today_rounded,
            "Follow-up Date",
            _formatDate(data.followUpDate),
            ColorConst.primaryColor,
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            Icons.info_outline_rounded,
            "Reason",
            data.reason ?? "-",
            const Color(0xFFF59E0B), // Amber for attention
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            Icons.confirmation_number_outlined,
            "OPD Number",
            data.opdNumber?.toString() ?? "-",
            Colors.blueGrey,
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            Icons.fingerprint_rounded,
            "Patient ID",
            data.patientUniqueId ?? "-",
            Colors.green,
          ),

          const SizedBox(height: 40),

          // Action Button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConst.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                "Got it",
                style: TextStyleConst.boldTextStyle(Colors.white, 16),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyleConst.mediumTextStyle(Colors.grey, 12),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyleConst.boldTextStyle(Colors.black87, 15),
            ),
          ],
        ),
      ],
    );
  }
}
