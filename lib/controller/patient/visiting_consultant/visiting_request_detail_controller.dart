import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_bill_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_request_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_summary_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/services/visiting_consultant_service.dart';

class VisitingRequestDetailController extends GetxController {
  final VisitingConsultantService _service = VisitingConsultantService();

  Rxn<VisitingRequestItem> requestDetail = Rxn<VisitingRequestItem>();
  RxBool isLoading = false.obs;

  // Bill state
  Rxn<VisitingBillData> billData = Rxn<VisitingBillData>();
  RxBool isBillLoading = false.obs;
  RxBool isPaying = false.obs;

  // Summary state
  Rxn<VisitingSummaryData> summaryData = Rxn<VisitingSummaryData>();
  RxBool isSummaryLoading = false.obs;

  // Payment Form
  RxString selectedPaymentMode = "UPI / Online".obs;
  final TextEditingController transactionNotesController = TextEditingController();

  final List<String> availablePaymentModes = [
    "UPI / Online",
    "Cash",
    "Card",
    "Cheque",
  ];

  @override
  void onClose() {
    transactionNotesController.dispose();
    super.onClose();
  }

  Future<void> loadAllDetails(int requestId) async {
    await fetchRequestDetail(requestId);
    fetchBill(requestId);
    if (requestDetail.value?.isCompleted == true) {
      fetchSummary(requestId);
    }
  }

  Future<void> fetchRequestDetail(int id) async {
    isLoading.value = true;
    try {
      final res = await _service.getVisitingRequestDetail(id);
      if (res.success == true && res.data != null) {
        requestDetail.value = res.data;
        if (res.data!.bill != null) {
          billData.value = res.data!.bill;
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBill(int requestId) async {
    isBillLoading.value = true;
    try {
      final res = await _service.getVisitingRequestBill(requestId);
      if (res.success == true && res.data != null) {
        billData.value = res.data;
      }
    } finally {
      isBillLoading.value = false;
    }
  }

  Future<bool> recordPayment(int requestId) async {
    isPaying.value = true;
    try {
      final payload = RecordPaymentPayload(
        paymentMode: selectedPaymentMode.value,
        notes: transactionNotesController.text.trim().isNotEmpty
            ? transactionNotesController.text.trim()
            : null,
      );

      final success = await _service.payVisitingRequest(requestId, payload);
      if (success) {
        Get.snackbar(
          "Payment Recorded",
          "Payment via ${selectedPaymentMode.value} has been updated.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade700,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        );
        transactionNotesController.clear();
        await fetchBill(requestId);
        await fetchRequestDetail(requestId);
        return true;
      } else {
        Get.snackbar(
          "Payment Failed",
          "Unable to record payment mode. Please contact hospital support.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade700,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
        return false;
      }
    } finally {
      isPaying.value = false;
    }
  }

  Future<void> fetchSummary(int requestId) async {
    isSummaryLoading.value = true;
    try {
      final res = await _service.getVisitingRequestSummary(requestId);
      if (res.success == true && res.data != null) {
        summaryData.value = res.data;
      }
    } finally {
      isSummaryLoading.value = false;
    }
  }
}
