import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class HospitalDetailScreen extends StatelessWidget {
  final String hospitalName;
  final String emaiAddress;
  final String hospitalSlug;
  final String hospitalType;
  final String city;
  final String status;
  const HospitalDetailScreen({
    Key? key,
    required this.hospitalName,
    required this.emaiAddress,
    required this.hospitalSlug,
    required this.hospitalType,
    required this.city,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        appBar: CommonAppBar(
          title: StringUtils.hospitalDetail,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Column(
            children: [
              SizedBox(height: height * 0.03),
              CommonDetailText(
                width: width,
                titleText: StringUtils.hospitalName,
                descriptionText: hospitalName,
              ),
              SizedBox(height: height * 0.015),
              CommonDetailText(
                width: width,
                titleText: StringUtils.emailAddress,
                descriptionText: emaiAddress
              ),
              SizedBox(height: height * 0.015),
              CommonDetailText(
                width: width,
                titleText: StringUtils.hospitalSlug,
                descriptionText: hospitalSlug,
              ),
              SizedBox(height: height * 0.015),
              CommonDetailText(
                width: width,
                titleText: StringUtils.hospitalType,
                descriptionText: hospitalType,
              ),
              SizedBox(height: height * 0.015),
              CommonDetailText(
                width: width,
                titleText: StringUtils.city,
                descriptionText: city,
              ),
              SizedBox(height: height * 0.015),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      StringUtils.status,
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.hintGreyColor,
                        width * 0.043,
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                    Text(
                      status == "1" ? "Active" : "Deactive",
                      style: TextStyleConst.mediumTextStyle(
                        status == "1" ? ColorConst.greenColor : ColorConst.redColor,
                        width * 0.043,
                      ),
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
