import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/bills_controller/bill_details_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class BillDetailScreen extends StatelessWidget {
  BillDetailScreen({Key? key}) : super(key: key);
  final BillDetailsController billDetailsController =
      Get.put(BillDetailsController());

  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)!.settings.arguments as int;
    billDetailsController.getBillsDetails(res);
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            title: StringUtils.billsDetails,
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body: Obx(
            () {
              return billDetailsController.isGetBillsDetails.value != false
                  ? Container(
                      color: Colors.grey
                          .shade50, // Subtle off-white background to make cards pop
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 1. Premium Hero Header Card
                            _buildHeroHeaderCard(width),
                            const SizedBox(height: 20),

                            // 2. Admission Details Card
                            _buildAdmissionDetailsCard(width),
                            const SizedBox(height: 20),

                            // 3. Insurance Details Card
                            _buildInsuranceDetailsCard(width),
                            const SizedBox(height: 20),

                            // 4. Item Details (Receipt) Area
                            _buildItemDetailsReceipt(width),
                            const SizedBox(height: 30),

                            // 5. Download Button
                            Obx(() {
                              return billDetailsController
                                          .isDownloading.value ==
                                      true
                                  ?  Center(
                                      child: CircularProgressIndicator(
                                          color: ColorConst.primaryColor))
                                  : CommonButton(
                                      width:
                                          width, // Full width looks better here
                                      height: 55,
                                      text: StringUtils.downloadBill,
                                      color: ColorConst.primaryColor,
                                      onTap: () {
                                        billDetailsController.downloadPDF(
                                            billDetailsController
                                                .billDetailModel!
                                                .data!
                                                .bill_download!);
                                      },
                                      textStyleConst:
                                          TextStyleConst.boldTextStyle(
                                              ColorConst.whiteColor, 18),
                                    );
                            }),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }

  // Helper Widget for white premium cards
  Widget _buildCardBase({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: child,
    );
  }

  // Helper for structured key-value detail rows
  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style:
                  TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 14),
            ),
          ),
          Expanded(
            flex: 3,
            child: isStatus
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorConst.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        value,
                        style: TextStyleConst.boldTextStyle(
                            ColorConst.primaryColor, 13),
                      ),
                    ),
                  )
                : Text(
                    value,
                    textAlign: TextAlign.right,
                    style:
                        TextStyleConst.boldTextStyle(ColorConst.blackColor, 14),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeaderCard(double width) {
    final data = billDetailsController.billDetailModel!.data!;
    return _buildCardBase(
      child: Column(
        children: [
          // Logo
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConst.primaryColor.withOpacity(0.05),
              border: Border.all(
                  color: ColorConst.primaryColor.withOpacity(0.1), width: 2),
            ),
            padding: const EdgeInsets.all(10),
            child: ClipOval(
              child: data.app_logo == null || data.app_logo!.isEmpty
                  ? Image.asset(ImageUtils.appLogo, fit: BoxFit.cover)
                  : FadeInImage(
                      placeholder: const AssetImage(ImageUtils.appLogo),
                      image: NetworkImage(data.app_logo!),
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(ImageUtils.appLogo, fit: BoxFit.cover),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 16),
          // Total Amount prominently displayed
          Text(
            "${data.currency!} ${data.amount!}",
            style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 32),
          ),
          const SizedBox(height: 8),
          // Bill ID and Subtext
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Bill #${data.bill_id}",
              style: TextStyleConst.boldTextStyle(Colors.grey.shade800, 15),
            ),
          ),
          const SizedBox(height: 16),
          Divider(color: ColorConst.greyShadowColor),
          const SizedBox(height: 12),
          // Minimal Date Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.event_note_rounded,
                  color: ColorConst.hintGreyColor, size: 16),
              const SizedBox(width: 6),
              Text(
                "${data.bill_date} • ${data.bill_time}",
                style: TextStyleConst.mediumTextStyle(
                    ColorConst.hintGreyColor, 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdmissionDetailsCard(double width) {
    final details =
        billDetailsController.billDetailModel!.data!.admission_detail!;
    return _buildCardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.local_hospital_rounded,
                    color: Colors.blue, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                StringUtils.admissionDetails,
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
              StringUtils.admissionId,
              billDetailsController
                  .billDetailModel!.data!.patient_admission_id!),
          _buildDetailRow(StringUtils.patientCellNO, details.phone!),
          _buildDetailRow(StringUtils.doctor, details.doctor!),
          _buildDetailRow("Admission",
              "${details.admission_date!} ${details.admission_time!}"),
          _buildDetailRow("Discharge",
              "${details.discharge_date!} ${details.discharge_time!}"),
          _buildDetailRow(StringUtils.createOn, details.created_at!),
        ],
      ),
    );
  }

  Widget _buildInsuranceDetailsCard(double width) {
    if (billDetailsController.billDetailModel!.data!.insurance_detail == null)
      return const SizedBox();
    final ins = billDetailsController.billDetailModel!.data!.insurance_detail!;
    return _buildCardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.verified_user_rounded,
                    color: Colors.orange, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                StringUtils.insuranceDetails,
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDetailRow(StringUtils.insuranceName, ins.insurance_name!),
          _buildDetailRow(StringUtils.packageName, ins.package_name!),
          _buildDetailRow(StringUtils.policyNo, ins.policy_no!),
          _buildDetailRow(StringUtils.totalDays, "${ins.total_days!} Days"),
        ],
      ),
    );
  }

  Widget _buildItemDetailsReceipt(double width) {
    final data = billDetailsController.billDetailModel!.data!;
    return _buildCardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.receipt_long_rounded,
                    color: Colors.purple, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                StringUtils.itemDetails,
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Items List
          ...List.generate(data.item_details!.length, (index) {
            final item = data.item_details![index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.item_name!,
                          style:
                              TextStyleConst.boldTextStyle(Colors.black87, 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${item.quantity!}x ${data.currency!} ${item.price!}",
                          style: TextStyleConst.mediumTextStyle(
                              ColorConst.hintGreyColor, 13),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${data.currency!} ${item.total!}",
                    style:
                        TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
                  ),
                ],
              ),
            );
          }),

          Divider(color: ColorConst.greyShadowColor),
          const SizedBox(height: 12),

          // Grand Total Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorConst.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border:
                  Border.all(color: ColorConst.primaryColor.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringUtils.totalAmount,
                  style:
                      TextStyleConst.boldTextStyle(ColorConst.primaryColor, 18),
                ),
                Text(
                  "${data.currency!} ${data.amount!}",
                  style:
                      TextStyleConst.boldTextStyle(ColorConst.primaryColor, 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
