import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class CommonAlertDialog {
  static void commonAlertDialog(BuildContext context, ContentOfDialog contentOfDialog) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return contentOfDialog;
      },
    );
  }
}

class ContentOfDialog extends StatelessWidget {
  const ContentOfDialog({
    Key? key,
    required this.height,
    required this.width,
    required this.image,
    required this.title,
    required this.description,
    required this.leftText,
    required this.rightText,
    required this.leftTapEvent,
    required this.rightTapEvent,
  }) : super(key: key);
  final double height;
  final double width;
  final String image;
  final String title;
  final String description;
  final String leftText;
  final String rightText;
  final VoidCallback leftTapEvent;
  final VoidCallback rightTapEvent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height / 2.8,
        width: width / 1.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Text(
              title,
              style: TextStyleConst.boldTextStyle(
                ColorConst.blackColor,
                width * 0.05,
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyleConst.mediumTextStyle(
                ColorConst.hintGreyColor,
                width * 0.042,
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CommonButton(
                  textStyleConst: TextStyleConst.mediumTextStyle(
                    ColorConst.whiteColor,
                    width * 0.05,
                  ),
                  onTap: leftTapEvent,
                  color: ColorConst.blueColor,
                  text: leftText,
                  width: width / 2.5,
                  height: 50,
                ),
                CommonButton(
                  textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
                  onTap: rightTapEvent,
                  color: ColorConst.borderGreyColor,
                  text: rightText,
                  width: width / 2.5,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
