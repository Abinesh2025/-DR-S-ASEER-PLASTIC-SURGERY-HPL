import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

Widget statusText(String status, double width) {
  if (status == "Cancelled") {
    return Text(
      "• $status",
      style: TextStyleConst.mediumTextStyle(
        Colors.red,
        width * 0.035,
      ),
    );
  } else if (status == "Finished") {
    return Text(
      "• $status",
      style: TextStyleConst.mediumTextStyle(
        Colors.green,
        width * 0.035,
      ),
    );
  } else {
    return Text(
      "• $status",
      style: TextStyleConst.mediumTextStyle(
        ColorConst.orangeColor,
        width * 0.035,
      ),
    );
  }
}