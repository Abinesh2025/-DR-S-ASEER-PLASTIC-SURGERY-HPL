import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/main.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/home_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/appointment/appointment_screen.dart';

import '../order/my_orders_screen.dart';

class OrderSuccessScreen extends StatefulWidget {
  final String message;
  final String orderId;

  const OrderSuccessScreen({
    Key? key,
    required this.message,
    required this.orderId,
  }) : super(key: key);

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onContinueShopping() {
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().changeBottomNavIndex(0);
    }

    if (Get.isRegistered<PatientHomeController>()) {
      Get.find<PatientHomeController>().refreshData();
    }

    // Because the Success Screen was pushed with Get.offAll(), router.go() fails to update the display
    // Using Get.offAll() safely replaces the entire screen state back to Home.
    Get.offAll(() => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 600),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: ColorConst.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: ColorConst.primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorConst.primaryColor.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  StringUtils.orderSuccessful,
                  textAlign: TextAlign.center,
                  style: TextStyleConst.boldTextStyle(
                    ColorConst.blackColor,
                    28,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.hintGreyColor,
                    16,
                  ).copyWith(height: 1.5),
                ),
                if (widget.orderId.isNotEmpty) ...[
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConst.bgGreyColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ColorConst.primaryColor.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          StringUtils.orderIdLabel,
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.hintGreyColor,
                            14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "#${widget.orderId}",
                          style: TextStyleConst.boldTextStyle(
                            ColorConst.primaryColor,
                            18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: _onContinueShopping,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    StringUtils.continueShopping,
                    style: TextStyleConst.boldTextStyle(
                      ColorConst.whiteColor,
                      18,
                    ),
                  ),
                ),
                // const SizedBox(height: 16),
                // TextButton(
                //   onPressed: () {
                //     // Navigate to appointments replacing the success screen
                //     Get.offAll(() =>  MyOrdersScreen());
                //   },
                //   style: TextButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(vertical: 18),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(16),
                //     ),
                //   ),
                //   child: Text(
                //     StringUtils.myOrders,
                //     style: TextStyleConst.boldTextStyle(
                //       ColorConst.primaryColor,
                //       16,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
