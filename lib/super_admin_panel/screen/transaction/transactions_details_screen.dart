import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class TransactionsDetailScreen extends StatelessWidget {
  final String hospitalName;
  final String payments;
  final String currencySymbol;
  final String amount;
  final String transactionDate;
  final String startTime;
  final String paymentApproved;
  final String status;

 const TransactionsDetailScreen({
    Key? key,
    required this.hospitalName,
    required this.payments,
    required this. currencySymbol,
    required this.amount,
    required this.transactionDate,
   required this.startTime,
    required this.paymentApproved,
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
              title: StringUtils.transactionDetail,
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                      titleText: StringUtils.payments,
                      descriptionText: payments,
                    ),
                    SizedBox(height: height * 0.015),
                    CommonDetailText(
                      width: width,
                      titleText: StringUtils.amount,
                      descriptionText: '$currencySymbol $amount',
                    ),
                    SizedBox(height: height * 0.015),
                    CommonDetailText(
                        width: width,
                        titleText: StringUtils.transactionDate,
                        descriptionText: '$transactionDate $startTime'
                        ),
                    SizedBox(height: height * 0.015),
                    CommonDetailText(
                      width: width,
                      titleText: StringUtils.paymentApproved,
                      descriptionText: paymentApproved == "0" ? "Waiting for Approved" : paymentApproved == "1" ? "Approved" : "Denied",
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
                            child: Text(status,
                          style: TextStyleConst.mediumTextStyle(
                            status == "Paid"
                                ? ColorConst.greenColor
                                : ColorConst.redColor,
                            width * 0.043,
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
