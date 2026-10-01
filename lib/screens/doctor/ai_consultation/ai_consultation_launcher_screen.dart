import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/ai_consultant_controller/ai_consultant_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_theme.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_setup_dialog.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_live_consultation_screen.dart';


class AiConsultationLauncherScreen extends StatelessWidget {
  const AiConsultationLauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aiController = Get.put(AiConsultantController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        title: Text('AI Consultation Assistant', style: AiTheme.titleStyle(size: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF064E3B),
                    Color(0xFF0FA66A),
                    Color(0xFF022C22),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0FA66A).withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Aura Clinical Transcriber',
                        style: AiTheme.headingStyle(color: Colors.white, size: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ambient Medical AI at your side.',
                    style: AiTheme.titleStyle(color: Colors.white, size: 22),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Listen to patient conversations, automatically extract chief complaints and vitals, verify allergy safety, and produce sign-ready SOAP notes in seconds.',
                    style: AiTheme.bodyStyle(color: Colors.white.withOpacity(0.9), size: 13.5),
                  ),
                  const SizedBox(height: 22),
                  Obx(() {
                    final isActive = aiController.isRecording || aiController.isPaused;
                    if (isActive) {
                      return ElevatedButton.icon(
                        onPressed: () => Get.to(() => const AiLiveConsultationScreen()),
                        icon: const Icon(Icons.radio_button_checked, color: Colors.red, size: 18),
                        label: Text(
                          'Resume Active Session (${aiController.formattedDuration})',
                          style: AiTheme.headingStyle(color: const Color(0xFF064E3B), size: 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      );
                    }
                    return ElevatedButton.icon(
                      onPressed: () => AiConsultationSetupDialog.show(context),
                      icon: const Icon(Icons.mic, color: Color(0xFF064E3B), size: 20),
                      label: Text(
                        'Start New AI Consultation',
                        style: AiTheme.headingStyle(color: const Color(0xFF064E3B), size: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Capabilities Checklist
            Text('Intelligent Consultation Features', style: AiTheme.titleStyle(size: 17)),
            const SizedBox(height: 14),

            _buildFeatureTile(
              icon: Icons.graphic_eq_rounded,
              color: const Color(0xFF0FA66A),
              title: 'Real-time Streaming Transcriber',
              subtitle: 'Whisper Large v3 diarization separates Doctor and Patient lines live during consultation.',
            ),
            const SizedBox(height: 12),
            _buildFeatureTile(
              icon: Icons.monitor_heart_outlined,
              color: const Color(0xFF3B82F6),
              title: 'Live Vitals & Symptoms Copilot',
              subtitle: 'Detected BP, pulse, SpO2, and chief complaints are tracked into clinical memory every 10s.',
            ),
            const SizedBox(height: 12),
            _buildFeatureTile(
              icon: Icons.shield_outlined,
              color: const Color(0xFFEF4444),
              title: 'Allergy & Safety Warning Guard',
              subtitle: 'Prescriptions are cross-checked against patient allergies and hospital drug formulary.',
            ),
            const SizedBox(height: 12),
            _buildFeatureTile(
              icon: Icons.draw_outlined,
              color: const Color(0xFF8B5CF6),
              title: 'Instant SOAP Note & Sign-Off',
              subtitle: 'One-tap approval marks consultation completed and saves records to hospital HMS.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: AiTheme.softShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AiTheme.headingStyle(size: 14.5)),
                const SizedBox(height: 4),
                Text(subtitle, style: AiTheme.bodyStyle(color: const Color(0xFF64748B), size: 12.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
