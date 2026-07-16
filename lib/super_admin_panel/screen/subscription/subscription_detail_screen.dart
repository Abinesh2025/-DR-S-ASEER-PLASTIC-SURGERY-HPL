import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class SubscriptionDetailScreen extends StatelessWidget {
  final String hospitalName;
  final String planName;
  final String currency;
  final String amount;
  final String startDate;
  final String startTime;
  final String expiresOn;
  final String expireTime;
  final String frequency;
  final String status;

   const SubscriptionDetailScreen({
     Key? key,
     required this.hospitalName,
     required this.planName,
     required this.currency,
     required this.amount,
     required this.startDate,
     required this.startTime,
     required this.expiresOn,
     required this.expireTime,
     required this.frequency,
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
            title: StringUtils.subscriptionDetail,
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
                  titleText: StringUtils.planName,
                  descriptionText: planName,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.amount,
                  descriptionText: '$currency $amount',
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.startDate,
                  descriptionText: '$startDate $startTime'
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.expiresOn,
                  descriptionText: '$expiresOn $expireTime',
                ),
                SizedBox(height: height * 0.015),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(StringUtils.frequency,
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.hintGreyColor,
                          width * 0.043,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(frequency,
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.primaryColor,
                          width * 0.043,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: height * 0.015),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(StringUtils.status,
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.hintGreyColor,
                          width * 0.043,
                        ),
                      ),
                    ),
                    Expanded(
                      child:
                      Text(status,
                        style: TextStyleConst.mediumTextStyle(
                         status == "Active" ? ColorConst.greenColor : ColorConst.redColor,
                          width * 0.043,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
