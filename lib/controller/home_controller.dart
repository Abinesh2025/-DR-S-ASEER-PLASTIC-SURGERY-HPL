import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/screen/admin_appointment/admin_appointment_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/screen/admin_dashboard/admin_dashboard_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/screen/doctor/doctor_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/screen/patient/patient_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/screen/setting/setting_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/appointment_controller/appointment_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/account_model/get_profile_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/logout_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/bed_assign/bed_assigns_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/bed_status/bed_status_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/doctor_admission_screen/patient_admission_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/doctor_prescription/doctor_prescription_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/doctor_screen/doctors_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/payroll_screen/my_payrolls_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/report_screen/select_report_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/schedule_screen/schedules_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/dashboard/doctor_dashboard_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/admission/admissions_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/account/my_account_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/appointment/appointment_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/visiting_consultant_directory_screen.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/login_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/bills/bills_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/case/case_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/diagnosis/diagnosis_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/document/document_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/invoice/invoice_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/notice/notice_board_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/newsletters/newsletters_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/prescription/prescriptions_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/vaccination/vaccination_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/screen/Hospital/hospital_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/screen/dashboard/dashboard_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/screen/settings/settings_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/screen/subscription/subscription_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/screen/transaction/transaction_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/patient_home_page.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/medicine/medicines_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/order/my_orders_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_launcher_screen.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/appointment_controller/filter_appointments_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/appointment_controller/filter_appointment_controller.dart';

// Patient Controllers
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/bills_controller/bills_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/diagnosis_controller/diagnosis_test_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/document_controller/document_list_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/invoice_controller/invoice_list_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/order_controller/order_list_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/case_controller/case_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/admission_controller/admission_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/prescription_controller/prescription_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/vaccination_controller/vaccination_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/medicine_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/notice_board_controller/notice_board_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/newsletters_controller/newsletters_controller.dart';

// Doctor Controllers
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_dashboard/doctor_dashboard_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_appoinment_controller/doctor_filter_appointment_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/bed_assign_controller/bed_assign_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/bed_status_controller/bed_status_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_screen_controller/doctor_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/schedule_controller/schedule_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_prescription_controller/doctor_prescription_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_payroll_controller/payroll_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/patient_admission_controller/patient_admission_controller.dart';

// Admin Controllers
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/appointment_controller/appointment_controllers.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/admin_dashboard_controller/admin_dashboard_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/patient_controller/patient_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/doctor_controller/doctors_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/setting_controller/settings_controller.dart';

// Super Admin Controllers
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/dashboard_controller/dashboard_controller.dart' as super_admin_dashboard;
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/hospital/hospital_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/transaction_controller/transaction_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/subscription_controller/subscription_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/setting_controller/setting_controller.dart' as super_admin_setting;

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/main.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_controllers/push_notification_controller/push_notification_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/screen/push_notification/push_notification_screen.dart';
import 'doctor/doctor_appoinment_controller/doctor_appoinment_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_session_controller.dart';

class HomeController extends GetxController {
  Widget? currentWidget;
  // late RxString appBarTitle;
  RxString appBarTitle = "".obs;
  RxBool showAppBar = false.obs;

  // Global scaffold key so child pages can open the root drawer
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  getHomePageWidget() {
    currentWidget = PreferenceUtils.getStringValue("role") == "Super Admin"
        ? DashboardScreen()
        : PreferenceUtils.getStringValue("role") == "Admin"
        ? AdminDashboardScreen()
        : PreferenceUtils.getStringValue("role") == "Doctor"
        ? const DoctorDashboardScreen()
        : const PatientHomePage();
  }

  LogoutModel? logoutModel;
  GetProfileModel? getProfileModel;

  RxInt currentDrawerIndex = 0.obs;
  RxInt currentBottomIndex = 0.obs;

  getAppBarTitle() {
    String role = PreferenceUtils.getStringValue("role");
    if (role == "Super Admin") {
      appBarTitle = StringUtils.dashboard.obs;
      showAppBar.value = true;
    } else if (role == "Admin") {
      appBarTitle = StringUtils.dashboard.obs;
      showAppBar.value = true;
    } else if (role == "Doctor") {
      appBarTitle = StringUtils.dashboard.obs;
      showAppBar.value = true;
    } else {
      appBarTitle = StringUtils.home.obs;
      showAppBar.value = false;
    }
  }

