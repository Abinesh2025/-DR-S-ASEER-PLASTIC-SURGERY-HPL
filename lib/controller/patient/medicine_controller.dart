import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_category_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/medicine_category_detail_model.dart';

class MedicineController extends GetxController {
  RxList<MedicineModel> medicines = <MedicineModel>[].obs;
  RxList<MedicineModel> filteredMedicines = <MedicineModel>[].obs;
  RxList<MedicineCategoryModel> categories = <MedicineCategoryModel>[].obs;

  // Update to use the new Detail Data model
  Rx<MedicineCategoryDetailData?> selectedCategoryDetails =
      Rx<MedicineCategoryDetailData?>(null);

  Rx<int?> selectedCategoryId = Rx<int?>(null);
  RxBool isLoading = true.obs;
  RxBool isCategoriesLoading = true.obs;
  RxBool isCategoryDetailsLoading = true.obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();
    fetchCategories();
  }


  Future<void> fetchCategories() async {
    isCategoriesLoading.value = true;
    try {
      final response = await StringUtils.client
          .getMedicineCategories(PreferenceUtils.getStringValue("token"));

      if (response.success == true) {
        categories.value = response.data ?? [];
      }
    } catch (e) {
      debugPrint("Categories Fetch Error: $e");
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  Future<void> fetchCategoryDetails(int id) async {
    isCategoryDetailsLoading.value = true;
    selectedCategoryDetails.value = null;
    try {
      // Use ApiClient
      final response = await StringUtils.client.getMedicineCategoryDetails(
          PreferenceUtils.getStringValue("token"), id);

      if (response.success == true && response.data != null) {
        selectedCategoryDetails.value = response.data;
      }
    } catch (e) {
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
      debugPrint("Category Details Fetch Error: $e");
    } finally {
      isCategoryDetailsLoading.value = false;
    }
  }

  Future<void> fetchMedicines() async {
    isLoading.value = true;

    try {
      final response = await StringUtils.dio.get(
        "${StringUtils.domainUrl}api/medicines",
        options: Options(headers: {
          'Authorization': PreferenceUtils.getStringValue("token"),
          'X-HOSPITAL': ConfigUtils.hospitalSku,
        }),
      );

      if (response.statusCode == 200) {
        final parsed = MedicineListResponse.fromJson(response.data);
        if (parsed.success) {
          medicines.value = parsed.data;
          filteredMedicines.value = parsed.data;
        }
      }
    } catch (e) {
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
      debugPrint("Medicines Fetch Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void searchMedicines(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void selectCategory(int? categoryId) {
    if (selectedCategoryId.value == categoryId) {
      selectedCategoryId.value = null; // Deselect if already selected
    } else {
      selectedCategoryId.value = categoryId;
    }
    _applyFilters();
  }

  void _applyFilters() {
    List<MedicineModel> temp = medicines;

    // Apply Category Filter
    if (selectedCategoryId.value != null) {
      temp =
          temp.where((m) => m.categoryId == selectedCategoryId.value).toList();
    }

    // Apply Search Filter
    String query = searchQuery.value;
    if (query.isNotEmpty) {
      temp = temp
          .where((m) =>
              m.name.toLowerCase().contains(query.toLowerCase()) ||
              (m.categoryName?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (m.brandName?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (m.saltComposition?.toLowerCase().contains(query.toLowerCase()) ??
                  false))
          .toList();
    }

    filteredMedicines.value = temp;
  }
}
