import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../constant/text_style_const.dart';
import '../../../controller/patient/intro_controller/splash_controller.dart';
import '../../../utils/image_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  final SplashController splashController = Get.put(SplashController()); // ✅ ADD THIS

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // Subtle gradient prevents the screen from looking "flat" or "empty"
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Colors.white,
              const Color(0xFFF8F7FF), // Extremely faint purple tint
            ],
          ),
        ),
        child: Stack(
          children: [
            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with a subtle shadow for depth
                  Image.asset(
                    ImageUtils.hospitalSplashLogo,
                    height: 160, // Increased size slightly
                    width: 160,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 80),

                  // Loader with a more modern, thinner profile
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      strokeWidth: 2.5, // Thinner lines look more "high-end"
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Branding (Re-enabled and Polished)

          ],
        ),
      ),
    );
  }}
