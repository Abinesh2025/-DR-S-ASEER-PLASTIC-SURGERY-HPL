import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/widget/onboarding/onboarding_content.dart';

class FirstOnBoardingScreen extends StatelessWidget {
  const FirstOnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OnboardingContent(
      imagePath: "assets/image/onboarding_1.png",
      title: "Book Appointment & Rescheduling",
      description: "Patients can easily make appointments & reschedule appointments, reducing missed visits.",
    );
  }
}
