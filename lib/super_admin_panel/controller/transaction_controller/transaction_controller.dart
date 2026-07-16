import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/transaction_model/filter_transaction_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/transaction_model/transaction_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class TransactionController extends GetxController {
  TransactionModel? transactionModel;
  FilterTransactionModel? filterTransactionModel;
  RxBool isGetTransaction = false.obs;

  RxList transactionStatus = ["All", "Paytm", "Paypal", "Stripe", "RazorPay", "PayStack", "Manual"].obs;
  RxInt currentIndex = 0.obs;

  @override
void onInit() {
  // TODO: implement onInit
  super.onInit();
    if (currentIndex.value == 0) {
      getFilterTransactions("all");
    }
}
  void changeIndex(int index) {
    isGetTransaction.value = false;
    switch (index) {
      case 0:
        currentIndex.value = 0;
        getFilterTransactions("all");
        break;
      case 1:
        currentIndex.value = 1;
        getFilterTransactions("paytm");
        break;
      case 2:
        currentIndex.value = 2;
        getFilterTransactions("paypal");
        break;
      case 3:
        currentIndex.value = 3;
        getFilterTransactions("stripe");
        break;
      case 4:
        currentIndex.value = 4;
        getFilterTransactions("razorpay");
        break;
      case 5:
        currentIndex.value = 5;
        getFilterTransactions("paystack");
        break;
      case 6:
        currentIndex.value = 6;
        getFilterTransactions("manual");
        break;
    }
  }

  void getFilterTransactions(String filter) {
    StringUtils.client.getFilterTransactions(PreferenceUtils.getStringValue("token"), filter).then((value) {
      filterTransactionModel = value;
      isGetTransaction.value = true;
    }).onError((DioException error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }
}
