import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

import '../../../../component/common_shimmer.dart';
import '../../../../model/doctor/dashboard/doctor_dashboard_model.dart';

class RecentPatientItemWidget extends StatelessWidget {
  final RecentPatientData? data;
  final bool isLoading;

  const RecentPatientItemWidget({
    super.key,
    this.data,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const CommonShimmer(height: 40, width: 40, borderRadius: 20),
            const SizedBox(width: 15),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonShimmer(height: 16, width: 120),
                  SizedBox(height: 5),
                  CommonShimmer(height: 12, width: 80),
                ],
              ),
            ),
            const CommonShimmer(height: 14, width: 50),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorConst.primaryColor.withOpacity(0.1),
            // Load the image from the URL if it exists
            backgroundImage: data?.image != null ? NetworkImage(data!.image!) : null,
            child: data?.image == null
                ? Text(
              // Extract the first letter of the name safely
              data?.name?.isNotEmpty == true ? data!.name![0].toUpperCase() : "?",
              style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 16),
            )
                : null,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.name ?? "Unknown",
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
                ),
                Text(
                  data?.lastVisit ?? "",
                  style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 13),
                ),
              ],
            ),
          ),
          Text(
            data?.status ?? "",
            style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 13),
          ),
        ],
      ),
    );
  }
}