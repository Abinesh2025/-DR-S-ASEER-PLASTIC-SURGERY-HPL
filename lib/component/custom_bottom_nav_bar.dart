import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

import '../constant/text_style_const.dart';
import '../utils/string_utils.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  void initState() {
    super.initState();
    // Fetch profile data when bottom bar is initialized
    try {
      final homeController = Get.find<HomeController>();
      homeController.getProfile();
    } catch (e) {
      // HomeController might not be initialized yet in some edge cases
      print("Error fetching profile in bottom bar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

        child: Container(

      margin: const EdgeInsets.only(bottom:16, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(0.95), // Slight opacity ensures it's not a dead zone
        borderRadius: BorderRadius.circular(40),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // _buildPillItem(
          //   index: 0,
          //   icon: Icons.home_rounded,
          //   label: StringUtils.home,
          // ),
          //
          // _buildPillItem(
          //   index: 1,
          //   icon: Icons.calendar_month_rounded,
          //   label: StringUtils.book,
          // ),
          // _buildPillItem(
          //   index: 2,
          //   icon: Icons.medication_outlined,
          //   label: StringUtils.medicines,
          // ),
          _buildPillItem(
            index: 0,
            imagePath: ImageUtils.home,
            label: "Home",
          ),

          _buildPillItem(
            index: 1,
            imagePath: ImageUtils.appointment,
            label: "Appointment",
          ),

          _buildPillItem(
            index: 2,
            imagePath: ImageUtils.medicine,
            label: "Medicine",
          ),
          _buildAvatarItem(3),
        ],
      ),
    ));
  }

  // Widget _buildPillItem({
  //   required int index,
  //   required IconData icon,
  //   required String label,
  // }) {
  //   final isSelected = widget.currentIndex == index;
  //   return GestureDetector(
  //     onTap: () => widget.onTap(index),
  //     behavior: HitTestBehavior.opaque,
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //       padding: EdgeInsets.symmetric(
  //         vertical: 10,
  //         horizontal: isSelected ? 16 : 12,
  //       ),
  //       decoration: BoxDecoration(
  //         color: isSelected ? ColorConst.primaryColor : Colors.transparent,
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             icon,
  //             color: isSelected ? Colors.white : ColorConst.hintGreyColor,
  //             size: 24,
  //           ),
  //           if (isSelected) ...[
  //             const SizedBox(width: 8),
  //             Text(
  //               label,
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 14,
  //               ),
  //             ),
  //           ],
  //         ],
  //       ),
  //     ),
  //   );
  // }
  // Widget _buildPillItem({
  //   required int index,
  //   required String imagePath,
  //   required String label,
  // }) {
  //   final isSelected = widget.currentIndex == index;
  //
  //   return GestureDetector(
  //     onTap: () => widget.onTap(index),
  //     behavior: HitTestBehavior.opaque,
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //       padding: EdgeInsets.symmetric(
  //         vertical: 10,
  //         horizontal: isSelected ? 16 : 12,
  //       ),
  //       decoration: BoxDecoration(
  //         color: isSelected ? ColorConst.primaryColor : Colors.transparent,
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Image.asset(
  //             imagePath,
  //             height: 22,
  //             width: 22,
  //             color: isSelected ? Colors.white : ColorConst.hintGreyColor,
  //           ),
  //
  //           if (isSelected) ...[
  //             const SizedBox(width: 8),
  //             Text(
  //               label,
  //               style: TextStyleConst.mediumTextStyle(
  //                 Colors.white,
  //                 14,
  //
  //               ),
  //             ),
  //           ],
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildPillItem({
    required int index,
    required String imagePath,
    required String label,
  }) {
    final isSelected = widget.currentIndex == index;

    Widget iconWidget;

    if (imagePath.endsWith('.svg')) {
      iconWidget = SvgPicture.asset(
        imagePath,
        height: 22,
        width: 22,
        colorFilter: ColorFilter.mode(
          isSelected ? Colors.white : ColorConst.hintGreyColor,
          BlendMode.srcIn,
        ),
      );
    } else {
      iconWidget = Image.asset(
        imagePath,
        height: 22,
        width: 22,
        color: isSelected ? Colors.white : ColorConst.hintGreyColor,
      );
    }

    return GestureDetector(
      onTap: () => widget.onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: isSelected ? 16 : 12,
        ),
        decoration: BoxDecoration(
          color: isSelected ? ColorConst.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,

            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyleConst.mediumTextStyle(
                  Colors.white,
                  14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  Widget _buildAvatarItem(int index) {
    final isSelected = widget.currentIndex == index;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? ColorConst.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConst.lightBlueColor,
          ),
          child: ClipOval(
            child: Obx(() {
              final imageUrl = VariableUtils.imageUrl.value;

              if (imageUrl.isEmpty) {
                return Image.asset(
                  ImageUtils.profileIcon,
                  fit: BoxFit.cover,
                );
              }

              return Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    ImageUtils.profileIcon,
                    fit: BoxFit.cover,
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
