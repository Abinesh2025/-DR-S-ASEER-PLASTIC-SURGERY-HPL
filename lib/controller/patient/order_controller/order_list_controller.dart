import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/order_model/order_response_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class OrderListController extends GetxController {
  RxBool isLoading = false.obs;
  OrderResponseModel? orderResponseModel;
  RxList<OrderDataModel> orders = <OrderDataModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getOrdersData();
  }

  Future<void> getOrdersData() async {
    isLoading.value = true;
    try {
      final value = await StringUtils.client.getOrders(PreferenceUtils.getStringValue("token"));
      orderResponseModel = value;
      if (orderResponseModel?.success == true && orderResponseModel?.data != null) {
        orders.value = orderResponseModel!.data!;
      } else {
        orders.clear();
      }
    } on DioException catch (error) {
      CheckSocketException.checkSocketException(error);
    } finally {
        update();
      isLoading.value = false;
    }
  }
}
