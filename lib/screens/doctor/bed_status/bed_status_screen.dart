// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/bed_status_controller/bed_status_controller.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/bed_assign/new_bed_screen.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
//
// class BedStatusScreen extends StatelessWidget {
//   BedStatusScreen({Key? key}) : super(key: key);
//   final BedStatusController bedStatusController = Get.put(BedStatusController());
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Container(
//       color: ColorConst.whiteColor,
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Obx(() {
//         return bedStatusController.isStatusApiCalled.value == false
//             ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
//             : bedStatusController.bedStatusModel?.data?.isEmpty ?? true
//                 ? Center(child: Text("No data found!", style: TextStyleConst.mediumTextStyle(ColorConst.blackColor, 18)))
//                 : RefreshIndicator(
//                     onRefresh: () async {
//                       bedStatusController.isStatusApiCalled.value = false;
//                       bedStatusController.getBedStatusData();
//                     },
//                     child: AnimationLimiter(
//                       child: ListView.builder(
//                         physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//                         itemCount: bedStatusController.bedStatusModel?.data?.length ?? 0,
//                         itemBuilder: (context, mainIndex) {
//                           return AnimationConfiguration.staggeredList(
//                             position: mainIndex,
//                             duration: const Duration(milliseconds: 1000),
//                             child: SlideAnimation(
//                               verticalOffset: 50.0,
//                               child: FadeInAnimation(
//                                 child: Padding(
//                                   padding: EdgeInsets.only(top: mainIndex == 0 ? 15 : 0),
//                                   child: Column(
//                                     children: [
//                                       const SizedBox(height: 10),
//                                       InkWell(
//                                           onTap: () {
//                                             bedStatusController.changeIcon(mainIndex);
//                                           },
//                                           child: Obx(
//                                             () => Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 CommonText(
//                                                   text: bedStatusController.bedStatusModel?.data?[mainIndex].bed_title ?? "",
//                                                   width: width,
//                                                 ),
//                                                 RotatedBox(
//                                                   quarterTurns: bedStatusController.turns[mainIndex].value,
//                                                   child: Image.asset(
//                                                     ImageUtils.dropDownIcon,
//                                                     width: 16,
//                                                     height: 8,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           )),
//                                       Obx(() {
//                                         return Visibility(
//                                           visible: bedStatusController.showData[mainIndex].value,
//                                           child: Column(
//                                             children: List.generate(
//                                               bedStatusController.bedStatusModel?.data?[mainIndex].bed?.length ?? 0,
//                                               (subIndex) {
//                                                 return ListTile(
//                                                   onTap: () {
//                                                     if (bedStatusController.bedStatusModel?.data?[mainIndex].bed?[subIndex].status == false) {
//                                                       CommonLoader.showLoader();
//                                                       bedStatusController.getBedDetails(
//                                                         "${bedStatusController.bedStatusModel?.data?[mainIndex].bed?[subIndex].id}",
//                                                         context,
//                                                         height,
//                                                         width,
//                                                       );
//                                                     } else {
//                                                       Get.to(
//                                                         () => NewBedScreen(
//                                                             bedId: bedStatusController.bedStatusModel?.data?[mainIndex].bed?[subIndex].id == null
//                                                                 ? null
//                                                                 : "${bedStatusController.bedStatusModel?.data?[mainIndex].bed?[subIndex].id}"),
//                                                       );
//                                                     }
//                                                   },
//                                                   title: Text(
//                                                     bedStatusController.bedStatusModel?.data?[mainIndex].bed?[subIndex].name ?? "N/A",
//                                                     style: TextStyleConst.mediumTextStyle(Colors.black, 17),
//                                                   ),
//                                                   leading: Image.asset(
//                                                     bedStatusController.bedStatusModel?.data?[mainIndex].bed?[subIndex].status ?? false
//                                                         ? ImageUtils.bedStatusGreen
//                                                         : ImageUtils.bedStatusRed,
//                                                     height: 22,
//                                                     width: 30,
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                         );
//                                       }),
//                                       const SizedBox(height: 10),
//                                       const Divider(
//                                         color: ColorConst.borderGreyColor,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/bed_status_controller/bed_status_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/bed_assign/new_bed_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class BedStatusScreen extends StatelessWidget {
  BedStatusScreen({Key? key}) : super(key: key);

  final BedStatusController bedStatusController = Get.put(BedStatusController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      // Changed to a softer background color to make white cards pop
      color: const Color(0xffF5F7FA),
      child: Obx(() {
        if (bedStatusController.isStatusApiCalled.value == false) {
          return  Center(
            child: CircularProgressIndicator(color: ColorConst.primaryColor),
          );
        }

        if (bedStatusController.bedStatusModel?.data?.isEmpty ?? true) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bed_outlined, size: 80, color: ColorConst.hintGreyColor.withOpacity(0.3)),
                const SizedBox(height: 16),
                Text(
                  "No Bed Data Found!",
                  style: TextStyleConst.boldTextStyle(ColorConst.hintGreyColor, 18),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // --- Legend Section ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: ColorConst.borderGreyColor, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem("Available", Colors.green),
                  const SizedBox(width: 30),
                  _buildLegendItem("Occupied", Colors.red),
                ],
              ),
            ),

            // --- Main List Section ---
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  bedStatusController.isStatusApiCalled.value = false;
                  bedStatusController.getBedStatusData();
                },
                color: ColorConst.primaryColor,
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    itemCount: bedStatusController.bedStatusModel?.data?.length ?? 0,
                    itemBuilder: (context, mainIndex) {
                      final categoryData = bedStatusController.bedStatusModel?.data?[mainIndex];

                      return AnimationConfiguration.staggeredList(
                        position: mainIndex,
                        duration: const Duration(milliseconds: 600),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // --- Category Header ---
                                  InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      bedStatusController.changeIcon(mainIndex);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: ColorConst.primaryColor.withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child:  Icon(
                                              Icons.meeting_room_outlined,
                                              color: ColorConst.primaryColor,
                                              size: 22,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Text(
                                              categoryData?.bed_title ?? "Unknown Ward",
                                              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
                                            ),
                                          ),
                                          Obx(() => RotatedBox(
                                            quarterTurns: bedStatusController.turns[mainIndex].value,
                                            child: Image.asset(
                                              ImageUtils.dropDownIcon,
                                              width: 16,
                                              height: 8,
                                              color: ColorConst.hintGreyColor,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // --- Expanded Beds Grid ---
                                  Obx(() {
                                    bool isExpanded = bedStatusController.showData[mainIndex].value;
                                    List beds = categoryData?.bed ?? [];

                                    return AnimatedSize(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      child: isExpanded
                                          ? (beds.isEmpty
                                          ? Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          "No beds configured in this ward.",
                                          style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 14),
                                        ),
                                      )
                                          : GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3, // 3 beds per row
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          childAspectRatio: 1.0, // Square cards
                                        ),
                                        itemCount: beds.length,
                                        itemBuilder: (context, subIndex) {
                                          final bed = beds[subIndex];
                                          final bool isAvailable = bed.status ?? false;

                                          return _buildBedTile(bed, isAvailable, mainIndex, subIndex, context, height, width);
                                        },
                                      ))
                                          : const SizedBox.shrink(),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // --- Helper Widget for the Bed Tile ---
  Widget _buildBedTile(dynamic bed, bool isAvailable, int mainIndex, int subIndex, BuildContext context, double height, double width) {
    return GestureDetector(
      onTap: () {
        if (!isAvailable) {
          CommonLoader.showLoader();
          bedStatusController.getBedDetails(
            "${bed.id}",
            context,
            height,
            width,
          );
        } else {
          Get.to(
                () => NewBedScreen(bedId: bed.id == null ? null : "${bed.id}"),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isAvailable ? Colors.green.shade50 : const Color(0xFFFEF2F2), // Light Red
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isAvailable ? Colors.green.shade200 : Colors.red.shade200,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (isAvailable ? Colors.green : Colors.red).withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isAvailable ? ImageUtils.bedStatusGreen : ImageUtils.bedStatusRed,
              height: 32,
              width: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                bed.name ?? "N/A",
                textAlign: TextAlign.center,
                style: TextStyleConst.boldTextStyle(
                  isAvailable ? Colors.green.shade700 : Colors.red.shade700,
                  13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget for the Top Legend ---
  Widget _buildLegendItem(String title, Color color) {
    return Row(
      children: [
        Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color, width: 1.5),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyleConst.mediumTextStyle(ColorConst.blackColor, 14),
        ),
      ],
    );
  }
}
