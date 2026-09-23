import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/visiting_consultant/visiting_request_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/visiting_consultant/visiting_request_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/widgets/visiting_summary_widget.dart';

class VisitingRequestDetailScreen extends StatefulWidget {
  final int requestId;

  const VisitingRequestDetailScreen({
    super.key,
    required this.requestId,
  });

  @override
  State<VisitingRequestDetailScreen> createState() => _VisitingRequestDetailScreenState();
}

class _VisitingRequestDetailScreenState extends State<VisitingRequestDetailScreen> {
  late final VisitingRequestDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(VisitingRequestDetailController(), tag: widget.requestId.toString());
    controller.loadAllDetails(widget.requestId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      appBar: CommonAppBar(
        title: "Request Details",
        leadIcon: const Icon(Icons.arrow_back_rounded, color: ColorConst.blackColor),
        leadOnTap: () => Navigator.of(context).maybePop(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: ColorConst.greenColor),
          );
        }

        final item = controller.requestDetail.value;
        if (item == null) {
          return const Center(child: Text("Unable to load request details"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.loadAllDetails(widget.requestId),
          color: ColorConst.primaryColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Status & Header Card
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ColorConst.borderGreyColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Request #VCR-${item.id}",
                                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Created: ${item.createdAt ?? 'Recent'}",
                                  style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildStatusPill(item.status ?? "Requested"),
                        ],
                      ),
                      const Divider(height: 24),

                      // Stepper / Lifecycle
                      _buildLifecycleStepper(item.status ?? "Requested"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 2. Visit Info Card
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ColorConst.borderGreyColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hospital Assigned Schedule Banner (highlighted when assigned/scheduled)
                      if (item.isAssigned || item.hasAssignedSchedule) ...[
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xffEBF8F2),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: ColorConst.primaryColor.withOpacity(0.35)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ColorConst.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.event_available, color: Colors.white, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      spacing: 6,
                                      runSpacing: 4,
                                      children: [
                                        Text(
                                          "Scheduled Appointment",
                                          style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 12),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: ColorConst.primaryColor,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            "CONFIRMED",
                                            style: TextStyleConst.boldTextStyle(Colors.white, 9),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.assignedDate ?? item.preferredDate ?? "Date Confirmed",
                                      style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 15),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      Text(
                        "Consultation Details",
                        style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
                      ),
                      const SizedBox(height: 14),
                      _buildDetailRow("Visit Type", item.visitType ?? "OPD"),
                      _buildDetailRow("Priority", item.priority ?? "Routine"),

                      // Assigned Date & Time (if scheduled by hospital)
                      if (item.assignedDate != null && item.assignedDate!.isNotEmpty)
                        _buildDetailRow("Assigned Date (Hospital)", item.assignedDate!, isBold: true),
                      if (item.assignedTimeSlot != null && item.assignedTimeSlot!.isNotEmpty)
                        _buildDetailRow("Assigned Time Slot", item.assignedTimeSlot!, isBold: true),

                      // Preferred Date & Time (requested by patient)
                      _buildDetailRow(
                        (item.assignedDate != null && item.assignedDate!.isNotEmpty)
                            ? "Preferred Date (Requested)"
                            : "Preferred Date",
                        item.preferredDate ?? "Flexible",
                      ),
                      if (item.preferredTimeSlot != null && item.preferredTimeSlot!.isNotEmpty)
                        _buildDetailRow(
                          (item.assignedTimeSlot != null && item.assignedTimeSlot!.isNotEmpty)
                              ? "Preferred Time Slot (Requested)"
                              : "Preferred Time Slot",
                          item.preferredTimeSlot!,
                        ),

                      if (item.reason != null && item.reason!.isNotEmpty)
                        _buildDetailRow("Reason", item.reason!),
                      if (item.cancellationReason != null && item.cancellationReason!.isNotEmpty)
                        _buildDetailRow("Cancellation Reason", item.cancellationReason!, isAlert: true),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 3. Consultant Info Card
                if (item.consultant != null) ...[
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ColorConst.borderGreyColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Assigned Specialist",
                          style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: ColorConst.primaryColor.withOpacity(0.1),
                              child: Icon(Icons.person, color: ColorConst.primaryColor, size: 28),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.consultant!.name ?? "Specialist",
                                    style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 15),
                                  ),
                                  Text(
                                    item.consultant!.specialty ?? item.consultant!.designation ?? "Visiting Consultant",
                                    style: TextStyleConst.mediumTextStyle(ColorConst.primaryColor, 13),
                                  ),
                                  if (item.consultant!.department != null)
                                    Text(
                                      item.consultant!.department!,
                                      style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 12),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // 4. Bill & Payment Section
                Obx(() {
                  final bill = controller.billData.value;
                  if (controller.isBillLoading.value) {
                    return const Center(child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                  if (bill == null) return const SizedBox.shrink();

                  return Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ColorConst.borderGreyColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Bill & Voucher",
                                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: bill.isPaid ? Colors.green.shade50 : Colors.red.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                bill.paymentStatus ?? "Unpaid",
                                style: TextStyleConst.boldTextStyle(
                                  bill.isPaid ? Colors.green.shade700 : Colors.red.shade700,
                                  12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow("Bill Number", bill.billNumber ?? "#VCR-${item.id}"),
                        if (bill.amount != null)
                          _buildDetailRow("Consultation Amount", "${bill.currency ?? '₹'}${bill.amount}"),
                        if (bill.tax != null && bill.tax! > 0)
                          _buildDetailRow("Tax", "${bill.currency ?? '₹'}${bill.tax}"),
                        if (bill.discount != null && bill.discount! > 0)
                          _buildDetailRow("Discount", "-${bill.currency ?? '₹'}${bill.discount}"),
                        const Divider(height: 16),
                        _buildDetailRow(
                          "Total Payable",
                          "${bill.currency ?? '₹'}${bill.netAmount ?? bill.amount ?? '0'}",
                          isBold: true,
                        ),

                        if (!bill.isPaid) ...[
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.amber.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, size: 16, color: Colors.amber.shade900),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Payment to be settled at the hospital billing counter.",
                                    style: TextStyleConst.mediumTextStyle(Colors.amber.shade900, 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          if (bill.paymentMode != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle_outline, size: 16, color: Colors.green.shade700),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      "Paid via ${bill.paymentMode} ${bill.paidAt != null ? 'on ${bill.paidAt}' : ''}",
                                      style: TextStyleConst.mediumTextStyle(Colors.green.shade700, 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                        if (bill.voucherUrl != null && bill.voucherUrl!.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 42,
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                final uri = Uri.tryParse(bill.voucherUrl!);
                                if (uri != null && await canLaunchUrl(uri)) {
                                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                                }
                              },
                              icon: Icon(Icons.download_rounded, size: 18, color: ColorConst.primaryColor),
                              label: Text(
                                "Download Voucher / Receipt",
                                style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 13),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: ColorConst.primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),

                // 5. Clinical Findings & Consultation Summary
                Obx(() {
                  final summary = controller.summaryData.value;
                  if (controller.isSummaryLoading.value) {
                    return const Center(child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                  if (summary != null) {
                    return Column(
                      children: [
                        VisitingSummaryWidget(summary: summary),
                        const SizedBox(height: 20),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),

                // 6. Cancel Request Button
                if (item.canBeCancelled) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmCancel(context, item.id!),
                      icon: const Icon(Icons.cancel_outlined, color: Colors.red, size: 20),
                      label: Text(
                        "Cancel Request",
                        style: TextStyleConst.boldTextStyle(Colors.red, 14),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false, bool isAlert = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 13),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyleConst.boldTextStyle(
                isAlert ? Colors.red : (isBold ? ColorConst.primaryColor : ColorConst.blackColor),
                isBold ? 15 : 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill(String status) {
    Color bg = Colors.amber.shade50;
    Color fg = Colors.amber.shade900;
    if (status.toLowerCase() == 'completed') {
      bg = Colors.green.shade50;
      fg = Colors.green.shade700;
    } else if (status.toLowerCase() == 'cancelled') {
      bg = Colors.red.shade50;
      fg = Colors.red.shade700;
    } else if (status.toLowerCase() == 'assigned' || status.toLowerCase() == 'confirmed') {
      bg = Colors.blue.shade50;
      fg = Colors.blue.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyleConst.boldTextStyle(fg, 12),
      ),
    );
  }

  Widget _buildLifecycleStepper(String status) {
    int activeStep = 0;
    final s = status.toLowerCase();
    if (s == 'requested') activeStep = 0;
    if (s == 'assigned' || s == 'confirmed') activeStep = 1;
    if (s == 'completed') activeStep = 2;
    if (s == 'cancelled') activeStep = -1;

    if (activeStep == -1) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.cancel, color: Colors.red, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "This request has been cancelled.",
                style: TextStyleConst.mediumTextStyle(Colors.red.shade800, 13),
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        _buildStepItem("Submitted", 0, activeStep),
        _buildStepLine(activeStep >= 1),
        _buildStepItem("Assigned", 1, activeStep),
        _buildStepLine(activeStep >= 2),
        _buildStepItem("Completed", 2, activeStep),
      ],
    );
  }

  Widget _buildStepItem(String title, int step, int currentStep) {
    final isDone = currentStep > step;
    final isCurrent = currentStep == step;

    Color color = Colors.grey.shade400;
    if (isDone || isCurrent) color = ColorConst.primaryColor;

    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: isDone ? ColorConst.primaryColor : (isCurrent ? ColorConst.primaryColor.withOpacity(0.2) : Colors.grey.shade200),
            child: isDone
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : Text(
                    "${step + 1}",
                    style: TextStyleConst.boldTextStyle(color, 11),
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyleConst.mediumTextStyle(color, 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepLine(bool isDone) {
    return Container(
      width: 20,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      color: isDone ? ColorConst.primaryColor : Colors.grey.shade300,
    );
  }

  void _confirmCancel(BuildContext context, int id) {
    final listController = Get.isRegistered<VisitingRequestController>()
        ? Get.find<VisitingRequestController>()
        : Get.put(VisitingRequestController());
    listController.cancelReasonController.clear();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Cancel Visit Request",
            style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you sure you want to cancel request #VCR-$id?",
                style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 13),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: listController.cancelReasonController,
                decoration: InputDecoration(
                  hintText: "Reason (e.g. Feeling better / Rescheduling needed)",
                  hintStyle: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 12),
                  filled: true,
                  fillColor: ColorConst.bgGreyColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: ColorConst.borderGreyColor),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Keep Request"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(ctx);
                final reason = listController.cancelReasonController.text.trim().isNotEmpty
                    ? listController.cancelReasonController.text.trim()
                    : "Feeling better / Rescheduling needed";
                final ok = await listController.cancelRequest(id, reason);
                if (ok) {
                  controller.fetchRequestDetail(id);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Yes, Cancel", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
