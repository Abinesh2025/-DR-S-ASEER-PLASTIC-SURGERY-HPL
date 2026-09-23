import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_consultant_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_request_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/services/visiting_consultant_service.dart';

class VisitingRequestController extends GetxController {
  final VisitingConsultantService _service = VisitingConsultantService();

  // --- Booking Form State ---
  RxString visitType = "OPD".obs; // "OPD" or "IPD"
  RxString priority = "Routine".obs; // "Routine", "Urgent", "Critical"
  Rxn<VisitingConsultantData> selectedConsultant = Rxn<VisitingConsultantData>();
  Rxn<DateTime> preferredDate = Rxn<DateTime>();
  RxString preferredTimeSlot = "".obs;

  final TextEditingController reasonController = TextEditingController();
  final TextEditingController cancelReasonController = TextEditingController();
  RxBool isSubmitting = false.obs;

  // --- Available Time Slots Suggestions ---
  final List<String> standardSlots = [
    "09:00 AM - 10:00 AM",
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "12:00 PM - 01:00 PM",
    "02:00 PM - 03:00 PM",
    "03:00 PM - 04:00 PM",
    "04:00 PM - 05:00 PM",
    "05:00 PM - 06:00 PM",
    "06:00 PM - 07:00 PM",
  ];

  // --- Requests List State ---
  RxList<VisitingRequestItem> requests = <VisitingRequestItem>[].obs;
  RxList<VisitingRequestItem> filteredRequests = <VisitingRequestItem>[].obs;
  RxBool isListLoading = false.obs;
  RxString currentTab = "All".obs; // "All", "Requested", "Assigned", "Completed", "Cancelled"

  final List<String> statusTabs = [
    "All",
    "Requested",
    "Assigned",
    "Completed",
    "Cancelled",
  ];

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  @override
  void onClose() {
    reasonController.dispose();
    cancelReasonController.dispose();
    super.onClose();
  }

  void initForm({VisitingConsultantData? preselectedConsultant}) {
    visitType.value = "OPD";
    priority.value = "Routine";
    selectedConsultant.value = preselectedConsultant;
    preferredDate.value = DateTime.now().add(const Duration(days: 1));
    preferredTimeSlot.value = standardSlots[1]; // default 10:00 AM - 11:00 AM
    reasonController.clear();
  }

  void setVisitType(String type) {
    visitType.value = type;
  }

  void setPriority(String prio) {
    priority.value = prio;
  }

  void setPreferredDate(DateTime date) {
    preferredDate.value = date;
  }

  void setTimeSlot(String slot) {
    preferredTimeSlot.value = slot;
  }

  Future<bool> submitRequest() async {
    isSubmitting.value = true;
    try {
      String? formattedDate;
      if (preferredDate.value != null) {
        formattedDate = DateFormat('yyyy-MM-dd').format(preferredDate.value!);
      }

      final payload = CreateVisitingRequestPayload(
        visitType: visitType.value,
        visitingConsultantId: selectedConsultant.value?.id,
        preferredDate: formattedDate,
        preferredTimeSlot: preferredTimeSlot.value.isNotEmpty ? preferredTimeSlot.value : null,
        priority: priority.value,
        reason: reasonController.text.trim().isNotEmpty ? reasonController.text.trim() : null,
      );

      final result = await _service.createVisitingRequest(payload);
      if (result.success == true) {
        Get.snackbar(
          "Request Submitted",
          "Your visiting consultant request has been placed successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade700,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        );
        await fetchRequests();
        return true;
      } else {
        Get.snackbar(
          "Submission Failed",
          result.message ?? "Could not submit your request. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade700,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.error_outline, color: Colors.white),
        );
        return false;
      }
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> fetchRequests({String? status}) async {
    isListLoading.value = true;
    try {
      final res = await _service.getVisitingRequests(status: status);
      if (res.success == true && res.data != null) {
        requests.assignAll(res.data!);
        _filterRequestsByTab();
      } else {
        requests.clear();
        filteredRequests.clear();
      }
    } finally {
      isListLoading.value = false;
    }
  }

  void changeTab(String tab) {
    currentTab.value = tab;
    _filterRequestsByTab();
  }

  void _filterRequestsByTab() {
    if (currentTab.value == "All") {
      filteredRequests.assignAll(requests);
    } else {
      filteredRequests.assignAll(
        requests.where((r) => r.status?.toLowerCase() == currentTab.value.toLowerCase()).toList(),
      );
    }
  }

  Future<bool> cancelRequest(int id, String reason) async {
    final success = await _service.cancelVisitingRequest(id, reason);
    if (success) {
      Get.snackbar(
        "Request Cancelled",
        "Your visit request #$id has been cancelled.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      await fetchRequests();
      return true;
    } else {
      Get.snackbar(
        "Action Failed",
        "Unable to cancel this request. Only 'Requested' or 'Assigned' requests can be cancelled.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return false;
    }
  }
}
