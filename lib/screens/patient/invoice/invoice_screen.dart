import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/invoice_controller/invoice_list_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/invoice/invoice_detail_screen.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({Key? key}) : super(key: key);
  final InvoiceListController invoiceListController =
      Get.put(InvoiceListController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white,
        child: Obx(
          () => invoiceListController.isGotInvoice.value == false
              ?  Center(
                  child:
                      CircularProgressIndicator(color: ColorConst.primaryColor))
              : invoiceListController.invoiceModel?.data?.isEmpty ?? true
                  ? Center(
                      child: Text(
                        "No invoice found",
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.blackColor,
                          width * 0.04,
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        invoiceListController.isGotInvoice.value = false;
                        invoiceListController.getInvoices();
                      },
                      child: AnimationLimiter(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount: invoiceListController
                                  .invoiceModel?.data?.length ??
                              0,
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
                                        () => InvoiceDetailScreen(
                                            status: invoiceListController
                                                    .invoiceModel
                                                    ?.data?[index]
                                                    .status ??
                                                false),
                                        transition: Transition.rightToLeft,
                                        arguments: invoiceListController
                                                .invoiceModel
                                                ?.data?[index]
                                                .id ??
                                            0,
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: index == 0 ? 15 : 8,
                                          bottom: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.04),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                        border: Border.all(
                                            color: Colors.grey.shade100),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          children: [
                                            // Status Icon Leading
                                            Container(
                                              height: 48,
                                              width: 48,
                                              decoration: BoxDecoration(
                                                color: invoiceListController
                                                            .invoiceModel
                                                            ?.data?[index]
                                                            .status ==
                                                        true
                                                    ? Colors.green
                                                        .withOpacity(0.1)
                                                    : Colors.orange
                                                        .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                invoiceListController
                                                            .invoiceModel
                                                            ?.data?[index]
                                                            .status ==
                                                        true
                                                    ? Icons.check_circle_outline
                                                    : Icons.access_time_rounded,
                                                color: invoiceListController
                                                            .invoiceModel
                                                            ?.data?[index]
                                                            .status ==
                                                        true
                                                    ? Colors.green
                                                    : Colors.orange,
                                                size: 24,
                                              ),
                                            ),
                                            const SizedBox(width: 16),

                                            // Invoice Info
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    invoiceListController
                                                            .invoiceModel
                                                            ?.data?[index]
                                                            .invoice_id ??
                                                        "N/A",
                                                    style: TextStyleConst
                                                        .boldTextStyle(
                                                      ColorConst.blackColor,
                                                      width * 0.042,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    invoiceListController
                                                            .invoiceModel
                                                            ?.data?[index]
                                                            .invoice_date ??
                                                        "N/A",
                                                    style: TextStyleConst
                                                        .mediumTextStyle(
                                                      Colors.grey.shade600,
                                                      width * 0.035,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Amount & Status Badge
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${invoiceListController.invoiceModel?.data?[index].currency ?? ""} ${invoiceListController.invoiceModel?.data?[index].amount ?? "0"}",
                                                  style: TextStyleConst
                                                      .boldTextStyle(
                                                    ColorConst.primaryColor,
                                                    width * 0.045,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: invoiceListController
                                                                .invoiceModel
                                                                ?.data?[index]
                                                                .status ==
                                                            true
                                                        ? Colors.green
                                                            .withOpacity(0.1)
                                                        : Colors.orange
                                                            .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Text(
                                                    invoiceListController
                                                                .invoiceModel
                                                                ?.data?[index]
                                                                .status ==
                                                            true
                                                        ? "Paid"
                                                        : "Pending",
                                                    style: TextStyleConst
                                                        .mediumTextStyle(
                                                      invoiceListController
                                                                  .invoiceModel
                                                                  ?.data?[index]
                                                                  .status ==
                                                              true
                                                          ? Colors.green
                                                          : Colors
                                                              .orange.shade800,
                                                      width * 0.028,
                                                    ),
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
                              ),
                            );
                          },
                        ),
                      ),
                    ),
        ));
  }
}
