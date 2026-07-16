import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_payroll_controller/payroll_details_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class MyPayRollDetailsScreen extends StatelessWidget {
  MyPayRollDetailsScreen({Key? key}) : super(key: key);
  final PayrollDetailsController payrollDetailsController = Get.put(PayrollDetailsController());

  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)!.settings.arguments as int;
    payrollDetailsController.getPayrollDetails(res);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            title: StringUtils.payrollsDetails,
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body: Obx(() {
            return payrollDetailsController.isGetDetails.value == false
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.03),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConst.borderGreyColor,
                                ),
                                child: ClipOval(
                                  child: payrollDetailsController.payrollDetailsModel?.data?.app_logo == null ||
                                          payrollDetailsController.payrollDetailsModel!.data!.app_logo!.isEmpty
                                      ? Image.asset(
                                          ImageUtils.appLogo,
                                          fit: BoxFit.cover,
                                        )
                                      : FadeInImage(
                                          placeholder: const AssetImage(ImageUtils.appLogo),
                                          image: NetworkImage(payrollDetailsController.payrollDetailsModel!.data!.app_logo!),
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              ImageUtils.appLogo,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payroll #${payrollDetailsController.payrollDetailsModel?.data?.payroll_id ?? "N/A"}",
                                    style: TextStyleConst.boldTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.05,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.004),
                                  Text(
                                    "${payrollDetailsController.payrollDetailsModel?.data?.month ?? "N/A"}  ${payrollDetailsController.payrollDetailsModel?.data?.year ?? "N/A"}",
                                    style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.037),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              payrollDetailsController.payrollDetailsModel!.data!.status == "Paid"
                                  ? Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: ColorConst.greenColor.withOpacity(0.15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          payrollDetailsController.payrollDetailsModel?.data?.status ?? "N/A",
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.greenColor,
                                            width * 0.035,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red.withOpacity(0.15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          payrollDetailsController.payrollDetailsModel?.data?.status ?? "N/A",
                                          style: TextStyleConst.mediumTextStyle(
                                            Colors.red,
                                            width * 0.035,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: height * 0.02),
                          Divider(
                            thickness: 1.5,
                            color: ColorConst.greyShadowColor,
                          ),
                          SizedBox(height: height * 0.025),

                          /// Sr No:
                          CommonDetailText(
                            width: width,
                            titleText: StringUtils.srNo,
                            descriptionText: "${payrollDetailsController.payrollDetailsModel?.data?.sr_no ?? "N/A"}",
                          ),
                          SizedBox(height: height * 0.015),

                          /// Created On
                          CommonDetailText(
                            width: width,
                            titleText: StringUtils.createOn,
                            descriptionText: payrollDetailsController.payrollDetailsModel?.data?.created_on ?? "N/A",
                          ),
                          SizedBox(height: height * 0.02),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorConst.bgGreyColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Salary Details
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                                  child: Text(
                                    StringUtils.salaryDetails,
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.04,
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                const Padding(
                                  padding: EdgeInsets.only(right: 15, left: 15),
                                  child: Divider(
                                    color: ColorConst.borderGreyColor,
                                    thickness: 1.5,
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Basic Salary
                                      Text(
                                        StringUtils.basicSalary,
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                      Text(
                                        "${payrollDetailsController.payrollDetailsModel?.data?.currency_symbol ?? "N/A"} ${payrollDetailsController.payrollDetailsModel?.data?.basic_salary ?? "N/A"}",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Allowance
                                      Text(
                                        StringUtils.allowance,
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                      Text(
                                        "${payrollDetailsController.payrollDetailsModel?.data?.currency_symbol ?? "N/A"} ${payrollDetailsController.payrollDetailsModel?.data?.allowance ?? "N/A"}",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Deductions
                                      Text(
                                        StringUtils.deductions,
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.orangeColor,
                                          width * 0.045,
                                        ),
                                      ),
                                      Text(
                                        "${payrollDetailsController.payrollDetailsModel?.data?.currency_symbol ?? "N/A"} ${payrollDetailsController.payrollDetailsModel?.data?.deductions ?? "N/A"}",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.orangeColor,
                                          width * 0.045,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    color: ColorConst.lightBlueColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Net Salary
                                      Text(
                                        StringUtils.netSalary,
                                        style: TextStyleConst.boldTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                      Text(
                                        "${payrollDetailsController.payrollDetailsModel?.data?.currency_symbol ?? "N/A"} ${payrollDetailsController.payrollDetailsModel?.data?.net_salary ?? "N/A"}",
                                        style: TextStyleConst.boldTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ),
                  );
          })),
    );
  }
}
