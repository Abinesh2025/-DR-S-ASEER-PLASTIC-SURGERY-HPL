import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/visiting_consultant/visiting_request_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_request_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/create_visiting_request_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/visiting_request_detail_screen.dart';

class VisitingRequestsListScreen extends StatefulWidget {
  const VisitingRequestsListScreen({super.key});

  @override
  State<VisitingRequestsListScreen> createState() => _VisitingRequestsListScreenState();
}

class _VisitingRequestsListScreenState extends State<VisitingRequestsListScreen> {
  final VisitingRequestController controller = Get.put(VisitingRequestController());

  @override
  void initState() {
    super.initState();
    controller.fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      appBar: CommonAppBar(
        title: "Visit Requests",
        leadIcon: const Icon(Icons.arrow_back_rounded, color: ColorConst.blackColor),
        leadOnTap: () => Navigator.of(context).maybePop(),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: ColorConst.blackColor),
            tooltip: "New Request",
            onPressed: () {
              Get.to(() => const CreateVisitingRequestScreen());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            height: 48,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              itemCount: controller.statusTabs.length,
              itemBuilder: (context, index) {
                final tab = controller.statusTabs[index];
                return Obx(() {
                  final isSelected = controller.currentTab.value == tab;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(tab),
                      selected: isSelected,
                      selectedColor: ColorConst.primaryColor,
                      backgroundColor: ColorConst.bgGreyColor,
                      labelStyle: TextStyleConst.mediumTextStyle(
                        isSelected ? Colors.white : ColorConst.blackColor,
                        12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isSelected ? ColorConst.primaryColor : ColorConst.borderGreyColor,
                        ),
                      ),
                      onSelected: (_) => controller.changeTab(tab),
                    ),
                  );
                });
              },
            ),
          ),
          const SizedBox(height: 8),

          // Requests List
          Expanded(
            child: Obx(() {
              if (controller.isListLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: ColorConst.greenColor),
                );
              }

              if (controller.filteredRequests.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => controller.fetchRequests(),
                  color: ColorConst.primaryColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_note_outlined, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            "No Visit Requests",
                            style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            controller.currentTab.value == "All"
                                ? "You haven't requested any visiting consultants yet."
                                : "No requests with status '${controller.currentTab.value}'",
                            textAlign: TextAlign.center,
                            style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 13),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              Get.to(() => const CreateVisitingRequestScreen());
                            },
                            icon: const Icon(Icons.add, color: Colors.white, size: 18),
                            label: Text(
                              "Create Request",
                              style: TextStyleConst.boldTextStyle(Colors.white, 14),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConst.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchRequests(),
                color: ColorConst.primaryColor,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  itemCount: controller.filteredRequests.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredRequests[index];
                    return _buildRequestCard(context, item);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, VisitingRequestItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ColorConst.borderGreyColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            if (item.id != null) {
              Get.to(() => VisitingRequestDetailScreen(requestId: item.id!));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header: ID, Visit Type & Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "#VCR-${item.id ?? ''}",
                          style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 15),
                        ),
                        const SizedBox(width: 8),
                        _buildVisitTypeChip(item.visitType ?? "OPD"),
                      ],
                    ),
                    _buildStatusChip(item.status ?? "Requested"),
                  ],
                ),
                const Divider(height: 20),

                // Doctor / Specialist Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: ColorConst.primaryColor.withOpacity(0.1),
                      child: Icon(Icons.person, color: ColorConst.primaryColor, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.consultant?.name ?? "General Specialist Request",
                            style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            item.consultant?.specialty ?? item.consultant?.department ?? "Hospital Specialist",
                            style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    _buildPriorityTag(item.priority ?? "Routine"),
                  ],
                ),
                const SizedBox(height: 12),

                // Date & Time Slot (highlights Assigned/Scheduled vs Preferred)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: item.hasAssignedSchedule ? const Color(0xffEBF8F2) : ColorConst.bgGreyColor,
                    borderRadius: BorderRadius.circular(10),
                    border: item.hasAssignedSchedule
                        ? Border.all(color: ColorConst.primaryColor.withOpacity(0.3))
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.hasAssignedSchedule ? Icons.event_available : Icons.event_available_outlined,
                        size: 16,
                        color: item.hasAssignedSchedule ? ColorConst.primaryColor : ColorConst.hintGreyColor,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item.hasAssignedSchedule
                              ? "Scheduled: ${item.displayDate}"
                              : (item.preferredDate != null ? "Pref: ${item.preferredDate}" : "Date not specified"),
                          style: TextStyleConst.mediumTextStyle(
                            item.hasAssignedSchedule ? ColorConst.primaryColor : ColorConst.blackColor,
                            12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!item.hasAssignedSchedule &&
                          item.preferredTimeSlot != null &&
                          item.preferredTimeSlot!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.schedule,
                          size: 14,
                          color: ColorConst.hintGreyColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.preferredTimeSlot!,
                          style: TextStyleConst.regularTextStyle(
                            ColorConst.hintGreyColor,
                            11,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Reason snippet
                if (item.reason != null && item.reason!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    "Reason: ${item.reason}",
                    style: TextStyleConst.regularTextStyle(ColorConst.blackColor.withOpacity(0.7), 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                // Action Bar: Cancel / View Bill / View Summary
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (item.canBeCancelled) ...[
                      TextButton(
                        onPressed: () => _confirmCancel(context, item.id!),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        child: const Text("Cancel Request"),
                      ),
                      const SizedBox(width: 8),
                    ],
                    OutlinedButton(
                      onPressed: () {
                        if (item.id != null) {
                          Get.to(() => VisitingRequestDetailScreen(requestId: item.id!));
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: ColorConst.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                      child: Text(
                        "View Details",
                        style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisitTypeChip(String type) {
    final isOPD = type.toUpperCase() == "OPD";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isOPD ? Colors.blue.shade50 : Colors.teal.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isOPD ? Colors.blue.shade200 : Colors.teal.shade200,
          width: 0.8,
        ),
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyleConst.boldTextStyle(
          isOPD ? Colors.blue.shade700 : Colors.teal.shade700,
          10,
        ),
      ),
    );
  }

  Widget _buildPriorityTag(String priority) {
    Color bg = Colors.teal.shade50;
    Color fg = Colors.teal.shade700;
    if (priority.toLowerCase() == 'urgent') {
      bg = Colors.orange.shade50;
      fg = Colors.orange.shade800;
    } else if (priority.toLowerCase() == 'critical') {
      bg = Colors.red.shade50;
      fg = Colors.red.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        priority,
        style: TextStyleConst.boldTextStyle(fg, 11),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg = Colors.blue.shade50;
    Color fg = Colors.blue.shade700;

    switch (status.toLowerCase()) {
      case 'requested':
        bg = Colors.amber.shade50;
        fg = Colors.amber.shade900;
        break;
      case 'assigned':
        bg = Colors.purple.shade50;
        fg = Colors.purple.shade700;
        break;
      case 'confirmed':
        bg = Colors.blue.shade50;
        fg = Colors.blue.shade700;
        break;
      case 'completed':
        bg = Colors.green.shade50;
        fg = Colors.green.shade700;
        break;
      case 'cancelled':
        bg = Colors.red.shade50;
        fg = Colors.red.shade700;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyleConst.boldTextStyle(fg, 11),
      ),
    );
  }

  void _confirmCancel(BuildContext context, int id) {
    controller.cancelReasonController.clear();
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
                controller: controller.cancelReasonController,
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
                final reason = controller.cancelReasonController.text.trim().isNotEmpty
                    ? controller.cancelReasonController.text.trim()
                    : "Feeling better / Rescheduling needed";
                await controller.cancelRequest(id, reason);
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
