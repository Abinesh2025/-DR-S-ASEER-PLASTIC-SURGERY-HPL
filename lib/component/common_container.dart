import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class CommonContainer extends StatelessWidget {
  final double? width;
  final double height;
  final String text;
  final String description;
  final String? image;
  final String? symbol;
  final bool? icon;
  const CommonContainer({
    Key? key,
     this.width,
    required this.height,
    required this.text,
    this.image,
    required this.description,
    this.symbol,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConst.bgGreyColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           icon == false ? Image.asset(
              "$image",
              height: 25,
              width: 25,
            )
            : Text("$symbol",style:  TextStyle(fontSize: 27,color: ColorConst.primaryColor,fontWeight: FontWeight.w500),),
            const Spacer(),
            Text(
              text,
            style: TextStyleConst.boldTextStyle(
                ColorConst.blackColor,
                20
            ),),
            SizedBox(height: height * 0.01,),
            Text(
                description,
            style: TextStyleConst.mediumTextStyle(
              ColorConst.hintGreyColor,
               13,
            ))
          ],
        ),
      ),
    );
  }
}
