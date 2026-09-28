import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/visiting_consultant/visiting_consultant_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/visiting_consultant/visiting_request_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_consultant_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/visiting_requests_list_screen.dart';

class CreateVisitingRequestScreen extends StatefulWidget {
  final VisitingConsultantData? initialConsultant;

  const CreateVisitingRequestScreen({
    super.key,
    this.initialConsultant,
  });

  @override
  State<CreateVisitingRequestScreen> createState() => _CreateVisitingRequestScreenState();
}

class _CreateVisitingRequestScreenState extends State<CreateVisitingRequestScreen> {
  final VisitingRequestController requestController = Get.put(VisitingRequestController());
  final VisitingConsultantController directoryController = Get.put(VisitingConsultantController());

  @override
  void initState() {
    super.initState();
    requestController.initForm(preselectedConsultant: widget.initialConsultant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      appBar: CommonAppBar(
        title: "Request Consultation",
        leadIcon: const Icon(Icons.arrow_back_rounded, color: ColorConst.blackColor),
        leadOnTap: () => Navigator.of(context).maybePop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Visit Type Selector (OPD vs IPD)
            _buildSectionTitle("1. Select Visit Type", required: true),
            const SizedBox(height: 10),
            Obx(() => Row(
                  children: [
                    _buildVisitTypeCard(
                      type: "OPD",
                      title: "Outpatient (OPD)",
                      subtitle: "Visit doctor at hospital clinic",
                      icon: Icons.local_hospital_outlined,
                      isSelected: requestController.visitType.value == "OPD",
                      onTap: () => requestController.setVisitType("OPD"),
                    ),
                    const SizedBox(width: 14),
                    _buildVisitTypeCard(
                      type: "IPD",
                      title: "Inpatient (IPD)",
                      subtitle: "Bedside visit for admitted patient",
                      icon: Icons.hotel_outlined,
                      isSelected: requestController.visitType.value == "IPD",
                      onTap: () => requestController.setVisitType("IPD"),
                    ),
                  ],
                )),
            const SizedBox(height: 24),

            // 2. Preferred Specialist
            _buildSectionTitle("2. Preferred Visiting Consultant", required: false),
            const SizedBox(height: 10),
            Obx(() {
              final consultant = requestController.selectedConsultant.value;
              if (consultant != null) {
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ColorConst.primaryColor.withOpacity(0.4)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorConst.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.medical_services_outlined, color: ColorConst.primaryColor, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              consultant.name ?? "Specialist",
                              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 15),
                            ),
                            Text(
                              consultant.specialty ?? consultant.department ?? "Specialist",
                              style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 12),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                        onPressed: () {
                          requestController.selectedConsultant.value = null;
                        },
                      ),
                    ],
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorConst.borderGreyColor),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_search_outlined, color: ColorConst.hintGreyColor, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Any Available Specialist (Hospital will assign)",
                            style: TextStyleConst.mediumTextStyle(ColorConst.blackColor, 13),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _showConsultantPicker(context),
                          child: Text(
                            "Pick Doctor",
                            style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 13),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),

            // 3. Priority Level Selector (Routine, Urgent, Critical)
            _buildSectionTitle("3. Priority Level", required: true),
            const SizedBox(height: 10),
            Obx(() => Row(
                  children: [
                    _buildPriorityChip(
                      label: "Routine",
                      color: Colors.teal,
                      icon: Icons.check_circle_outline,
                      isSelected: requestController.priority.value == "Routine",
                      onTap: () => requestController.setPriority("Routine"),
                    ),
                    const SizedBox(width: 10),
                    _buildPriorityChip(
                      label: "Urgent",
                      color: Colors.orange,
                      icon: Icons.warning_amber_rounded,
                      isSelected: requestController.priority.value == "Urgent",
                      onTap: () => requestController.setPriority("Urgent"),
                    ),
                    const SizedBox(width: 10),
                    _buildPriorityChip(
                      label: "Critical",
                      color: Colors.red,
                      icon: Icons.emergency_outlined,
                      isSelected: requestController.priority.value == "Critical",
                      onTap: () => requestController.setPriority("Critical"),
                    ),
                  ],
                )),
            const SizedBox(height: 24),

