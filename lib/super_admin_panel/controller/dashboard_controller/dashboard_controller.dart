import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/dashboard/dashboard_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/dashboard/income_chart_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DashboardController extends GetxController {
  DashBoardModel? dashBoardModel;
  IncomeModel? incomeModel;
  RxList<IncomeData> incomeData = <IncomeData>[].obs;
  RxBool isGetDetails = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getDashboardData();
    await getIncomeDataForCurrentWeek();
  }


  Future<void> getDashboardData() async {
    try {
      dashBoardModel = await StringUtils.client.getDashboardData(PreferenceUtils.getStringValue("token"));
      if (dashBoardModel != null) {
        isGetDetails.value = true;
        update();
      }
    } catch (error) {
      isGetDetails.value = false;
    }
  }

  String formatRevenue(double revenue) {
    if (revenue >= 1000000) {
      double formattedRevenue = revenue / 1000000;
      return '${formattedRevenue.toStringAsFixed(2)}M';
    } else if (revenue >= 1000) {
      double formattedRevenue = revenue / 1000;
      return '${formattedRevenue.toStringAsFixed(2)}K';
    } else {
      return revenue.toString();
    }
  }

  Future<void> getIncomeDataForCurrentWeek() async {
    try {
      DateTime now = DateTime.now();
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

      String startDate = "${startOfWeek.day}-${startOfWeek.month}-${startOfWeek.year}";
      String endDate = "${endOfWeek.day}-${endOfWeek.month}-${endOfWeek.year}";

      await getIncomeData(startDate, endDate);
    } catch (error) {
      Text("Error fetching income data for the current week: $error");
    }
  }


  Future<void> getIncomeData(String startDate, String endDate) async {
    isGetDetails.value = false;
    StringUtils.client.getIncomeData(PreferenceUtils.getStringValue("token"), startDate , endDate)
      ..then((value) {
        List<IncomeData>? incomeList = value.data;
        if (incomeList != null && incomeList.isNotEmpty) {
          incomeData.assignAll(incomeList);
        }
        isGetDetails.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return IncomeModel(success: false, data: [], message: "Error fetching income data");
      });
  }

  Future<void> showDatePicker(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      String startDate = "${picked.start.day}-${picked.start.month}-${picked.start.year}";
      String endDate = "${picked.end.day}-${picked.end.month}-${picked.end.year}";

      getIncomeData(startDate, endDate);
    }
  }
}
