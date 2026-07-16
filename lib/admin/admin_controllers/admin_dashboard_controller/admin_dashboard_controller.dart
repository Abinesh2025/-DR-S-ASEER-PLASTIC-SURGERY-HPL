import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/admin_dashboard_model/admin_dashboard_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class AdminDashboardController extends GetxController {
  AdminDashboardModel? adminDashboardModel;
  RxBool isGetData = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAdminDashboardData();
  }

  void getAdminDashboardData() {
    StringUtils.client.getAdminDashboardData(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        adminDashboardModel = value;
        isGetData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return AdminDashboardModel();
      });
  }

  String formatRevenues(double revenue) {
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

}
