
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/subscription_model/subscription_models.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/subscription_model/update_subscription_model/update_subscription_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:intl/intl.dart';

class EditSubscriptionController extends GetxController{

  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController expiresOnController = TextEditingController();
  final TextEditingController smsLimitController = TextEditingController();

  String? startDate;
  String? startTime;
  String? expireDate;
  String? expireTime;
  String status = "";
  String frequency = "";

  SubscriptionModel? subscriptionModel;

   RxBool gotData = false.obs;
  var arguments = Get.arguments;


  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime.now();
    TimeOfDay initialTime = TimeOfDay.now();

    try {
      if (expireDate!.isNotEmpty) {
        DateTime parsedInitialDate = parseDate(expireDate!);
        initialDate = parsedInitialDate;
      }

      if (expireTime!.isNotEmpty) {
        initialTime = parseTime(expireTime!);
      }
    } catch (e) {
      print('Error parsing initial date or time: $e');
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (pickedDate != null) {
      if (!context.mounted) return;

      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (pickedTime != null) {
        DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        String formattedDateTime = DateFormat('h:mm a d MMM, yyyy').format(pickedDateTime);
        controller.text = formattedDateTime;
      }
    }
  }

  DateTime parseDate(String dateString) {

    dateString = dateString.replaceAll(',', ' ');


    Map<String, int> months = {
      'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4,
      'May': 5, 'Jun': 6, 'Jul': 7, 'Aug': 8,
      'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
    };


    List<String> components = dateString.split(' ');
    if (components.length != 3) {
      throw FormatException('Invalid date format: $dateString');
    }


    String dayString = components[0].replaceAll(RegExp(r'[^\d]'), '');
    int day = int.parse(dayString);


    int month = months[components[1]]!;
    int year = int.parse(components[2]);
    return DateTime(year, month, day);
  }

  TimeOfDay parseTime(String time) {
    RegExp timeRegExp = RegExp(r'\d{1,2}:\d{1,2} [APMapm]+');
    Match? timeMatch = timeRegExp.firstMatch(time);
    String matchedTime = timeMatch?.group(0) ?? '00:00 AM';

    int hour = int.tryParse(matchedTime.split(':')[0]) ?? 0;
    int minute = int.tryParse(matchedTime.split(':')[1].split(' ')[0]) ?? 0;

    return TimeOfDay(hour: hour, minute: minute);
  }

  void editSubscription(int subId) {
     if (expiresOnController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please select end date", 3 , ColorConst.redColor);
    } else if (smsLimitController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter SMS limit", 3 , ColorConst.redColor);
    } else {
        CommonLoader.showLoader();

        StringUtils.client.updateSubscriptions(
          PreferenceUtils.getStringValue("token"),
          subId.toString(),
          expiresOnController.text.trim(),
          smsLimitController.text.trim()
        )
          ..then((value) {
            Get.back();
            Get.back(result: "Call API");
            DisplaySnackBar.displaySnackBar("Subscription updated successfully", 3, ColorConst.greenColor);
          })
          ..onError((DioException error, stackTrace) {
            Get.back();
            Get.back();
            CheckSocketException.checkSocketException(error);
            return UpdateSubscriptionModel();
          });
    }
  }

  void getSubscriptionDetail() {
    StringUtils.client.getSubscriptions(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        subscriptionModel = value;
        hospitalNameController.text = arguments["hospital_name"];
        planNameController.text = arguments["subscription_plan_name"];
        status = arguments["status"];
        frequency = "${arguments["plan_frequency"]}";

        startDate = arguments["start_date"];
        startTime = arguments["start_time"];
        startDateController.text = "$startTime $startDate";

        expireDate = arguments["expire_date"];
        expireTime = arguments["expire_time"];
        expiresOnController.text = "$expireTime $expireDate";

        smsLimitController.text = arguments["sms_limit"];
        gotData.value = true;
      })
      ..onError((error, stackTrace) {
        gotData.value = true;
        return SubscriptionModel();
      });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSubscriptionDetail();
  }
}

