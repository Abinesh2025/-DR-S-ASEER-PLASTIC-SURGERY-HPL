import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';

class VoiceSearchBottomSheet extends StatelessWidget {
  const VoiceSearchBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PatientHomeController>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Listening...",
            style: TextStyleConst.boldTextStyle(Colors.black, 20),
          ),
          const SizedBox(height: 10),
          Obx(() {
            return Text(
              controller.voicePreviewText.value.isEmpty
                  ? "Try saying 'Dr. Smith' or 'Dentist'"
                  : controller.voicePreviewText.value,
              textAlign: TextAlign.center,
              style: TextStyleConst.mediumTextStyle(Colors.grey, 16),
            );
          }),
          const SizedBox(height: 50),
          // Sound Wave Animation
          SizedBox(
            height: 100,
            child: Obx(() {
              if (!controller.isListening.value) {
                return const Center(child: Text("Tap button to start"));
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(15, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 4,
                    height: ((controller.soundLevel.value.abs() * 3) +
                            (index % 5 * 3) +
                            10)
                        .clamp(10, 80),
                    decoration: BoxDecoration(
                      color: ColorConst.primaryColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              );
            }),
          ),
          const SizedBox(height: 50),
          // Mic Button
          Obx(() => GestureDetector(
                onTap: () {
                  if (controller.isListening.value) {
                    controller.stopListening();
                  } else {
                    controller.startListening();
                  }
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: controller.isListening.value
                        ? ColorConst.primaryColor
                        : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorConst.primaryColor.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      )
                    ],
                    border:
                        Border.all(color: ColorConst.primaryColor, width: 2),
                  ),
                  child: Icon(
                    controller.isListening.value ? Icons.mic : Icons.mic_none,
                    color: controller.isListening.value
                        ? Colors.white
                        : ColorConst.primaryColor,
                    size: 35,
                  ),
                ),
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
