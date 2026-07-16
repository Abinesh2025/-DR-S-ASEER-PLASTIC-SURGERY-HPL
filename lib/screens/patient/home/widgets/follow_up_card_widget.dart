import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/follow_up_model.dart';
import 'package:intl/intl.dart';

class FollowUpCardWidget extends StatelessWidget {
  final FollowUpData? data;
  final VoidCallback? onTap;
  final VoidCallback? onMenuTap;

  const FollowUpCardWidget({
    super.key,
    this.data,
    this.onTap,
    this.onMenuTap,
  });

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40), // Capsule shape
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.black.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Circular Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: ColorConst.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorConst.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                (data?.doctorName ?? "D").isNotEmpty
                    ? (data?.doctorName ?? "D")[0].toUpperCase()
                    : "D",
                style: TextStyleConst.boldTextStyle(
                  Colors.white,
                  18,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data?.doctorName ?? "Doctor",
                    style: TextStyleConst.boldTextStyle(Colors.black87, 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data?.reason ?? "Follow-up",
                    style: TextStyleConst.mediumTextStyle(
                      Colors.black.withOpacity(0.5),
                      12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Highlighted Date on the right
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: ColorConst.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _formatDate(data?.followUpDate),
                style: TextStyleConst.boldTextStyle(
                  ColorConst.primaryColor,
                  11,
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
