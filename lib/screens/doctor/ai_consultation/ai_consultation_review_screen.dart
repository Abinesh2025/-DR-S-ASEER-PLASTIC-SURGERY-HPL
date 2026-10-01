import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/ai_consultant_controller/ai_consultant_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/ai_consultant/ai_consultant_models.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_theme.dart';

class AiConsultationReviewScreen extends StatefulWidget {
  const AiConsultationReviewScreen({super.key});

  @override
  State<AiConsultationReviewScreen> createState() => _AiConsultationReviewScreenState();
}

class _AiConsultationReviewScreenState extends State<AiConsultationReviewScreen> {
  final AiConsultantController controller = Get.find<AiConsultantController>();

  late TextEditingController _subjectiveController;
  late TextEditingController _objectiveController;
  late TextEditingController _assessmentController;
  late TextEditingController _planController;
  late TextEditingController _adviceController;

  String _nextVisitQty = '5';
  String _nextVisitTime = 'days';
  bool _isEditingSoap = false;

  @override
  void initState() {
    super.initState();
    final soap = controller.reviewData.value?.soapNote ?? controller.processResult.value?.soapNote;
    _subjectiveController = TextEditingController(text: soap?.subjective ?? '');
    _objectiveController = TextEditingController(text: soap?.objective ?? '');
    _assessmentController = TextEditingController(text: soap?.assessment ?? '');
    _planController = TextEditingController(text: soap?.plan ?? '');
    _adviceController = TextEditingController(text: 'Rest adequately. Drink plenty of fluids.');
  }

  @override
  void dispose() {
    _subjectiveController.dispose();
    _objectiveController.dispose();
    _assessmentController.dispose();
    _planController.dispose();
    _adviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        title: Text('Review & Sign-Off', style: AiTheme.titleStyle(size: 18)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(color: Colors.amber.shade700, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text(
                  'REVIEW PENDING',
                  style: AiTheme.monoStyle(color: Colors.amber.shade900, size: 11),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(() {
        final review = controller.reviewData.value;
        final warnings = review?.safetyWarnings ?? [];
        final prescriptions = controller.editablePrescriptions;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Patient Info Card ──
            _buildPatientBanner(),
            const SizedBox(height: 16),

            // ── Clinical Safety Warnings (e.g. Allergies) ──
            if (warnings.isNotEmpty) ...[
              _buildSafetyWarningsBox(warnings),
              const SizedBox(height: 16),
            ],

            // ── SOAP Notes Section ──
            _buildSoapCard(),
            const SizedBox(height: 20),

            // ── Prescriptions Draft Section ──
            _buildPrescriptionsHeader(prescriptions.length),
            const SizedBox(height: 10),
            if (prescriptions.isEmpty)
              _buildEmptyPrescriptionsTile()
            else
              ...List.generate(
                prescriptions.length,
                (index) => _buildPrescriptionCard(prescriptions[index], index),
              ),
            const SizedBox(height: 20),

            // ── Doctor Advice & Follow-Up ──
            _buildAdviceAndFollowUpSection(),
            const SizedBox(height: 28),

            // ── Final Sign & Approve Button ──
            _buildApproveButton(context),
            const SizedBox(height: 40),
          ],
        );
      }),
    );
  }

