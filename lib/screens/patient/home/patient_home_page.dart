import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/banner_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/category_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/common_health_issues_widget.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/token_slot_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/wellness_product_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/newsletters_home_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/sticky_search_bar_delegate.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/live_token_status_widget.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/horizontal_doctor_card.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/follow_up_card_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/upcoming_appointments_widget.dart';

import '../../../utils/string_utils.dart';
import '../notification/notification_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/all_doctors_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/skeleton_loading_widgets.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/chatbot/chatbot_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/visiting_consultant_directory_screen.dart';
import 'package:lottie/lottie.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  void initState() {
    super.initState();

    // Controller is now handled by LoginController or HomeController
    // We just ensure it's put here if accessed directly
    Get.put(PatientHomeController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<PatientHomeController>(
      // init: PatientHomeController(),
      builder: (controller) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
          //   floatingActionButton: GestureDetector(
          //   onTap: () {
          //     Get.to(() => const ChatBotScreen());
          //   },
          //   child: Container(
          //     margin: EdgeInsets.only(bottom: screenHeight * 0.1), // Increased bottom margin based on screen height
          //     width: 80, // Larger width
          //     height: 80, // Larger height
          //     decoration: const BoxDecoration(
          //       color: Colors.transparent, // Transparent background
          //     ),
          //     child: Lottie.asset(
          //       'assets/animation/Robot assistant  Online manager.json',
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          // ),
          backgroundColor: ColorConst.bgGreyColor,
          body: SafeArea(
            bottom: false,
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.refreshData();
              },
              color: ColorConst.primaryColor,
              backgroundColor: Colors.white,
              child: CustomScrollView(
                slivers: [
                  // SliverAppBar(
                  //   // Assuming ColorConst.primaryColor is your app's purple theme color
                  //   backgroundColor: ColorConst.primaryColor,
                  //   pinned: true,
                  //   floating: true,
                  //   expandedHeight: 125.0, // Adjust height as needed
                  //   elevation: 0,
                  //   // Creates the rounded bottom corners seen in modern apps
                  //   shape: const RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.vertical(
                  //       bottom: Radius.circular(20),
                  //     ),
                  //   ),
                  //   // 1. Menu Icon (Left)
                  //   leading: IconButton(
                  //     icon: const Icon(Icons.sort, color: Colors.white, size: 28),
                  //     onPressed: () {
                  //       Get.find<HomeController>().scaffoldKey.currentState?.openDrawer();
                  //     },
                  //   ),
                  //   // 2. Location (Center)
                  //   title: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       const Icon(Icons.location_on_outlined, color: Colors.white, size: 18),
                  //       const SizedBox(width: 4),
                  //       Text(
                  //         "World Trade, Texas", // Replace with controller.location if dynamic
                  //         style: TextStyleConst.mediumTextStyle(Colors.white, 15),
                  //       ),
                  //     ],
                  //   ),
                  //   centerTitle: true,
                  //   // 3. User Avatar (Right)
                  //   actions: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         // Optional: Action for tapping the profile
                  //       },
                  //       child: const Padding(
                  //         padding: EdgeInsets.only(right: 20.0),
                  //         child: CircleAvatar(
                  //           radius: 16,
                  //           backgroundColor: Colors.white24,
                  //           // Replace with your actual user image variable
                  //           backgroundImage: NetworkImage(
                  //               'https://ui-avatars.com/api/?name=User&background=random'
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  //   // 4. Search Bar (Bottom of the purple header)
                  //   bottom: PreferredSize(
                  //     preferredSize: const Size.fromHeight(60),
                  //     child: Padding(
                  //       padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           // If you want this to open a dedicated search screen like before
                  //           // Get.to(() => SearchScreen());
                  //         },
                  //         child: Container(
                  //           height: 45,
                  //           padding: const EdgeInsets.symmetric(horizontal: 15),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white.withOpacity(0.15), // Slightly transparent white overlay
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 "Search Doctor, Drugs, Articles...",
                  //                 style: TextStyleConst.regularTextStyle(
                  //                     Colors.white.withOpacity(0.8),
                  //                     13
                  //                 ),
                  //               ),
                  //               // Search icon on the right side exactly like the image
                  //               const Icon(Icons.search, color: Colors.white, size: 20),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),   // --- SCROLLABLE HEADER (Menu, Animation, Notification) ---
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.find<HomeController>()
                                      .scaffoldKey
                                      .currentState
                                      ?.openDrawer();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        ColorConst.blackColor.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.sort,
                                    color: ColorConst.blackColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.greeting,
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.blackColor,
                                      14,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      "${VariableUtils.firstName.value} ${VariableUtils.lastName.value}",
                                      style: TextStyleConst.boldTextStyle(
                                        ColorConst.blackColor,
                                        18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // SOS and Notification Icons
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.goToSosScreen();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: ColorConst.redColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color:
                                          ColorConst.redColor.withOpacity(0.5),
                                    ),
                                  ),
                                  child: Text(
                                    "SOS",
                                    style: TextStyleConst.boldTextStyle(
                                      ColorConst.redColor,
                                      14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => NotificationScreen());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: ColorConst.greyShadowColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.notifications_outlined,
                                    color: ColorConst.blackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- STICKY SEARCH BAR ---
                  SliverPersistentHeader(
                    delegate: StickySearchBarDelegate(controller),
                    pinned: true,
                  ),

                  // --- SCROLLABLE CONTENT ---
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- NEW PREMIUM TOKEN UI ---
                          LiveTokenStatusWidget(controller: controller),

                          if (controller.followUps.isNotEmpty)
                            FollowUpCardWidget(
                              data: controller.followUps.first,
                              onTap: () {
                                if (controller.followUps.first.id != null) {
                                  controller.showFollowUpDetailById(
                                      controller.followUps.first.id!);
                                }
                              },
                            ),
const SizedBox(height: 15),
UpcomingAppointmentsWidget(controller: controller),
                          const SizedBox(height: 15),
                          // Banner
                          const BannerWidget(),
                          const SizedBox(height: 15),
                          // Categories (Find your doctor)
                          const CategoryWidget(),
                          const SizedBox(height: 12),

                          // Visiting Specialists on Demand Banner
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => const VisitingConsultantDirectoryScreen());
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      ColorConst.primaryColor,
                                      const Color(0xff097A4D),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorConst.primaryColor.withOpacity(0.22),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.18),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: const Icon(
                                        Icons.medical_services_rounded,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Visiting Specialists",
                                                style: TextStyleConst.boldTextStyle(
                                                  Colors.white,
                                                  15,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.25),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  "OPD & IPD",
                                                  style: TextStyleConst.boldTextStyle(
                                                    Colors.white,
                                                    9,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            "Book consultations with external super-specialists",
                                            style: TextStyleConst.regularTextStyle(
                                              Colors.white.withOpacity(0.9),
                                              12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Popular Doctors Header
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  StringUtils.popularDoctors,
                                  style: TextStyleConst.boldTextStyle(
                                    ColorConst.blackColor,
                                    18,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const AllDoctorsScreen());
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        StringUtils.seeAll,
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.primaryColor
                                              .withOpacity(0.7),
                                          14,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                        color: ColorConst.primaryColor
                                            .withOpacity(0.7),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),

                          Obx(() {
                            if (controller.isAllDoctorsLoading.value) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                itemCount: 4,
                                itemBuilder: (context, index) => const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: DoctorSkeleton(),
                                ),
                              );
                            }
                            if (controller.allDoctors.isEmpty) {
                              return  Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(StringUtils.noDoctorsAvailable));
                            }

                            // Vertical List
                            final int doctorCount =
                                controller.allDoctors.length > 4
                                    ? 4
                                    : controller.allDoctors.length;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              itemCount: doctorCount,
                              itemBuilder: (context, index) {
                                final doctor = controller.allDoctors[index];
                                return HorizontalDoctorCard(
                                  doctor: doctor,
                                  onTap: () {
                                    context.push('/doctor-details', extra: {
                                      'doctor': doctor,
                                      'doctorId': doctor.id!,
                                    });
                                  },
                                );
                              },
                            );
                          }),
                          //const SizedBox(height: 15),

                          /// DISEASE BASED DOCTOR RECOMMENDATION
                          const CommonHealthIssuesWidget(),
                          const SizedBox(height: 5),

                          // Pharmacy Products Section
                          const WellnessProductWidget(),
                          const SizedBox(height: 20),

                          // Newsletters Section
                          const NewslettersHomeWidget(),
                          
                          SizedBox(height: screenHeight * 0.10),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
