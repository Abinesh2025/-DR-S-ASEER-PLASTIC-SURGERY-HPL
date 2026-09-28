import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/visiting_consultant/visiting_request_detail_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_bill_model.dart';

class VisitingPaymentBottomSheet extends StatelessWidget {
  final int requestId;
  final VisitingBillData? bill;
  final VisitingRequestDetailController controller;

  const VisitingPaymentBottomSheet({
    super.key,
    required this.requestId,
    required this.bill,
    required this.controller,
  });

  static void show(
    BuildContext context, {
    required int requestId,
    required VisitingBillData? bill,
    required VisitingRequestDetailController controller,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => VisitingPaymentBottomSheet(
        requestId: requestId,
        bill: bill,
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Header & Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Record Payment",
                      style: TextStyleConst.boldTextStyle(
                        ColorConst.blackColor,
                        18,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Bill #${bill?.billNumber ?? requestId}",
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.hintGreyColor,
                        13,
                      ),
                    ),
                  ],
                ),
                if (bill?.netAmount != null || bill?.amount != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: ColorConst.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${bill?.currency ?? '₹'}${bill?.netAmount ?? bill?.amount ?? '0'}",
                      style: TextStyleConst.boldTextStyle(
                        ColorConst.primaryColor,
                        18,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Select Payment Mode
            Text(
              "Select Payment Mode",
              style: TextStyleConst.boldTextStyle(
                ColorConst.blackColor,
                14,
              ),
            ),
            const SizedBox(height: 12),

            Obx(() => Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: controller.availablePaymentModes.map((mode) {
                    final isSelected = controller.selectedPaymentMode.value == mode;
                    return ChoiceChip(
                      label: Text(mode),
                      selected: isSelected,
                      selectedColor: ColorConst.primaryColor,
                      backgroundColor: Colors.grey.shade100,
                      labelStyle: TextStyleConst.mediumTextStyle(
                        isSelected ? Colors.white : ColorConst.blackColor,
                        13,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          controller.selectedPaymentMode.value = mode;
                        }
                      },
                    );
                  }).toList(),
                )),
            const SizedBox(height: 20),

            // Transaction Notes / ID
            Text(
              "Transaction Reference / Notes",
              style: TextStyleConst.boldTextStyle(
                ColorConst.blackColor,
                14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.transactionNotesController,
              decoration: InputDecoration(
                hintText: "e.g. Transaction ID: UPI123456789 or Cash Desk 2",
                hintStyle: TextStyleConst.regularTextStyle(
                  ColorConst.hintGreyColor,
                  13,
                ),
                filled: true,
                fillColor: ColorConst.bgGreyColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorConst.borderGreyColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorConst.borderGreyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorConst.primaryColor),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isPaying.value
                        ? null
                        : () async {
                            final success = await controller.recordPayment(requestId);
                            if (success && context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConst.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isPaying.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.2,
                            ),
                          )
                        : Text(
                            "Confirm Payment",
                            style: TextStyleConst.boldTextStyle(
                              Colors.white,
                              15,
                            ),
                          ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
