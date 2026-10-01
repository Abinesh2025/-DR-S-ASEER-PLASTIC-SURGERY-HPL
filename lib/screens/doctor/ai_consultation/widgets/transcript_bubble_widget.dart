import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/ai_consultant/ai_consultant_models.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_theme.dart';

class TranscriptBubbleWidget extends StatelessWidget {
  final TranscriptSegment segment;
  final VoidCallback? onEdit;

  const TranscriptBubbleWidget({
    super.key,
    required this.segment,
    this.onEdit,
  });

  bool get isDoctor => segment.speaker.toUpperCase().contains('DOCTOR');

  @override
  Widget build(BuildContext context) {
    final startTimeFormatted = _formatSeconds(segment.startTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isDoctor ? MainAxisAlignment.start : MainAxisAlignment.start,
        children: [
          // Speaker Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDoctor
                    ? [const Color(0xFF0FA66A), const Color(0xFF086C45)]
                    : [const Color(0xFF334155), const Color(0xFF1E293B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (isDoctor ? AiTheme.primaryEmerald : Colors.black)
                      .withOpacity(0.18),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                isDoctor ? Icons.medical_services_rounded : Icons.person_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Message Card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDoctor ? AiTheme.doctorBubble : AiTheme.patientBubble,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(18),
                  bottomLeft: const Radius.circular(18),
                  bottomRight: const Radius.circular(18),
                  topLeft: isDoctor ? const Radius.circular(4) : const Radius.circular(18),
                ),
                border: Border.all(
                  color: isDoctor
                      ? AiTheme.primaryEmerald.withOpacity(0.2)
                      : const Color(0xFFCBD5E1).withOpacity(0.6),
                  width: 1.2,
                ),
                boxShadow: AiTheme.softShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Speaker Tag & Metadata Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            isDoctor ? 'DOCTOR' : 'PATIENT',
                            style: AiTheme.headingStyle(
                              color: isDoctor
                                  ? AiTheme.doctorAccent
                                  : AiTheme.patientAccent,
                              size: 12,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '• $startTimeFormatted',
                            style: AiTheme.labelStyle(
                              color: const Color(0xFF94A3B8),
                              size: 11,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (segment.isUncertain == true) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Low confidence',
                                style: AiTheme.labelStyle(
                                  color: Colors.amber.shade900,
                                  size: 10,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                          if (onEdit != null)
                            InkWell(
                              onTap: onEdit,
                              borderRadius: BorderRadius.circular(12),
                              child: const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 15,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Segment Text
                  Text(
                    segment.text,
                    style: AiTheme.bodyStyle(
                      color: const Color(0xFF1E293B),
                      size: 14.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatSeconds(double sec) {
    final total = sec.toInt();
    final m = total ~/ 60;
    final s = total % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
