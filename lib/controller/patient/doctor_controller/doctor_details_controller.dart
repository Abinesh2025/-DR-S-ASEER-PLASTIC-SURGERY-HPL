import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/create_appointment/create_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/slot_booking/slot_booking_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/main.dart';
import 'package:intl/intl.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import '../home_controller/patient_home_controller.dart';

class DoctorDetailsController extends GetxController {
  late Razorpay _razorpay;
  String paymentMethod = "onsite";
  int appointmentTypeFilter = 1;

// For API
  String? selectedSpecialTokenType;
  int? selectedSpecialTokenId; // Calendar Logic
  DateTime focusedDate = DateTime.now();
  List<DateTime> visibleDates = [];
  String? selectedDate; // YYYY-MM-DD
  String appointmentType = 'me';
  double selectedRating = 5.0;

  bool isPostingReview = false;

  final TextEditingController reviewController =
  TextEditingController();


  // Store the full details map from the widget
  Map<String, String>? dependentDetails;
  // Slots Logic
  bool isSlotLoading = false;
  SlotBookingModel? slotBookingModel;
  dynamic appointmentTypeApi = 1;
  String? selectedTime;
  int? selectedTimeIndex;
  String selectedCategory = "overall";
  // String appointmentType = 'me';
  Map<String, dynamic>? guestPatientDetails;
  // Variables to hold guest details
  String? guestPatientName;
  String? guestPatientAge;
  String? guestPatientRelation;
  // Token Logic
  int? selectedToken;

  bool get isTokenBased =>
      slotBookingModel?.data?.schedule_type == 'token_based';

  // Booking Logic
  TextEditingController descriptionController = TextEditingController();
  CreateAppointmentModel? createAppointmentModel;
  bool isBookingLoading = false;

  // Profile Logic
  bool isLoadingDoctorDetails = false;
  DoctorDetailData? doctorProfile;
  int? currentDoctorId; // Prevents redundant API calls on UI rebuilds

  bool isOnlinePaymentAvailable = false;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _generateVisibleDates();
    // Default select today
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    _checkPaymentGateway();
  }
  Future<void> submitReview() async {
    if (doctorProfile == null) return;

    if (reviewController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
        "Please enter your review.",
        3,
        ColorConst.redColor,
      );
      return;
    }

    isPostingReview = true;
    update();

    try {
      final body = {
        "doctor_id": doctorProfile!.id,
        "rating": selectedRating.toInt(),
        "review": reviewController.text.trim(),
      };

      final response = await StringUtils.client.postDoctorReview(
        PreferenceUtils.getStringValue("token"),
        body,
      );

      debugPrint("Review Response : $response");

      if (response != null) {
        /// Reset form
        reviewController.clear();
        selectedRating = 5.0;

        /// Refresh doctor details
        if (currentDoctorId != null) {
          await refreshData(currentDoctorId!);
        }

        DisplaySnackBar.displaySnackBar(
          "Review submitted successfully.",
          3,
          ColorConst.greenColor,
        );
      }
    } on DioException catch (e) {
      CheckSocketException.checkSocketException(e);
    } catch (e) {
      debugPrint("Submit Review Error : $e");

      DisplaySnackBar.displaySnackBar(
        "Something went wrong.",
        3,
        ColorConst.redColor,
      );
    } finally {
      isPostingReview = false;
      update();
    }
  }
