import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/ai_consultant_controller/ai_consultant_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_theme.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_live_consultation_screen.dart';

class AiConsultationSetupDialog extends StatefulWidget {
  final int? initialPatientId;
  final String? initialPatientName;
  final int? initialAppointmentId;
  final String? initialSpecialty;

  const AiConsultationSetupDialog({
    super.key,
    this.initialPatientId,
    this.initialPatientName,
    this.initialAppointmentId,
    this.initialSpecialty,
  });

  static Future<void> show(
    BuildContext context, {
    int? patientId,
    String? patientName,
    int? appointmentId,
    String? specialty,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => AiConsultationSetupDialog(
        initialPatientId: patientId,
        initialPatientName: patientName,
        initialAppointmentId: appointmentId,
        initialSpecialty: specialty,
      ),
    );
  }

  @override
  State<AiConsultationSetupDialog> createState() => _AiConsultationSetupDialogState();
}

class _AiConsultationSetupDialogState extends State<AiConsultationSetupDialog> {
  final controller = Get.put(AiConsultantController());
  late TextEditingController _patientIdController;
  late TextEditingController _patientNameController;
  String _selectedSpecialty = 'GENERAL_PHYSICIAN';

  @override
  void initState() {
    super.initState();
    _patientIdController = TextEditingController(
      text: widget.initialPatientId != null && widget.initialPatientId! > 0
          ? widget.initialPatientId.toString()
          : '42',
    );
    _patientNameController = TextEditingController(
      text: widget.initialPatientName ?? '',
    );
    if (widget.initialSpecialty != null && widget.initialSpecialty!.isNotEmpty) {
      _selectedSpecialty = widget.initialSpecialty!;
    }
  }

  @override
  void dispose() {
    _patientIdController.dispose();
    _patientNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        20,
        24,
        MediaQuery.of(context).viewInsets.bottom + 28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AiTheme.primaryEmerald.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_awesome, color: AiTheme.primaryEmerald, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text('Start AI Consultation', style: AiTheme.titleStyle(size: 18)),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Color(0xFF64748B)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'The AI assistant will transcribe dialogue in real-time, extract symptoms, monitor vitals, and generate SOAP clinical notes.',
            style: AiTheme.bodyStyle(color: const Color(0xFF64748B), size: 13),
          ),
          const SizedBox(height: 20),

          // Patient Name & ID
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _patientNameController,
                  decoration: InputDecoration(
                    labelText: 'Patient Name',
                    hintText: 'e.g. Rajan Kumar',
                    labelStyle: AiTheme.labelStyle(size: 13),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.person_outline, size: 20),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _patientIdController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Patient ID',
                    labelStyle: AiTheme.labelStyle(size: 13),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.tag, size: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Specialty Dropdown
          Text('Clinical Specialty', style: AiTheme.headingStyle(size: 13)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedSpecialty,
                items: AiConsultantController.availableSpecialties.map((spec) {
                  return DropdownMenuItem(
                    value: spec,
                    child: Text(
                      spec.replaceAll('_', ' '),
                      style: AiTheme.bodyStyle(size: 14),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedSpecialty = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Launch Button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [Color(0xFF0FA66A), Color(0xFF086C45)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: AiTheme.glowingShadow(AiTheme.primaryEmerald),
            ),
            child: ElevatedButton.icon(
              onPressed: () => _launchSession(context),
              icon: const Icon(Icons.mic, color: Colors.white, size: 20),
              label: Text(
                'Start Live Consultation',
                style: AiTheme.titleStyle(color: Colors.white, size: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchSession(BuildContext context) async {
    final patientId = int.tryParse(_patientIdController.text.trim()) ?? 0;
    if (patientId <= 0) {
      Get.snackbar('Invalid Patient ID', 'Please enter a valid patient ID.',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    Navigator.pop(context); // close sheet

    controller.initConsultationContext(
      pId: patientId,
      pName: _patientNameController.text.trim(),
      aId: widget.initialAppointmentId,
      preferredSpecialty: _selectedSpecialty,
    );

    // Navigate to live session screen
    Get.to(() => const AiLiveConsultationScreen());

    // Start session in background
    controller.startConsultation();
  }
}
