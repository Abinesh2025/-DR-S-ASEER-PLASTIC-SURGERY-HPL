import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/subscription_controller/subscription_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/screen/subscription/edit_subscription_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/screen/subscription/subscription_detail_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({Key? key}) : super(key: key);
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        color: ColorConst.whiteColor,
        child: Column(
          children: [
            Container(
              height: 70,
              margin: EdgeInsets.only(top: height * 0.01),
              width: double.infinity,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: subscriptionController.subscriptionStatus.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Center(
                    child: Obx(
                          () => GestureDetector(
                        onTap: () {
                          subscriptionController.changeIndex(index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: width * 0.03, right: index == 2 ? 10 : 0),
                          height: 50,
                          decoration:
                          index == subscriptionController.currentIndex.value
                              ? BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConst.blueColor,
                          )
                              : BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: ColorConst.borderGreyColor,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                subscriptionController.subscriptionStatus[index],
                                style: TextStyleConst.mediumTextStyle(
                                  index == subscriptionController.currentIndex.value
                                      ? ColorConst.whiteColor
                                      : ColorConst.hintGreyColor,
                                  width * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Obx(
              () {
                return subscriptionController.isGetSubscription.value == false
                    ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                        : subscriptionController.filterSubscriptionModel!.data!.isEmpty
                        ? Expanded(
                          child: Container(
                      color: ColorConst.whiteColor,
                      child: Center(
                          child: Text(
                            "No Subscription found",
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor,
                              width * 0.04,
                            ),
                          ),
                      ),
                    ),
                        )
                    : Expanded(
                      child: RefreshIndicator(
                          onRefresh: () async {
                            subscriptionController.isGetSubscription.value = false;
                            subscriptionController.changeIndex(subscriptionController.currentIndex.value);
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                              itemCount: subscriptionController.filterSubscriptionModel?.data?.length,
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemBuilder: (context, index) {

                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Column(
                                        children: [
                                          Slidable(
                                            startActionPane: ActionPane(
                                              extentRatio: 0.25,
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (contextAction) async {
                                                    final message = await Get.to(
                                                      () => EditSubscriptionScreen(
                                                          subId: subscriptionController.filterSubscriptionModel?.data?[index].id ?? 0
                                                          ),
                                                      transition: Transition.leftToRight,
                                                      arguments: {
                                                        "hospital_name": subscriptionController.filterSubscriptionModel!.data![index].hospital_name,
                                                        "subscription_plan_name": subscriptionController.filterSubscriptionModel!.data![index].subscription_plan_name,
                                                        "status": subscriptionController.filterSubscriptionModel!.data![index].status!.toString(),
                                                        "plan_frequency" : subscriptionController.filterSubscriptionModel!.data![index].plan_frequency.toString(),
                                                        "start_date": subscriptionController.filterSubscriptionModel!.data![index].start_date!,
                                                        "start_time": subscriptionController.filterSubscriptionModel!.data![index].start_time!,
                                                        "expire_date": subscriptionController.filterSubscriptionModel!.data![index].expire_date!,
                                                        "expire_time": subscriptionController.filterSubscriptionModel!.data![index].expire_time!,
                                                        "sms_limit" : subscriptionController.filterSubscriptionModel!.data![index].sms_limit!.toString(),
                                                      }
                                                    );
                                                    if (message == "Call API") {
                                                      subscriptionController.changeIndex(subscriptionController.currentIndex.value);
                                                    }
                                                  },
                                                  backgroundColor: ColorConst.orangeColor.withOpacity(0.15),
                                                  label: StringUtils.edit,
                                                  foregroundColor: ColorConst.orangeColor,
                                                ),
                                              ],
                                            ),
                                            child: GestureDetector(
                                              onTap: (){
                                                Get.to(
                                                      () => SubscriptionDetailScreen(
                                                            hospitalName: subscriptionController.filterSubscriptionModel!.data![index].hospital_name!,
                                                            planName: subscriptionController.filterSubscriptionModel!.data![index].subscription_plan_name!,
                                                            currency: subscriptionController.filterSubscriptionModel!.data![index].currency!,
                                                            amount: subscriptionController.filterSubscriptionModel!.data![index].amount!.toStringAsFixed(2),
                                                            startDate: subscriptionController.filterSubscriptionModel!.data![index].start_date!,
                                                            startTime: subscriptionController.filterSubscriptionModel!.data![index].start_time!,
                                                            expiresOn: subscriptionController.filterSubscriptionModel!.data![index].expire_date!,
                                                            expireTime: subscriptionController.filterSubscriptionModel!.data![index].expire_time!,
                                                            frequency: subscriptionController.filterSubscriptionModel!.data![index].plan_frequency!,
                                                            status: subscriptionController.filterSubscriptionModel!.data![index].status!,
                                                          ),
                                                          transition: Transition.rightToLeft,
                                                        );
                                                },
                                              child: Container(
                                                margin: EdgeInsets.only(left: 15, right: 15, top: index == 0 ? 15 : 10, bottom: 15),
                                                //height: 65,
                                                color: Colors.transparent,
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(subscriptionController.filterSubscriptionModel?.data?[index].hospital_name ?? "N/A",
                                                            maxLines: 2,
                                                            style: TextStyleConst.mediumTextStyle(
                                                              ColorConst.blackColor,
                                                              width * 0.045,
                                                            ),
                                                          ),
                                                          SizedBox(height: height * 0.004),
                                                          RichText(
                                                            text: TextSpan(
                                                              text: subscriptionController.filterSubscriptionModel?.data?[index].status ?? "",
                                                              style: TextStyleConst.mediumTextStyle(
                                                                subscriptionController.filterSubscriptionModel?.data?[index].status == "Active" ? Colors.green : Colors.red,
                                                                width * 0.036,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: " | ",
                                                                  style: TextStyleConst.mediumTextStyle(
                                                                    ColorConst.hintGreyColor,
                                                                    width * 0.038,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: subscriptionController.filterSubscriptionModel?.data?[index].subscription_plan_name ?? "N/A",
                                                                  style: TextStyleConst.mediumTextStyle(
                                                                    ColorConst.hintGreyColor,
                                                                    width * 0.036,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: ColorConst.bgGreyColor),
                                                      child: Center(
                                                          child: Text(
                                                            "${subscriptionController.filterSubscriptionModel!.data![index].currency} ${subscriptionController.filterSubscriptionModel?.data?[index].amount?.toString() ?? "N/A"}",
                                                            style: TextStyleConst.boldTextStyle(
                                                              ColorConst.blackColor,
                                                              width * 0.045,
                                                            ),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          index == subscriptionController.filterSubscriptionModel!.data!.length - 1
                                              ? const SizedBox(
                                            height: 70,
                                          )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    );
              },
            ),
          ],
        ));
  }
}
