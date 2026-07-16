import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/transaction_controller/transaction_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/screen/transaction/transactions_details_screen.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);
  final TransactionController transactionController = Get.put(TransactionController());

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
                itemCount: transactionController.transactionStatus.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Center(
                    child: Obx(
                          () => GestureDetector(
                        onTap: () {
                          transactionController.changeIndex(index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: width * 0.03, right: index == 6 ? 10 : 0),
                          height: 50,
                          decoration:
                          index == transactionController.currentIndex.value
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
                                transactionController.transactionStatus[index],
                                style: TextStyleConst.mediumTextStyle(
                                  index == transactionController.currentIndex.value
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
            Obx(() {
              return transactionController.isGetTransaction.isFalse
                  ? const Expanded(child: Center(child: CircularProgressIndicator()))
                  : transactionController.filterTransactionModel!.data!.isEmpty
                      ? Expanded(
                        child: Container(
                            color: ColorConst.whiteColor,
                            child: Center(
                              child: Text(
                                "No transaction found",
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
                              transactionController.isGetTransaction.value = false;
                              transactionController.changeIndex(transactionController.currentIndex.value);
                            },
                            child: AnimationLimiter(
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                itemCount: transactionController.filterTransactionModel!.data!.length,
                                itemBuilder: (context, index) {

                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 1000),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => TransactionsDetailScreen(
                                                hospitalName: transactionController.filterTransactionModel!.data![index].hospital_name!,
                                                payments: transactionController.filterTransactionModel!.data![index].payment_type!,
                                                currencySymbol : transactionController.filterTransactionModel!.data![index].currency_symbol!,
                                                amount: transactionController.filterTransactionModel!.data![index].amount!.toString(),
                                                transactionDate: transactionController.filterTransactionModel!.data![index].transaction_date!,
                                                startTime : transactionController.filterTransactionModel!.data![index].start_time!,
                                                paymentApproved: transactionController.filterTransactionModel!.data![index].is_manual_payment!.toString(),
                                                status: transactionController.filterTransactionModel!.data![index].status!,
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
                                                      Text(transactionController.filterTransactionModel!.data![index].hospital_name!,
                                                        maxLines: 2,
                                                        style: TextStyleConst.mediumTextStyle(
                                                          ColorConst.blackColor,
                                                          width * 0.045,
                                                        ),
                                                      ),
                                                      SizedBox(height: height * 0.004),
                                                      RichText(
                                                        text: TextSpan(
                                                          text: transactionController.filterTransactionModel!.data![index].status,
                                                          style: TextStyleConst.mediumTextStyle(
                                                            transactionController.filterTransactionModel!.data![index].status == "Paid"
                                                            ? Colors.green : Colors.red,
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
                                                              text: transactionController.filterTransactionModel!.data![index].transaction_date,
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
                                                    "${transactionController.filterTransactionModel!.data![index].currency_symbol} ${transactionController.filterTransactionModel!.data![index].amount}",
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
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      );
            }),
          ],
        ));
  }
}
