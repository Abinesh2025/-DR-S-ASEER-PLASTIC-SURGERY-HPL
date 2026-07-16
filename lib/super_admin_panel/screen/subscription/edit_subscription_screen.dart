import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/subscription_controller/edit_subscription_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class EditSubscriptionScreen extends StatelessWidget {
  final int subId;

  EditSubscriptionScreen({Key? key, required this.subId}) : super(key: key);
  final EditSubscriptionController editSubscriptionController = Get.put(EditSubscriptionController());

  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)?.settings.arguments;
    editSubscriptionController.arguments = res;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConst.whiteColor,
            appBar: CommonAppBar(
              title: StringUtils.editSubscription,
              leadOnTap: () {
                Get.back();
              },
              leadIcon: const Icon(
                Icons.arrow_back_rounded,
                color: ColorConst.blackColor,
              ),
            ),
            body: Obx(() {
              return editSubscriptionController.gotData.value == false
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.03),

                            ///hospital Name TextField
                            CommonText(
                              width: width,
                              text: StringUtils.hospitalName,
                            ),
                            SizedBox(height: height * 0.01),
                            Container(
                              decoration: BoxDecoration(
                                  color: ColorConst.bgGreyColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: CommonTextField(
                                readOnly: true,
                                validator: (value) {
                                  return null;
                                },
                                controller: editSubscriptionController.hospitalNameController,
                              ),
                            ),
                            SizedBox(height: height * 0.03,),

                            ///plan Name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      width: width,
                                      text: StringUtils.planName,
                                    ),
                                    SizedBox(height: height * 0.01,),
                                    Text(
                                      editSubscriptionController.planNameController.text,
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.hintGreyColor,
                                        width * 0.043,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: editSubscriptionController.status == "Active"
                                        ? ColorConst.greenColor.withOpacity(0.15)
                                    : ColorConst.redColor.withOpacity(0.15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      editSubscriptionController.status,
                                      style: TextStyleConst.mediumTextStyle(
                                       editSubscriptionController.status == "Active"
                                        ? ColorConst.greenColor
                                        : ColorConst.redColor,
                                        width * 0.035,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.03),

                            /// frequency
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText(
                                  width: width,
                                  text: StringUtils.frequency,
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ColorConst.primaryColor.withOpacity(0.13),
                                  ),
                                  child: Center(
                                    child: Text(
                                      editSubscriptionController.frequency,
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.primaryColor,
                                        width * 0.035,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.03),

                            /// status
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText(
                                  width: width,
                                  text: StringUtils.status,
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: editSubscriptionController.status == "Active"
                                        ? ColorConst.greenColor.withOpacity(0.15)
                                        : ColorConst.redColor.withOpacity(0.15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      editSubscriptionController.status,
                                      style: TextStyleConst.mediumTextStyle(
                                        editSubscriptionController.status == "Active"
                                            ? ColorConst.greenColor
                                            : ColorConst.redColor,
                                        width * 0.035,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.03),

                            /// start date textfield
                            CommonText(
                              width: width,
                              text: StringUtils.startDate,
                            ),
                            SizedBox(height: height * 0.01),
                            Container(
                              decoration: BoxDecoration(
                                  color: ColorConst.bgGreyColor,
                                  borderRadius: BorderRadius.circular(10),
                              ),
                              child: CommonTextField(
                                readOnly: true,
                                validator: (value) {
                                  return null;
                                },
                                controller: editSubscriptionController.startDateController,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),

                            ///expires on textfield
                            CommonText(
                              width: width,
                              text: StringUtils.expiresOn,
                            ),
                            SizedBox(height: height * 0.01),
                            GestureDetector(
                              onTap: () {
                                editSubscriptionController.selectDate(context, editSubscriptionController.expiresOnController);
                              },
                              child: AbsorbPointer(
                                child: CommonTextField(
                                  validator: (value) {
                                    return null;
                                  },
                                  controller: editSubscriptionController.expiresOnController,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.03),

                            ///sms Limit textfield
                            CommonText(
                              width: width,
                              text: StringUtils.smsLimit,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonTextField(
                              validator: (value) {
                                return null;
                              },
                              controller:
                                  editSubscriptionController.smsLimitController,
                            ),
                            SizedBox(height: height * 0.05),

                            ///Button

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonButton(
                                  textStyleConst:
                                      TextStyleConst.mediumTextStyle(
                                          ColorConst.whiteColor, width * 0.05),
                                  onTap: () {
                                    editSubscriptionController.editSubscription(subId);
                                  },
                                  color: ColorConst.blueColor,
                                  text: StringUtils.save,
                                  width: width / 2.3,
                                  height: 50,
                                ),
                                CommonButton(
                                  textStyleConst:
                                      TextStyleConst.mediumTextStyle(
                                          ColorConst.hintGreyColor,
                                          width * 0.05),
                                  onTap: () {
                                    Get.back();
                                  },
                                  color: ColorConst.borderGreyColor,
                                  text: StringUtils.cancel,
                                  width: width / 2.3,
                                  height: 50,
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.03),
                          ],
                        ),
                      ),
                    );
            })));
  }
}
