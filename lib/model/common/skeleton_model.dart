import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';

class SkeletonLoadingConfig {
  final Color baseColor;
  final Color highlightColor;

  SkeletonLoadingConfig({
    required this.baseColor,
    required this.highlightColor,
  });

  /// Default theme for Hospital/Medicine app
  factory SkeletonLoadingConfig.hospitalTheme() {
    return SkeletonLoadingConfig(
      baseColor: ColorConst.shimmerBaseColor,
      highlightColor: ColorConst.shimmerHighlightColor,
    );
  }

  /// Dark theme if needed
  factory SkeletonLoadingConfig.darkHospitalTheme() {
    return SkeletonLoadingConfig(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
    );
  }
}
