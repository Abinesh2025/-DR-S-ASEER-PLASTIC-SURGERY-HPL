import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_consultant_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/services/visiting_consultant_service.dart';

class VisitingConsultantController extends GetxController {
  final VisitingConsultantService _service = VisitingConsultantService();

  RxBool isLoading = false.obs;
  RxBool isDetailLoading = false.obs;
  RxList<VisitingConsultantData> allConsultants = <VisitingConsultantData>[].obs;
  RxList<VisitingConsultantData> filteredConsultants = <VisitingConsultantData>[].obs;
  RxList<String> departments = <String>["All"].obs;
  RxString selectedDepartment = "All".obs;
  RxString searchQuery = "".obs;

  Rxn<VisitingConsultantData> selectedConsultant = Rxn<VisitingConsultantData>();

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchConsultants();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchConsultants() async {
    isLoading.value = true;
    try {
      final res = await _service.getVisitingConsultants();
      if (res.success == true && res.data != null) {
        allConsultants.assignAll(res.data!);
        _extractDepartments();
        applyFilter();
      } else {
        allConsultants.clear();
        filteredConsultants.clear();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _extractDepartments() {
    final Set<String> deptSet = {};
    for (var doc in allConsultants) {
      final dept = doc.department?.trim();
      if (dept != null &&
          dept.isNotEmpty &&
          dept.toLowerCase() != "general") {
        deptSet.add(dept);
      }
      final spec = doc.specialty?.trim();
      if (spec != null &&
          spec.isNotEmpty &&
          spec.toLowerCase() != "consultant" &&
          spec.toLowerCase() != "general") {
        deptSet.add(spec);
      }
    }

    // Only show filter chips if there are meaningful department/specialty categories to filter by
    if (deptSet.isNotEmpty) {
      departments.assignAll(["All", ...deptSet.toList()]);
    } else {
      departments.clear();
    }
  }

  void selectDepartment(String dept) {
    if (selectedDepartment.value.toLowerCase() == dept.toLowerCase() && dept.toLowerCase() != "all") {
      selectedDepartment.value = "All"; // Clicking active chip unselects it back to All
    } else {
      selectedDepartment.value = dept;
    }
    applyFilter();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query.trim().toLowerCase();
    applyFilter();
  }

  void applyFilter() {
    List<VisitingConsultantData> list = List.from(allConsultants);

    // Department/Specialty filter
    if (selectedDepartment.value != "All") {
      final target = selectedDepartment.value.trim().toLowerCase();
      list = list.where((doc) {
        final d = (doc.department ?? "").trim().toLowerCase();
        final s = (doc.specialty ?? "").trim().toLowerCase();
        return d == target || s == target;
      }).toList();
    }

    // Search query filter
    if (searchQuery.value.isNotEmpty) {
      final q = searchQuery.value;
      list = list.where((doc) {
        final name = (doc.name ?? "").toLowerCase();
        final spec = (doc.specialty ?? "").toLowerCase();
        final dept = (doc.department ?? "").toLowerCase();
        final qual = (doc.qualification ?? "").toLowerCase();
        return name.contains(q) || spec.contains(q) || dept.contains(q) || qual.contains(q);
      }).toList();
    }

    filteredConsultants.assignAll(list);
  }

  Future<void> fetchConsultantDetail(int id) async {
    isDetailLoading.value = true;
    try {
      final res = await _service.getVisitingConsultantDetail(id);
      if (res.success == true && res.data != null) {
        selectedConsultant.value = res.data;
      }
    } finally {
      isDetailLoading.value = false;
    }
  }
}
