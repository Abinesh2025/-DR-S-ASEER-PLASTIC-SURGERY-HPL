// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_alert_box.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/bed_assign_controller/bed_assign_controller.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/bed_assign/bed_details.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/bed_assign/edit_bed_screen.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/bed_assign/new_bed_screen.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
//
// class BedAssignsScreen extends StatelessWidget {
//   BedAssignsScreen({Key? key}) : super(key: key);
//   final BedAssignController bedAssignController = Get.put(BedAssignController());
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Container(
//       color: ColorConst.whiteColor,
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 height: 70,
//                 margin: EdgeInsets.only(top: height * 0.01),
//                 width: double.infinity,
//                 child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: bedAssignController.appointmentStatus.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return Center(
//                       child: Obx(
//                         () => GestureDetector(
//                           onTap: () {
//                             bedAssignController.changeIndex(index);
//                           },
//                           child: Container(
//                             margin: EdgeInsets.only(left: width * 0.03, right: index == 3 ? 10 : 0),
//                             height: 50,
//                             decoration: index == bedAssignController.currentIndex.value
//                                 ? BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: ColorConst.blueColor,
//                                   )
//                                 : BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                       width: 2,
//                                       color: ColorConst.borderGreyColor,
//                                     ),
//                                   ),
//                             child: Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                                 child: Text(
//                                   bedAssignController.appointmentStatus[index],
//                                   style: TextStyleConst.mediumTextStyle(
//                                     index == bedAssignController.currentIndex.value ? ColorConst.whiteColor : ColorConst.hintGreyColor,
//                                     width * 0.04,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: Obx(() {
//                   return bedAssignController.isBedAssignDataCalled.value == false
//                       ? const Center(child: CircularProgressIndicator())
//                       : bedAssignController.bedAssignFilterModel?.data?.isEmpty ?? true
//                           ? Center(
//                               child: Text(
//                                 "No data found!",
//                                 style: TextStyleConst.mediumTextStyle(
//                                   ColorConst.blackColor,
//                                   width * 0.04,
//                                 ),
//                               ),
//                             )
//                           : RefreshIndicator(
//                               onRefresh: () async {
//                                 bedAssignController.changeIndex(bedAssignController.currentIndex.value);
//                               },
//                               child: AnimationLimiter(
//                                 child: ListView.builder(
//                                   physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//                                   itemCount: bedAssignController.bedAssignFilterModel?.data?.length ?? 3,
//                                   itemBuilder: (context, index) {
//                                     return AnimationConfiguration.staggeredList(
//                                       position: index,
//                                       duration: const Duration(milliseconds: 1000),
//                                       child: SlideAnimation(
//                                         verticalOffset: 50.0,
//                                         child: FadeInAnimation(
//                                           child: Column(
//                                             children: [
//                                               Slidable(
//                                                 startActionPane: ActionPane(
//                                                   extentRatio: 0.25,
//                                                   motion: const ScrollMotion(),
//                                                   children: [
//                                                     SlidableAction(
//                                                       onPressed: (context) async {
//                                                         var data = {
//                                                           "bed": "${bedAssignController.bedAssignFilterModel?.data?[index].bed}",
//                                                           "bedId": "${bedAssignController.bedAssignFilterModel?.data?[index].bed_id}",
//                                                           "assignDate": "${bedAssignController.bedAssignFilterModel?.data?[index].assign_date}",
//                                                           "assignId": "${bedAssignController.bedAssignFilterModel?.data?[index].id}",
//                                                         };
//
//                                                         final result = await Get.to(
//                                                           () => EditBedScreen(),
//                                                           arguments: data,
//                                                         );
//                                                         if (result == "Call API") {
//                                                           bedAssignController.changeIndex(bedAssignController.currentIndex.value);
//                                                         }
//                                                       },
//                                                       backgroundColor: ColorConst.orangeColor.withOpacity(0.15),
//                                                       label: StringUtils.edit,
//                                                       foregroundColor: ColorConst.orangeColor,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 endActionPane: ActionPane(
//                                                   extentRatio: 0.25,
//                                                   motion: const ScrollMotion(),
//                                                   children: [
//                                                     SlidableAction(
//                                                       onPressed: (context) {
//                                                         ContentOfDialog contentOfDialog = ContentOfDialog(
//                                                           height: height,
//                                                           width: width,
//                                                           image: ImageUtils.deleteIcon,
//                                                           title: "Delete",
//                                                           description: "Are you sure want to delete this bed",
//                                                           leftText: "Delete",
//                                                           rightText: "Cancel",
//                                                           leftTapEvent: () {
//                                                             Get.back();
//                                                             bedAssignController.deleteBedAssign(
//                                                               context,
//                                                               "${bedAssignController.bedAssignFilterModel?.data?[index].id ?? 0}",
//                                                               bedAssignController.currentIndex.value,
//                                                             );
//                                                           },
//                                                           rightTapEvent: () {
//                                                             Get.back();
//                                                           },
//                                                         );
//                                                         CommonAlertDialog.commonAlertDialog(context, contentOfDialog);
//                                                       },
//                                                       backgroundColor: const Color(0xFFFCE5E5),
//                                                       foregroundColor: ColorConst.redColor,
//                                                       label: StringUtils.delete,
//                                                       // lableColor: ColorConst.redColor,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 child: ListTile(
//                                                   onTap: () {
//                                                     Get.to(
//                                                       () => BedDetails(),
//                                                       arguments: bedAssignController.bedAssignFilterModel?.data?[index].id ?? 0,
//                                                     );
//                                                   },
//                                                   title: Text(
//                                                     bedAssignController.bedAssignFilterModel?.data?[index].patient_name ?? "",
//                                                     style: TextStyleConst.mediumTextStyle(
//                                                       ColorConst.blackColor,
//                                                       width * 0.045,
//                                                     ),
//                                                   ),
//                                                   subtitle: RichText(
//                                                     text: TextSpan(
//                                                       text: bedAssignController.bedAssignFilterModel?.data?[index].bed ?? "",
//                                                       style: TextStyleConst.mediumTextStyle(
//                                                         ColorConst.hintGreyColor,
//                                                         width * 0.036,
//                                                       ),
//                                                       children: [
//                                                         TextSpan(text: " | ",
//                                                           style: TextStyleConst.mediumTextStyle(
//                                                           ColorConst.primaryColor,
//                                                           width * 0.037,
//                                                         ),
//                                                         ),
//                                                         TextSpan(
//                                                             text: bedAssignController.bedAssignFilterModel?.data?[index].case_id ?? "",
//                                                             style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.036)),
//                                                          TextSpan(
//                                                            text: " | ",
//                                                            style: TextStyleConst.mediumTextStyle(
//                                                           ColorConst.primaryColor,
//                                                           width * 0.037,
//                                                         ),),
//                                                         TextSpan(
//                                                           text: bedAssignController.bedAssignFilterModel?.data?[index].assign_date ?? "",
//                                                           style: TextStyleConst.mediumTextStyle(
//                                                             ColorConst.hintGreyColor,
//                                                             width * 0.036,
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   leading: Container(
//                                                     height: 60,
//                                                     width: 60,
//                                                     decoration: BoxDecoration(
//                                                       shape: BoxShape.circle,
//                                                       color: ColorConst.borderGreyColor,
//                                                     ),
//                                                     child: ClipOval(
//                                                       child: bedAssignController.bedAssignFilterModel?.data?[index].patient_image == null ||
//                                                               bedAssignController.bedAssignFilterModel!.data![index].patient_image!.isEmpty
//                                                           ? Image.asset(
//                                                               ImageUtils.patientIcon,
//                                                               fit: BoxFit.cover,
//                                                             )
//                                                           : FadeInImage(
//                                                               placeholder: const AssetImage(ImageUtils.patientIcon),
//                                                               image: NetworkImage(bedAssignController.bedAssignFilterModel!.data![index].patient_image!),
//                                                               imageErrorBuilder: (context, error, stackTrace) {
//                                                                 return Image.asset(
//                                                                   ImageUtils.patientIcon,
//                                                                   fit: BoxFit.cover,
//                                                                 );
//                                                               },
//                                                               fit: BoxFit.cover,
//                                                             ),
//                                                     ),
//                                                     // child: CachedNetworkImage(
//                                                     //   imageUrl:
//                                                     //       appointmentModel!.data![index].doctor_image_url!,
//                                                     //   placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                                                     //   errorWidget: (context, url, error) => const Icon(Icons.error),
//                                                     // ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(height: height * 0.01),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             );
//                 }),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: const EdgeInsets.all(25),
//               child: GestureDetector(
//                 onTap: () async {
//                   final result = await Get.to(() => NewBedScreen());
//                   if (result == "Call API") {
//                     bedAssignController.getBedAssignData();
//                   }
//                 },
//                 child: Container(
//                   height: 55,
//                   width: 55,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: ColorConst.blueColor,
//                   ),
//                   child: const Icon(Icons.add, color: ColorConst.whiteColor),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_alert_box.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/bed_assign_controller/bed_assign_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/bed_assign/bed_details.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/bed_assign/edit_bed_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/bed_assign/new_bed_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class BedAssignsScreen extends StatelessWidget {
  BedAssignsScreen({Key? key}) : super(key: key);
  final BedAssignController bedAssignController = Get.put(BedAssignController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // 1. Softer background color makes the white cards pop beautifully
      backgroundColor: const Color(0xffF5F7FA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- TOP TABS (Modern Pill Style) ---
          Container(
            height: 65,
            margin: EdgeInsets.only(top: height * 0.015, bottom: 10),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: bedAssignController.appointmentStatus.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelected = index == bedAssignController.currentIndex.value;
                  return GestureDetector(
                    onTap: () {
                      bedAssignController.changeIndex(index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 12, top: 5, bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: isSelected ? ColorConst.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: isSelected ? null : Border.all(color: Colors.grey.shade300),
                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color: ColorConst.blueColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ]
                            : [],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        bedAssignController.appointmentStatus[index],
                        style: TextStyleConst.boldTextStyle(
                          isSelected ? Colors.white : ColorConst.hintGreyColor,
                          width * 0.038,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),

          // --- MAIN LIST ---
          Expanded(
            child: Obx(() {
              if (bedAssignController.isBedAssignDataCalled.value == false) {
                return const Center(child: CircularProgressIndicator());
              }

              if (bedAssignController.bedAssignFilterModel?.data?.isEmpty ?? true) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bed_outlined, size: 80, color: ColorConst.hintGreyColor.withOpacity(0.3)),
                      const SizedBox(height: 16),
                      Text(
                        "No bed assignments found!",
                        style: TextStyleConst.boldTextStyle(ColorConst.hintGreyColor, 18),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  bedAssignController.changeIndex(bedAssignController.currentIndex.value);
                },
                color: ColorConst.blueColor,
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
                    itemCount: bedAssignController.bedAssignFilterModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      var data = bedAssignController.bedAssignFilterModel!.data![index];

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 600),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Slidable(
                                  startActionPane: ActionPane(
                                    extentRatio: 0.25,
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) async {
                                          var args = {
                                            "bed": "${data.bed}",
                                            "bedId": "${data.bed_id}",
                                            "assignDate": "${data.assign_date}",
                                            "assignId": "${data.id}",
                                          };
                                          final result = await Get.to(() => EditBedScreen(), arguments: args);
                                          if (result == "Call API") {
                                            bedAssignController.changeIndex(bedAssignController.currentIndex.value);
                                          }
                                        },
                                        backgroundColor: ColorConst.orangeColor.withOpacity(0.9),
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit_rounded,
                                        label: StringUtils.edit,
                                      ),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    extentRatio: 0.25,
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          CommonAlertDialog.commonAlertDialog(
                                            context,
                                            ContentOfDialog(
                                              height: height,
                                              width: width,
                                              image: ImageUtils.deleteIcon,
                                              title: "Delete",
                                              description: "Are you sure want to delete this bed assignment?",
                                              leftText: "Delete",
                                              rightText: "Cancel",
                                              leftTapEvent: () {
                                                Get.back();
                                                bedAssignController.deleteBedAssign(
                                                  context,
                                                  "${data.id ?? 0}",
                                                  bedAssignController.currentIndex.value,
                                                );
                                              },
                                              rightTapEvent: () {
                                                Get.back();
                                              },
                                            ),
                                          );
                                        },
                                        backgroundColor: ColorConst.redColor.withOpacity(0.9),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete_outline_rounded,
                                        label: StringUtils.delete,
                                      ),
                                    ],
                                  ),

                                  // --- CUSTOM BED CARD ---
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => BedDetails(), arguments: data.id ?? 0);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.04),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Avatar
                                              Container(
                                                height: 55,
                                                width: 55,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: ColorConst.blueColor.withOpacity(0.3), width: 2),
                                                ),
                                                child: ClipOval(
                                                  child: data.patient_image == null || data.patient_image!.isEmpty
                                                      ? Image.asset(ImageUtils.patientIcon, fit: BoxFit.cover)
                                                      : FadeInImage(
                                                    placeholder: const AssetImage(ImageUtils.patientIcon),
                                                    image: NetworkImage(data.patient_image!),
                                                    fit: BoxFit.cover,
                                                    imageErrorBuilder: (context, error, stackTrace) =>
                                                        Image.asset(ImageUtils.patientIcon, fit: BoxFit.cover),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              // Details
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.patient_name ?? "Unknown",
                                                      style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 17),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Row(
                                                      children: [
                                                        _buildInfoChip(Icons.bed, data.bed ?? "N/A", ColorConst.blueColor),
                                                        const SizedBox(width: 8),
                                                        _buildInfoChip(Icons.folder_shared_outlined, data.case_id ?? "N/A", Colors.orange),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Arrow Icon
                                              Container(
                                                padding: const EdgeInsets.all(6),
                                                decoration: BoxDecoration(color: ColorConst.bgGreyColor, shape: BoxShape.circle),
                                                child: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: ColorConst.hintGreyColor),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          const Divider(height: 1, color: ColorConst.borderGreyColor),
                                          const SizedBox(height: 12),
                                          // Date Row
                                          Row(
                                            children: [
                                              const Icon(Icons.calendar_month_rounded, size: 16, color: ColorConst.hintGreyColor),
                                              const SizedBox(width: 6),
                                              Text(
                                                "Assigned: ${data.assign_date ?? "N/A"}",
                                                style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 13),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),

      // --- FLOATING ACTION BUTTON ---
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final result = await Get.to(() => NewBedScreen());
      //     if (result == "Call API") {
      //       bedAssignController.getBedAssignData();
      //     }
      //   },
      //   backgroundColor: ColorConst.primaryColor,
      //   elevation: 6,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      //   child: const Icon(Icons.add, color: Colors.white, size: 28),
      // ),
    );
  }

  // --- Helper Widget for Clean Info Chips ---
  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyleConst.boldTextStyle(color, 11),
          ),
        ],
      ),
    );
  }
}