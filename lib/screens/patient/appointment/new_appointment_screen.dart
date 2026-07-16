// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_dropdown_button.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_required_text.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/appointment_controller/new_appointment_controller.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/slot_booking/slot_booking_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/skeleton_loading_widgets.dart';
//
// class NewAppointmentScreen extends StatelessWidget {
//   const NewAppointmentScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).requestFocus(FocusNode());
//       },
//       child: Scaffold(
//         backgroundColor: ColorConst.bgGreyColor, // A softer background
//         appBar: CommonAppBar(
//           title: StringUtils.newAppointment,
//           leadOnTap: () {
//             Get.back();
//           },
//           leadIcon: const Icon(
//             Icons.arrow_back_rounded,
//             color: ColorConst.blackColor,
//           ),
//         ),
//         body: GetBuilder<NewAppointmentController>(
//           init: NewAppointmentController(),
//           builder: (controller) {
//             if (controller.doctorDepartmentModel == null) {
//               return const NewAppointmentSkeleton();
//             }
//
//             return SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // --- SECTION 1: SPECIALIST DETAILS ---
//                   _buildSectionContainer(
//                     title: "Specialist Details",
//                     icon: Icons.medical_services_outlined,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CommonRequiredText(
//                           width: width,
//                           text: StringUtils.doctorDepartment,
//                         ),
//                         const SizedBox(height: 8),
//                         _buildDropdownWrapper(
//                           CommonDropDown(
//                             value: controller.departmentId,
//                             onChange: (value) {
//                               controller.dateController.clear();
//                               controller.departmentId = value;
//                               controller.isSelectDate = false;
//                               controller.getDoctorName(int.parse(value!));
//                             },
//                             hintText: StringUtils.selectDepartment,
//                             dropdownItems: controller
//                                 .doctorDepartmentModel!.data!
//                                 .map((value) {
//                               return DropdownMenuItem(
//                                 value: value.id.toString(),
//                                 child: Text(
//                                   value.title!,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyleConst.mediumTextStyle(
//                                     ColorConst.blackColor,
//                                     width * 0.04,
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         CommonRequiredText(
//                           width: width,
//                           text: StringUtils.doctor,
//                         ),
//                         const SizedBox(height: 8),
//                         _buildDropdownWrapper(
//                           CommonDropDown(
//                             value: controller.doctorId,
//                             onChange: (value) {
//                               controller.onDoctorSelected(value!);
//                             },
//                             hintText: StringUtils.selectDoctor,
//                             dropdownItems: controller
//                                         .isSelectDoctorDepartment !=
//                                     false
//                                 ? controller.getDoctorModel!.data!.map((value) {
//                                     return DropdownMenuItem(
//                                       value: value.id.toString(),
//                                       child: Text(
//                                         value.title!,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyleConst.mediumTextStyle(
//                                           ColorConst.blackColor,
//                                           width * 0.04,
//                                         ),
//                                       ),
//                                     );
//                                   }).toList()
//                                 : [],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//
//                   // --- SECTION 2: DATE & TIME ---
//                   _buildSectionContainer(
//                     title: "Date & Time",
//                     icon: Icons.calendar_month_outlined,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CommonRequiredText(
//                           width: width,
//                           text: StringUtils.date,
//                         ),
//                         const SizedBox(height: 10),
//                         // Month Header
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                               onTap: () => controller.prevMonth(),
//                               child: Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: ColorConst.lightGreyColor,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(Icons.arrow_back_ios_new,
//                                     size: 16, color: Colors.black54),
//                               ),
//                             ),
//                             Text(
//                               DateFormat('MMMM yyyy')
//                                   .format(controller.focusedDate),
//                               style: TextStyleConst.boldTextStyle(
//                                 ColorConst.blackColor,
//                                 width * 0.045,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () => controller.nextMonth(),
//                               child: Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: ColorConst.lightGreyColor,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(Icons.arrow_forward_ios,
//                                     size: 16, color: Colors.black54),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 15),
//                         // Horizontal Date List
//                         SizedBox(
//                           height: height * 0.09,
//                           child: ListView.builder(
//                             controller: controller.dateScrollController,
//                             scrollDirection: Axis.horizontal,
//                             itemCount: controller.visibleDates.length,
//                             physics: const BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               final date = controller.visibleDates[index];
//                               final isSelected = controller.selectedDate ==
//                                   "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//
//                               return GestureDetector(
//                                 onTap: () {
//                                   controller.onDateSelected(date, context);
//                                 },
//                                 child: Container(
//                                   width: width * 0.16,
//                                   margin: const EdgeInsets.only(right: 12),
//                                   decoration: BoxDecoration(
//                                     color: isSelected
//                                         ? ColorConst.primaryColor
//                                         : Colors.white,
//                                     borderRadius: BorderRadius.circular(15),
//                                     border: Border.all(
//                                       width: 1.5,
//                                       color: isSelected
//                                           ? ColorConst.primaryColor
//                                           : Colors.grey.shade300,
//                                     ),
//                                     boxShadow: isSelected
//                                         ? [
//                                             BoxShadow(
//                                               color: ColorConst.primaryColor
//                                                   .withOpacity(0.3),
//                                               blurRadius: 8,
//                                               offset: const Offset(0, 4),
//                                             )
//                                           ]
//                                         : [],
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         DateFormat('EEE')
//                                             .format(date)
//                                             .toUpperCase(),
//                                         style: TextStyleConst.mediumTextStyle(
//                                           isSelected
//                                               ? Colors.white70
//                                               : Colors.grey,
//                                           12,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Text(
//                                         date.day.toString(),
//                                         style: TextStyleConst.boldTextStyle(
//                                           isSelected
//                                               ? Colors.white
//                                               : Colors.black87,
//                                           18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//
//                         // Slots Section
//                         if (controller.isSelectDate != false) ...[
//                           const SizedBox(height: 25),
//                           CommonRequiredText(
//                             width: width,
//                             text: StringUtils.slotAvailable,
//                           ),
//                           const SizedBox(height: 15),
//                           if (controller.slotBookingModel!.data!.bookingSlotArr!
//                               .isNotEmpty)
//                             _buildSlotsGrid(controller, width)
//                           else
//                             Container(
//                               padding: const EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                 color: ColorConst.redColor.withOpacity(0.05),
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color:
//                                         ColorConst.redColor.withOpacity(0.3)),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(Icons.event_busy,
//                                       color: ColorConst.redColor),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     "No slots available",
//                                     style: TextStyleConst.mediumTextStyle(
//                                       ColorConst.redColor,
//                                       width * 0.04,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                         ]
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//
//                   // --- SECTION 3: ADDITIONAL DETAILS ---
//                   _buildSectionContainer(
//                     title: "Additional Details",
//                     icon: Icons.notes_outlined,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CommonRequiredText(
//                           width: width,
//                           text: StringUtils.description,
//                         ),
//                         const SizedBox(height: 10),
//                         CommonTextField(
//                           keyBoardType: TextInputType.multiline,
//                           maxLine: 4,
//                           onTap: () {},
//                           validator: (value) {
//                             return null;
//                           },
//                           controller: controller.descriptionController,
//                           hintText: "Briefly describe your symptoms here...",
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//
//                   // --- BOOKING BUTTON SUMMARY ---
//                   if (controller.isSelectDate != false &&
//                       controller.slotBookingModel?.data?.appointment_charge !=
//                           null)
//                     Container(
//                       margin: const EdgeInsets.only(bottom: 15),
//                       padding: const EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                         color: ColorConst.lightGreyColor.withOpacity(0.5),
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: Colors.grey.shade300),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Total Appointment Charge",
//                             style: TextStyleConst.mediumTextStyle(
//                               ColorConst.blackColor,
//                               width * 0.04,
//                             ),
//                           ),
//                           Text(
//                             "₹ ${controller.slotBookingModel?.data?.appointment_charge ?? 0}",
//                             style: TextStyleConst.boldTextStyle(
//                               ColorConst.primaryColor,
//                               width * 0.045,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                   // Payment Method Section
//                   if (controller.isSelectDate != false)
//                     _buildSectionContainer(
//                       title: "Payment Method",
//                       icon: Icons.payment_outlined,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: InkWell(
//                               onTap: () {
//                                 controller.paymentMethod = "onsite";
//                                 controller.update();
//                               },
//                               child: Container(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 12),
//                                 decoration: BoxDecoration(
//                                   color: controller.paymentMethod == "onsite"
//                                       ? ColorConst.primaryColor.withOpacity(0.1)
//                                       : Colors.transparent,
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: controller.paymentMethod == "onsite"
//                                         ? ColorConst.primaryColor
//                                         : Colors.grey.shade300,
//                                   ),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "Onsite",
//                                     style: TextStyleConst.mediumTextStyle(
//                                       controller.paymentMethod == "onsite"
//                                           ? ColorConst.primaryColor
//                                           : Colors.black87,
//                                       14,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           if (controller.isOnlinePaymentAvailable) ...[
//                             const SizedBox(width: 15),
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   controller.paymentMethod = "online";
//                                   controller.update();
//                                 },
//                                 child: Container(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 12),
//                                   decoration: BoxDecoration(
//                                     color: controller.paymentMethod == "online"
//                                         ? ColorConst.primaryColor
//                                             .withOpacity(0.1)
//                                         : Colors.transparent,
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                       color:
//                                           controller.paymentMethod == "online"
//                                               ? ColorConst.primaryColor
//                                               : Colors.grey.shade300,
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "Online",
//                                       style: TextStyleConst.mediumTextStyle(
//                                         controller.paymentMethod == "online"
//                                             ? ColorConst.primaryColor
//                                             : Colors.black87,
//                                         14,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                   const SizedBox(height: 15),
//
//
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             );
//           },
//         ),
//         bottomNavigationBar: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CommonButton(
//               textStyleConst: TextStyleConst.mediumTextStyle(
//                   ColorConst.whiteColor, width * 0.05),
//               onTap: () {
//                 Get.find<NewAppointmentController>().createNewAppointment();
//               },
//               color: ColorConst.primaryColor,
//               text: StringUtils.bookAppointment,
//               width: width,
//               height: 55,
//             ),
//           ),
//         ),
//       ),
//
//     );
//   }
//
//   // Helper function to create clean card sections
//   Widget _buildSectionContainer({
//     required String title,
//     required IconData icon,
//     required Widget child,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: ColorConst.primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(icon, color: ColorConst.primaryColor, size: 20),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 title,
//                 style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
//               ),
//             ],
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 12),
//             child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
//           ),
//           child,
//         ],
//       ),
//     );
//   }
//
//   // Wrapper to standardize dropdown box decorations naturally
//   Widget _buildDropdownWrapper(Widget dropdown) {
//     return Container(
//       decoration: BoxDecoration(
//         color: ColorConst.bgGreyColor.withOpacity(0.5),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: dropdown,
//     );
//   }
//
//   // Slots grid specific to the old token logic preserved carefully.
//   Widget _buildSlotsGrid(NewAppointmentController controller, double width) {
//     final isTokenBased =
//         controller.slotBookingModel!.data!.schedule_type == 'token_based';
//     final slots = controller.slotBookingModel!.data!.bookingSlotArr!;
//
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: slots.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: isTokenBased ? 4 : 3,
//         childAspectRatio: 2.2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemBuilder: (context, index) {
//         final slotData = slots[index];
//         String timeString = "";
//         bool isBooked = false;
//
//         if (isTokenBased) {
//           final token = BookingToken.fromJson(slotData as Map<String, dynamic>);
//           isBooked = token.isBooked == true;
//           timeString = token.token.toString();
//         } else {
//           if (slotData is Map<String, dynamic>) {
//             timeString = slotData['time']?.toString() ?? "";
//             isBooked = slotData['isBooked'] == true;
//           } else {
//             timeString = slotData.toString();
//           }
//         }
//
//         final isSelected = isTokenBased
//             ? controller.selectedTime == timeString
//             : controller.currentIndex == index;
//
//         return GestureDetector(
//           onTap: isBooked
//               ? null
//               : () {
//                   controller.currentIndex = index;
//                   controller.selectedTime = timeString;
//                   controller.update();
//                 },
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 250),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: isBooked
//                   ? Colors.grey.shade100
//                   : isSelected
//                       ? ColorConst.primaryColor
//                       : Colors.white,
//               border: Border.all(
//                 color: isBooked
//                     ? Colors.grey.shade300
//                     : isSelected
//                         ? ColorConst.primaryColor
//                         : Colors.grey.shade300,
//                 width: isSelected ? 2 : 1.5,
//               ),
//               boxShadow: isSelected
//                   ? [
//                       BoxShadow(
//                         color: ColorConst.primaryColor.withOpacity(0.3),
//                         blurRadius: 6,
//                         offset: const Offset(0, 3),
//                       )
//                     ]
//                   : [],
//             ),
//             child: Center(
//               child: Text(
//                 timeString,
//                 style: TextStyleConst.mediumTextStyle(
//                   isBooked
//                       ? Colors.grey.shade400
//                       : isSelected
//                           ? Colors.white
//                           : ColorConst.blackColor,
//                   width * (isTokenBased ? 0.04 : 0.035),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
