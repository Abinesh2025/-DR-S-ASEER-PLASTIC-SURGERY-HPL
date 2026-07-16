import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_appoinment_controller/doctor_appoinment_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_appoinment_controller/doctor_filter_appointment_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/appointment_controller/appointment_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/appointment_controller/filter_appointment_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_session_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/skeleton_loading_widgets.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/widgets/doctor_session_widget.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late final AppointmentController appointmentController;
  late final DoctorAppointmentController doctorAppointmentController;
  late final PatientFilterAppointmentController filterAppointmentController;
  late final DoctorFilterAppointmentController
      doctorFilterAppointmentController;
  late final DoctorSessionController doctorSessionController;

  @override
  void initState() {
    super.initState();

    // 🔥 Use Get.find instead of always Get.put
    appointmentController = Get.put(AppointmentController());
    doctorAppointmentController = Get.put(DoctorAppointmentController());
    filterAppointmentController = Get.put(PatientFilterAppointmentController());
    doctorFilterAppointmentController =
        Get.put(DoctorFilterAppointmentController());
    doctorSessionController = Get.put(DoctorSessionController());

    // 🔥 Refresh on open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });
  }

  void _refreshPage() {
    if (PreferenceUtils.getStringValue("role") == "Doctor") {
      doctorSessionController.fetchSessionStatus();
      doctorFilterAppointmentController.changeDoctorIndex(
        doctorAppointmentController.currentIndex.value,
      );
    } else {
      filterAppointmentController.changeIndex(
        appointmentController.currentIndex.value,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final role = PreferenceUtils.getStringValue("role");
    final tabs = role == "Doctor"
        ? doctorAppointmentController.appointmentStatus
        : appointmentController.appointmentStatus;

    return Obx(() {
      final initialIndex = role == "Doctor"
          ? doctorAppointmentController.currentIndex.value
          : appointmentController.currentIndex.value;

      return DefaultTabController(
        key: ValueKey("appointment_tabs_$initialIndex"),
        length: tabs.length,
        initialIndex: initialIndex,
        child: Builder(builder: (context) {
          final tabController = DefaultTabController.of(context);

          // Listen to tab changes (sliding/swiping)
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              int newIndex = tabController.index;
              if (role == "Doctor") {
                if (doctorAppointmentController.currentIndex.value !=
                    newIndex) {
                  doctorFilterAppointmentController.changeDoctorIndex(newIndex);
                }
              } else {
                if (appointmentController.currentIndex.value != newIndex) {
                  filterAppointmentController.changeIndex(newIndex);
                }
              }
            }
          });

          return Scaffold(
            backgroundColor: const Color(0xffF5F7FA),
            body: Stack(
              children: [
                Column(
                  children: [
                    if (role == "Doctor") DoctorSessionManagementBar(),
                    Container(
                      height: 50,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: height * 0.0),
                      width: double.infinity,
                      child: TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 10, right: width * 0.04),
                        indicatorColor: ColorConst.primaryColor,
                        indicatorWeight: 3,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: ColorConst.primaryColor,
                        unselectedLabelColor: ColorConst.hintGreyColor,
                        labelStyle: TextStyleConst.boldTextStyle(
                            ColorConst.primaryColor, width * 0.042),
                        unselectedLabelStyle: TextStyleConst.mediumTextStyle(
                            ColorConst.hintGreyColor, width * 0.04),
                        tabs: tabs.map((status) => Tab(text: status)).toList(),
                        onTap: (index) {
                          if (role == "Doctor") {
                            doctorFilterAppointmentController
                                .changeDoctorIndex(index);
                          } else {
                            filterAppointmentController.changeIndex(index);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        children: tabs.asMap().entries.map((entry) {
                          int index = entry.key;
                          return Obx(() {
                            if (role == "Doctor") {
                              if (doctorAppointmentController
                                      .currentIndex.value !=
                                  index) {
                                return _buildSkeletonList();
                              }

                              // Doctor Logic for this tab
                              bool isLoading =
                                  !doctorFilterAppointmentController
                                      .isDoctorFilterApiCall.value;
                              var data = doctorFilterAppointmentController
                                      .doctorAppointmentModel.value?.data ??
                                  [];

                              if (isLoading) {
                                return _buildSkeletonList();
                              }

                              if (data.isEmpty) {
                                return _buildEmptyState(width, () async {
                                  doctorSessionController.fetchSessionStatus();
                                  await doctorFilterAppointmentController
                                      .changeDoctorIndex(index);
                                });
                              }

                              return RefreshIndicator(
                                onRefresh: () async {
                                  doctorSessionController.fetchSessionStatus();
                                  await doctorFilterAppointmentController
                                      .changeDoctorIndex(index);
                                },
                                child: AnimationLimiter(
                                  child: ListView.separated(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(
                                            parent: BouncingScrollPhysics()),
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 100),
                                    itemCount: data.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 16),
                                    itemBuilder: (context, i) {
                                      var appointment = data[i];
                                      return _buildDoctorAnimatedCard(
                                          context, i, appointment, width);
                                    },
                                  ),
                                ),
                              );
                            } else {
                              if (appointmentController.currentIndex.value !=
                                  index) {
                                return _buildSkeletonList();
                              }

                              // Patient Logic for this tab
                              bool isLoading =
                                  !filterAppointmentController.isApiCall.value;
                              var data = filterAppointmentController
                                      .filterAppointmentModel?.data ??
                                  [];

                              if (isLoading) {
                                return _buildSkeletonList();
                              }

                              if (data.isEmpty) {
                                return _buildEmptyState(width, () async {
                                  await filterAppointmentController
                                      .changeIndex(index);
                                });
                              }

                              return RefreshIndicator(
                                onRefresh: () async {
                                  await filterAppointmentController
                                      .changeIndex(index);
                                },
                                child: AnimationLimiter(
                                  child: ListView.separated(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(
                                            parent: BouncingScrollPhysics()),
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 100,
                                        top: 5),
                                    itemCount: data.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 16),
                                    itemBuilder: (context, i) {
                                      var appointment = data[i];
                                      return _buildPatientAnimatedCard(
                                          context, i, appointment, width);
                                    },
                                  ),
                                ),
                              );
                            }
                          });
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      );
    });
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: 5,
      itemBuilder: (context, index) => const AppointmentSkeleton(),
    );
  }

  Widget _buildDoctorAnimatedCard(
      BuildContext context, int index, dynamic appointment, double width) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Builder(builder: (context) {
            // INDEX 0: Pending Appointments -> Show Cancel and Confirm
            if (doctorAppointmentController.currentIndex.value == 0) {
              return Slidable(
                startActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        doctorFilterAppointmentController.changeStatus(
                            appointment.id!, "Cancelled");
                      },
                      backgroundColor: ColorConst.redColor,
                      foregroundColor: ColorConst.whiteColor,
                      label: "Cancel",
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        doctorFilterAppointmentController.changeStatus(
                            appointment.id!, "Completed");
                      },
                      backgroundColor: ColorConst.greenColor,
                      foregroundColor: ColorConst.whiteColor,
                      label: "Confirm",
                    ),
                  ],
                ),
                child: _buildRoleAppointmentCard(context, appointment, width,
                    isDoctor: true),
              );
            }
            // INDEX 1: Confirmed Appointments -> Show Check In
            else if (doctorAppointmentController.currentIndex.value == 1) {
              return Slidable(
                key: ValueKey(appointment.id),
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => doctorFilterAppointmentController
                          .changeStatus(appointment.id!, "Checked In"),
                      backgroundColor: ColorConst.greenColor,
                      foregroundColor: ColorConst.whiteColor,
                      label: "Check In",
                    ),
                  ],
                ),
                child: _buildRoleAppointmentCard(context, appointment, width,
                    isDoctor: true),
              );
            }
            // INDEX 2: Checked In / In Progress Appointments -> Show Check Out
            else if (doctorAppointmentController.currentIndex.value == 2) {
              return Slidable(
                key: ValueKey(appointment.id),
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => doctorFilterAppointmentController
                          .changeStatus(appointment.id!, "Checked Out"),
                      backgroundColor: ColorConst.redColor,
                      foregroundColor: ColorConst.whiteColor,
                      label: "Check Out",
                    ),
                  ],
                ),
                child: _buildRoleAppointmentCard(context, appointment, width,
                    isDoctor: true),
              );
            }
            // OTHER INDEXES: Just show the card without slidable actions
            else {
              return _buildRoleAppointmentCard(context, appointment, width,
                  isDoctor: true);
            }
          }),
        ),
      ),
    );
  }

  Widget _buildPatientAnimatedCard(
      BuildContext context, int index, dynamic appointment, double width) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: _buildPatientAppointmentCard(
              context,
              width,
              appointment,
              appointmentController.currentIndex.value,
              filterAppointmentController),
        ),
      ),
    );
  }

  Widget _buildRoleAppointmentCard(
      BuildContext context, dynamic appointment, double width,
      {required bool isDoctor}) {
    String name = isDoctor
        ? (appointment.patient_name ?? "Unknown")
        : (appointment.doctor_name ?? "Doctor");
    String image = isDoctor
        ? (appointment.patient_image ?? "")
        : (appointment.doctor_image_url ?? "");
    String statusLabel = isDoctor
        ? doctorAppointmentController
            .appointmentStatus[doctorAppointmentController.currentIndex.value]
        : appointmentController
            .appointmentStatus[appointmentController.currentIndex.value];

    String tokenNum = (appointment.token_number != null &&
            appointment.token_number.toString() != "" &&
            appointment.token_number.toString() != "0")
        ? appointment.token_number.toString()
        : "";
    String timeStr = appointment.appointment_time ?? "";

    return _buildAppointmentCard(
      context: context,
      width: width,
      name: name,
      imageUrl: image,
      date: appointment.appointment_date ?? "",
      time: timeStr,
      department: isDoctor ? "" : (appointment.doctor_department ?? ""),
      appointmentType: appointment.appointmentType ?? "",
      statusLabel: statusLabel,
      tokenNumber: tokenNum,
      isIsroPatient: appointment.isIsroPatient,
      onViewTap: () {
        _showAppointmentDetails(
          context,
          name: name,
          imageUrl: image,
          date: appointment.appointment_date ?? "",
          time: tokenNum.isNotEmpty ? "Token $tokenNum" : timeStr,
          department: isDoctor ? "" : (appointment.doctor_department ?? ""),
          statusLabel: statusLabel,
        );
      },
    );
  }

  Widget _buildEmptyState(double width, Future<void> Function() onRefresh) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: ColorConst.primaryColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: ColorConst.primaryColor.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.calendar_month_outlined,
                        size: 60,
                        color: ColorConst.primaryColor.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "No Appointments Yet",
                      style: TextStyleConst.boldTextStyle(
                        ColorConst.blackColor.withOpacity(0.7),
                        18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "You don't have any appointments\nin this category.",
                      textAlign: TextAlign.center,
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.hintGreyColor,
                        14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypeBadge(String type) {
    Color badgeColor;
    switch (type.toUpperCase()) {
      case 'EMERGENCY':
        badgeColor = Colors.red;
        break;
      case 'POP':
        badgeColor = Colors.purple;
        break;
      default:
        badgeColor = ColorConst.primaryColor;
    }
    String displayText = type.toUpperCase() == 'POP' ? 'FOLLOW UP' : type;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: badgeColor.withOpacity(0.2)),
      ),
      child: Text(
        displayText,
        style: TextStyleConst.boldTextStyle(badgeColor, 10),
      ),
    );
  }

  Widget _buildAppointmentCard({
    required BuildContext context,
    required double width,
    required String name,
    required String imageUrl,
    required String date,
    required String time,
    required String department,
    required String statusLabel,
    required String appointmentType,
    String? tokenNumber,
    bool? isIsroPatient,
    VoidCallback? onViewTap,
  }) {
    return GestureDetector(
      onTap: onViewTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: ColorConst.primaryColor.withOpacity(0.1), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: ColorConst.primaryColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Box (Token or Date)
            Container(
              width: 65,
              height: 65, // Fixed height to enforce uniform size
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFF0F6FF), 
                  width: 1.5,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF0F6FF),
                    Colors.white,
                  ],
                  stops: [0.6, 0.6],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        tokenNumber?.isNotEmpty == true
                            ? tokenNumber!
                            : (time.isNotEmpty ? time : "-"),
                        textAlign: TextAlign.center,
                        style: TextStyleConst.boldTextStyle(
                          const Color(0xFF2A7CBA),
                          tokenNumber?.isNotEmpty == true ? 18 : 11,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        tokenNumber?.isNotEmpty == true ? "Token" : "Time",
                        style: TextStyleConst.mediumTextStyle(
                          const Color(0xFF2A7CBA),
                          10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Right Side
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorConst.primaryColor.withOpacity(0.2),
                            width: 1,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageUrl),
                            onError: (e, s) => const AssetImage(
                                "assets/image/placeholder.png"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyleConst.boldTextStyle(
                                ColorConst.blackColor,
                                15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              department.isNotEmpty ? department : "General",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.hintGreyColor,
                                12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (PreferenceUtils.getStringValue("role") == "Doctor")
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: (isIsroPatient ?? false)
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.orange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  (isIsroPatient ?? false)
                                      ? "Normal Patient"
                                      : "ISRO Patient",
                                  style: TextStyle(
                                    color: (isIsroPatient ?? false)
                                        ? Colors.green
                                        : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _buildTypeBadge(appointmentType),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 12),
                          Icon(Icons.calendar_month_outlined,
                              size: 16, color: Colors.orange[300]),
                          const SizedBox(width: 4),
                          Text(
                            date.isNotEmpty ? date : "--",
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor.withOpacity(0.8),
                              12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2A7CBA).withOpacity(0.3),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: Color(0xFF2A7CBA),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientAppointmentCard(
      BuildContext context,
      double width,
      dynamic appointmentData,
      int currentIndex,
      PatientFilterAppointmentController controller) {
    // Check if actions are allowed (Upcoming is now index 0)
    bool canEdit = currentIndex == 0;

    String tokenNum = (appointmentData.token_number != null &&
            appointmentData.token_number.toString() != "" &&
            appointmentData.token_number.toString() != "0")
        ? appointmentData.token_number.toString()
        : "";
    String timeStr = appointmentData.appointment_time ?? "";

    return _buildAppointmentCard(
        context: context,
        width: width,
        name: appointmentData.doctor_name ?? "Doctor",
        imageUrl: appointmentData.doctor_image_url ?? "",
        date: appointmentData.appointment_date ?? "",
        time: timeStr,
        department: appointmentData.doctor_department ?? "",
        appointmentType: appointmentData.appointmentType ?? "General",
        statusLabel:
            controller.appointmentController.appointmentStatus[currentIndex],
        tokenNumber: tokenNum,

        onViewTap: () {
          _showAppointmentDetails(
            context,
            name: appointmentData.doctor_name ?? "Doctor",
            imageUrl: appointmentData.doctor_image_url ?? "",
            date: appointmentData.appointment_date ?? "",
            time: tokenNum.isNotEmpty ? "Token $tokenNum" : timeStr,
            department: appointmentData.doctor_department ?? "",
            statusLabel: controller
                .appointmentController.appointmentStatus[currentIndex],
            onCancel: canEdit
                ? () {
                    _showCancelDialog(context, width, () {
                      controller
                          .cancelledPendingAppointment(appointmentData.id!);
                    });
                  }
                : null,
            onDelete: canEdit
                ? () {
                    _showDeleteDialog(context, width, () {
                      controller.deleteAppointment(appointmentData.id!);
                    });
                  }
                : null,
          );
        });
  }

  void _showCancelDialog(
      BuildContext context, double width, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.cancel_outlined,
                      color: ColorConst.redColor, size: 32),
                ),
                const SizedBox(height: 16),
                Text(
                  "Cancel Appointment",
                  style:
                      TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
                ),
                const SizedBox(height: 8),
                Text(
                  "Are you sure you want to cancel this appointment?",
                  textAlign: TextAlign.center,
                  style: TextStyleConst.mediumTextStyle(
                      ColorConst.hintGreyColor, 14),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                    color: ColorConst.borderGreyColor))),
                        child: Text("No",
                            style: TextStyleConst.mediumTextStyle(
                                ColorConst.hintGreyColor, 16)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          onYes();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConst.redColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0),
                        child: Text("Yes, Cancel",
                            style: TextStyleConst.mediumTextStyle(
                                Colors.white, 16)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(
      BuildContext context, double width, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.delete_outline_rounded,
                      color: ColorConst.redColor, size: 32),
                ),
                const SizedBox(height: 16),
                Text(
                  "Delete Appointment",
                  style:
                      TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
                ),
                const SizedBox(height: 8),
                Text(
                  "Are you sure you want to delete this appointment?",
                  textAlign: TextAlign.center,
                  style: TextStyleConst.mediumTextStyle(
                      ColorConst.hintGreyColor, 14),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                    color: ColorConst.borderGreyColor))),
                        child: Text("No",
                            style: TextStyleConst.mediumTextStyle(
                                ColorConst.hintGreyColor, 16)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          onYes();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConst.redColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0),
                        child: Text("Delete",
                            style: TextStyleConst.mediumTextStyle(
                                Colors.white, 16)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAppointmentDetails(
    BuildContext context, {
    required String name,
    required String imageUrl,
    required String date,
    required String time,
    required String department,
    required String statusLabel,
    VoidCallback? onCancel,
    VoidCallback? onDelete,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Appointment Details",
                          style: TextStyleConst.boldTextStyle(
                              ColorConst.blackColor, 18)),
                      IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: () => Get.back())
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: ColorConst.primaryColor, width: 2),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(imageUrl),
                          onError: (e, s) =>
                              const AssetImage("assets/image/placeholder.png"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      name,
                      style: TextStyleConst.boldTextStyle(
                          ColorConst.blackColor, 20),
                    ),
                  ),
                  if (department.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        department,
                        style: TextStyleConst.mediumTextStyle(
                            ColorConst.primaryColor, 14),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  _buildDetailRow(Icons.calendar_month_rounded, "Date", date),
                  const SizedBox(height: 12),
                  _buildDetailRow(Icons.access_time_rounded, "Time", time),
                  const SizedBox(height: 12),
                  _buildDetailRow(Icons.info_outline, "Status", statusLabel),
                  if (onCancel != null || onDelete != null) ...[
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    if (onCancel != null)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Get.back(); // Explicitly close details dialog
                            onCancel();
                          },
                          icon: const Icon(Icons.cancel_outlined,
                              color: ColorConst.blackColor),
                          label: Text("Cancel Appointment",
                              style: TextStyleConst.mediumTextStyle(
                                  ColorConst.blackColor, 16)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(
                                color: ColorConst.borderGreyColor),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    if (onCancel != null && onDelete != null)
                      const SizedBox(height: 12),
                    if (onDelete != null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.back(); // Explicitly close details dialog
                            onDelete();
                          },
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.white),
                          label: Text("Delete Appointment",
                              style: TextStyleConst.mediumTextStyle(
                                  Colors.white, 16)),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: ColorConst.redColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                        ),
                      ),
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: ColorConst.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: ColorConst.primaryColor, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyleConst.mediumTextStyle(
                    ColorConst.hintGreyColor, 12)),
            Text(value,
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16)),
          ],
        )
      ],
    );
  }
}