  RxBool isSetValue = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  Future getProfile() async {
    try {
      final value = await StringUtils.client
          .getProfile(PreferenceUtils.getStringValue("token"));
      getProfileModel = value;
      if (getProfileModel!.success == true) {
        PreferenceUtils.setStringValue(
            "first_name", getProfileModel!.data?.first_name ?? "");
        PreferenceUtils.setStringValue(
            "last_name", getProfileModel!.data?.last_name ?? "");
        PreferenceUtils.setStringValue(
            "email", getProfileModel!.data?.email ?? "");
        PreferenceUtils.setStringValue(
            "phone_number", getProfileModel!.data?.phone_number ?? "");
        PreferenceUtils.setStringValue(
            "region_code", getProfileModel!.data?.region_code ?? "");
        PreferenceUtils.setStringValue(
            "address", getProfileModel!.data?.address?.toString() ?? "");
        PreferenceUtils.setStringValue(
            "city", getProfileModel!.data?.city ?? "");
        PreferenceUtils.setStringValue(
            "pincode", getProfileModel!.data?.pincode ?? "");
        PreferenceUtils.setStringValue("image_url",
            StringUtils.fixImageUrl(getProfileModel!.data?.image_url ?? ""));

        // Update VariableUtils so UI updates immediately
        VariableUtils.firstName.value = getProfileModel!.data?.first_name ?? "";
        VariableUtils.lastName.value = getProfileModel!.data?.last_name ?? "";
        VariableUtils.email.value = getProfileModel!.data?.email ?? "";
        VariableUtils.phoneNo.value = getProfileModel!.data?.phone_number ?? "";
        VariableUtils.regionCode.value =
            getProfileModel!.data?.region_code ?? "";
        VariableUtils.address.value = getProfileModel!.data?.address?.toString() ?? "";
        VariableUtils.city.value = getProfileModel!.data?.city ?? "";
        VariableUtils.pincode.value = getProfileModel!.data?.pincode ?? "";
        VariableUtils.imageUrl.value =
            StringUtils.fixImageUrl(getProfileModel!.data?.image_url ?? "");
      }
    } on DioException catch (error) {
      if (error.response?.statusCode != 401) {
        CheckSocketException.checkSocketException(error);
      } else {
        // If 401 Unauthenticated on startup, token is expired.
        debugPrint(
            "Token expired or invalid: 401 Unauthenticated. Logging out.");
        await PreferenceUtils.clear();
        VariableUtils.reset();
        Get.deleteAll(force: true);
        router.go('/login');
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    }
  }

  void onBackButton(context, double height, double width) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext contextOfDialog) {
        return Center(
          child: Container(
            height: height / 2.6,
            width: width / 1.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageUtils.hospitalSplashLogo),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Text(
                  StringUtils.exitApp,
                  style: TextStyleConst.boldTextStyle(
                    ColorConst.blackColor,
                    width * 0.05,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  StringUtils.exitAppConfirm,
                  textAlign: TextAlign.center,
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.hintGreyColor,
                    width * 0.042,
                  ),
                ),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonButton(
                      textStyleConst: TextStyleConst.mediumTextStyle(
                        ColorConst.whiteColor,
                        width * 0.05,
                      ),
                      onTap: () {
                        SystemNavigator.pop();
                      },
                      color: ColorConst.primaryColor,
                      text: StringUtils.yes,
                      width: width / 2.5,
                      height: 50,
                    ),
                    CommonButton(
                      textStyleConst: TextStyleConst.mediumTextStyle(
                        ColorConst.hintGreyColor,
                        width * 0.05,
                      ),
                      onTap: () {
                        Get.back();
                      },
                      color: ColorConst.borderGreyColor,
                      text: StringUtils.no,
                      width: width / 2.5,
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // void logOut() {
  //   Get.back();
  //   CommonLoader.showLoader();
  //   StringUtils.client
  //       .logout(PreferenceUtils.getStringValue("token"))
  //       .then((value) {
  //     logoutModel = value;
  //     if (logoutModel!.success == true) {
  //       PreferenceUtils.setStringValue("token", "");
  //       Get.to(() => LoginScreen());
  //     }
  //   }).onError((DioException error, stackTrace) {
  //     CheckSocketException.checkSocketException(error);
  //   });
  // }
  Future<void> logOut(BuildContext context) async {
    Navigator.of(context).pop();

    CommonLoader.showLoader();

    try {
      final value = await StringUtils.client
          .logout(PreferenceUtils.getStringValue("token"));

      if (value.success == true) {
        await PreferenceUtils.clear();
        PreferenceUtils.setStringValue("role", ""); // Reset role explicitly

        VariableUtils.reset();

        // Reset local controller state before deletion as a safety measure
        currentBottomIndex.value = 0;
        currentWidget = null;

        Get.deleteAll(force: true);

        router.go('/login');
      }
    } on DioException catch (error) {
      debugPrint("Logout error: $error");
      CheckSocketException.checkSocketException(error);
    } finally {
      CommonLoader.hideLoader();
    }
  }

  // void changeWidget(int index) {
  //   currentBottomIndex.value = 4; // Reset bottom nav selection
  //   update();
  //   showAppBar.value = true;
  //   switch (index) {
  //     case 0:
  //       currentWidget = const PatientHomePage();
  //       appBarTitle.value = "Home";
  //       showAppBar.value = false;
  //       currentDrawerIndex.value = 0;
  //
  //       if (Get.isRegistered<PatientHomeController>()) {
  //         Get.find<PatientHomeController>().refreshData();
  //       }
  //       break;
  //     case 1:
  //       currentWidget = BillScreen();
  //       appBarTitle.value = StringUtils.bills;
  //       currentDrawerIndex.value = 1;
  //       if (Get.isRegistered<BillsController>()) {
  //         Get.find<BillsController>().getBill();
  //       }
  //       break;
  //     case 2:
  //       currentWidget = DiagnosisScreen();
  //       appBarTitle.value = StringUtils.diagnosisTests;
  //       currentDrawerIndex.value = 2;
  //       if (Get.isRegistered<DiagnosisTestController>()) {
  //         Get.find<DiagnosisTestController>().getDiagnosisTest();
  //       }
  //       break;
  //     case 3:
  //       currentWidget = DocumentScreen();
  //       appBarTitle.value = StringUtils.documents;
  //       currentDrawerIndex.value = 3;
  //       if (Get.isRegistered<DocumentController>()) {
  //         Get.find<DocumentController>().getDocuments();
  //       }
  //       break;
  //     case 4:
  //       currentWidget = InvoiceScreen();
  //       appBarTitle.value = StringUtils.invoices;
  //       currentDrawerIndex.value = 4;
  //       if (Get.isRegistered<InvoiceListController>()) {
  //         Get.find<InvoiceListController>().getInvoices();
  //       }
  //       break;
  //     case 5:
  //       currentWidget = MyOrdersScreen();
  //       appBarTitle.value = StringUtils.myOrders;
  //       currentDrawerIndex.value = 5;
  //       if (Get.isRegistered<OrderListController>()) {
  //         Get.find<OrderListController>().getOrdersData();
  //       }
  //       break;
  //     case 6:
  //       currentWidget = LiveConsultationsScreen();
  //       appBarTitle.value = StringUtils.liveConsultations;
  //       currentDrawerIndex.value = 6;
  //       if (Get.isRegistered<LiveConsultationsController>()) {
  //         Get.find<LiveConsultationsController>().getConsultancy("all");
  //       }
  //       break;
  //     case 7:
  //       currentWidget = CaseScreen();
  //       appBarTitle.value = StringUtils.myCases;
  //       currentDrawerIndex.value = 7;
  //       if (Get.isRegistered<CaseController>()) {
  //         Get.find<CaseController>().getCase();
  //       }
  //       break;
  //     case 8:
  //       currentWidget = AdmissionScreen();
  //       appBarTitle.value = StringUtils.myAdmissions;
  //       currentDrawerIndex.value = 8;
  //       if (Get.isRegistered<AdmissionController>()) {
  //         Get.find<AdmissionController>().getAdmission();
  //       }
  //       break;
  //     case 9:
  //       currentWidget = PrescriptionsScreen();
  //       appBarTitle.value = StringUtils.prescriptions;
  //       currentDrawerIndex.value = 9;
  //       if (Get.isRegistered<PrescriptionController>()) {
  //         Get.find<PrescriptionController>().getPrescription();
  //       }
  //       break;
  //     case 10:
  //       currentWidget = VaccinationScreen();
  //       appBarTitle.value = StringUtils.vaccinatedPatients;
  //       currentDrawerIndex.value = 10;
  //       if (Get.isRegistered<VaccinationController>()) {
  //         Get.find<VaccinationController>().getVaccination();
  //       }
  //       break;
  //   }
  //   router.go('/home');
  // }
  //
  // void changeBottomNavIndex(int index) {
  //   currentBottomIndex.value = index;
  //   update();
  //   switch (index) {
  //     case 0:
  //       currentWidget = const PatientHomePage();
  //       appBarTitle.value = "Home";
  //       showAppBar.value = false;
  //       currentDrawerIndex.value = 0;
  //
  //       if (Get.isRegistered<PatientHomeController>()) {
  //         Get.find<PatientHomeController>().refreshData();
  //       }
  //       break;
  //     case 1:
  //       currentWidget = const AppointmentScreen();
  //       appBarTitle.value = StringUtils.appointment;
  //       showAppBar.value = true;
  //
  //       if (Get.isRegistered<PatientFilterAppointmentController>()) {
  //         Get.find<PatientFilterAppointmentController>().changeIndex(
  //           Get.find<AppointmentController>().currentIndex.value,
  //         );
  //       } else if (Get.isRegistered<AdminFilterAppointmentController>()) {
  //         Get.find<AdminFilterAppointmentController>().changeIndex(
  //           Get.find<AppointmentController>().currentIndex.value,
  //         );
  //       }
  //       break;
  //     case 2:
  //       currentWidget = const MedicinesScreen();
  //       appBarTitle.value = "Medicines";
  //       showAppBar.value = false;
  //
  //       if (Get.isRegistered<MedicineController>()) {
  //         Get.find<MedicineController>().fetchMedicines();
  //         Get.find<MedicineController>().fetchCategories();
  //       }
  //       break;
  //     case 3:
  //       currentWidget = MyAccountScreen(isBottomNavItem: true);
  //       appBarTitle.value = StringUtils.myAccount;
  //       showAppBar.value = true;
  //       getProfile();
  //       break;
  //   }
  // }
  void changeWidget(int index) {
    currentBottomIndex.value = 0; // Reset bottom nav selection
    update();
    showAppBar.value = true;
    switch (index) {
      case 0:
        currentWidget = const PatientHomePage();
        appBarTitle.value = StringUtils.home;
        showAppBar.value = false;
        currentDrawerIndex.value = 0;
        Future.delayed(const Duration(milliseconds: 100), () {
          // 🔥 Request real-time token whenever switching to home tab
          if (PreferenceUtils.getStringValue("token").isNotEmpty &&
              PreferenceUtils.getStringValue("role") != "Doctor" &&
              PreferenceUtils.getStringValue("role") != "Admin" &&
              PreferenceUtils.getStringValue("role") != "Super Admin") {
            StringUtils.client
                .broadcastTodayAppointment(PreferenceUtils.getStringValue("token"), {})
                .catchError((e) => debugPrint("Broadcast error: $e"));
          }
          if (Get.isRegistered<PatientHomeController>()) {
            Get.find<PatientHomeController>().refreshData();
          }
        });
        break;
      case 1:
        currentWidget = BillScreen();
        appBarTitle.value = StringUtils.bills;
        currentDrawerIndex.value = 1;
        final billsController = Get.put(BillsController());
        billsController.isGetBills.value = false;
        billsController.getBill();
        break;
      case 2:
        currentWidget = DiagnosisScreen();
        appBarTitle.value = StringUtils.diagnosisTests;
        currentDrawerIndex.value = 2;
        final diagnosisController = Get.put(DiagnosisTestController());
        diagnosisController.isDiagnosisTestApiCall.value = false;
        diagnosisController.getDiagnosisTest();
        break;
      case 3:
        currentWidget = DocumentScreen();
        appBarTitle.value = StringUtils.documents;
        currentDrawerIndex.value = 3;
        final docController = Get.put(DocumentController());
        docController.gotData.value = false;
        docController.getDocuments();
        break;
      case 4:
        currentWidget = InvoiceScreen();
        appBarTitle.value = StringUtils.invoices;
        currentDrawerIndex.value = 4;
        final invoiceController = Get.put(InvoiceListController());
        invoiceController.isGotInvoice.value = false;
        invoiceController.getInvoices();
        break;
      case 5:
        currentWidget = MyOrdersScreen();
        appBarTitle.value = StringUtils.myOrders;
        currentDrawerIndex.value = 5;
        final orderController = Get.put(OrderListController());
        orderController.isLoading.value = true;
        orderController.getOrdersData();
        break;
    // case 6:
    //   currentWidget = LiveConsultationsScreen();
    //   appBarTitle.value = StringUtils.liveConsultations;
    //   currentDrawerIndex.value = 6;
    //   final liveController = Get.put(LiveConsultationsController());
    //   liveController.gotConsultationData.value = false;
    //   liveController.getConsultancy("all");
    //   break;
      case 6:
        currentWidget = CaseScreen();
        appBarTitle.value = StringUtils.myCases;
        currentDrawerIndex.value = 6;
        final caseController = Get.put(CaseController());
        caseController.isGetCase.value = false;
        caseController.getCase();
        break;
      case 7:
        currentWidget = AdmissionScreen();
        appBarTitle.value = StringUtils.myAdmissions;
        currentDrawerIndex.value = 7;
        final admissionController = Get.put(AdmissionController());
        admissionController.isGetAdmission.value = false;
        admissionController.getAdmission();
        break;
      case 8:
        currentWidget = PrescriptionsScreen();
        appBarTitle.value = StringUtils.prescriptions;
        currentDrawerIndex.value = 8;
        final prescriptionController = Get.put(PrescriptionController());
        prescriptionController.isGetPrescription.value = false;
        prescriptionController.getPrescription();
        break;
      case 9:
        currentWidget = VaccinationScreen();
        appBarTitle.value = StringUtils.vaccinatedPatients;
        currentDrawerIndex.value = 9;
        final vaccinationController = Get.put(VaccinationController());
        vaccinationController.isGetVaccination.value = false;
        vaccinationController.getVaccination();
        break;
      case 10:
        currentWidget = const NewslettersScreen();
        appBarTitle.value = StringUtils.newsletters;
        currentDrawerIndex.value = 10;
        final newslettersController = Get.put(NewslettersController());
        newslettersController.fetchCategories();
        break;
      case 11:
        currentWidget = const VisitingConsultantDirectoryScreen();
        appBarTitle.value = StringUtils.visitingConsultantsTitle;
        currentDrawerIndex.value = 11;
        break;
    }
    router.go('/home');
  }

  void changeBottomNavIndex(int index) {
    currentBottomIndex.value = index;
    update();
    switch (index) {
      case 0:
        currentWidget = const PatientHomePage();
        appBarTitle.value = StringUtils.home;
        showAppBar.value = false;
        currentDrawerIndex.value = 0;
        Future.delayed(const Duration(milliseconds: 100), () {
          // 🔥 Request real-time token on bottom nav change
          if (PreferenceUtils.getStringValue("token").isNotEmpty &&
              PreferenceUtils.getStringValue("role") != "Doctor" &&
              PreferenceUtils.getStringValue("role") != "Admin" &&
              PreferenceUtils.getStringValue("role") != "Super Admin") {
            StringUtils.client
                .broadcastTodayAppointment(PreferenceUtils.getStringValue("token"), {})
                .catchError((e) => debugPrint("Broadcast error: $e"));
          }
          if (Get.isRegistered<PatientHomeController>()) {
            Get.find<PatientHomeController>().refreshData();
          }
        });
        break;
      case 1:
        currentWidget = const AppointmentScreen();
        appBarTitle.value = StringUtils.appointment;
        showAppBar.value = true;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<PatientFilterAppointmentController>()) {
            Get.find<PatientFilterAppointmentController>().changeIndex(
              Get.find<AppointmentController>().currentIndex.value,
            );
          } else if (Get.isRegistered<AdminFilterAppointmentController>()) {
            Get.find<AdminFilterAppointmentController>().changeIndex(
              Get.find<AppointmentController>().currentIndex.value,
            );
          }
        });
        break;
      case 2:
        currentWidget = const MedicinesScreen();
        appBarTitle.value = StringUtils.medicines;
        showAppBar.value = false;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<MedicineController>()) {
            Get.find<MedicineController>().fetchMedicines();
            Get.find<MedicineController>().fetchCategories();
          }
        });
        break;
      case 3:
        currentWidget = MyAccountScreen(isBottomNavItem: true);
        appBarTitle.value = StringUtils.myAccount;
        showAppBar.value = true;
        getProfile(); // This handles its own API call reliably
        break;
    }
  }
  void changeDoctorWidget(int index) {
    update();
    showAppBar.value = true;
    switch (index) {
      case 0:
        currentWidget = const DoctorDashboardScreen();
        appBarTitle.value = StringUtils.dashboard;
        currentDrawerIndex.value = 0;
        if (Get.isRegistered<DoctorDashboardController>()) {
          Get.find<DoctorDashboardController>().refreshData();
        }
        break;
      case 1:
        currentWidget = AppointmentScreen();
        appBarTitle.value = StringUtils.appointment;
        currentDrawerIndex.value = 1;
        if (Get.isRegistered<DoctorFilterAppointmentController>()) {
          Get.find<DoctorFilterAppointmentController>().changeDoctorIndex(
            Get.find<DoctorAppointmentController>().currentIndex.value,
          );
        }
        if (Get.isRegistered<DoctorSessionController>()) {
          Get.find<DoctorSessionController>().fetchSessionStatus();
        }
        break;
      case 2:
        currentWidget = BedAssignsScreen();
        appBarTitle.value = StringUtils.bedAssign;
        currentDrawerIndex.value = 2;
        if (Get.isRegistered<BedAssignController>()) {
          Get.find<BedAssignController>().getBedAssignData();
        }
        break;
      case 3:
        currentWidget = BedStatusScreen();
        appBarTitle.value = StringUtils.bedStatus;
        currentDrawerIndex.value = 3;
        if (Get.isRegistered<BedStatusController>()) {
          Get.find<BedStatusController>().getBedStatusData();
        }
        break;
      case 4:
        currentWidget = DoctorScreen();
        appBarTitle.value = StringUtils.doctorDrawer;
        currentDrawerIndex.value = 4;
        if (Get.isRegistered<DoctorScreenController>()) {
          Get.find<DoctorScreenController>().getDoctors();
        }
        break;
      case 5:
        currentWidget = SchedulesScreen();
        appBarTitle.value = StringUtils.schedules;
        currentDrawerIndex.value = 5;
        if (Get.isRegistered<SchedulesController>()) {
          Get.find<SchedulesController>().getSchedules();
        }
        break;
      case 6:
        currentWidget = DoctorPrescriptionScreen();
        appBarTitle.value = StringUtils.prescriptions;
        currentDrawerIndex.value = 6;
        if (Get.isRegistered<DoctorPrescriptionController>()) {
          Get.find<DoctorPrescriptionController>().getDoctorPrescription();
        }
        break;
      case 7:
        currentWidget = DocumentScreen();
        appBarTitle.value = StringUtils.documents;
        currentDrawerIndex.value = 7;
        if (Get.isRegistered<DocumentController>()) {
          Get.find<DocumentController>().getDoctorDocuments();
        }
        break;
      case 8:
        currentWidget = DiagnosisScreen();
        appBarTitle.value = StringUtils.diagnosisTests;
        currentDrawerIndex.value = 8;
        if (Get.isRegistered<DiagnosisTestController>()) {
          Get.find<DiagnosisTestController>().getDoctorDiagnosisTest();
        }
        break;
      case 9:
        currentWidget = NoticeBoardScreen();
        appBarTitle.value = StringUtils.noticeBoards;
        currentDrawerIndex.value = 9;
        if (Get.isRegistered<NoticeBoardController>()) {
          Get.find<NoticeBoardController>().getNotice();
        }
        break;
      case 10:
        currentWidget = const AiConsultationLauncherScreen();
        appBarTitle.value = "AI Consultation";
        currentDrawerIndex.value = 10;
        break;
      case 11:
        currentWidget = MyPayrollsScreen();
        appBarTitle.value = StringUtils.myPayrolls;
        currentDrawerIndex.value = 11;
        if (Get.isRegistered<PayrollController>()) {
          Get.find<PayrollController>().getPayroll();
        }
        break;
      case 12:
        currentWidget = PatientAdmission();
        appBarTitle.value = StringUtils.patientAdmissions;
        currentDrawerIndex.value = 12;
        if (Get.isRegistered<PatientAdmissionController>()) {
          Get.find<PatientAdmissionController>().getPatientAdmission();
        }
        break;
      case 13:
        currentWidget = const SelectReportScreen();
        appBarTitle.value = StringUtils.report;
        currentDrawerIndex.value = 13;
        break;
    }
    router.go('/home');
  }

  void changeSuperAdminWidget(int index) {
    update();
    switch (index) {
      case 0:
        currentWidget = DashboardScreen();
        appBarTitle.value = StringUtils.dashboard;
        currentDrawerIndex.value = 0;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<super_admin_dashboard.DashboardController>()) {
            final controller = Get.find<super_admin_dashboard.DashboardController>();
            controller.getDashboardData();
            controller.getIncomeDataForCurrentWeek();
          }
        });
        break;
      case 1:
        currentWidget = HospitalScreen();
        appBarTitle.value = StringUtils.hospitals;
        currentDrawerIndex.value = 1;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<HospitalController>()) {
            Get.find<HospitalController>().changeIndex(
              Get.find<HospitalController>().currentIndex.value,
            );
          }
        });
        break;
      case 2:
        currentWidget = TransactionScreen();
        appBarTitle.value = StringUtils.transaction;
        currentDrawerIndex.value = 2;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<TransactionController>()) {
            Get.find<TransactionController>().changeIndex(
              Get.find<TransactionController>().currentIndex.value,
            );
          }
        });
        break;
      case 3:
        currentWidget = SubscriptionScreen();
        appBarTitle.value = StringUtils.subscription;
        currentDrawerIndex.value = 3;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<SubscriptionController>()) {
            Get.find<SubscriptionController>().changeIndex(
              Get.find<SubscriptionController>().currentIndex.value,
            );
          }
        });
        break;
      case 4:
        currentWidget = SettingsScreen();
        appBarTitle.value = StringUtils.setting;
        currentDrawerIndex.value = 4;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<super_admin_setting.SettingController>()) {
            Get.find<super_admin_setting.SettingController>().getSettings();
          }
        });
        break;
    }
    router.go('/home');
  }

  void changeAdminWidget(int index) {
    update();
    switch (index) {
      case 0:
        currentWidget = AdminDashboardScreen();
        appBarTitle.value = StringUtils.dashboard;
        currentDrawerIndex.value = 0;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<AdminDashboardController>()) {
            Get.find<AdminDashboardController>().getAdminDashboardData();
          }
        });
        break;
      case 1:
        currentWidget = AdminAppointmentsScreen();
        appBarTitle.value = StringUtils.appointment;
        currentDrawerIndex.value = 1;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<AdminFilterAppointmentController>()) {
            Get.find<AdminFilterAppointmentController>().changeIndex(
              Get.find<AdminAppointmentController>().currentIndex.value,
            );
          }
        });
        break;
      case 2:
        currentWidget = PatientsScreen();
        appBarTitle.value = StringUtils.patients;
        currentDrawerIndex.value = 2;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<PatientScreenController>()) {
            Get.find<PatientScreenController>().changeIndex(
              Get.find<PatientScreenController>().currentIndex.value,
            );
          }
        });
        break;
      case 3:
        currentWidget = DoctorsScreen();
        appBarTitle.value = StringUtils.doctorList;
        currentDrawerIndex.value = 3;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<DoctorsController>()) {
            Get.find<DoctorsController>().changeIndex(
              Get.find<DoctorsController>().currentIndex.value,
            );
          }
        });
        break;
      case 4:
        currentWidget = BedStatusScreen();
        appBarTitle.value = StringUtils.bedStatus;
        currentDrawerIndex.value = 4;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<BedStatusController>()) {
            Get.find<BedStatusController>().getBedStatusData();
          }
        });
        break;
      case 5:
        currentWidget = RegularUpdatesListScreen(); // Your new screen
        appBarTitle.value = "Regular Updates"; // Or use StringUtils.regularUpdates if defined
        currentDrawerIndex.value = 5;
        update(); // Force GetBuilder/Obx to rebuild
        Future.delayed(const Duration(milliseconds: 100), () {
          final controller = Get.put(RegularUpdateController());
          controller.fetchUpdates();
        });
        break;
      case 6:
        currentWidget = SettingScreen();
        appBarTitle.value = StringUtils.setting;
        currentDrawerIndex.value = 6;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (Get.isRegistered<AdminSettingController>()) {
            Get.find<AdminSettingController>().getSettings();
          }
        });
        break;
    }
    router.go('/home');
  }
}
