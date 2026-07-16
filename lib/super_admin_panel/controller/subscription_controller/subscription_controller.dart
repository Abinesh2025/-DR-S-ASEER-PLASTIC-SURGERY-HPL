
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/subscription_model/filter_subscription_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/subscription_model/subscription_models.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class SubscriptionController extends GetxController {
  SubscriptionModel? subscriptionModel;
  FilterSubscriptionModel? filterSubscriptionModel;
  RxBool isGetSubscription = false.obs;

  RxList subscriptionStatus = ["All", "Active", "Deactive"].obs;
  RxInt currentIndex = 0.obs;

  @override
void onInit() {
  // TODO: implement onInit
  super.onInit();
  if (currentIndex.value == 0) {
    getFilterSubscription("all");
  }
}

  void changeIndex(int index) {
    isGetSubscription.value = false;
    switch (index) {
      case 0:
        currentIndex.value = 0;
        getFilterSubscription("all");
        break;
      case 1:
        currentIndex.value = 1;
        getFilterSubscription("active");
        break;
      case 2:
        currentIndex.value = 2;
        getFilterSubscription("deactive");
        break;
    }
  }

  void getFilterSubscription(String filter) {
    StringUtils.client.getFilterSubscription(PreferenceUtils.getStringValue("token"), filter).then((value) {
      filterSubscriptionModel = value;
      isGetSubscription.value = true;
    }).onError((DioException error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }

}
