import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';

import '../../../controller/patient/home_controller/patient_home_controller.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({Key? key}) : super(key: key);

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen>
    with SingleTickerProviderStateMixin {
  final PatientHomeController controller = Get.find<PatientHomeController>();
  late AnimationController _animationController;
  late Worker _recordingWorker;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );


    _recordingWorker = ever(controller.isSosRecording, (bool isRecording) {
      if (isRecording) {
        if (!_animationController.isAnimating) {
          _animationController.repeat(reverse: true);
        }
      } else {
        _animationController.stop();
      }
    });


    if (controller.isSosRecording.value) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _recordingWorker.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {

    const Color curvedPanelColor = Color(0xFFFFFFFF);
    const Color secondaryBtnColor = Color(0xFFF3F7FF);

    return WillPopScope(
      onWillPop: () async {
        await controller.cancelSos();
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorConst.lightGreens,
        appBar: CommonAppBar(
          title: "SOS Emergency",
          leadIcon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          leadOnTap: () async {
            await controller.cancelSos();
            Navigator.of(context).pop();
          },
        ),
        body: Stack(
          children: [

            Column(
              children: [
                const SizedBox(height: 60),
                Text(
                  "Emergency Recording",
                  style: TextStyleConst.boldTextStyle(Colors.black, 22),
                ),
                const SizedBox(height: 12),
                Obx(() => Text(
                      controller.isSosRecording.value
                          ? (controller.isSosPaused.value 
                              ? "Recording paused. Tap to resume." 
                              : "Recording audio, please state your emergency clearly.")
                          : "Tap to record your emergency message.",
                      textAlign: TextAlign.center,
                      style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 14),
                    )),
                const SizedBox(height: 80),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: _buildWaveform(ColorConst.primaryColor),
                ),
              ],
            ),


            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [

                  Container(
                    margin: const EdgeInsets.only(top: 55),
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
                    decoration: const BoxDecoration(
                      color: curvedPanelColor,
                      borderRadius: BorderRadius.vertical(top: Radius.elliptical(400, 150)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Obx(() => Text(
                              _formatDuration(controller.sosRecordingDuration.value),
                              style: TextStyleConst.boldTextStyle(Colors.black, 24),
                            )),
                        const SizedBox(height: 35),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildCircleBtn(
                              icon: Icons.check,
                              color: Colors.black,
                              backgroundColor: secondaryBtnColor,
                              onTap: () => controller.sendSosData(),
                            ),
                            const SizedBox(width: 90),
                            _buildCircleBtn(
                              icon: Icons.close,
                              color: ColorConst.redColor,
                              backgroundColor: secondaryBtnColor,
                              onTap: () async {
                                await controller.cancelSos();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (controller.isSosRecording.value) {
                        if (controller.isSosPaused.value) {
                          controller.resumeSosRecording();
                        } else {
                          controller.pauseSosRecording();
                        }
                      } else {
                        controller.startSosRecording();
                      }
                    },
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Obx(() {
                          final bool isRecording = controller.isSosRecording.value;
                          final bool isPaused = controller.isSosPaused.value;
                          final double pulseScale = (isRecording && !isPaused)
                              ? (1.0 + (_animationController.value * 0.12))
                              : 1.0;

                          return Transform.scale(
                            scale: pulseScale,
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                color:ColorConst.primaryColor.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorConst.primaryColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    if (isRecording && !isPaused)
                                      BoxShadow(
                                        color: ColorConst.primaryColor.withOpacity(0.4),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      )
                                  ],
                                ),
                                child: Icon(
                                  (isRecording && !isPaused) ? Icons.pause : Icons.mic,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaveform(Color color) {
    return Obx(() {
      final bool isRecording = controller.isSosRecording.value;
      final bool isPaused = controller.isSosPaused.value;
      
      if (!isRecording || isPaused) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(35, (index) => _buildBar(10, color.withOpacity(0.15))),
        );
      }
      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(35, (index) {
              double variance = Random().nextDouble() * 50;
              double height = 10 + (variance * (0.4 + _animationController.value * 0.6));
              return _buildBar(height, color);
            }),
          );
        },
      );
    });
  }

  Widget _buildBar(double height, Color color) {
    return Container(
      width: 4,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildCircleBtn({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
