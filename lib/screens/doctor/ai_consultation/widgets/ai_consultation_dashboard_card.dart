import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_theme.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_setup_dialog.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_live_consultation_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/ai_consultant_controller/ai_consultant_controller.dart';

class AiConsultationDashboardCard extends StatelessWidget {
  const AiConsultationDashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    final aiController = Get.put(AiConsultantController());

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF064E3B), // Deep Forest Emerald
            Color(0xFF0FA66A), // Brand Green
            Color(0xFF022C22), // Dark Slate Emerald
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0FA66A).withOpacity(0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background ambient circles
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tag
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            'AI CLINICAL ASSISTANT',
                            style: AiTheme.monoStyle(color: Colors.white, size: 11),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      if (aiController.isRecording) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'REC',
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
                const SizedBox(height: 14),

                // Main Title
                Text(
                  'Live Consultation Transcriber',
                  style: AiTheme.titleStyle(color: Colors.white, size: 19),
                ),
                const SizedBox(height: 6),
                Text(
                  'Record conversation • Real-time STT • Auto-generate SOAP notes & safe prescriptions.',
                  style: AiTheme.bodyStyle(color: Colors.white.withOpacity(0.85), size: 13),
                ),
                const SizedBox(height: 16),

                // Action Buttons
                Obx(() {
                  final isSessionActive = aiController.isRecording || aiController.isPaused;

                  return Row(
                    children: [
                      if (isSessionActive) ...[
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => Get.to(() => const AiLiveConsultationScreen()),
                            icon: const Icon(Icons.radio_button_checked, size: 16, color: Colors.red),
                            label: Text(
                              'Resume Active (${aiController.formattedDuration})',
                              style: AiTheme.headingStyle(color: const Color(0xFF064E3B), size: 13),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ] else ...[
                        ElevatedButton.icon(
                          onPressed: () => AiConsultationSetupDialog.show(context),
                          icon: const Icon(Icons.mic_rounded, color: Color(0xFF064E3B), size: 18),
                          label: Text(
                            'Start AI Consultation',
                            style: AiTheme.headingStyle(color: const Color(0xFF064E3B), size: 13),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
