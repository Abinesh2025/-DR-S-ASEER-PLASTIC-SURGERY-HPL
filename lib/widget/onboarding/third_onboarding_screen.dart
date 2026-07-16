import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/widget/onboarding/onboarding_content.dart';

class ThirdOnBoardingScreen extends StatelessWidget {
  const ThirdOnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OnboardingContent(
      imagePath: "assets/image/onboarding_3.png",

      title: "24/7 Booking and Automated Reminders",
      description: "Allow patients to book anytime, with reminders to reduce no-shows.",
    );
  }
}
