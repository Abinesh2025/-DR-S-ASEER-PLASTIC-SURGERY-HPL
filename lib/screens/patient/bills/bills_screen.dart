import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/bills_controller/bills_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/bills/bills_detail_screen.dart';

class BillScreen extends StatelessWidget {
  BillScreen({Key? key}) : super(key: key);
  final BillsController billsController = Get.put(BillsController());

  @override
  Widget build(BuildContext context) {
    // Height variable removed to fix lint warning
    final width = MediaQuery.of(context).size.width;
    return Obx(() => billsController.isGetBills.value
        ? billsController.billsModel!.data!.isEmpty
            ? Center(
                child: Text(
                  "No bills found",
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.blackColor,
                    width * 0.04,
                  ),
                ),
              )
            : Container(
                color: Colors.white,
                child: RefreshIndicator(
                  onRefresh: () async {
                    billsController.isGetBills.value = false;
                    billsController.getBill();
                  },
                  backgroundColor: ColorConst.primaryColor,
                  color: Colors.white,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      padding: const EdgeInsets.only(top: 15, bottom: 30),
                      itemCount: billsController.billsModel!.data!.length,
                      itemBuilder: (context, index) {
                        final bill = billsController.billsModel!.data![index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    arguments: bill.id!,
                                    () => BillDetailScreen(),
                                    transition: Transition.rightToLeft,
                                  );
                                },
                                // Modern Premium Card Layout
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(
                                            0.04), // Very soft, modern shadow
                                        offset: const Offset(0, 8),
                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Left Side Icon Indicator (Document/Receipt Theme)
                                      Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          color: ColorConst.primaryColor
                                              .withOpacity(0.12),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.receipt_long_rounded,
                                            color: ColorConst.primaryColor,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),

                                      // Middle Content (Bill ID & Date)
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              bill.bill_id!,
                                              style:
                                                  TextStyleConst.boldTextStyle(
                                                ColorConst.blackColor,
                                                16,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_rounded,
                                                  color:
                                                      ColorConst.hintGreyColor,
                                                  size: 14,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  bill.bill_date!,
                                                  style: TextStyleConst
                                                      .mediumTextStyle(
                                                    ColorConst.hintGreyColor,
                                                    13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Right Side Content (Price & Arrow)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${bill.currency!} ${bill.amount!}",
                                            style: TextStyleConst.boldTextStyle(
                                              ColorConst.primaryColor,
                                              17,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade50,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.chevron_right_rounded,
                                              color: Colors.grey.shade400,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
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
              )
        : const Center(child: CircularProgressIndicator()));
  }
}
