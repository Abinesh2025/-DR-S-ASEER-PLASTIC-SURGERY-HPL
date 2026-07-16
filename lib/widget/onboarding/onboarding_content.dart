import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class OnboardingContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingContent({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [

          Positioned(
            top: height * 0.05,
            left: 0,
            right: 0,
            child: SizedBox(
              height: height * 0.4,
              child: Stack(
                alignment: Alignment.center,
                children: [

                  Transform.rotate(
                    angle: -0.1,
                    child: Container(
                      width: width * 0.7,
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  Transform.rotate(
                    angle: 0.1,
                    child: Container(
                      width: width * 0.75,
                      height: height * 0.32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: height * 0.50,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyleConst.boldTextStyle(Colors.white, width * 0.065),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyleConst.mediumTextStyle(Colors.white.withOpacity(0.8), width * 0.04),
                    ),
                  ),
                  const SizedBox(height: 180),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
