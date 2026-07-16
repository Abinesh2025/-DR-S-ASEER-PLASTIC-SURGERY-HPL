import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/format_time_duration.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_schedule_model/doctor_schedule_update_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class SchedulesController extends GetxController {
  TextEditingController perPatientTimeController = TextEditingController();
  TextEditingController maxTokensController = TextEditingController();
  List<TextEditingController> controllerList = [];

  // Detailed token controllers lists
  List<TextEditingController> maxTokensControllers = [];
  List<TextEditingController> opdTokensControllers = [];
  List<TextEditingController> popTokensControllers = [];
  List<TextEditingController> emergencyTokensControllers = [];
  List<TextEditingController> morningTokensControllers = [];
  List<TextEditingController> afternoonTokensControllers = [];
  List<TextEditingController> nightTokensControllers = [];
  List<TextEditingController> morningPopTokensControllers = [];
  List<TextEditingController> afternoonPopTokensControllers = [];
  List<TextEditingController> nightPopTokensControllers = [];

  RxBool gotData = false.obs;
  RxBool isTokenBased = false.obs;
  RxBool useSlots = true.obs;
  RxBool isLoading = false.obs;
  RxInt tokenBlockOption = 0.obs;

  List<TextEditingController> morningEmergencyControllers = [];
  List<TextEditingController> afternoonEmergencyControllers = [];
  List<TextEditingController> nightEmergencyControllers = [];

  // Stepper-based token count
  static const int minTokens = 1;
  static const int maxTokensLimit = 200;
  RxInt maxTokens = 1.obs;

  void showMaxTokenPickerDialog(BuildContext context) {
    int selectedValue = maxTokens.value;
    
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with Done button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "Select Max Tokens",
                     style: TextStyleConst.boldTextStyle(Colors.black87, 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Done",
                      style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 16),
                    ),
                  ),
                ],
              ),
            ),
            // Picker
            SizedBox(
              height: 200,
              child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(initialItem: selectedValue - 1),
                onSelectedItemChanged: (index) {
                  selectedValue = index + 1;
                  maxTokens.value = selectedValue;
                  maxTokensController.text = selectedValue.toString();
                },
                children: List.generate(maxTokensLimit, (index) {
                  return Center(
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
    );
  }

  DoctorScheduleModel? doctorScheduleModel;

  void updateSchedules() {
    List<Map<String, dynamic>> scheduleDays = [];

    for (int i = 0; i < (doctorScheduleModel?.data?.schedule?.length ?? 0); i++) {
      scheduleDays.add({
        "available_on": doctorScheduleModel?.data?.schedule?[i].available_on ?? "",
        "available_from": controllerList[i * 2].text,
        "available_to": controllerList[(i * 2) + 1].text,
        "use_slots": useSlots.value,
        "morning_tokens": int.tryParse(morningTokensControllers[i].text) ?? 0,
        "afternoon_tokens": int.tryParse(afternoonTokensControllers[i].text) ?? 0,
        "night_tokens": int.tryParse(nightTokensControllers[i].text) ?? 0,
        "opd_tokens": int.tryParse(opdTokensControllers[i].text) ?? 0,
        "morning_pop_tokens": int.tryParse(morningPopTokensControllers[i].text) ?? 0,
        "afternoon_pop_tokens": int.tryParse(afternoonPopTokensControllers[i].text) ?? 0,
        "night_pop_tokens": int.tryParse(nightPopTokensControllers[i].text) ?? 0,
        "pop_tokens": int.tryParse(popTokensControllers[i].text) ?? 0,
        "max_tokens": int.tryParse(maxTokensControllers[i].text) ?? 0,
        "morning_emergency_tokens": 0,
        "afternoon_emergency_tokens": 0,
        "night_emergency_tokens": 0,
      });
    }

    Map<String, dynamic> data = {
      "schedule_type": isTokenBased.value ? "token_based" : "time_based",
      "per_patient_time": perPatientTimeController.text,
      "token_block_option": tokenBlockOption.value,
      "schedule_days": scheduleDays,
    };

    if (isTokenBased.value) {
      data["max_tokens_per_day"] = maxTokens.value;
    }

    isLoading.value = true;
    // CommonLoader.showLoader();
    StringUtils.client.scheduleUpdate(PreferenceUtils.getStringValue("token"), data)
      ..then((value) {
        isLoading.value = false;
        // Get.back();
        getSchedules();
        DisplaySnackBar.displaySnackBar("Schedules updated successfully", 3, ColorConst.greenColor);
      })
      ..onError((DioException error, stackTrace) {
        isLoading.value = false;
        Get.back();
        CheckSocketException.checkSocketException(error);
        return DoctorScheduleUpdateModel();
      });
  }

  void showTimePickerDialog(BuildContext context, int? index, String time) {
    String hour = "00";
    String minutes = "00";
    String seconds = "00";
    
    if (time.isNotEmpty && time.contains(":")) {
      List<String> parts = time.split(":");
      if (parts.length >= 3) {
        hour = parts[0];
        minutes = parts[1];
        seconds = parts[2];
      }
    }
    
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFefeff4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text("Cancel", style: TextStyle(color: Colors.red)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child:  Text("Done", style: TextStyleConst.boldTextStyle( ColorConst.primaryColor ,14)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: CupertinoTimerPicker(
                  initialTimerDuration: Duration(
                    hours: int.tryParse(hour) ?? 0,
                    minutes: int.tryParse(minutes) ?? 0,
                    seconds: int.tryParse(seconds) ?? 0,
                  ),
                  onTimerDurationChanged: (value) {
                    if (index != null) {
                      controllerList[index].text = FormatTimeDuration.showDuration(value);
                    } else {
                      perPatientTimeController.text = FormatTimeDuration.showDuration(value);
                    }
                    gotData.refresh();
                  },
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void getSchedules() {
    gotData.value = false;
    StringUtils.client.schedule(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorScheduleModel = value;
        int scheduleCount = doctorScheduleModel?.data?.schedule?.length ?? 0;
        controllerList = List.generate(scheduleCount * 2, (index) => TextEditingController());
        maxTokensControllers = List.generate(scheduleCount, (index) => TextEditingController());
        opdTokensControllers = List.generate(scheduleCount, (index) => TextEditingController());
        popTokensControllers = List.generate(scheduleCount, (index) => TextEditingController());
        emergencyTokensControllers = List.generate(scheduleCount, (index) => TextEditingController());
        morningTokensControllers = List.generate(scheduleCount, (index) => TextEditingController());
        afternoonTokensControllers = List.generate(scheduleCount, (index) => TextEditingController());
        nightTokensControllers = List.generate(scheduleCount, (index) => TextEditingController());
        morningPopTokensControllers = List.generate(scheduleCount, (index) => TextEditingController());
        afternoonPopTokensControllers = List.generate(scheduleCount, (index) => TextEditingController());
        nightPopTokensControllers = List.generate(scheduleCount, (index) => TextEditingController());
        morningEmergencyControllers = List.generate(scheduleCount, (index) => TextEditingController());
        afternoonEmergencyControllers = List.generate(scheduleCount, (index) => TextEditingController());
        nightEmergencyControllers = List.generate(scheduleCount, (index) => TextEditingController());

        perPatientTimeController.text = doctorScheduleModel?.data?.per_patient_time ?? "";
        
        // Set schedule type from server response
        if (doctorScheduleModel?.data?.slot_type == "token_based" || doctorScheduleModel?.data?.schedule_type == "token_based") {
          isTokenBased.value = true;
        } else {
          isTokenBased.value = false;
        }
        
        // Set max tokens (legacy global value)
        int serverTokens = doctorScheduleModel?.data?.max_tokens_per_day ?? 0;
        if (serverTokens < minTokens) serverTokens = minTokens;
        if (serverTokens > maxTokensLimit) serverTokens = maxTokensLimit;
        maxTokens.value = serverTokens;
        maxTokensController.text = serverTokens.toString();
        
        for (int i = 0; i < scheduleCount; i++) {
          var s = doctorScheduleModel?.data?.schedule?[i];
          controllerList[i * 2].text = s?.available_from ?? "";
          controllerList[(i * 2) + 1].text = s?.available_to ?? "";
          
          // New detailed fields
          maxTokensControllers[i].text = s?.max_tokens?.toString() ?? "0";
          opdTokensControllers[i].text = s?.opd_tokens?.toString() ?? "0";
          popTokensControllers[i].text = s?.pop_tokens?.toString() ?? "0";
          emergencyTokensControllers[i].text = s?.emergency_tokens?.toString() ?? "0";
          morningTokensControllers[i].text = s?.morning_tokens?.toString() ?? "0";
          afternoonTokensControllers[i].text = s?.afternoon_tokens?.toString() ?? "0";
          nightTokensControllers[i].text = s?.night_tokens?.toString() ?? "0";
          morningPopTokensControllers[i].text = s?.morning_pop_tokens?.toString() ?? "0";
          afternoonPopTokensControllers[i].text = s?.afternoon_pop_tokens?.toString() ?? "0";
          nightPopTokensControllers[i].text = s?.night_pop_tokens?.toString() ?? "0";
          morningEmergencyControllers[i].text = s?.morning_emergency_tokens?.toString() ?? "0";
          afternoonEmergencyControllers[i].text = s?.afternoon_emergency_tokens?.toString() ?? "0";
          nightEmergencyControllers[i].text = s?.night_emergency_tokens?.toString() ?? "0";
        }

        gotData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        gotData.value = true;
        CheckSocketException.checkSocketException(error);
        return DoctorScheduleModel();
      });
  }

  @override
  void onInit() {
    super.onInit();
    getSchedules();
  }

  void showPerPatientTimePickerDialog(BuildContext context) {
    Duration initialDuration = const Duration(minutes: 15);
    String currentTime = perPatientTimeController.text;
    if (currentTime.isNotEmpty && currentTime.contains(":")) {
      List<String> parts = currentTime.split(":");
      if (parts.length >= 3) {
        initialDuration = Duration(
          hours: int.tryParse(parts[0]) ?? 0,
          minutes: int.tryParse(parts[1]) ?? 0,
          seconds: int.tryParse(parts[2]) ?? 0,
        );
      }
    }

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hms,
                  initialTimerDuration: initialDuration,
                  onTimerDurationChanged: (Duration duration) {
                    perPatientTimeController.text = formatDuration(duration);
                    gotData.refresh();
                  },
                ),
              ),
              CupertinoButton(
                child: const Text("Done"),
                onPressed: () {
                  // Ensure current value is set if changed
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