            // 4. Preferred Date
            _buildSectionTitle("4. Preferred Consultation Date", required: false),
            const SizedBox(height: 4),
            Text(
              "Choose your preferred day. The hospital team will schedule and assign the final date/time.",
              style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 12),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final date = requestController.preferredDate.value;
              final formatted = date != null ? DateFormat('EEEE, dd MMMM yyyy').format(date) : "Select Date";
              return InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: date ?? DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: ColorConst.primaryColor,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    requestController.setPreferredDate(picked);
                  }
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: ColorConst.borderGreyColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, color: ColorConst.primaryColor, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          formatted,
                          style: TextStyleConst.mediumTextStyle(ColorConst.blackColor, 14),
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: ColorConst.hintGreyColor),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),

            // 5. Preferred Time Slot
            _buildSectionTitle("5. Preferred Time Slot", required: false),
            const SizedBox(height: 4),
            Text(
              "Select your preferred timing. (Please arrive at least 1 hour earlier)",
              style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 12),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final consultant = requestController.selectedConsultant.value;
              final visitingHours = consultant?.visitingHours;
              if (visitingHours != null && visitingHours.trim().isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConst.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorConst.primaryColor.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: ColorConst.primaryColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Specialist's Regular Hours: $visitingHours",
                          style: TextStyleConst.mediumTextStyle(ColorConst.primaryColor, 12),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            Obx(() {
              final selectedSlot = requestController.preferredTimeSlot.value;
              final isCustomTime = selectedSlot.isNotEmpty &&
                  !requestController.standardSlots.contains(selectedSlot);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: requestController.standardSlots.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final slot = requestController.standardSlots[index];
                      final isSelected = selectedSlot == slot;
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          requestController.setTimeSlot(isSelected ? "" : slot);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected ? ColorConst.primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? ColorConst.primaryColor
                                  : ColorConst.borderGreyColor,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: ColorConst.primaryColor.withOpacity(0.25),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 15,
                                color: isSelected ? Colors.white : ColorConst.hintGreyColor,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  slot,
                                  style: TextStyleConst.mediumTextStyle(
                                    isSelected ? Colors.white : ColorConst.blackColor,
                                    12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: ColorConst.primaryColor,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null && context.mounted) {
                        final formattedTime = picked.format(context);
                        requestController.setTimeSlot(formattedTime);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: isCustomTime
                            ? ColorConst.primaryColor.withOpacity(0.08)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isCustomTime
                              ? ColorConst.primaryColor
                              : ColorConst.borderGreyColor,
                          width: isCustomTime ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.more_time_rounded,
                            size: 18,
                            color: isCustomTime
                                ? ColorConst.primaryColor
                                : ColorConst.hintGreyColor,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              isCustomTime
                                  ? "Selected Custom Time: $selectedSlot"
                                  : "Choose Other / Custom Time...",
                              style: TextStyleConst.mediumTextStyle(
                                isCustomTime
                                    ? ColorConst.primaryColor
                                    : ColorConst.hintGreyColor,
                                13,
                              ),
                            ),
                          ),
                          if (isCustomTime)
                            GestureDetector(
                              onTap: () => requestController.setTimeSlot(""),
                              child: const Icon(Icons.close, size: 18, color: Colors.grey),
                            )
                          else
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 13,
                              color: ColorConst.hintGreyColor,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 18),

            // Arrival Advisory Notice / Warning Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFCD34D),
                  width: 1.2,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xFFD97706),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Important: Arrive 1 Hour Earlier",
                          style: TextStyleConst.boldTextStyle(
                            const Color(0xFFB45309),
                            13.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Please arrive at the hospital at least 1 hour before your scheduled appointment time for registration, preliminary checkup, and vitals recording.",
                          style: TextStyleConst.regularTextStyle(
                            const Color(0xFF92400E),
                            12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 6. Reason for Visit / Medical Notes
            _buildSectionTitle("6. Reason for Consultation", required: false),
            const SizedBox(height: 10),
            TextField(
              controller: requestController.reasonController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Describe symptoms, follow-up purpose, or referral reason (e.g. Follow-up consultation for cardiac assessment)",
                hintStyle: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 13),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: ColorConst.borderGreyColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: ColorConst.borderGreyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: ColorConst.primaryColor),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: requestController.isSubmitting.value
                        ? null
                        : () async {
                            final success = await requestController.submitRequest();
                            if (success && context.mounted) {
                              Get.off(() => const VisitingRequestsListScreen());
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConst.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: requestController.isSubmitting.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.2,
                            ),
                          )
                        : Text(
                            "Submit Visit Request",
                            style: TextStyleConst.boldTextStyle(Colors.white, 16),
                          ),
                  ),
                )),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool required = false}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 15),
        ),
        if (required)
          Text(
            " *",
            style: TextStyleConst.boldTextStyle(Colors.red, 15),
          ),
      ],
    );
  }

  Widget _buildVisitTypeCard({
    required String type,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? ColorConst.primaryColor : ColorConst.borderGreyColor,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: ColorConst.primaryColor.withOpacity(0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? ColorConst.primaryColor : ColorConst.hintGreyColor,
                    size: 24,
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? ColorConst.primaryColor : Colors.grey.shade400,
                        width: 2,
                      ),
                      color: isSelected ? ColorConst.primaryColor : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 12, color: Colors.white)
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyleConst.boldTextStyle(
                  isSelected ? ColorConst.primaryColor : ColorConst.blackColor,
                  14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 11),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityChip({
    required String label,
    required MaterialColor color,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? color.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color.shade400 : ColorConst.borderGreyColor,
              width: isSelected ? 1.8 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? color.shade700 : ColorConst.hintGreyColor,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyleConst.boldTextStyle(
                  isSelected ? color.shade800 : ColorConst.blackColor,
                  12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConsultantPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose Visiting Consultant",
                    style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: Obx(() {
                  if (directoryController.allConsultants.isEmpty) {
                    return const Center(child: Text("No consultants available"));
                  }
                  return ListView.builder(
                    itemCount: directoryController.allConsultants.length,
                    itemBuilder: (context, index) {
                      final doc = directoryController.allConsultants[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: ColorConst.primaryColor.withOpacity(0.1),
                          child: Icon(Icons.person, color: ColorConst.primaryColor),
                        ),
                        title: Text(
                          doc.name ?? "Specialist",
                          style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 14),
                        ),
                        subtitle: Text(
                          "${doc.specialty ?? ''} • ${doc.department ?? ''}",
                          style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 12),
                        ),
                        trailing: const Icon(Icons.chevron_right, size: 18),
                        onTap: () {
                          requestController.selectedConsultant.value = doc;
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
