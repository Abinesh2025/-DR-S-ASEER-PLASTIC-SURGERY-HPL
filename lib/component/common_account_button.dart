import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class CommonAccountButton extends StatelessWidget {
  final double width;
  final VoidCallback onTap;
  final String text;
  const CommonAccountButton({
    Key? key,
    required this.width,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConst.borderGreyColor, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyleConst.mediumTextStyle(
                  ColorConst.blackColor,
                  width * 0.04,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorConst.hintGreyColor,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}
