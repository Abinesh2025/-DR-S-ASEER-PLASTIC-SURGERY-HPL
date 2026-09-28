import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/PatientSelectionWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/doctor_controller/doctor_details_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/slot_booking/slot_booking_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/rating_summary_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/reviews_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/write_review_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/skeleton_loading_widgets.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import '../../../utils/string_utils.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final dynamic doctor;
  final int doctorId;

  const DoctorDetailsScreen(
      {Key? key, required this.doctor, required this.doctorId})
      : super(key: key);

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  late final DoctorDetailsController controller;
  int appointmentTypeFilter = 1;

// For API
  String? selectedSpecialTokenType;
  int? selectedSpecialTokenId;
  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<DoctorDetailsController>()) {
      controller = Get.put(DoctorDetailsController());
    } else {
      controller = Get.find<DoctorDetailsController>();
    }
    controller.resetToToday();
    // Fetch details once on entry
    controller.getDoctorDetails(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    String? getDepartmentId(DoctorDetailsController controller) {
      if (controller.doctorProfile != null) {
        return controller.doctorProfile!.doctorDepartmentId?.toString();
      }

      if (widget.doctor.runtimeType.toString() == 'DoctorListData') {
        return widget.doctor.departmentId?.toString();
      }

      try {
        return widget.doctor.doctorDepartmentId?.toString() ??
            widget.doctor.departmentId?.toString();
      } catch (e) {
        return null;
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA), // Light grey background
        body: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.black87, size: 18),
                      ),
                    ),
                    Text(
                      "Doctor Details",
                      style: TextStyleConst.boldTextStyle(Colors.black87, 18),
                    ),
                    const SizedBox(width: 40), // Balance
                  ],
                ),
              ),

              Expanded(
                child:
                    GetBuilder<DoctorDetailsController>(builder: (controller) {
                  // Helper to extract data safely, prioritizing fetched profile
                  String? getName() {
                    if (controller.doctorProfile != null) {
                      return controller.doctorProfile!.doctorName;
                    }
                    if (widget.doctor.runtimeType.toString() ==
                        'DoctorListData') {
                      return widget.doctor.name;
                    }
                    try {
                      return widget.doctor.doctorName ??
                          widget.doctor.name ??
                          widget.doctor.title;
                    } catch (e) {
                      return null;
                    }
                  }

                  String? getDepartment() {
                    if (controller.doctorProfile != null) {
                      return controller.doctorProfile!.doctorDepartment;
                    }
                    if (widget.doctor.runtimeType.toString() ==
                        'DoctorListData') {
                      return widget.doctor.department;
                    }
                    try {
                      return widget.doctor.doctorDepartment ??
                          widget.doctor.department;
                    } catch (e) {
                      return null;
                    }
                  }

                  String? getImageUrl() {
                    if (controller.doctorProfile != null) {
                      return controller.doctorProfile!.doctorImage;
                    }
                    if (widget.doctor.runtimeType.toString() ==
                        'DoctorListData') {
                      return widget.doctor.imageUrl;
                    }
                    try {
                      return widget.doctor.doctorImage ??
                          widget.doctor.imageUrl ??
                          widget.doctor.doctor_image_url;
                    } catch (e) {
                      return null;
                    }
                  }

                  String? getDescription() {
                    if (controller.doctorProfile != null) {
                      return controller.doctorProfile!.description;
                    }
                    if (widget.doctor.runtimeType.toString() ==
                        'DoctorListData') {
                      return widget.doctor.description;
                    }
                    return null;
                  }

                  final profile = controller.doctorProfile;

                  return RefreshIndicator(
                      onRefresh: () async {
                        await controller.refreshData(widget.doctorId);
                      },
                      color: ColorConst.primaryColor,
                      backgroundColor: Colors.white,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Premium Doctor Card
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  // Doctor Image with premium border
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: ColorConst.primaryColor
                                              .withOpacity(0.1),
                                          width: 4),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Builder(builder: (context) {
                                        String? imageUrl = getImageUrl();
                                        if (imageUrl != null &&
                                            imageUrl.isNotEmpty) {
                                          return Image.network(imageUrl,
                                              fit: BoxFit.cover,
                                              errorBuilder: (c, e, s) =>
                                                  Image.asset(
                                                      ImageUtils.doctorIcon));
                                        }
                                        return Image.asset(
                                            ImageUtils.doctorIcon,
                                            fit: BoxFit.cover);
                                      }),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  // Name and specialization
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getName() ?? "Unknown Doctor",
                                          style: TextStyleConst.boldTextStyle(
                                              Colors.black87, 20),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: ColorConst.primaryColor
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            profile?.specialist ??
                                                getDepartment() ??
                                                "Specialist",
                                            style: TextStyleConst.boldTextStyle(
                                                ColorConst.primaryColor, 12),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        if (profile?.qualification != null)
                                          Text(
                                            profile!.qualification!,
                                            style:
                                                TextStyleConst.mediumTextStyle(
                                                    Colors.grey, 14),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // About Doctor
                                  _buildSectionTitle("Doctor Biography"),
                                  const SizedBox(height: 10),
                                  Builder(builder: (context) {
                                    if (controller.isLoadingDoctorDetails &&
                                        controller.doctorProfile == null) {
                                      return const Skeleton(
                                          height: 60,
                                          width: double.infinity,
                                          borderRadius: 10);
                                    }
                                    String? desc = getDescription();
                                    if (desc == null ||
                                        desc.trim().isEmpty ||
                                        desc.trim().toUpperCase() == "N/A") {
                                      desc =
                                          "Dr. ${getName() ?? 'Doctor'} is a highly skilled specialist in ${getDepartment() ?? 'General Medicine'}. Dedicated to providing comprehensive care with a focus on patient well-being.";
                                    }
                                    return Text(
                                      desc,
                                      style: TextStyleConst.regularTextStyle(
                                          Colors.grey.shade600, 16),
                                      textAlign: TextAlign.justify,
                                    );
                                  }),


                                   const SizedBox(height: 14),
                                   // Appointment Type
                                   _buildSectionTitle("Appointment Type"),
                                   const SizedBox(height: 10),
                                   _buildAppointmentTypeFilter(controller),

                                   const SizedBox(height: 12),
                                   // Queue Policy in full line next to/below NEW OPD and NEW FOLLOW UP
                                   Container(
                                     width: double.infinity,
                                     padding: const EdgeInsets.symmetric(
                                         horizontal: 10, vertical: 8),
                                     decoration: BoxDecoration(
                                       color: const Color(0xffFFF8EE),
                                       borderRadius: BorderRadius.circular(8),
                                       border: Border.all(
                                           color: const Color(0xffFDE3BA)),
                                     ),
                                     child: Row(
                                       crossAxisAlignment:
                                           CrossAxisAlignment.center,
                                       children: [
                                         const Icon(
                                           Icons.info_outline,
                                           size: 16,
                                           color: Color(0xffD97706),
                                         ),
                                         const SizedBox(width: 8),
                                         Expanded(
                                           child: RichText(
                                             text: TextSpan(
                                               style: TextStyleConst
                                                   .regularTextStyle(
                                                 const Color(0xff92400E),
                                                 11,
                                               ),
                                               children: [
                                                 TextSpan(
                                                   text: "Queue Policy: ",
                                                   style: TextStyleConst
                                                       .boldTextStyle(
                                                     const Color(0xffB45309),
                                                     11,
                                                   ),
                                                 ),
                                                 const TextSpan(
                                                   text:
                                                       "If your token is called and you are not present, priority passes to patients currently waiting.",
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   
                                   const SizedBox(height: 20),
                                  // Schedules
                                   Row(
                                     mainAxisAlignment:
                                         MainAxisAlignment.spaceBetween,
                                     children: [
                                       _buildSectionTitle("Schedules"),
                                       Container(
                                         padding: const EdgeInsets.symmetric(
                                             horizontal: 10, vertical: 4),
                                         decoration: BoxDecoration(
                                           color: ColorConst.primaryColor
                                               .withOpacity(0.08),
                                           borderRadius:
                                               BorderRadius.circular(20),
                                           border: Border.all(
                                             color: ColorConst.primaryColor
                                                 .withOpacity(0.25),
                                           ),
                                         ),
                                         child: Row(
                                           mainAxisSize: MainAxisSize.min,
                                           children: [
                                              Icon(Icons.bolt,
                                                  size: 14,
                                                  color: ColorConst.primaryColor),
                                             const SizedBox(width: 4),
                                             Text(
                                               "Today Only",
                                               style: TextStyleConst
                                                   .boldTextStyle(
                                                       ColorConst.primaryColor,
                                                       12),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(height: 10),
                                   _buildCalendar(controller),

                                  const SizedBox(height: 25),
                                  // Slots Selection
                                  _buildSlots(controller),

                                  const SizedBox(height: 30),
                                  // New Patient Selection Widget
                                  // Inside build method of _DoctorDetailsScreenState
                                  PatientSelectionWidget(
                                    onSelectionChanged: (selectionType, patientDetails) {
                                      controller.appointmentType = selectionType;
                                      // Store the whole map in a new variable in your controller
                                      controller.guestPatientDetails = patientDetails;
                                      controller.update();
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  // Description Input
                                  Text(
                                    "Reason for Visit",
                                    style: TextStyleConst.boldTextStyle(
                                        Colors.black87, 20),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller:
                                        controller.descriptionController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: "Describe your symptoms...",
                                      hintStyle:
                                          TextStyleConst.regularTextStyle(
                                              Colors.grey, 14),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: ColorConst.primaryColor),
                                      ),
                                      contentPadding: const EdgeInsets.all(15),
                                    ),
                                  ),

                                  const SizedBox(height: 25),
                                  // Payment Method
                                  Text(
                                    "Payment Method",
                                    style: TextStyleConst.boldTextStyle(
                                        Colors.black87, 16),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            controller.paymentMethod = "onsite";
                                            controller.update();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            decoration: BoxDecoration(
                                              color: controller.paymentMethod ==
                                                      "onsite"
                                                  ? ColorConst.primaryColor
                                                      .withOpacity(0.1)
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: controller
                                                            .paymentMethod ==
                                                        "onsite"
                                                    ? ColorConst.primaryColor
                                                    : Colors.grey.shade300,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "On Hospital",
                                                style: TextStyleConst
                                                    .mediumTextStyle(
                                                  controller.paymentMethod ==
                                                          "onsite"
                                                      ? ColorConst.primaryColor
                                                      : Colors.black87,
                                                  14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (controller
                                          .isOnlinePaymentAvailable) ...[
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              controller.paymentMethod =
                                                  "online";
                                              controller.update();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              decoration: BoxDecoration(
                                                color: controller
                                                            .paymentMethod ==
                                                        "online"
                                                    ? ColorConst.primaryColor
                                                        .withOpacity(0.1)
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: controller
                                                              .paymentMethod ==
                                                          "online"
                                                      ? ColorConst.primaryColor
                                                      : Colors.grey.shade300,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Online",
                                                  style: TextStyleConst
                                                      .mediumTextStyle(
                                                    controller.paymentMethod ==
                                                            "online"
                                                        ? ColorConst
                                                            .primaryColor
                                                        : Colors.black87,
                                                    14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),

                                  const SizedBox(height: 20),
                                  RatingSummaryWidget(
                                    controller: controller,
                                  ),


                                  const SizedBox(height: 8),
                                  ReviewsWidget(
                                    controller: controller,
                                  ),

                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            GetBuilder<DoctorDetailsController>(builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    controller.bookAppointment(
                      widget.doctorId,
                      getDepartmentId(controller),
                      context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    shadowColor: ColorConst.primaryColor.withOpacity(0.3),
                  ),
                  child: Text(
                    "Book Appointment ₹${controller.slotBookingModel?.data?.appointment_charge ?? 0}",
                    style: TextStyleConst.boldTextStyle(
                      Colors.white,
                      18,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyleConst.boldTextStyle(Colors.black87, 20),
    );
  }
  // ...specialTokens.asMap().entries.map(
  //       (entry) => Padding(
  //     padding: const EdgeInsets.only(left: 10),
  //     child: SizedBox(
  //       width: 100,
  //       child: _buildApptTypeOption(
  //         controller,
  //         entry.value.tokenType ?? "",
  //         entry.value.id ?? (100 + entry.key),
  //       ),
  //     ),
  //   ),
  // ),
  Widget _buildAppointmentTypeFilter(
      DoctorDetailsController controller) {
    final specialTokens = controller.doctorProfile?.specialTokens ?? [];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildApptTypeOption(controller, "NEW OPD", 1),
          const SizedBox(width: 10),

          _buildApptTypeOption(controller, "NEW FOLLOW UP", 2),

          // Show only when special tokens exist
          if (specialTokens.isNotEmpty)
            ...specialTokens.asMap().entries.map(
                  (entry) {
                final uiValue = 1000 + (entry.value.id ?? entry.key);

                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: _buildApptTypeOption(
                    controller,
                    entry.value.tokenType ?? "",
                    uiValue,
                    specialTokenType: entry.value.tokenType,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
  Widget _buildApptTypeOption(
      DoctorDetailsController controller,
      String label,
      int value, {
        String? specialTokenType,
      }) {
    final isSelected = controller.appointmentTypeFilter == value;

    return GestureDetector(
      onTap: () {
        controller.setAppointmentTypeFilter(
          value,
          widget.doctorId,
          specialTokenType: specialTokenType,
        );
      },
      child: Container(
        height: 35,
        constraints: const BoxConstraints(minWidth: 90),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? ColorConst.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? ColorConst.primaryColor
                : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyleConst.mediumTextStyle(
            isSelected ? Colors.white : Colors.black87,
            14,
          ),
        ),
      ),
    );
  }

  Widget _buildSlots(DoctorDetailsController controller) {
    if (controller.isSlotLoading) {
      return const Column(
        children: [
          Skeleton(height: 40, width: 150, borderRadius: 5),
          SizedBox(height: 10),
          Skeleton(height: 100, width: double.infinity, borderRadius: 10),
        ],
      );
    }
    if (controller.slotBookingModel == null) {
      if (controller.selectedDate == null) {
        return Center(
            child: Text("Select a date to view available slots",
                style: TextStyleConst.mediumTextStyle(Colors.grey, 14)));
      } else {
        return const SizedBox();
      }
    }

    final data = controller.slotBookingModel?.data;
    final allSlots = data?.bookingSlotArr ?? [];

    if (data?.is_holiday == true) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorConst.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: ColorConst.primaryColor.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(Icons.event_busy, color: ColorConst.primaryColor, size: 40),
            const SizedBox(height: 5),
            Text(
              "Today is a holiday.",
              style: TextStyleConst.boldTextStyle(Colors.black87, 18),
            ),
            const SizedBox(height: 2),
            Text(
              "No appointments available.",
              style: TextStyleConst.mediumTextStyle(Colors.grey, 14),
            ),
          ],
        ),
      );
    }

    if (allSlots.isEmpty) {
      return Center(
          child: Text("No slots available",
              style: TextStyleConst.mediumTextStyle(Colors.grey, 14)));
    }

    // Map all slots preserving original indices
    final allSlotsWithIndices = <Map<String, dynamic>>[];
    for (int i = 0; i < allSlots.length; i++) {
      allSlotsWithIndices.add({
        'slot': allSlots[i],
        'index': i,
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1565C0).withOpacity(0.28),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.event_available_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  "Available Session",
                  style: TextStyleConst.boldTextStyle(Colors.white, 15),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        if (controller.isTokenBased)
          _buildTokenGrid(controller, allSlotsWithIndices)
        else
          _buildTimeGrid(controller, allSlotsWithIndices),
      ],
    );
  }

  Widget _buildTokenGrid(
      DoctorDetailsController controller, List<Map<String, dynamic>> slots) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: slots.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        childAspectRatio: 1.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final slotData = slots[index];
        final slot = slotData['slot'];
        final originalIndex = slotData['index'] as int;

        int tokenNum = (slot is BookingToken)
            ? slot.token!
            : (slot is Map ? slot['token'] : originalIndex + 1);
        bool isBooked = (slot is BookingToken)
            ? (slot.isBooked ?? false)
            : (slot is Map
                ? (slot['isBooked'] == true || slot['isBooked'] == 1)
                : false);
        bool isDisabled = (slot is BookingToken)
            ? (slot.disabled ?? false)
            : (slot is Map
                ? (slot['disabled'] == true || slot['disabled'] == 1)
                : false);
        String? status = (slot is BookingToken)
            ? slot.status
            : (slot is Map ? slot['status']?.toString() : null);

        String displayLabel = (slot is BookingToken)
            ? (slot.label ?? tokenNum.toString())
            : (slot is Map
                ? (slot['label']?.toString() ?? tokenNum.toString())
                : tokenNum.toString());

        bool isBlocked = status?.toLowerCase() == "blocked";
        final isSelected = controller.selectedToken == tokenNum;

        // Optionally, you might want to adjust logic if tokens can be Strings
        // But assuming token value is still used for booking (integer ID), we keep `tokenNum` for selection logic:
        return GestureDetector(
          onTap: (isBooked || isBlocked || isDisabled)
              ? null
              : () => controller.selectToken(tokenNum, originalIndex),
          child: Opacity(
            opacity: (isBooked || isDisabled) ? 0.3 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorConst.primaryColor
                    : (isBlocked ? Colors.grey.shade200 : Colors.white),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: isSelected
                        ? ColorConst.primaryColor
                        : (isBlocked
                            ? Colors.grey.shade400
                            : Colors.grey.shade300)),
              ),
              child: Center(
                child: Text(
                  displayLabel,
                  style: TextStyleConst.boldTextStyle(
                      isSelected
                          ? Colors.white
                          : (isBlocked ? Colors.grey : Colors.black87),
                      14),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeGrid(
      DoctorDetailsController controller, List<Map<String, dynamic>> slots) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: slots.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final slotWithIndex = slots[index];
        final slotData = slotWithIndex['slot'];
        final originalIndex = slotWithIndex['index'] as int;

        String timeString = "";
        bool isBooked = false;
        bool isDisabled = false;
        String? status;
        int tokenNum = originalIndex + 1; // Default to index + 1

        if (slotData is Map<String, dynamic> || slotData is Map) {
          timeString = slotData['time']?.toString() ?? "";
          isBooked =
              (slotData['isBooked'] == true) || (slotData['isBooked'] == 1);
          isDisabled =
              (slotData['disabled'] == true) || (slotData['disabled'] == 1);
          status = slotData['status']?.toString();
          if (slotData['token'] != null) {
            tokenNum = int.tryParse(slotData['token'].toString()) ?? tokenNum;
          }
        } else if (slotData is BookingToken) {
          // This case might not happen for time slots but handle for safety
          timeString = slotData.token.toString();
          isBooked = slotData.isBooked ?? false;
          isDisabled = slotData.disabled ?? false;
          status = slotData.status;
          tokenNum = slotData.token ?? tokenNum;
        } else {
          timeString = slotData.toString();
        }

        bool isBlocked = status?.toLowerCase() == "blocked";
        final isSelected = controller.selectedTime == timeString;

        return GestureDetector(
          onTap: (isBooked || isBlocked || isDisabled)
              ? null
              : () => controller.selectTime(timeString, originalIndex),
          child: Opacity(
            opacity: (isBooked || isDisabled) ? 0.3 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorConst.primaryColor
                    : (isBlocked ? Colors.grey.shade100 : Colors.white),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: isSelected
                        ? ColorConst.primaryColor
                        : (isBlocked
                            ? Colors.grey.shade300
                            : Colors.grey.shade300)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Token $tokenNum",
                      style: TextStyleConst.boldTextStyle(
                          isSelected
                              ? Colors.white
                              : (isBlocked ? Colors.grey : ColorConst.primaryColor),
                          11),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isBlocked ? "Blocked" : timeString,
                      style: TextStyleConst.mediumTextStyle(
                          isSelected
                              ? Colors.white
                              : (isBlocked ? Colors.grey : Colors.black87),
                          isBlocked ? 10 : 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCalendar(DoctorDetailsController controller) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final monthName = _getMonthName(today.month);
    final weekDayName = _getWeekDayName(today.weekday);

    return GestureDetector(
      onTap: () {
        controller.onDateSelected(today, widget.doctorId);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: ColorConst.primaryColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: ColorConst.primaryColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: ColorConst.primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: ColorConst.primaryColor.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "TODAY",
                    style: TextStyleConst.boldTextStyle(Colors.white, 10),
                  ),
                  Text(
                    today.day.toString(),
                    style: TextStyleConst.boldTextStyle(Colors.white, 20),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: ColorConst.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "$weekDayName, ${today.day} $monthName ${today.year}",
                    style: TextStyleConst.boldTextStyle(
                      Colors.black87,
                      15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ColorConst.primaryColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: 16,
                color: ColorConst.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }

  String _getWeekDayName(int weekday) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[weekday - 1];
  }
}
