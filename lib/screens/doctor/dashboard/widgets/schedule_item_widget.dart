import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

import '../../../../component/common_shimmer.dart';
import '../../../../model/doctor/dashboard/doctor_dashboard_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_setup_dialog.dart';


class ScheduleItemWidget extends StatelessWidget {
  final ScheduleData? data;
  final bool isLoading;

  const ScheduleItemWidget({
    super.key,
    this.data,
    this.isLoading = false,
  });

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'CANCELLED':
        return Colors.red;
      case 'PENDING':
        return Colors.orange;
      case 'IN PROGRESS':
        return Colors.blue;
      case 'CONFIRMED':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Row(
          children: [
            CommonShimmer(height: 40, width: 40, borderRadius: 20),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonShimmer(height: 16, width: 120),
                  SizedBox(height: 5),
                  CommonShimmer(height: 12, width: 80),
                ],
              ),
            ),
            CommonShimmer(height: 25, width: 70, borderRadius: 8),
          ],
        ),
      );
    }

    final statusColor = _getStatusColor(data?.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorConst.bgGreyColor,
            backgroundImage: data?.patientImage != null ? NetworkImage(data!.patientImage!) : null,
            child: data?.patientImage == null
                ? const Icon(Icons.person_outline, color: ColorConst.hintGreyColor)
                : null,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.patientName ?? "Unknown Patient",
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
                ),
                Text(
                  "${data?.time ?? ''} • ${data?.type ?? ''}",
                  style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              data?.status ?? "",
              style: TextStyleConst.boldTextStyle(statusColor, 10),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              AiConsultationSetupDialog.show(
                context,
                appointmentId: data?.id,
                patientName: data?.patientName,
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ColorConst.primaryColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 16,
                color: ColorConst.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}