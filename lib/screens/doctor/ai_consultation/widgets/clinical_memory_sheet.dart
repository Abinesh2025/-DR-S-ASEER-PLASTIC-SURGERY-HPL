import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/ai_consultant/ai_consultant_models.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_theme.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/ai_consultant_controller/ai_consultant_controller.dart';

class ClinicalMemoryView extends StatelessWidget {
  const ClinicalMemoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AiConsultantController>();

    return Obx(() {
      final memory = controller.memory.value;
      final alerts = controller.clinicalAlerts;

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // ── Active Clinical Alerts Banner ──
          if (alerts.isNotEmpty) ...[
            _buildSectionHeader('ACTIVE CLINICAL ALERTS', Icons.warning_amber_rounded, AiTheme.alertWarning),
            const SizedBox(height: 8),
            ...alerts.map((alert) => _buildAlertCard(context, alert, controller)),
            const SizedBox(height: 18),
          ],

          // ── Extracted Vitals ──
          _buildSectionHeader('EXTRACTED VITALS', Icons.monitor_heart_outlined, AiTheme.primaryEmerald),
          const SizedBox(height: 10),
          _buildVitalsGrid(memory?.vitalsExtracted),
          const SizedBox(height: 20),

          // ── Chief Complaints ──
          _buildSectionHeader('CHIEF COMPLAINTS', Icons.assignment_outlined, const Color(0xFF3B82F6)),
          const SizedBox(height: 10),
          if (memory == null || memory.typedChiefComplaints.isEmpty)
            _buildEmptyState('No chief complaints extracted yet.')
          else
            ...memory.typedChiefComplaints.map(_buildComplaintTile),
          const SizedBox(height: 20),

          // ── Symptoms & Negative Findings ──
          _buildSectionHeader('SYMPTOMS & FINDINGS', Icons.healing_outlined, const Color(0xFF8B5CF6)),
          const SizedBox(height: 10),
          if (memory == null || memory.typedSymptoms.isEmpty)
            _buildEmptyState('Listening for symptoms and examination points...')
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: memory.typedSymptoms.map(_buildSymptomChip).toList(),
            ),
          const SizedBox(height: 20),

          // ── Examination Findings ──
          if (memory != null && memory.examinationFindings.isNotEmpty) ...[
            _buildSectionHeader('EXAMINATION FINDINGS', Icons.fact_check_outlined, const Color(0xFF0284C7)),
            const SizedBox(height: 8),
            ...memory.examinationFindings.map((finding) => Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 16, color: AiTheme.primaryEmerald),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(finding, style: AiTheme.bodyStyle(size: 13)),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
          ],
        ],
      );
    });
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: AiTheme.headingStyle(color: const Color(0xFF334155), size: 12),
        ),
      ],
    );
  }

  Widget _buildVitalsGrid(VitalsExtracted? vitals) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: AiTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildVitalItem('BP', vitals?.bp ?? '--/--', 'mmHg', Icons.speed_rounded),
          _buildVitalDivider(),
          _buildVitalItem('Pulse', vitals?.pulse ?? '--', 'bpm', Icons.favorite_border_rounded),
          _buildVitalDivider(),
          _buildVitalItem('SpO2', vitals?.spo2 ?? '--', '%', Icons.air_rounded),
          _buildVitalDivider(),
          _buildVitalItem('Temp', vitals?.temperature ?? '--', '°F', Icons.thermostat_rounded),
        ],
      ),
    );
  }

  Widget _buildVitalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: const Color(0xFFE2E8F0),
    );
  }

  Widget _buildVitalItem(String label, String value, String unit, IconData icon) {
    final hasValue = value != '--' && value != '--/--';
    return Column(
      children: [
        Icon(icon, size: 18, color: hasValue ? AiTheme.primaryEmerald : const Color(0xFF94A3B8)),
        const SizedBox(height: 4),
        Text(
          value,
          style: AiTheme.titleStyle(
            size: 15,
            color: hasValue ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
          ),
        ),
        Text(
          '$label ($unit)',
          style: AiTheme.labelStyle(color: const Color(0xFF64748B), size: 10),
        ),
      ],
    );
  }

  Widget _buildComplaintTile(ChiefComplaint complaint) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                complaint.complaint,
                style: AiTheme.headingStyle(size: 14),
              ),
            ],
          ),
          if (complaint.duration != null && complaint.duration!.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                complaint.duration!,
                style: AiTheme.labelStyle(color: const Color(0xFF2563EB), size: 11),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSymptomChip(SymptomItem symptom) {
    final isNegative = symptom.isNegativeFinding;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isNegative ? const Color(0xFFF1F5F9) : const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isNegative ? const Color(0xFFCBD5E1) : const Color(0xFFDDD6FE),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isNegative ? Icons.remove_circle_outline : Icons.check_circle,
            size: 14,
            color: isNegative ? const Color(0xFF64748B) : const Color(0xFF7C3AED),
          ),
          const SizedBox(width: 6),
          Text(
            isNegative ? 'No ${symptom.name}' : symptom.name,
            style: AiTheme.bodyStyle(
              size: 12.5,
              color: isNegative ? const Color(0xFF64748B) : const Color(0xFF5B21B6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(BuildContext context, ClinicalAlert alert, AiConsultantController controller) {
    final isCritical = alert.severity.toUpperCase() == 'HIGH' || alert.severity.toUpperCase() == 'CRITICAL';
    final cardColor = isCritical ? const Color(0xFFFEF2F2) : const Color(0xFFFFFBEB);
    final borderColor = isCritical ? const Color(0xFFFCA5A5) : const Color(0xFFFDE68A);
    final accentColor = isCritical ? const Color(0xFFDC2626) : const Color(0xFFD97706);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.report_problem_rounded, color: accentColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      alert.type.replaceAll('_', ' '),
                      style: AiTheme.headingStyle(color: accentColor, size: 12),
                    ),
                    InkWell(
                      onTap: () => controller.resolveAlert(alert.id),
                      child: Text(
                        'Acknowledge',
                        style: AiTheme.headingStyle(color: accentColor, size: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  alert.message,
                  style: AiTheme.bodyStyle(color: const Color(0xFF1E293B), size: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), style: BorderStyle.solid),
      ),
      child: Center(
        child: Text(
          message,
          style: AiTheme.labelStyle(color: const Color(0xFF94A3B8), size: 13),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
