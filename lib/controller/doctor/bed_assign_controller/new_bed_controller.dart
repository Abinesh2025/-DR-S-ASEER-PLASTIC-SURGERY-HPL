// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
// import 'package:flutter_datetime_picker_plus/src/datetime_picker_theme.dart' as picker_theme;
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/beds_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/create_new_bed_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/ipd_patients_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/patient_cases_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
//
// class NewBedController extends GetxController {
//   String? selectedDate;
//   TextEditingController dateController = TextEditingController();
//   TextEditingController notesController = TextEditingController();
//
//   RxBool gotDropDownData = false.obs;
//
//   PatientCases? patientCases;
//   IPDPatientsModel? ipdPatientsModel;
//   BedsModel? bedsModel;
//
//   String? caseId;
//   //String? patientId;
//   RxString patientId = RxString("");
//   String? bedId;
//
//   DateTime? oldDate;
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     getMyCases();
//   }
//
//   void caseChoice(String value) {
//     String id = value.split(" ").first;
//     caseId = id;
//     getIPDPatients(id);
//   }
//
//   void getMyCases() {
//     StringUtils.client.getPatientCases(PreferenceUtils.getStringValue("token"))
//       ..then((value) {
//         patientCases = value;
//         getBeds();
//         update();
//       })
//       ..onError((DioException error, stackTrace) {
//         CheckSocketException.checkSocketException(error);
//         return PatientCases();
//       });
//   }
//
//   void getIPDPatients(String caseId) {
//     StringUtils.client.getIPDModel(PreferenceUtils.getStringValue("token"), caseId)
//       ..then((value) {
//         ipdPatientsModel = value;
//         patientId.value = ((value.data?.isEmpty ?? true) ? null : value.data?[0].id.toString()) ?? "";
//         gotDropDownData.value = true;
//         getBeds();
//         update();
//       })
//       ..onError((DioException error, stackTrace) {
//         return IPDPatientsModel();
//       });
//   }
//
//   void getBeds() {
//     StringUtils.client.getBeds(PreferenceUtils.getStringValue("token"))
//       ..then((value) {
//         bedsModel = value;
//         gotDropDownData.value = true;
//       })
//       ..onError((DioException error, stackTrace) {
//         return BedsModel();
//       });
//   }
//
//   void selectAssignDate(BuildContext context) async {
//     selectedDate = (await selectDate(context)) ?? selectedDate;
//     dateController.text = selectedDate ?? "";
//   }
//
//   void createNewBedAssign() {
//     if ((patientCases?.data?.isNotEmpty ?? true) && caseId == null) {
//       DisplaySnackBar.displaySnackBar("Please select case", 3 , ColorConst.redColor);
//     } else if (bedId == null) {
//       DisplaySnackBar.displaySnackBar("Please select bed", 3 , ColorConst.redColor);
//     } else if (selectedDate == null) {
//       DisplaySnackBar.displaySnackBar("Please select date", 3 , ColorConst.redColor);
//     } else {
//       CommonLoader.showLoader();
//       StringUtils.client.createNewBedAssign(PreferenceUtils.getStringValue("token"), caseId ?? "", patientId.value, bedId, selectedDate ?? "")
//         ..then((value) {
//           Get.back();
//           if (value.success == true) {
//             Get.back(result: "Call API");
//             DisplaySnackBar.displaySnackBar("New Bed Assigned Successfully", 3, ColorConst.greenColor);
//           } else {
//             Get.back();
//           }
//         })
//         ..onError((DioException error, stackTrace) {
//           Get.back();
//           CheckSocketException.checkSocketException(error);
//           DisplaySnackBar.displaySnackBar("You Can't assign mew bed", 3 , ColorConst.redColor);
//           return CreateNewBedModel();
//         });
//     }
//   }
//
//   Future<String?> selectDate(BuildContext context) async {
//     DateTime? picked = await DatePicker.showDateTimePicker(
//       context,
//       showTitleActions: true,
//       currentTime: oldDate ?? DateTime.now(),
//       theme: picker_theme.DatePickerTheme(
//         doneStyle: const TextStyle(fontSize: 17),
//         cancelStyle: TextStyle(fontSize: 17,color: Colors.grey.shade700)
//       )
//     );
//     if (picked != null) {
//       oldDate = picked;
//       selectedDate =
//           "${picked.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day} ${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:${picked.second.toString().padLeft(2, '0')}";
//       return selectedDate ?? "";
//     } else {
//       return null;
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_datetime_picker_plus/src/datetime_picker_theme.dart' as picker_theme;
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/beds_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/create_new_bed_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/ipd_patients_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/patient_cases_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class NewBedController extends GetxController {
  String? selectedDate;
  TextEditingController dateController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  RxBool gotDropDownData = false.obs;

  PatientCases? patientCases;
  IPDPatientsModel? ipdPatientsModel;
  BedsModel? bedsModel;

  // 🔥 CHANGED TO REACTIVE VARIABLES so Obx can detect changes
  RxnString selectedCase = RxnString();
  String? caseId; // Kept for the API call

  RxnString patientId = RxnString();
  RxnString bedId = RxnString();

  DateTime? oldDate;

  @override
  void onInit() {
    super.onInit();
    getMyCases();
  }

  void caseChoice(String value) {
    selectedCase.value = value; // Update the UI
    String id = value.split(" ").first;
    caseId = id; // Save for API
    getIPDPatients(id);
  }

  void getMyCases() {
    StringUtils.client.getPatientCases(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        patientCases = value;
        getBeds();
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PatientCases();
      });
  }

  void getIPDPatients(String id) {
    StringUtils.client.getIPDModel(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        ipdPatientsModel = value;

        // Safely set the first patient as selected if the list is not empty
        if (value.data != null && value.data!.isNotEmpty) {
          patientId.value = value.data![0].id.toString();
        } else {
          patientId.value = null; // Clear if empty
        }

        gotDropDownData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        return IPDPatientsModel();
      });
  }

  void getBeds() {
    StringUtils.client.getBeds(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        bedsModel = value;
        gotDropDownData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        return BedsModel();
      });
  }

  void selectAssignDate(BuildContext context) async {
    selectedDate = (await selectDate(context)) ?? selectedDate;
    dateController.text = selectedDate ?? "";
  }

  // Pass the initialBedId from the UI just in case the user doesn't change it
  void createNewBedAssign(String? initialBedId) {
    String? finalBedId = bedId.value ?? initialBedId;

    if ((patientCases?.data?.isNotEmpty ?? true) && caseId == null) {
      DisplaySnackBar.displaySnackBar("Please select case", 3, ColorConst.redColor);
    } else if (finalBedId == null) {
      DisplaySnackBar.displaySnackBar("Please select bed", 3, ColorConst.redColor);
    } else if (selectedDate == null) {
      DisplaySnackBar.displaySnackBar("Please select date", 3, ColorConst.redColor);
    } else {
      CommonLoader.showLoader();
      StringUtils.client.createNewBedAssign(
          PreferenceUtils.getStringValue("token"),
          caseId ?? "",
          patientId.value,
          finalBedId,
          selectedDate ?? ""
      )
        ..then((value) {
          Get.back();
          if (value.success == true) {
            Get.back(result: "Call API");
            DisplaySnackBar.displaySnackBar("New Bed Assigned Successfully", 3, ColorConst.greenColor);
          } else {
            Get.back();
          }
        })
        ..onError((DioException error, stackTrace) {
          Get.back();
          CheckSocketException.checkSocketException(error);
          DisplaySnackBar.displaySnackBar("You Can't assign new bed", 3, ColorConst.redColor);
          return CreateNewBedModel();
        });
    }
  }

  Future<String?> selectDate(BuildContext context) async {
    DateTime? picked = await DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        currentTime: oldDate ?? DateTime.now(),
        theme: picker_theme.DatePickerTheme(
            doneStyle: const TextStyle(fontSize: 17),
            cancelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade700)
        )
    );
    if (picked != null) {
      oldDate = picked;
      selectedDate =
      "${picked.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day} ${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:${picked.second.toString().padLeft(2, '0')}";
      return selectedDate ?? "";
    } else {
      return null;
    }
  }
}