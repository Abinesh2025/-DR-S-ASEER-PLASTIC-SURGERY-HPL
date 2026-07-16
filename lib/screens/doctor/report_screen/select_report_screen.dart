import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_account_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/report_screen/reports_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class SelectReportScreen extends StatelessWidget {
  const SelectReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConst.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.02),
          CommonAccountButton(
            width: width,
            onTap: () async {
              Get.to(
                () => ReportScreen(title: StringUtils.birthReport),
                transition: Transition.rightToLeft,
                arguments: StringUtils.birthReport,
              );
            },
            text: StringUtils.birthReport,
          ),
          SizedBox(height: height * 0.02),
          CommonAccountButton(
            width: width,
            onTap: () {
              Get.to(
                () => ReportScreen(title: StringUtils.deathReport),
                transition: Transition.rightToLeft,
                arguments: StringUtils.deathReport,
              );
            },
            text: StringUtils.deathReport,
          ),
          SizedBox(height: height * 0.02),
          CommonAccountButton(
            width: width,
            onTap: () {
              Get.to(
                () => ReportScreen(title: StringUtils.investigationReport),
                transition: Transition.rightToLeft,
                arguments: StringUtils.investigationReport,
              );
            },
            text: StringUtils.investigationReport,
          ),
          SizedBox(height: height * 0.02),
          CommonAccountButton(
            width: width,
            onTap: () {
              Get.to(
                () => ReportScreen(title: StringUtils.operationReport),
                transition: Transition.rightToLeft,
                arguments: StringUtils.operationReport,
              );
            },
            text: StringUtils.operationReport,
          ),
        ],
      ),
    );
  }
}
