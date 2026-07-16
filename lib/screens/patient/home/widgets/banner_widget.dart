import 'package:carousel_slider/carousel_slider.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/skeleton_loading_widgets.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final controller = Get.find<PatientHomeController>();

    return Obx(() {
      if (controller.isBannersLoading.value) {
        return const BannerSkeleton();
      }

      // Use API banners if available, else fallback
      final bannerList =
          controller.banners.isNotEmpty ? controller.banners : [];

      if (bannerList.isEmpty) {
        // Fallback to the requested redesign if no banners from API
        return SizedBox();
        //   Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //   child: Container(
        //     padding:
        //         const EdgeInsets.fromLTRB(20, 15, 0, 0), // Adjusted top padding
        //     decoration: BoxDecoration(
        //       color: const Color(0xff529486), // Theme green color from design
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: [
        //         Expanded(
        //           child: Padding(
        //             padding: const EdgeInsets.only(bottom: 15.0),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   "Looking for\ndesired doctor?",
        //                   style: TextStyleConst.boldTextStyle(
        //                     ColorConst.whiteColor,
        //                     18, // Reduced font size slightly
        //                   ).copyWith(height: 1.2),
        //                 ),
        //                 const SizedBox(height: 10),
        //                 ElevatedButton(
        //                   onPressed: () {},
        //                   style: ElevatedButton.styleFrom(
        //                     backgroundColor: ColorConst.whiteColor,
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(10),
        //                     ),
        //                     padding: const EdgeInsets.symmetric(
        //                         horizontal: 16, vertical: 8),
        //                   ),
        //                   child: Text(
        //                     "Search for",
        //                     style: TextStyleConst.mediumTextStyle(
        //                       const Color(0xff529486), // Same green
        //                       14,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         Image.asset(
        //           'assets/image/doctor-icon.png',
        //           height: 110, // Reduced height here
        //           fit: BoxFit.contain,
        //           alignment: Alignment.bottomRight,
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      }

      return CarouselSlider(
        options: CarouselOptions(
          height: height * 0.16, // Reduced from 0.20
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 16 / 9,
          initialPage: 0,
        ),
        items: bannerList.map((bannerData) {
          return Builder(
            builder: (BuildContext context) {
              String imageUrl = bannerData.imageUrl ?? "";
              if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
                imageUrl = '${StringUtils.imagePath}$imageUrl';
              }

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConst.lightGreyColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const Skeleton(borderRadius: 20),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        }).toList(),
      );
    });
  }
}
