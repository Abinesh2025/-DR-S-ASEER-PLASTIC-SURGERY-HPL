import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
// TODO: Make sure this path points to your CommonShimmer widget


import '../../../../component/common_shimmer.dart';

class SummaryCardWidget extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color color;
  final bool isLoading; // Added loading state parameter

  const SummaryCardWidget({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    this.isLoading = false, // Defaults to false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),

              // Show shimmer if loading, otherwise show the actual count
              isLoading
                  ? const CommonShimmer(height: 24, width: 40, borderRadius: 6)
                  : Text(
                count,
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 24),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Show shimmer if loading, otherwise show the actual title
          isLoading
              ? const CommonShimmer(height: 14, width: 110, borderRadius: 4)
              : Text(
            title,
            style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 14),
          ),
        ],
      ),
    );
  }
}