// Inside DoctorDetailsController
  void resetToToday() {
    focusedDate = DateTime.now();
    // Format today's date to match your API format (YYYY-MM-DD)
    selectedDate = "${focusedDate.year}-${focusedDate.month.toString().padLeft(2, '0')}-${focusedDate.day.toString().padLeft(2, '0')}";

    // Re-generate the date strip starting from now
    _generateVisibleDates();

    // Clear any previously selected specific token or time
    selectedToken = null;
    selectedTime = null;

    update();
  }
  void _checkPaymentGateway() {
    StringUtils.client
        .getPaymentGateways(PreferenceUtils.getStringValue("token"))
        .then((gatewayResponse) {
      if (gatewayResponse.success == true && gatewayResponse.data != null) {
        final data = gatewayResponse.data!;
        bool hasRazorpay = data.razorpay == true &&
            data.razorpayKey != null &&
            data.razorpayKey!.isNotEmpty;
        bool hasStripe = data.stripe == true &&
            data.stripeKey != null &&
            data.stripeKey!.isNotEmpty;
        bool hasPaypal = data.paypal == true &&
            data.paypalClientId != null &&
            data.paypalClientId!.isNotEmpty;
        bool hasPaystack = data.paystack == true &&
            data.paystackPublicKey != null &&
            data.paystackPublicKey!.isNotEmpty;
        bool hasPhonepe = data.phonepe == true &&
            data.phonepeMerchantId != null &&
            data.phonepeMerchantId!.isNotEmpty;
        bool hasFlutterwave = data.flutterwave == true &&
            data.flutterwavePublicKey != null &&
            data.flutterwavePublicKey!.isNotEmpty;

        isOnlinePaymentAvailable = hasRazorpay ||
            hasStripe ||
            hasPaypal ||
            hasPaystack ||
            hasPhonepe ||
            hasFlutterwave;

        if (!isOnlinePaymentAvailable && paymentMethod == "online") {
          paymentMethod = "onsite";
        }

        update();
      }
    }).catchError((error) {
      print("Error fetching payment gateways: $error");
    });
  }

  void getDoctorDetails(int doctorId) {
    // Reset selection when entering for a new stay or different doctor
    selectedTime = null;
    selectedTimeIndex = null;
    selectedToken = null;

    if (currentDoctorId != doctorId) {
      currentDoctorId = doctorId;
      doctorProfile = null;
      slotBookingModel = null;
    }

    if (doctorProfile == null && !isLoadingDoctorDetails) {
      fetchDoctorProfile(doctorId);
    }

    getSlots(doctorId, forceRefresh: true);
  }

  Future<void> refreshData(int doctorId) async {
    selectedTime = null;
    selectedTimeIndex = null;
    selectedToken = null;
    update();

    await Future.wait([
      StringUtils.client
          .getDoctorDetail(PreferenceUtils.getStringValue("token"), doctorId)
          .then((value) {
        if (value.success == true && value.data != null) {
          doctorProfile = value.data;
        }
      }),
      StringUtils.client
          .getBookingSlotDate(
        PreferenceUtils.getStringValue("token"),
        selectedDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
        doctorId.toString(),
        appointmentTypeApi,
      )
          .then((value) {
        slotBookingModel = value;
        _initializeCategory();
      })
    ]);

    isLoadingDoctorDetails = false;
    isSlotLoading = false;
    update();
  }

  void _initializeCategory() {
    final slots = slotBookingModel?.data?.bookingSlotArr ?? [];
    if (slots.isNotEmpty) {
      Set<String> categories = {};
      for (var slot in slots) {
        String? cat;
        if (slot is BookingToken) {
          cat = slot.category;
        } else if (slot is Map) {
          cat = slot['category']?.toString();
        }
        if (cat != null) categories.add(cat.toLowerCase());
      }

      if (categories.contains("morning")) {
        selectedCategory = "morning";
      } else if (categories.contains("overall")) {
        selectedCategory = "overall";
      } else if (categories.isNotEmpty) {
        selectedCategory = categories.first;
      }
    }
  }

  void fetchDoctorProfile(int doctorId) {
    isLoadingDoctorDetails = true;
    update();

    StringUtils.client
        .getDoctorDetail(PreferenceUtils.getStringValue("token"), doctorId)
        .then((value) {
      if (value.success == true && value.data != null) {
        doctorProfile = value.data;
      }
      isLoadingDoctorDetails = false;
      update();
    }).onError((error, stackTrace) {
      isLoadingDoctorDetails = false;
      update();
      print("Error fetching doctor profile: $error");
    });
  }

  void _generateVisibleDates() {
    visibleDates.clear();
    DateTime firstDay = DateTime(focusedDate.year, focusedDate.month, 1);
    DateTime lastDay = DateTime(focusedDate.year, focusedDate.month + 1, 0);

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    for (int i = 0; i < lastDay.day; i++) {
      DateTime date = firstDay.add(Duration(days: i));
      if (!date.isBefore(today)) {
        visibleDates.add(date);
      }
    }
    update();
  }

  void prevMonth() {
    focusedDate = DateTime(focusedDate.year, focusedDate.month - 1, 1);
    _generateVisibleDates();
  }

  void nextMonth() {
    focusedDate = DateTime(focusedDate.year, focusedDate.month + 1, 1);
    _generateVisibleDates();
  }

  void onDateSelected(DateTime date, int doctorId) {
    selectedDate = DateFormat('yyyy-MM-dd').format(date);
    selectedTime = null;
    selectedTimeIndex = null;
    selectedToken = null;
    update();
    getSlots(doctorId, forceRefresh: true);
  }

  void selectTime(String time, int index) {
    final slots = slotBookingModel?.data?.bookingSlotArr ?? [];
    if (index >= 0 && index < slots.length) {
      final slot = slots[index];
      bool isBooked = false;
      bool isDisabled = false;
      if (slot is BookingToken) {
        isBooked = slot.isBooked == true;
        isDisabled = slot.disabled == true;
      } else if (slot is Map) {
        isBooked = (slot['isBooked'] == true) || (slot['isBooked'] == 1);
        isDisabled = (slot['disabled'] == true) || (slot['disabled'] == 1);
      }
      if (isBooked || isDisabled) return;
    }

    selectedTime = time;
    selectedTimeIndex = index;

    selectedToken = null;
    update();
  }

  void selectToken(int token, int index) {
    final slots = slotBookingModel?.data?.bookingSlotArr ?? [];
    if (index >= 0 && index < slots.length) {
      final slot = slots[index];
      bool isBooked = false;
      bool isDisabled = false;
      if (slot is BookingToken) {
        isBooked = slot.isBooked == true;
        isDisabled = slot.disabled == true;
      } else if (slot is Map) {
        isBooked = (slot['isBooked'] == true) || (slot['isBooked'] == 1);
        isDisabled = (slot['disabled'] == true) || (slot['disabled'] == 1);
      }
      if (isBooked || isDisabled) return;
    }

    selectedToken = token;
    selectedTimeIndex = index;
    selectedTime = "00:00";
    update();
  }

  void setCategory(String category) {
    selectedCategory = category;
    selectedTime = null;
    selectedTimeIndex = null;
    selectedToken = null;
    update();
  }

  void setAppointmentTypeFilter(
      int type,
      int doctorId, {
        String? specialTokenType,
      }) {
    appointmentTypeFilter = type;

    // OPD/FOLLOW UP => int
    // Special Token => String
    appointmentTypeApi = specialTokenType ?? type;

    selectedTime = null;
    selectedTimeIndex = null;
    selectedToken = null;

    update();

    getSlots(doctorId, forceRefresh: true);
  }
  void getSlots(int doctorId, {bool forceRefresh = false}) {
    if (selectedDate == null || isSlotLoading) return;

    if (!forceRefresh && slotBookingModel != null) return;

    isSlotLoading = true;
    slotBookingModel = null; // Clear previous if we are actually loading
    update();

    StringUtils.client
        .getBookingSlotDate(
      PreferenceUtils.getStringValue("token"),
      selectedDate!,
      doctorId.toString(),
      appointmentTypeApi,
    )
        .then((value) {
      slotBookingModel = value;
      isSlotLoading = false;

      // Reset selection when new slots are loaded (no auto-selection as per user request)
      selectedTime = null;
      selectedTimeIndex = null;
      selectedToken = null;

      _initializeCategory();

      update();
    }).onError((DioException error, stackTrace) {
      isSlotLoading = false;
      update();
      CheckSocketException.checkSocketException(error);
    });
  }

  // void bookAppointment(
  //     int doctorId, String? departmentId, BuildContext context) {
  //   if (selectedDate == null) {
  //     DisplaySnackBar.displaySnackBar(
  //         "Please select a date", 3, ColorConst.redColor);
  //     return;
  //   }
  //   if (selectedTime == null) {
  //     DisplaySnackBar.displaySnackBar(
  //         "Please select a slot", 3, ColorConst.redColor);
  //     return;
  //   }
  //
  //   if (isTokenBased) {
  //     if (selectedToken == null) {
  //       DisplaySnackBar.displaySnackBar(
  //           "Please select a token", 3, ColorConst.redColor);
  //       return;
  //     }
  //   } else {
  //     if (selectedTime == null) {
  //       DisplaySnackBar.displaySnackBar(
  //           "Please select a time slot", 3, ColorConst.redColor);
  //       return;
  //     }
  //   }
  //
  //   isBookingLoading = true;
  //   update();
  //
  //   _bookAppointmentFinally(doctorId, departmentId);
  // }
  void bookAppointment(int doctorId, String? departmentId, BuildContext context) {
    // 1. Basic Appointment Validations
    if (selectedDate == null) {
      DisplaySnackBar.displaySnackBar("Please select a date", 3, ColorConst.redColor);
      return;
    }
    if (selectedTime == null) {
      DisplaySnackBar.displaySnackBar("Please select a time slot", 3, ColorConst.redColor);
      return;
    }
    if (isTokenBased && selectedToken == null) {
      DisplaySnackBar.displaySnackBar("Please select a token", 3, ColorConst.redColor);
      return;
    }

    // 2. "Someone Else" Guest Data Validation
    if (appointmentType == 'someone_else') {
      if (guestPatientDetails == null) {
        DisplaySnackBar.displaySnackBar("Please fill in patient details", 3, ColorConst.redColor);
        return;
      }

      // Checking specific fields in the map
      String firstName = guestPatientDetails!["first_name"] ?? "";
      String lastName = guestPatientDetails!["last_name"] ?? "";
      String phone = guestPatientDetails!["phone"] ?? "";
      String age = guestPatientDetails!["age"] ?? "";
      String gender = guestPatientDetails!["gender"] ?? "";
      String dob = guestPatientDetails!["dob"] ?? "";

      if (firstName.isEmpty) {
        DisplaySnackBar.displaySnackBar("Please enter patient first name", 3, ColorConst.redColor);
        return;
      }
      if (lastName.isEmpty) {
        DisplaySnackBar.displaySnackBar("Please enter patient last name", 3, ColorConst.redColor);
        return;
      }
      if (phone.isEmpty || phone.length < 10) {
        DisplaySnackBar.displaySnackBar("Please enter a valid 10-digit phone number", 3, ColorConst.redColor);
        return;
      }
      if (age.isEmpty) {
        DisplaySnackBar.displaySnackBar("Please enter patient age", 3, ColorConst.redColor);
        return;
      }
      if (gender.isEmpty) {
        DisplaySnackBar.displaySnackBar("Please select patient gender", 3, ColorConst.redColor);
        return;
      }
      if (dob.isEmpty) {
        DisplaySnackBar.displaySnackBar("Please select patient date of birth", 3, ColorConst.redColor);
        return;
      }
    }

    // 3. Proceed to API Call if all validations pass
    isBookingLoading = true;
    update();
    _bookAppointmentFinally(doctorId, departmentId);
  }
  String? _currentRazorpayOrderId;
  int? _currentAppointmentId;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (_currentRazorpayOrderId != null && response.paymentId != null) {
      CommonLoader.showLoader(
          title: "Verifying Payment...", subtitle: "Please wait");
      StringUtils.client
          .verifyRazorpayPayment(
        PreferenceUtils.getStringValue("token"),
        _currentRazorpayOrderId!,
        response.paymentId!,
        response.signature ?? "",
      )
          .then((value) {
        CommonLoader.hideLoader();
        if (value.success == true) {
          DisplaySnackBar.displaySnackBar(
              "Payment verified successfully!", 3, ColorConst.greenColor);
          _refreshHomeData();
          router.go('/home');
        } else {
          DisplaySnackBar.displaySnackBar(
              value.message ?? "Payment verification failed",
              3,
              ColorConst.redColor);
        }
      }).catchError((error) {
        CommonLoader.hideLoader();
        DisplaySnackBar.displaySnackBar(
            "An error occurred during verification", 3, ColorConst.redColor);
      });
    } else {
      CommonLoader.hideLoader();
      DisplaySnackBar.displaySnackBar(
          "Payment Details Missing", 3, ColorConst.redColor);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (_currentAppointmentId != null && paymentMethod == "online") {
      CommonLoader.showLoader(
          title: "Cancelling...", subtitle: "Cleaning up appointment");
      StringUtils.client
          .deleteAppointment(
              PreferenceUtils.getStringValue("token"), _currentAppointmentId!)
          .then((value) {
        CommonLoader.hideLoader();
        DisplaySnackBar.displaySnackBar(
            "Payment Failed. ${response.message}", 3, ColorConst.redColor);
      }).catchError((_) {
        CommonLoader.hideLoader();
        DisplaySnackBar.displaySnackBar(
            "Payment Failed. ${response.message}", 3, ColorConst.redColor);
      });
    } else {
      CommonLoader.hideLoader();
      DisplaySnackBar.displaySnackBar(
          "Payment Failed. ${response.message}", 3, ColorConst.redColor);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (_currentAppointmentId != null && paymentMethod == "online") {
      CommonLoader.showLoader(
          title: "Cancelling...", subtitle: "Cleaning up appointment");
      StringUtils.client
          .deleteAppointment(
              PreferenceUtils.getStringValue("token"), _currentAppointmentId!)
          .then((value) {
        CommonLoader.hideLoader();
        DisplaySnackBar.displaySnackBar(
            "External Wallet not supported here: ${response.walletName}",
            3,
            ColorConst.redColor);
      }).catchError((_) {
        CommonLoader.hideLoader();
      });
    } else {
      CommonLoader.hideLoader();
      DisplaySnackBar.displaySnackBar(
          "External Wallet Selected: ${response.walletName}",
          3,
          ColorConst.primaryColor);
    }
  }

  // void _bookAppointmentFinally(int doctorId, String? departmentId) {
  //   String patientId = PreferenceUtils.getStringValue("id") ?? "";
  //
  //   isBookingLoading = true;
  //   update();
  //   CommonLoader.showLoader(
  //       title: "Booking Appointment...", subtitle: "Please wait a moment");
  //
  //   StringUtils.client
  //       .createAppointment(
  //           PreferenceUtils.getStringValue("token"),
  //           departmentId ?? "",
  //           doctorId.toString(),
  //           selectedDate!,
  //           selectedTime!,
  //           selectedToken ?? 0,
  //           patientId,
  //           descriptionController.text)
  //       .then((value) {
  //     CommonLoader.hideLoader();
  //
  //     createAppointmentModel = value;
  //     isBookingLoading = false;
  //
  //     if (value.success == true) {
  //       _currentAppointmentId = value.appointmentId ??
  //           value.data?.appointmentId ??
  //           value.data?.id ??
  //           0;
  //
  //       if (paymentMethod == "online") {
  //         _initiateRazorpayPayment(_currentAppointmentId!);
  //       } else {
  //         DisplaySnackBar.displaySnackBar(
  //             "Appointment Booked Successfully", 3, ColorConst.greenColor);
  //         _refreshHomeData();
  //         router.go('/home');
  //       }
  //     } else {
  //       DisplaySnackBar.displaySnackBar(
  //           value.message ?? "Booking Failed", 3, ColorConst.redColor);
  //     }
  //     update();
  //   }).onError((error, stackTrace) {
  //     CommonLoader.hideLoader();
  //     isBookingLoading = false;
  //
  //     if (error is DioException) {
  //       if (error.response?.statusCode == 500) {
  //         final errorData = error.response?.data.toString() ?? "";
  //         if (errorData.contains("SendPushNotificationJob") ||
  //             (errorData.contains("Class") &&
  //                 errorData.contains("not found")) ||
  //             errorData.contains("queue connection")) {
  //           _refreshHomeData();
  //           router.go('/home');
  //           update();
  //           return;
  //         }
  //       }
  //
  //       if (error.response?.statusCode == 422 &&
  //           error.response?.data != null &&
  //           error.response!.data
  //               .toString()
  //               .toLowerCase()
  //               .contains("already booked")) {
  //         DisplaySnackBar.displaySnackBar(
  //             "Slot is already booked. Please check your appointments.",
  //             3,
  //             ColorConst.orangeColor);
  //         //_refreshHomeData();
  //         //router.go('/home');
  //         update();
  //         return;
  //       }
  //       CheckSocketException.checkSocketException(error);
  //     } else {
  //       DisplaySnackBar.displaySnackBar(
  //           "An unexpected error occurred", 3, ColorConst.redColor);
  //     }
  //
  //     update();
  //   });
  // }

  void _bookAppointmentFinally(int doctorId, String? departmentId) {
    String patientId = PreferenceUtils.getStringValue("id") ?? "";

    isBookingLoading = true;
    update();
    CommonLoader.showLoader(
        title: "Booking Appointment...", subtitle: "Please wait a moment");

    // 1. Prepare the base data
    Map<String, dynamic> body = {
      "doctor_id": doctorId.toString(),
      "opd_date": selectedDate!,
      "token_number": selectedToken ?? 0,
      "department_id": departmentId ?? "",
      "appointment_type": appointmentTypeApi,

      "problem": descriptionController.text,
      "patient_id": patientId,
      "time": selectedTime!,
    };

    // if (appointmentTypeFilter != 1 && appointmentTypeFilter != 2) {
    //   body["special_token_type"] = appointmentTypeApi;
    // }
    // 2. Add dependent data if "Someone Else" is selected
    if (appointmentType == 'someone_else' && guestPatientDetails != null) {
      body["dependent"] = {
        // "name": guestPatientDetails!["name"],
        "first_name": guestPatientDetails!["first_name"],
        "last_name": guestPatientDetails!["last_name"],
        // "relation": ,
        "age": guestPatientDetails!["age"],
        "gender": guestPatientDetails!["gender"],
        "phone": guestPatientDetails!["phone"],
        "dob": guestPatientDetails!["dob"],
        "blood_group": guestPatientDetails!["blood_group"],
        "email": "",
      };
    }

    // DEBUG PRINT: Check if data is passing correctly
    print("------- APPOINTMENT POST DATA -------");
    print(const JsonEncoder.withIndent('  ').convert(body));
    print("-------------------------------------");

    StringUtils.client
        .createAppointment(PreferenceUtils.getStringValue("token"), body)
        .then((value) {
      CommonLoader.hideLoader();
      print("API Response Success: ${value.success}");

      createAppointmentModel = value;
      isBookingLoading = false;

      if (value.success == true) {
        _currentAppointmentId = value.appointmentId ??
            value.data?.appointmentId ??
            value.data?.id ??
            0;

        if (paymentMethod == "online") {
          _initiateRazorpayPayment(_currentAppointmentId!);
        } else {
          DisplaySnackBar.displaySnackBar(
              "Appointment Booked Successfully", 3, ColorConst.greenColor);
          _refreshHomeData();
          router.go('/home');
        }
      } else {
        DisplaySnackBar.displaySnackBar(
            value.message ?? "Booking Failed", 3, ColorConst.redColor);
      }
      update();
    }).onError((error, stackTrace) {
      CommonLoader.hideLoader();
      isBookingLoading = false;

      print("API Error: $error");

      if (error is DioException) {
        print("Error Response: ${error.response?.data}");
        if (error.response?.statusCode == 500) {
          final errorData = error.response?.data.toString() ?? "";
          if (errorData.contains("SendPushNotificationJob") ||
              (errorData.contains("Class") && errorData.contains("not found")) ||
              errorData.contains("queue connection")) {
            _refreshHomeData();
            router.go('/home');
            update();
            return;
          }
        }

        if (error.response?.statusCode == 422 &&
            error.response?.data != null &&
            error.response!.data
                .toString()
                .toLowerCase()
                .contains("already booked")) {
          DisplaySnackBar.displaySnackBar(
              "Slot is already booked. Please check your appointments.",
              3,
              ColorConst.orangeColor);
          update();
          return;
        }
        CheckSocketException.checkSocketException(error);
      } else {
        DisplaySnackBar.displaySnackBar(
            "An unexpected error occurred", 3, ColorConst.redColor);
      }
      update();
    });
  }
  void _initiateRazorpayPayment(int appointmentId) {
    CommonLoader.showLoader(
        title: "Loading Razorpay...", subtitle: "Please wait");
    int amount = 0;
    if (slotBookingModel?.data?.appointment_charge != null) {
      amount =
          double.parse(slotBookingModel!.data!.appointment_charge.toString())
              .toInt();
    }

    StringUtils.client
        .getPaymentGateways(PreferenceUtils.getStringValue("token"))
        .then((gatewayResponse) {
      if (gatewayResponse.success == true &&
          gatewayResponse.data?.razorpay == true &&
          gatewayResponse.data?.razorpayKey != null &&
          gatewayResponse.data!.razorpayKey!.isNotEmpty) {
        StringUtils.client
            .createRazorpayPayment(
                PreferenceUtils.getStringValue("token"), appointmentId, amount)
            .then((paymentResponse) {
          Get.back();

          if (paymentResponse.success == true &&
              paymentResponse.data != null &&
              paymentResponse.data!.success == true) {
            _currentRazorpayOrderId = paymentResponse.data!.orderId;

            int finalAmount = paymentResponse.data!.amount ?? 0;
            if (finalAmount < 1000) {
              finalAmount = finalAmount * 100;
            }

            var options = {
              'key': gatewayResponse.data!.razorpayKey,
              'amount': finalAmount,
              'name': 'Doctor Helix',
              'currency': paymentResponse.data!.currency ?? 'INR',
              'description': 'Appointment Booking #$appointmentId',
              'order_id': _currentRazorpayOrderId,
              'prefill': {
                'contact': PreferenceUtils.getStringValue("phone_number"),
                'email': PreferenceUtils.getStringValue("email")
              },
              'timeout': 300,
            };

            try {
              _razorpay.open(options);
            } catch (e) {
              DisplaySnackBar.displaySnackBar(
                  "Error opening Razorpay", 3, ColorConst.redColor);
            }
          } else {
            DisplaySnackBar.displaySnackBar(
                paymentResponse.message ??
                    ((paymentResponse.data?.success == false)
                        ? "Payment initiation failed"
                        : "Failed to initiate payment"),
                3,
                ColorConst.redColor);
          }
        }).catchError((error) {
          CommonLoader.hideLoader();
          DisplaySnackBar.displaySnackBar(
              "Error creating payment order", 3, ColorConst.redColor);
        });
      } else {
        CommonLoader.hideLoader();
        DisplaySnackBar.displaySnackBar(
            "Razorpay is not enabled or key is missing",
            3,
            ColorConst.redColor);
      }
    }).catchError((error) {
      CommonLoader.hideLoader();
      DisplaySnackBar.displaySnackBar(
          "Error fetching payment gateways", 3, ColorConst.redColor);
    });
  }

  void _refreshHomeData() {
    if (Get.isRegistered<HomeController>()) {
      final hc = Get.find<HomeController>();
      hc.changeBottomNavIndex(0);
    }
    if (Get.isRegistered<PatientHomeController>()) {
      Get.find<PatientHomeController>().refreshData();
    }
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
