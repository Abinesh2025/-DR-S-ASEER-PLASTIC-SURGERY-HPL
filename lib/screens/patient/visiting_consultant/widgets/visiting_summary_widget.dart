import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_summary_model.dart';

class VisitingSummaryWidget extends StatelessWidget {
  final VisitingSummaryData summary;

  const VisitingSummaryWidget({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorConst.primaryColor.withOpacity(0.3), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: ColorConst.primaryColor.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Doctor & Date
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorConst.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.assignment_outlined, color: ColorConst.primaryColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Clinical Summary & Findings",
                      style: TextStyleConst.boldTextStyle(
                        ColorConst.blackColor,
                        16,
                      ),
                    ),
                    if (summary.consultantName != null)
                      Text(
                        "Consultant: ${summary.consultantName}",
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.hintGreyColor,
                          12,
                        ),
                      ),
                  ],
                ),
              ),
              if (summary.consultationDate != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorConst.bgGreyColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    summary.consultationDate!,
                    style: TextStyleConst.mediumTextStyle(
                      ColorConst.hintGreyColor,
                      11,
                    ),
                  ),
                ),
            ],
          ),
          const Divider(height: 24),

          // Diagnosis
          if (summary.diagnosis != null && summary.diagnosis!.isNotEmpty) ...[
            _buildSection(
              title: "Diagnosis",
              icon: Icons.healing_outlined,
              content: summary.diagnosis!,
              highlight: true,
            ),
            const SizedBox(height: 14),
          ],

          // Clinical Findings
          if (summary.clinicalFindings != null && summary.clinicalFindings!.isNotEmpty) ...[
            _buildSection(
              title: "Clinical Findings",
              icon: Icons.biotech_outlined,
              content: summary.clinicalFindings!,
            ),
            const SizedBox(height: 14),
          ],

          // Physical Examination
          if (summary.physicalExamination != null && summary.physicalExamination!.isNotEmpty) ...[
            _buildSection(
              title: "Physical Examination",
              icon: Icons.monitor_heart_outlined,
              content: summary.physicalExamination!,
            ),
            const SizedBox(height: 14),
          ],

          // Advice & Treatment
          if (summary.advice != null && summary.advice!.isNotEmpty) ...[
            _buildSection(
              title: "Doctor's Advice & Treatment",
              icon: Icons.medical_services_outlined,
              content: summary.advice!,
            ),
            const SizedBox(height: 14),
          ],

          // Prescriptions
          if (summary.prescriptionNotes != null && summary.prescriptionNotes!.isNotEmpty) ...[
            _buildSection(
              title: "Prescription Notes",
              icon: Icons.medication_outlined,
              content: summary.prescriptionNotes!,
            ),
            const SizedBox(height: 14),
          ],

          // Follow-up
          if (summary.followUpAdvice != null || summary.followUpDate != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorConst.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.event_repeat_rounded, color: ColorConst.primaryColor, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      summary.followUpDate != null
                          ? "Follow-up recommended on: ${summary.followUpDate}"
                          : (summary.followUpAdvice ?? "Follow-up recommended"),
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.primaryColor,
                        13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required String content,
    bool highlight = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: highlight ? ColorConst.primaryColor : ColorConst.hintGreyColor),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyleConst.boldTextStyle(
                highlight ? ColorConst.primaryColor : ColorConst.blackColor,
                13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            content,
            style: TextStyleConst.regularTextStyle(
              ColorConst.blackColor.withOpacity(0.8),
              13,
            ),
          ),
        ),
      ],
    );
  }
}
