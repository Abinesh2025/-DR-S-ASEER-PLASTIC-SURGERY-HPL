import 'dart:io';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart'; // REQUIRED for MediaType
import '../../../api_request/api_request.dart';
import '../../../utils/string_utils.dart';
import '../../../model/push_notification/regular_update_model.dart';
import 'package:flutter/material.dart';

class RegularUpdateController extends GetxController {
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var isSaving = false.obs;
  var updatesList = <RegularUpdateData>[].obs;

  // Pagination Observables
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var total = 0.obs;

  // Observables for the Add Form
  var selectedImage = Rxn<File>();
  final picker = ImagePicker();

  // Scroll Controller for Infinite Scrolling
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    print("DEBUG: RegularUpdateController Init");
    fetchUpdates(page: 1); // Initial load
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void clearFields() {
    selectedImage.value = null;
    isSaving.value = false;
  }

  String _getToken() => " ${PreferenceUtils.getStringValue('token')}";
  ApiClient get _client => StringUtils.client;

  Future<void> fetchUpdates({int page = 1, bool isLoadMore = false, bool isManualRefresh = false}) async {
    print("DEBUG: fetchUpdates(page: $page, isLoadMore: $isLoadMore)");
    
    if (page == 1 && !isLoadMore) {
       if (!isManualRefresh) {
         isLoading(true);
         updatesList.clear(); 
       }
    } else if (isLoadMore) {
      isMoreLoading(true);
    }

    try {
      currentPage.value = page;
      var response = await _client.getRegularUpdates(
        _getToken(),
        10,
        page,
        null,
      );
      
      if (response.success == true && response.data != null) {
        var paginator = response.data!;
        var items = paginator.data ?? [];
        
        print("DEBUG: API Response - Page $page. Length: ${items.length}, LastPage reported: ${paginator.lastPage}");
        
        if (isLoadMore) {
          updatesList.addAll(items);
        } else {
          updatesList.assignAll(items);
        }
        
        currentPage.value = paginator.currentPage ?? 1;
        lastPage.value = paginator.lastPage ?? 1;
        total.value = paginator.total ?? 0;
        
        // --- SPECULATIVE PAGING (Failsafe) ---
        // If we got exactly 10 items but the API claims there's only 1 page, 
        // we'll "hope" there's more and allow a page-2 request.
        if (updatesList.length == 10 && lastPage.value == 1) {
           lastPage.value = 2; 
        }
        
        updatesList.refresh();
      } else {
        print("DEBUG: API SUCCESS: FALSE or Data NULL.");
        if (isLoadMore) Get.snackbar("End of List", "No more items found", snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1));
      }
    } catch (e) {
      print("CRITICAL: fetchUpdates Error: $e");
      String errorMsg = "Failed to load page $page";
      if (e is dio.DioException) {
         errorMsg = "Sync Error: ${e.response?.statusCode} ${e.response?.statusMessage}";
      }
      Get.snackbar("Network Error", errorMsg, 
          backgroundColor: Colors.redAccent, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
      isMoreLoading(false);
    }
  }

  Future<void> loadMore() async {
    if (isMoreLoading.value) return;
    
    if (currentPage.value >= lastPage.value) {
       print("DEBUG: loadMore SKIPPED - End reached (${currentPage.value}/${lastPage.value})");
       return;
    }

    print("DEBUG: loadMore triggering API for page ${currentPage.value + 1}");
    await fetchUpdates(page: currentPage.value + 1, isLoadMore: true);
  }

  Future<void> refreshUpdates() async {
    currentPage.value = 1;
    updatesList.clear();
    await Future.delayed(const Duration(milliseconds: 500));
    await fetchUpdates(page: 1, isLoadMore: false, isManualRefresh: true);
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image", snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addUpdate({
    required String title,
    required String desc,
  }) async {
    if (title.isEmpty) {
      Get.snackbar("Required", "Title is required", snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (selectedImage.value == null) {
      Get.snackbar("Error", "Please select an image", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      isSaving(true);
      String filePath = selectedImage.value!.path;
      String fileName = filePath.split('/').last;
      String extension = fileName.split('.').last.toLowerCase();
      
      String mimeType = "image/jpeg";
      if (extension == "png") mimeType = "image/png";
      if (extension == "gif") mimeType = "image/gif";
      if (extension == "webp") mimeType = "image/webp";

      dio.MultipartFile multipartImage = await dio.MultipartFile.fromFile(
        filePath,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      );

      await _client.createRegularUpdate(
        _getToken(),
        title,
        desc,
        multipartImage,
      );

      clearFields();
      await fetchUpdates(page: 1, isLoadMore: false, isManualRefresh: false); 
      Get.back();
      Get.snackbar("Success", "Regular update saved successfully.", 
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print("Error creating update: $e");
      Get.snackbar("Error", "Failed to create update. Please check your connection.",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSaving(false);
    }
  }

  Future<void> deleteUpdate(int id) async {
    try {
      await _client.deleteRegularUpdate(_getToken(), id);
      updatesList.removeWhere((item) => item.id == id);
      updatesList.refresh();
      Get.snackbar("Success", "Update removed successfully",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete update", snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> resendNotification(int id) async {
    try {
      await _client.resendUpdateNotification(_getToken(), id);
      Get.snackbar("Notification", "Alerts resent to all patients",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Failed to resend notification", snackPosition: SnackPosition.BOTTOM);
    }
  }
}