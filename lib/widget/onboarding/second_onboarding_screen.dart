import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/widget/onboarding/onboarding_content.dart';

class SecondOnBoardingScreen extends StatelessWidget {
  const SecondOnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OnboardingContent(
      imagePath: "assets/image/onboarding_2.png",
      title: "Efficient Hospital Token Management System",
      description: "Streamline patient flow with real-time token alerts and notifications.",
    );
  }
}
