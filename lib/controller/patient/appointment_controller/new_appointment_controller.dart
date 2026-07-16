// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/create_appointment/create_appointment_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/doctor/doctor_department_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/doctor/get_doctor_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/slot_booking/slot_booking_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/main.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
//
// import '../home_controller/patient_home_controller.dart';
//
// class NewAppointmentController extends GetxController {
//   final TextEditingController doctorController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//
//   late Razorpay _razorpay;
//   String paymentMethod = "onsite";
//
//   DoctorDepartmentModel? doctorDepartmentModel;
//   SlotBookingModel? slotBookingModel;
//   GetDoctorModel? getDoctorModel;
//   CreateAppointmentModel? createAppointmentModel;
//   DateTime? oldValue;
//
//   String? doctorId;
//   String? departmentId;
//   String? selectedDate;
//   String? selectedTime;
//
//   int currentIndex = 0;
//
//   bool isSelectDate = false;
//   bool isSelectDoctorDepartment = false;
//   bool isSelectDoctor = false;
//
//   bool isOnlinePaymentAvailable = false;
//
//   List<DateTime> visibleDates = [];
//   ScrollController dateScrollController = ScrollController();
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//     _generateDates();
//     _checkPaymentGateway();
//     StringUtils.client
//         .getDoctorDepartment(PreferenceUtils.getStringValue("token"))
//       ..then((value) {
//         doctorDepartmentModel = value;
//         update();
//
//         if (Get.arguments != null) {
//           final args = Get.arguments as Map<String, dynamic>;
//           final passedDoctorId = args['doctorId']?.toString();
//           final departmentName = args['departmentName'];
//
//           if (departmentName != null && doctorDepartmentModel?.data != null) {
//             final dept = doctorDepartmentModel!.data!
//                 .firstWhereOrNull((element) => element.title == departmentName);
//             if (dept != null) {
//               departmentId = dept.id.toString();
//               getDoctorName(dept.id!, targetDoctorId: passedDoctorId);
//             }
//           }
//         }
//       })
//       ..onError((DioException error, stackTrace) {
//         CheckSocketException.checkSocketException(error);
//         return DoctorDepartmentModel();
//       });
//   }
//
//   DateTime focusedDate = DateTime.now();
//
//   void _checkPaymentGateway() {
//     StringUtils.client
//         .getPaymentGateways(PreferenceUtils.getStringValue("token"))
//         .then((gatewayResponse) {
//       if (gatewayResponse.success == true && gatewayResponse.data != null) {
//         final data = gatewayResponse.data!;
//         bool hasRazorpay = data.razorpay == true &&
//             data.razorpayKey != null &&
//             data.razorpayKey!.isNotEmpty;
//         bool hasStripe = data.stripe == true &&
//             data.stripeKey != null &&
//             data.stripeKey!.isNotEmpty;
//         bool hasPaypal = data.paypal == true &&
//             data.paypalClientId != null &&
//             data.paypalClientId!.isNotEmpty;
//         bool hasPaystack = data.paystack == true &&
//             data.paystackPublicKey != null &&
//             data.paystackPublicKey!.isNotEmpty;
//         bool hasPhonepe = data.phonepe == true &&
//             data.phonepeMerchantId != null &&
//             data.phonepeMerchantId!.isNotEmpty;
//         bool hasFlutterwave = data.flutterwave == true &&
//             data.flutterwavePublicKey != null &&
//             data.flutterwavePublicKey!.isNotEmpty;
//
//         isOnlinePaymentAvailable = hasRazorpay ||
//             hasStripe ||
//             hasPaypal ||
//             hasPaystack ||
//             hasPhonepe ||
//             hasFlutterwave;
//
//         if (!isOnlinePaymentAvailable && paymentMethod == "online") {
//           paymentMethod = "onsite";
//         }
//
//         update();
//       }
//     }).catchError((error) {
//       print("Error fetching payment gateways: $error");
//     });
//   }
//
//   void _generateDates() {
//     visibleDates.clear();
//     final now = DateTime.now();
//
//     // Determine start date
//     DateTime startDate;
//     if (focusedDate.year == now.year && focusedDate.month == now.month) {
//       startDate = now;
//     } else {
//       startDate = DateTime(focusedDate.year, focusedDate.month, 1);
//     }
//
//     // Determine end date (last day of the focused month)
//     final lastDay = DateTime(focusedDate.year, focusedDate.month + 1, 0).day;
//
//     for (int i = startDate.day; i <= lastDay; i++) {
//       visibleDates.add(DateTime(focusedDate.year, focusedDate.month, i));
//     }
//   }
//
//   void nextMonth() {
//     focusedDate = DateTime(focusedDate.year, focusedDate.month + 1, 1);
//     _generateDates();
//     update();
//   }
//
//   void prevMonth() {
//     final now = DateTime.now();
//     if (focusedDate.year > now.year ||
//         (focusedDate.year == now.year && focusedDate.month > now.month)) {
//       focusedDate = DateTime(focusedDate.year, focusedDate.month - 1, 1);
//       _generateDates();
//       update();
//     }
//   }
//
//   void onDateSelected(DateTime date, BuildContext context) {
//     selectedDate =
//         "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//     dateController.text = selectedDate!;
//     oldValue = date;
//
//     // Reset slots when date changes
//     slotBookingModel = null;
//     selectedTime = null;
//     isSelectDate = false;
//     currentIndex = 0;
//
//     update();
//     fetchSlots();
//   }
//
//   getDoctorName(int id, {String? targetDoctorId}) {
//     StringUtils.client.getDoctor(PreferenceUtils.getStringValue("token"), id)
//       ..then((value) {
//         getDoctorModel = value;
//         if (targetDoctorId != null &&
//             (value.data?.any(
//                     (element) => element.id.toString() == targetDoctorId) ??
//                 false)) {
//           doctorId = targetDoctorId;
//         } else {
//           doctorId = (value.data?.isEmpty ?? true)
//               ? null
//               : value.data?[0].id.toString();
//         }
//         isSelectDoctor = true;
//         isSelectDoctorDepartment = true;
//
//         if (doctorId != null) {
//           onDoctorSelected(doctorId!);
//         } else {
//           update();
//         }
//       })
//       ..onError((DioException error, stackTrace) {
//         CheckSocketException.checkSocketException(error);
//         return GetDoctorModel();
//       });
//   }
//
//   Future<void> selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: oldValue ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       oldValue = picked;
//       selectedDate =
//           "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
//       dateController.text = selectedDate!;
//     }
//   }
//
//   void onDoctorSelected(String id) {
//     doctorId = id;
//
//     // Auto-select today
//     final now = DateTime.now();
//     onDateSelected(now, Get.context!);
//   }
//
//   fetchSlots() {
//     if (isSelectDoctor && selectedDate != null) {
//       StringUtils.client
//           .getBookingSlotDate(PreferenceUtils.getStringValue("token"),
//               selectedDate!, doctorId ?? "")
//           .then((value) {
//         slotBookingModel = value;
//         isSelectDate = true;
//
//         selectedTime = null;
//         currentIndex = -1; // Reset selection
//
//         if (slotBookingModel!.data!.bookingSlotArr!.isNotEmpty) {
//           if (slotBookingModel!.data!.schedule_type != 'token_based') {
//             // Find the first available (not booked) time slot
//             bool foundAvailable = false;
//             for (int i = 0;
//                 i < slotBookingModel!.data!.bookingSlotArr!.length;
//                 i++) {
//               final slotData = slotBookingModel!.data!.bookingSlotArr![i];
//               if (slotData is Map<String, dynamic>) {
//                 if (slotData['isBooked'] != true) {
//                   selectedTime = slotData['time'].toString();
//                   currentIndex = i;
//                   foundAvailable = true;
//                   break;
//                 }
//               } else {
//                 // Fallback for old string format just in case
//                 selectedTime = slotData.toString();
//                 currentIndex = 0;
//                 foundAvailable = true;
//                 break;
//               }
//             }
//             if (!foundAvailable) {
//               selectedTime = null;
//               currentIndex = -1;
//             }
//           }
//         }
//         update();
//       }).onError((DioException error, stackTrace) {
//         CheckSocketException.checkSocketException(error);
//       });
//     }
//   }
//
//   createNewAppointment() {
//     if (isSelectDoctorDepartment == false) {
//       DisplaySnackBar.displaySnackBar(
//           "Please select doctor department", 3, ColorConst.redColor);
//     } else if (isSelectDate == false) {
//       DisplaySnackBar.displaySnackBar(
//           "Please select date", 3, ColorConst.redColor);
//     } else if (isSelectDoctor == false) {
//       DisplaySnackBar.displaySnackBar(
//           "Please select doctor", 3, ColorConst.redColor);
//     } else if (slotBookingModel!.data!.bookingSlotArr!.isEmpty) {
//       DisplaySnackBar.displaySnackBar(
//           "Please select other date", 3, ColorConst.redColor);
//     }
//     // else if (descriptionController.text.isEmpty) {
//     //   DisplaySnackBar.displaySnackBar(
//     //       "Please enter description", 3, ColorConst.redColor);
//     // }
//     else {
//       // Create appointment first to get appointment_id
//       _bookAppointmentFinally();
//     }
//   }
//
//   String? _currentRazorpayOrderId;
//   int? _currentAppointmentId;
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     if (_currentRazorpayOrderId != null && response.paymentId != null) {
//       CommonLoader.showLoader(
//           title: "Verifying Payment...", subtitle: "Please wait");
//       StringUtils.client
//           .verifyRazorpayPayment(
//         PreferenceUtils.getStringValue("token"),
//         _currentRazorpayOrderId!,
//         response.paymentId!,
//         response.signature ?? "",
//       )
//           .then((value) {
//         if (value.success == true) {
//           DisplaySnackBar.displaySnackBar(
//               "Payment verified successfully!", 3, ColorConst.greenColor);
//           _refreshHomeData();
//           router.go('/home');
//         } else {
//           CommonLoader.hideLoader(); // Hide loader if verification fails
//           DisplaySnackBar.displaySnackBar(
//               value.message ?? "Payment verification failed",
//               3,
//               ColorConst.redColor);
//         }
//       }).catchError((error) {
//         CommonLoader.hideLoader();
//         DisplaySnackBar.displaySnackBar(
//             "An error occurred during verification", 3, ColorConst.redColor);
//       });
//     } else {
//       CommonLoader.hideLoader();
//       DisplaySnackBar.displaySnackBar(
//           "Payment Details Missing", 3, ColorConst.redColor);
//     }
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     if (_currentAppointmentId != null && paymentMethod == "online") {
//       CommonLoader.showLoader(
//           title: "Cancelling...", subtitle: "Cleaning up appointment");
//       StringUtils.client
//           .deleteAppointment(
//               PreferenceUtils.getStringValue("token"), _currentAppointmentId!)
//           .then((value) {
//         CommonLoader.hideLoader();
//         DisplaySnackBar.displaySnackBar(
//             "Payment Failed. ${response.message}", 3, ColorConst.redColor);
//       }).catchError((_) {
//         CommonLoader.hideLoader();
//         DisplaySnackBar.displaySnackBar(
//             "Payment Failed. ${response.message}", 3, ColorConst.redColor);
//       });
//     } else {
//       CommonLoader.hideLoader();
//       DisplaySnackBar.displaySnackBar(
//           "Payment Failed. ${response.message}", 3, ColorConst.redColor);
//     }
//   }
//
//   void _refreshHomeData() {
//     if (Get.isRegistered<HomeController>()) {
//       final hc = Get.find<HomeController>();
//       hc.changeBottomNavIndex(0);
//     }
//     if (Get.isRegistered<PatientHomeController>()) {
//       Get.find<PatientHomeController>().refreshData();
//     }
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     if (_currentAppointmentId != null && paymentMethod == "online") {
//       CommonLoader.showLoader(
//           title: "Cancelling...", subtitle: "Cleaning up appointment");
//       StringUtils.client
//           .deleteAppointment(
//               PreferenceUtils.getStringValue("token"), _currentAppointmentId!)
//           .then((value) {
//         CommonLoader.hideLoader();
//         DisplaySnackBar.displaySnackBar(
//             "External Wallet not supported here: ${response.walletName}",
//             3,
//             ColorConst.redColor);
//       }).catchError((_) {
//         CommonLoader.hideLoader();
//       });
//     } else {
//       CommonLoader.hideLoader();
//       DisplaySnackBar.displaySnackBar(
//           "External Wallet Selected: ${response.walletName}",
//           3,
//           ColorConst.primaryColor);
//     }
//   }
//
//   void _bookAppointmentFinally() {
//     CommonLoader.showLoader(
//         title: "Booking Appointment...", subtitle: "Please wait a moment");
//
//     // Determine time and token based on schedule type
//     String timeToSend = selectedTime!;
//     int? tokenToSend =
//         0; // Default to 0 so the key 'token_number' is sent (avoiding Undefined array key error)
//
//     if (slotBookingModel?.data?.schedule_type == 'token_based') {
//       timeToSend = "";
//       // selectedTime holds the token number as a string in this case
//       tokenToSend = int.tryParse(selectedTime ?? "");
//     }
//
//     StringUtils.client.createAppointment(
//       PreferenceUtils.getStringValue("token"),
//       departmentId!,
//       doctorId ?? "",
//       selectedDate!,
//       timeToSend,
//       tokenToSend,
//       PreferenceUtils.getStringValue("id"),
//       descriptionController.text,
//     )
//       ..then((value) {
//         Get.back(); // hide loader
//         createAppointmentModel = value;
//
//         if (value.success == true) {
//           // Sometimes the backend does not return the appointment ID in the response
//           // If we have an ID, use it. If not, default to 0 or another fallback we can agree on with the backend,
//           // or block the flow. However, let's allow it to pass 0 if the backend fails to provide it but reports success.
//           _currentAppointmentId = value.appointmentId ??
//               value.data?.appointmentId ??
//               value.data?.id ??
//               0;
//
//           if (paymentMethod == "online") {
//             // Initiate Razorpay flow
//             _initiateRazorpayPayment(_currentAppointmentId!);
//           } else {
//             DisplaySnackBar.displaySnackBar(
//                 value.message ?? "Appointment Booked Successfully",
//                 3,
//                 ColorConst.greenColor);
//             _refreshHomeData();
//             router.go('/appointments');
//           }
//         } else {
//           DisplaySnackBar.displaySnackBar(
//               value.message ?? "Appointment creation failed",
//               3,
//               ColorConst.redColor);
//         }
//       })
//       ..onError((error, stackTrace) {
//         Get.back(); // Hide loader
//         if (error is DioException) {
//           if (error.response?.statusCode == 500) {
//             final errorData = error.response?.data.toString() ?? "";
//             if (errorData.contains("SendPushNotificationJob") ||
//                 (errorData.contains("Class") &&
//                     errorData.contains("not found")) ||
//                 errorData.contains("queue connection")) {
//               DisplaySnackBar.displaySnackBar(
//                   "Appointment Failed", 3, ColorConst.redColor);
//               _refreshHomeData();
//               router.go('/appointments');
//               return CreateAppointmentModel();
//             }
//           }
//           if (error.response?.statusCode == 422 &&
//               error.response?.data != null &&
//               error.response!.data
//                   .toString()
//                   .toLowerCase()
//                   .contains("already booked")) {
//             DisplaySnackBar.displaySnackBar(
//                 "Slot is already booked", 3, ColorConst.orangeColor);
//             _refreshHomeData();
//             // router.go('/home');
//             return CreateAppointmentModel();
//           }
//           CheckSocketException.checkSocketException(error);
//         } else {
//           DisplaySnackBar.displaySnackBar(
//               "An unexpected error occurred", 3, ColorConst.redColor);
//         }
//         return CreateAppointmentModel();
//       });
//   }
//
//   void _initiateRazorpayPayment(int appointmentId) {
//     CommonLoader.showLoader(
//         title: "Loading Razorpay...", subtitle: "Please wait");
//     int amount = 0;
//     if (slotBookingModel?.data?.appointment_charge != null) {
//       amount =
//           double.parse(slotBookingModel!.data!.appointment_charge.toString())
//               .toInt();
//     }
//
//     StringUtils.client
//         .getPaymentGateways(PreferenceUtils.getStringValue("token"))
//         .then((gatewayResponse) {
//       if (gatewayResponse.success == true &&
//           gatewayResponse.data?.razorpay == true &&
//           gatewayResponse.data?.razorpayKey != null &&
//           gatewayResponse.data!.razorpayKey!.isNotEmpty) {
//         StringUtils.client
//             .createRazorpayPayment(
//                 PreferenceUtils.getStringValue("token"), appointmentId, amount)
//             .then((paymentResponse) {
//           Get.back(); // Hide initial loader
//
//           if (paymentResponse.success == true &&
//               paymentResponse.data != null &&
//               paymentResponse.data!.success == true) {
//             _currentRazorpayOrderId = paymentResponse.data!.orderId;
//
//             // Razorpay expects amount in paise (Rupees * 100)
//             int finalAmount = paymentResponse.data!.amount ?? 0;
//             if (finalAmount < 1000) {
//               finalAmount = finalAmount * 100;
//             }
//
//             var options = {
//               'key': gatewayResponse.data!.razorpayKey,
//               'amount': finalAmount,
//               'name': 'Doctor Helix',
//               'currency': paymentResponse.data!.currency ?? 'INR',
//               'description': 'Appointment Booking #$appointmentId',
//               'order_id': _currentRazorpayOrderId,
//               'prefill': {
//                 'contact': PreferenceUtils.getStringValue("phone_number"),
//                 'email': PreferenceUtils.getStringValue("email")
//               },
//               'timeout': 300, // 5 minutes
//             };
//
//             try {
//               _razorpay.open(options);
//             } catch (e) {
//               DisplaySnackBar.displaySnackBar(
//                   "Error opening Razorpay", 3, ColorConst.redColor);
//             }
//           } else {
//             DisplaySnackBar.displaySnackBar(
//                 paymentResponse.message ??
//                     ((paymentResponse.data?.success == false)
//                         ? "Payment initiation failed"
//                         : "Failed to initiate payment"),
//                 3,
//                 ColorConst.redColor);
//           }
//         }).catchError((error) {
//           Get.back(); // Hide loader
//           DisplaySnackBar.displaySnackBar(
//               "Error creating payment order", 3, ColorConst.redColor);
//         });
//       } else {
//         CommonLoader.hideLoader();
//         DisplaySnackBar.displaySnackBar(
//             "Razorpay is not enabled or key is missing",
//             3,
//             ColorConst.redColor);
//       }
//     }).catchError((error) {
//       CommonLoader.hideLoader();
//       DisplaySnackBar.displaySnackBar(
//           "Error fetching payment gateways", 3, ColorConst.redColor);
//     });
//   }
//
//   @override
//   void onClose() {
//     _razorpay.clear();
//     super.onClose();
//   }
// }
