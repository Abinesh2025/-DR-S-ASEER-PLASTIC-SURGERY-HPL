import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/ai_consultant_controller/ai_consultant_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_theme.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_review_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/widgets/waveform_visualizer.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/widgets/transcript_bubble_widget.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/widgets/clinical_memory_sheet.dart';

class AiLiveConsultationScreen extends StatefulWidget {
  const AiLiveConsultationScreen({super.key});

  @override
  State<AiLiveConsultationScreen> createState() => _AiLiveConsultationScreenState();
}

class _AiLiveConsultationScreenState extends State<AiLiveConsultationScreen> {
  final AiConsultantController controller = Get.find<AiConsultantController>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _dialogueController = TextEditingController();
  String _selectedSpeaker = 'DOCTOR';

  @override
  void initState() {
    super.initState();
    // Auto-scroll when new segments arrive
    ever(controller.transcriptSegments, (_) {
      if (controller.autoScrollTranscript.value && _scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 150), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _dialogueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: Obx(() {
        if (controller.phase.value == ConsultationPhase.finalizing) {
          return _buildFinalizingLoader();
        }

        return Column(
          children: [
            // ── Top Status Strip & Patient Info ──
            _buildPatientHeader(),

            // ── Audio Waveform Visualizer ──
            _buildAudioVisualizerSection(),

            // ── Segmented Tab Switcher (Transcript vs Copilot) ──
            _buildTabSwitcher(),

            // ── Tab Body Content ──
            Expanded(
              child: controller.activeTab.value == 0
                  ? _buildTranscriptView()
                  : const ClinicalMemoryView(),
            ),

            // ── Bottom Action & Control Bar ──
            _buildBottomActionBar(context),
          ],
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF0F172A),
      titleSpacing: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AiTheme.primaryEmerald.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: AiTheme.primaryEmerald, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aura AI Transcriber',
                style: AiTheme.titleStyle(size: 16),
              ),
              Obx(() => Text(
                    controller.consultationId.value.isNotEmpty
                        ? 'ID: ${controller.consultationId.value.substring(0, 12)}...'
                        : 'Starting Session...',
                    style: AiTheme.labelStyle(size: 11),
                  )),
            ],
          ),
        ],
      ),
      actions: [
        // Swap speakers button in App Bar
        IconButton(
          tooltip: 'Swap Doctor ↔ Patient labels',
          onPressed: controller.swapSpeakers,
          icon: const Icon(Icons.swap_horiz_rounded, color: Color(0xFF475569)),
        ),
        // Close / Discard button
        IconButton(
          tooltip: 'Exit Consultation',
          onPressed: () => _confirmExit(context),
          icon: const Icon(Icons.close_rounded, color: Color(0xFF475569)),
        ),
      ],
    );
  }

  Widget _buildPatientHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Patient info
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFF1F5F9),
                child: const Icon(Icons.person_outline_rounded, color: Color(0xFF475569), size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.patientName.value.isNotEmpty
                        ? controller.patientName.value
                        : 'Patient #${controller.patientId}',
                    style: AiTheme.headingStyle(size: 14),
                  ),
                  Text(
                    controller.specialty.value.replaceAll('_', ' '),
                    style: AiTheme.labelStyle(color: AiTheme.primaryEmerald, size: 11),
                  ),
                ],
              ),
            ],
          ),

          // Live Timer & Status Pill
          Obx(() {
            final isPaused = controller.isPaused;
            final statusColor = isPaused ? Colors.amber.shade700 : AiTheme.primaryEmerald;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isPaused ? 'PAUSED' : controller.formattedDuration,
                    style: AiTheme.monoStyle(color: statusColor, size: 13),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAudioVisualizerSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 8),
      child: Obx(() => WaveformVisualizer(
            isRecording: controller.isRecording,
            isPaused: controller.isPaused,
          )),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildTabButton(
                index: 0,
                title: 'Live Transcript',
                icon: Icons.subtitles_outlined,
                badgeCount: controller.transcriptSegments.length,
              ),
            ),
            Expanded(
              child: _buildTabButton(
                index: 1,
                title: 'Clinical Copilot',
                icon: Icons.psychology_outlined,
                badgeCount: controller.clinicalAlerts.length,
                isAlertBadge: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required int index,
    required String title,
    required IconData icon,
    int? badgeCount,
    bool isAlertBadge = false,
  }) {
    final isSelected = controller.activeTab.value == index;

    return GestureDetector(
      onTap: () => controller.activeTab.value = index,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? AiTheme.primaryEmerald : const Color(0xFF64748B),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: AiTheme.headingStyle(
                size: 12.5,
                color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
              ),
            ),
            if (badgeCount != null && badgeCount > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isAlertBadge ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$badgeCount',
                  style: AiTheme.labelStyle(
                    color: isAlertBadge ? Colors.white : const Color(0xFF334155),
                    size: 10,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTranscriptView() {
    return Column(
      children: [
        // Transcript Bubbles
        Expanded(
          child: controller.transcriptSegments.isEmpty
              ? _buildEmptyTranscriptState()
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  itemCount: controller.transcriptSegments.length,
                  itemBuilder: (context, index) {
                    final segment = controller.transcriptSegments[index];
                    return TranscriptBubbleWidget(
                      segment: segment,
                      onEdit: () => _showEditSegmentSheet(context, segment),
                    );
                  },
                ),
        ),

        // Manual Text Injection Fallback Bar
        _buildDialogueInputBar(),
      ],
    );
  }

  Widget _buildEmptyTranscriptState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AiTheme.primaryEmerald.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mic_none_rounded,
                color: AiTheme.primaryEmerald,
                size: 40,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Listening to consultation...',
              style: AiTheme.headingStyle(size: 16),
            ),
            const SizedBox(height: 6),
            Text(
              'Live transcription will appear here every 3-4 seconds as doctor and patient converse.',
              textAlign: TextAlign.center,
              style: AiTheme.bodyStyle(color: const Color(0xFF64748B), size: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogueInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          // Speaker Toggle (Doctor / Patient)
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedSpeaker = _selectedSpeaker == 'DOCTOR' ? 'PATIENT' : 'DOCTOR';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: _selectedSpeaker == 'DOCTOR' ? AiTheme.doctorBubble : AiTheme.patientBubble,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _selectedSpeaker == 'DOCTOR'
                      ? AiTheme.primaryEmerald.withOpacity(0.4)
                      : const Color(0xFFCBD5E1),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _selectedSpeaker == 'DOCTOR' ? Icons.medical_services_outlined : Icons.person_outline,
                    size: 14,
                    color: _selectedSpeaker == 'DOCTOR' ? AiTheme.doctorAccent : AiTheme.patientAccent,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _selectedSpeaker == 'DOCTOR' ? 'Dr.' : 'Pt.',
                    style: AiTheme.headingStyle(
                      size: 11,
                      color: _selectedSpeaker == 'DOCTOR' ? AiTheme.doctorAccent : AiTheme.patientAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Text Field
          Expanded(
            child: TextField(
              controller: _dialogueController,
              decoration: InputDecoration(
                hintText: 'Add dialogue or vitals manually...',
                hintStyle: AiTheme.labelStyle(size: 12.5),
                isDense: true,
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              onSubmitted: (_) => _submitDialogue(),
            ),
          ),
          const SizedBox(width: 6),

          // Send Button
          IconButton(
            onPressed: _submitDialogue,
            icon: const Icon(Icons.send_rounded, color: AiTheme.primaryEmerald, size: 20),
          ),
        ],
      ),
    );
  }

  void _submitDialogue() {
    final text = _dialogueController.text.trim();
    if (text.isNotEmpty) {
      controller.injectDialogue(text, speaker: _selectedSpeaker);
      _dialogueController.clear();
    }
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Pause / Resume Button
          Expanded(
            flex: 2,
            child: OutlinedButton.icon(
              onPressed: () {
                if (controller.isPaused) {
                  controller.resumeRecording();
                } else {
                  controller.pauseRecording();
                }
              },
              icon: Icon(
                controller.isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                size: 20,
                color: controller.isPaused ? AiTheme.primaryEmerald : const Color(0xFF475569),
              ),
              label: Text(
                controller.isPaused ? 'Resume' : 'Pause',
                style: AiTheme.headingStyle(
                  size: 14,
                  color: controller.isPaused ? AiTheme.primaryEmerald : const Color(0xFF475569),
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Finish & Synthesize SOAP Button
          Expanded(
            flex: 3,
            child: Container(
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
                onPressed: () => _finalizeAndReview(context),
                icon: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                label: Text(
                  'Finish & Review',
                  style: AiTheme.headingStyle(color: Colors.white, size: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalizingLoader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AiTheme.primaryEmerald.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(
                color: AiTheme.primaryEmerald,
                strokeWidth: 3.5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Synthesizing Consultation Notes...',
              style: AiTheme.titleStyle(size: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Generating structured SOAP notes, extracting vitals, formulary drug matching, and checking safety warnings.',
              textAlign: TextAlign.center,
              style: AiTheme.bodyStyle(color: const Color(0xFF64748B), size: 13.5),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditSegmentSheet(BuildContext context, dynamic segment) {
    final textController = TextEditingController(text: segment.text);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit Spoken Line', style: AiTheme.titleStyle(size: 16)),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: textController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: 'Correct text...',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.editSegment(segment.id, textController.text.trim());
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AiTheme.primaryEmerald,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Save Correction', style: AiTheme.headingStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _finalizeAndReview(BuildContext context) async {
    final success = await controller.finalizeConsultation();
    if (success) {
      Get.to(() => const AiConsultationReviewScreen());
    }
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Exit Consultation?', style: AiTheme.titleStyle(size: 18)),
        content: Text(
          'Active recording will be stopped. Unreviewed notes may be lost.',
          style: AiTheme.bodyStyle(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Stay'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Exit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
