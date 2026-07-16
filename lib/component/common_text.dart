import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class CommonText extends StatelessWidget {
  const CommonText({
    Key? key,
    required this.width,
    required this.text,
    this.color,
  }) : super(key: key);

  final double width;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyleConst.boldTextStyle(
        color ?? ColorConst.blackColor,
        width * 0.045,
      ),
    );
  }
}
