import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/dashboard/doctor_dashboard_model.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';

import '../../../api_request/api_request.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/string_utils.dart';

class DoctorDashboardController extends GetxController {
  // Observables for Stats
  var isStatsLoading = true.obs;
  var dashboardData = Rxn<DoctorDashboardModel>();

  // Observables for Schedule
  var isScheduleLoading = true.obs;
  var todayScheduleList = <ScheduleData>[].obs;

  // Observables for Recent Patients
  var isRecentPatientsLoading = true.obs;
  var recentPatientsList = <RecentPatientData>[].obs;

  // Scroll Controller (Fixes your error!)
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  @override
  void onClose() {
    scrollController.dispose(); // Always dispose of controllers to prevent memory leaks
    super.onClose();
  }

  // Pull-to-refresh method that fetches everything concurrently
  Future<void> refreshData() async {
    await Future.wait([
      fetchDashboardStatistics(),
      fetchTodaySchedule(),
      fetchRecentPatients(),
    ]);
  }

  Future<void> fetchDashboardStatistics() async {
    try {
      isStatsLoading(true);

      String token = PreferenceUtils.getStringValue("token");
      final response = await StringUtils.client.getDoctorDashboardStatistics(" $token");

      dashboardData.value = response;
    } catch (e) {
      print("Error fetching dashboard statistics: $e");
    } finally {
      isStatsLoading(false);
    }
  }

  Future<void> fetchTodaySchedule() async {
    try {
      isScheduleLoading(true);

      String token = PreferenceUtils.getStringValue("token");
      final response = await StringUtils.client.getDoctorTodaySchedule(" $token");

      if (response.success == true && response.data != null) {
        todayScheduleList.assignAll(response.data!);
      }
    } catch (e) {
      print("Error fetching today schedule: $e");
    } finally {
      isScheduleLoading(false);
    }
  }

  Future<void> fetchRecentPatients() async {
    try {
      isRecentPatientsLoading(true);

      String token = PreferenceUtils.getStringValue("token");
      final response = await StringUtils.client.getDoctorRecentPatients("Bearer $token");

      if (response.success == true && response.data != null) {
        recentPatientsList.assignAll(response.data!);
      }
    } catch (e) {
      print("Error fetching recent patients: $e");
    } finally {
      isRecentPatientsLoading(false);
    }
  }
}