  Widget _buildPatientBanner() {
    final profile = controller.patientProfile.value;
    final allergies = profile?.knownAllergies ?? [];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: AiTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AiTheme.softTealBg,
                    child: const Icon(Icons.person, color: AiTheme.primaryEmerald),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.patientName.value.isNotEmpty
                            ? controller.patientName.value
                            : 'Patient #${controller.patientId}',
                        style: AiTheme.headingStyle(size: 15),
                      ),
                      Text(
                        'ID: ${controller.patientId} • ${controller.specialty.value.replaceAll('_', ' ')}',
                        style: AiTheme.labelStyle(size: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'AI Synthesized',
                  style: AiTheme.labelStyle(color: const Color(0xFF2563EB), size: 11),
                ),
              ),
            ],
          ),
          if (allergies.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFCA5A5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Known Allergies: ${allergies.join(", ")}',
                    style: AiTheme.headingStyle(color: const Color(0xFFDC2626), size: 12),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSafetyWarningsBox(List<SafetyWarning> warnings) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF87171), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.dangerous_outlined, color: Color(0xFFDC2626), size: 20),
              const SizedBox(width: 8),
              Text(
                'Safety Warnings Flagged by AI',
                style: AiTheme.headingStyle(color: const Color(0xFFDC2626), size: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...warnings.map((w) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• ${w.message}',
                  style: AiTheme.bodyStyle(color: const Color(0xFF991B1B), size: 13),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSoapCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: AiTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AiTheme.primaryEmerald.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.description_outlined, color: AiTheme.primaryEmerald, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Text('SOAP Clinical Note', style: AiTheme.titleStyle(size: 16)),
                ],
              ),
              TextButton.icon(
                onPressed: () => setState(() => _isEditingSoap = !_isEditingSoap),
                icon: Icon(
                  _isEditingSoap ? Icons.check_circle_outline : Icons.edit_note_rounded,
                  size: 18,
                  color: AiTheme.primaryEmerald,
                ),
                label: Text(
                  _isEditingSoap ? 'Done' : 'Edit Note',
                  style: AiTheme.headingStyle(color: AiTheme.primaryEmerald, size: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildSoapField('Subjective (S)', _subjectiveController, const Color(0xFF2563EB)),
          const SizedBox(height: 12),
          _buildSoapField('Objective (O)', _objectiveController, const Color(0xFF059669)),
          const SizedBox(height: 12),
          _buildSoapField('Assessment (A)', _assessmentController, const Color(0xFFD97706)),
          const SizedBox(height: 12),
          _buildSoapField('Plan (P)', _planController, const Color(0xFF7C3AED)),
        ],
      ),
    );
  }

  Widget _buildSoapField(String label, TextEditingController textController, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 14, decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 6),
            Text(label, style: AiTheme.headingStyle(color: const Color(0xFF334155), size: 13)),
          ],
        ),
        const SizedBox(height: 6),
        _isEditingSoap
            ? TextField(
                controller: textController,
                maxLines: null,
                style: AiTheme.bodyStyle(size: 13.5),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                ),
              )
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  textController.text.isNotEmpty ? textController.text : 'Not recorded',
                  style: AiTheme.bodyStyle(color: const Color(0xFF334155), size: 13),
                ),
              ),
      ],
    );
  }

  Widget _buildPrescriptionsHeader(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.medication_outlined, color: Color(0xFF3B82F6), size: 18),
            ),
            const SizedBox(width: 10),
            Text('Prescriptions Draft ($count)', style: AiTheme.titleStyle(size: 16)),
          ],
        ),
        ElevatedButton.icon(
          onPressed: _showAddMedicineDialog,
          icon: const Icon(Icons.add, size: 16, color: Colors.white),
          label: Text('Add Drug', style: AiTheme.headingStyle(color: Colors.white, size: 12)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AiTheme.primaryEmerald,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget _buildPrescriptionCard(SuggestedMedication med, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: med.isFormularyMatched ? const Color(0xFFE2E8F0) : Colors.amber.shade300,
        ),
        boxShadow: AiTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      med.medicineName,
                      style: AiTheme.titleStyle(size: 15),
                    ),
                    const SizedBox(width: 8),
                    if (med.dosage != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          med.dosage!,
                          style: AiTheme.monoStyle(color: const Color(0xFF334155), size: 11),
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                onPressed: () => controller.removePrescriptionItem(index),
              ),
            ],
          ),
          if (med.saltComposition != null && med.saltComposition!.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              med.saltComposition!,
              style: AiTheme.labelStyle(color: const Color(0xFF64748B), size: 11.5),
            ),
          ],
          const SizedBox(height: 10),

          // Regimen chips
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _buildChip(Icons.access_time, 'Freq: ${med.frequency ?? "1-0-1"}', const Color(0xFF3B82F6)),
              _buildChip(Icons.calendar_today_outlined, 'Duration: ${med.duration ?? "5 days"}', const Color(0xFF8B5CF6)),
              if (med.foodTiming != null)
                _buildChip(Icons.restaurant_outlined, med.foodTiming!, const Color(0xFFD97706)),
              if (med.isFormularyMatched)
                _buildChip(Icons.verified, 'Formulary ✓', AiTheme.primaryEmerald),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: AiTheme.headingStyle(color: color, size: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPrescriptionsTile() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Text(
          'No prescriptions generated. Tap "+ Add Drug" to prescribe.',
          style: AiTheme.labelStyle(color: const Color(0xFF94A3B8), size: 13),
        ),
      ),
    );
  }

  Widget _buildAdviceAndFollowUpSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: AiTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Doctor Advice & Next Visit', style: AiTheme.titleStyle(size: 15)),
          const SizedBox(height: 12),
          TextField(
            controller: _adviceController,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Advice / Lifestyle Instructions',
              labelStyle: AiTheme.labelStyle(size: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text('Next Visit In:', style: AiTheme.headingStyle(size: 13)),
              const SizedBox(width: 12),
              SizedBox(
                width: 70,
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  controller: TextEditingController(text: _nextVisitQty),
                  onChanged: (v) => _nextVisitQty = v,
                ),
              ),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: _nextVisitTime,
                items: const [
                  DropdownMenuItem(value: 'days', child: Text('Days')),
                  DropdownMenuItem(value: 'weeks', child: Text('Weeks')),
                  DropdownMenuItem(value: 'months', child: Text('Months')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _nextVisitTime = val);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApproveButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0FA66A), Color(0xFF084E31)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: AiTheme.glowingShadow(AiTheme.primaryEmerald),
      ),
      child: ElevatedButton.icon(
        onPressed: () => _handleApprove(context),
        icon: const Icon(Icons.check_circle, color: Colors.white, size: 22),
        label: Text(
          'Approve & Complete Consultation',
          style: AiTheme.titleStyle(color: Colors.white, size: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  void _showAddMedicineDialog() {
    final nameCtrl = TextEditingController();
    final dosageCtrl = TextEditingController(text: '500mg');
    final freqCtrl = TextEditingController(text: '1-0-1');
    final durationCtrl = TextEditingController(text: '5 days');
    String foodTiming = 'After Meal';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Add Prescription', style: AiTheme.titleStyle(size: 18)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Medicine Name (e.g. Paracetamol)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: dosageCtrl,
                decoration: const InputDecoration(labelText: 'Dosage (e.g. 500mg)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: freqCtrl,
                decoration: const InputDecoration(labelText: 'Frequency (e.g. 1-0-1)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: durationCtrl,
                decoration: const InputDecoration(labelText: 'Duration (e.g. 5 days)'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.trim().isNotEmpty) {
                controller.addPrescriptionItem(
                  SuggestedMedication(
                    medicineName: nameCtrl.text.trim(),
                    dosage: dosageCtrl.text.trim(),
                    frequency: freqCtrl.text.trim(),
                    duration: durationCtrl.text.trim(),
                    foodTiming: foodTiming,
                    isFormularyMatched: true,
                    requiresDoctorConfirmation: false,
                  ),
                );
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AiTheme.primaryEmerald),
            child: const Text('Add Drug', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _handleApprove(BuildContext context) async {
    final ok = await controller.approveConsultation(
      advice: _adviceController.text.trim(),
      nextVisitQty: _nextVisitQty,
      nextVisitTime: _nextVisitTime,
    );
    if (ok) {
      Get.back(); // close review
      Get.back(); // close live session
    }
  }
}
