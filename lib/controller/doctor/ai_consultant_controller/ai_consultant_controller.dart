import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/ai_consultant/ai_consultant_models.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/services/ai_consultant/ai_consultant_service.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';

// ─────────────────────────────────────────────────────────────
//  AI Consultant Controller (GetX)
//  Manages consultation lifecycle:
//  start → live record & stream → review & edits → approve
// ─────────────────────────────────────────────────────────────

enum ConsultationPhase {
  idle,
  starting,
  recording,
  paused,
  finalizing,
  reviewPending,
  approving,
  completed,
  error,
}

class AiConsultantController extends GetxController {
  // ── Observable state ─────────────────────────────────────
  final phase = ConsultationPhase.idle.obs;
  final consultationId = ''.obs;
  final specialty = 'GENERAL_PHYSICIAN'.obs;
  final patientName = ''.obs;
  final patientProfile = Rxn<AiPatientProfile>();
  final transcriptSegments = <TranscriptSegment>[].obs;
  final latestLine = Rxn<TranscriptSegment>();
  final memory = Rxn<MemoryResponse>();
  final reviewData = Rxn<ReviewResponse>();
  final processResult = Rxn<ProcessFullResponse>();
  final clinicalAlerts = <ClinicalAlert>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final recordingSeconds = 0.obs;
  final isMaxDurationReached = false.obs;
  final activeTab = 0.obs; // 0 = Transcript, 1 = Clinical Memory / Copilot
  final autoScrollTranscript = true.obs;

  // Editable prescription draft list for the doctor review screen
  final editablePrescriptions = <SuggestedMedication>[].obs;

  // ── Internal ──────────────────────────────────────────────
  final AudioRecorder _recorder = AudioRecorder();
  Timer? _chunkTimer;
  Timer? _memoryPollTimer;
  Timer? _recordingTimer;
  int _chunkIndex = 0;
  double _clientStartTime = 0;
  String? _fullRecordingPath;

  // ── Session Context ───────────────────────────────────────
  int patientId = 0;
  int doctorId = 0;
  int? appointmentId;

  // Supported specialties from API contract
  static const List<String> availableSpecialties = [
    'GENERAL_PHYSICIAN',
    'CARDIOLOGY',
    'NEUROLOGY',
    'ORTHOPEDICS',
    'PEDIATRICS',
    'GYNECOLOGY',
    'DERMATOLOGY',
    'PSYCHIATRY',
    'OPHTHALMOLOGY',
    'ENT',
    'GASTROENTEROLOGY',
    'UROLOGY',
    'ONCOLOGY',
    'ENDOCRINOLOGY',
    'PULMONOLOGY',
    'NEPHROLOGY',
    'RHEUMATOLOGY',
    'DENTISTRY',
    'EMERGENCY_MEDICINE',
  ];

  /// Initialize context before launching session
  void initConsultationContext({
    required int pId,
    String pName = '',
    int? aId,
    String? preferredSpecialty,
  }) {
    patientId = pId;
    patientName.value = pName;
    appointmentId = aId;
    doctorId = int.tryParse(PreferenceUtils.getStringValue('id')) ?? 0;
    if (preferredSpecialty != null && preferredSpecialty.isNotEmpty) {
      specialty.value = preferredSpecialty;
    }
  }

  // ─────────────────────────────────────────────────────────
  //  1. START CONSULTATION
  // ─────────────────────────────────────────────────────────

  Future<bool> startConsultation() async {
    try {
      phase.value = ConsultationPhase.starting;
      isLoading(true);
      errorMessage('');

      // Reset state
      transcriptSegments.clear();
      latestLine.value = null;
      memory.value = null;
      reviewData.value = null;
      processResult.value = null;
      clinicalAlerts.clear();
      editablePrescriptions.clear();
      _chunkIndex = 0;
      _clientStartTime = 0;
      recordingSeconds.value = 0;
      isMaxDurationReached.value = false;

      if (doctorId == 0) {
        doctorId = int.tryParse(PreferenceUtils.getStringValue('id')) ?? 0;
      }

      final response = await AiConsultantService.startSession(
        patientId: patientId,
        doctorId: doctorId,
        specialty: specialty.value,
        appointmentId: appointmentId,
      );

      if (response.success) {
        consultationId.value = response.consultationId;
        specialty.value = response.specialty;
        patientProfile.value = response.patientProfile;
        if (response.patientProfile?.name.isNotEmpty == true) {
          patientName.value = response.patientProfile!.name;
        }
        await _startRecording();
        return true;
      } else {
        _setError('Failed to start consultation session.');
        return false;
      }
    } catch (e) {
      _setError('Error starting consultation: $e');
      return false;
    } finally {
      isLoading(false);
    }
  }

  // ─────────────────────────────────────────────────────────
  //  2. RECORDING & LIVE CHUNKS
  // ─────────────────────────────────────────────────────────

  Future<void> _startRecording() async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      _setError('Microphone permission is required for AI Transcriber.');
      return;
    }

    final dir = await getTemporaryDirectory();
    _fullRecordingPath = '${dir.path}/consult_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000, sampleRate: 44100),
      path: _fullRecordingPath!,
    );

    phase.value = ConsultationPhase.recording;

    // Timer: update elapsed seconds
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      recordingSeconds.value++;
    });

    // Timer: send chunks every 4 seconds
    _chunkTimer?.cancel();
    _chunkTimer = Timer.periodic(const Duration(seconds: 4), (_) => _sendCurrentChunk());

    // Timer: poll memory every 10 seconds
    _memoryPollTimer?.cancel();
    _memoryPollTimer = Timer.periodic(const Duration(seconds: 10), (_) => _pollMemory());
  }

  Future<void> _sendCurrentChunk() async {
    if (phase.value != ConsultationPhase.recording) return;
    if (consultationId.value.isEmpty || _fullRecordingPath == null) return;

    try {
      final masterFile = File(_fullRecordingPath!);
      if (!masterFile.existsSync() || masterFile.lengthSync() < 1500) return;

      // Create snapshot file of master recording to avoid lock contention
      final dir = await getTemporaryDirectory();
      final chunkSnapshotPath = '${dir.path}/chunk_snap_${_chunkIndex}.m4a';
      final chunkFile = await masterFile.copy(chunkSnapshotPath);

      final response = await AiConsultantService.sendAudioChunk(
        consultationId: consultationId.value,
        audioFile: chunkFile,
        mimeType: 'audio/mp4',
        chunkIndex: _chunkIndex,
        clientStartTime: _clientStartTime,
      );

      _chunkIndex++;
      _clientStartTime = response.audioDuration ?? _clientStartTime;

      if (response.maxDurationReached == true) {
        isMaxDurationReached.value = true;
        Get.snackbar(
          'Recording Limit',
          'Consultation reached maximum duration (30 mins). Please finalize.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        await pauseRecording();
        return;
      }

      if (!response.isSilent && response.newSegments.isNotEmpty) {
        for (final seg in response.newSegments) {
          if (!transcriptSegments.any((s) => s.id == seg.id)) {
            transcriptSegments.add(seg);
          }
        }
        latestLine.value = response.latestSegment ?? response.newSegments.last;
        if (response.summary != null) {
          _updateAlertsFromSummary(response.alerts);
        }
      }

      // Cleanup snapshot
      if (chunkFile.existsSync()) {
        await chunkFile.delete().catchError((_) => chunkFile);
      }
    } catch (e) {
      debugPrint('[AiConsultant] Chunk error: $e');
    }
  }

  Future<void> _pollMemory() async {
    if (consultationId.value.isEmpty) return;
    try {
      final m = await AiConsultantService.getMemory(consultationId.value);
      memory.value = m;
      clinicalAlerts.assignAll(m.alerts.where((a) => !a.isResolved).toList());
    } catch (e) {
      debugPrint('[AiConsultant] Memory poll error: $e');
    }
  }

  void _updateAlertsFromSummary(List<Map<String, dynamic>> rawAlerts) {
    final newAlerts = rawAlerts.map((a) => ClinicalAlert.fromJson(a)).toList();
    for (final alert in newAlerts) {
      if (!clinicalAlerts.any((existing) => existing.id == alert.id)) {
        clinicalAlerts.add(alert);
      }
    }
  }

  // ─────────────────────────────────────────────────────────
  //  3. PAUSE / RESUME / DIALOGUE / SWAP
  // ─────────────────────────────────────────────────────────

  Future<void> pauseRecording() async {
    if (phase.value != ConsultationPhase.recording) return;
    try {
      _chunkTimer?.cancel();
      _recordingTimer?.cancel();
      await _recorder.pause();
      await AiConsultantService.pauseSession(consultationId.value);
      phase.value = ConsultationPhase.paused;
    } catch (e) {
      debugPrint('[AiConsultant] Pause error: $e');
    }
  }

  Future<void> resumeRecording() async {
    if (phase.value != ConsultationPhase.paused) return;
    try {
      await _recorder.resume();
      await AiConsultantService.resumeSession(consultationId.value);
      phase.value = ConsultationPhase.recording;
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) => recordingSeconds.value++);
      _chunkTimer = Timer.periodic(const Duration(seconds: 4), (_) => _sendCurrentChunk());
    } catch (e) {
      debugPrint('[AiConsultant] Resume error: $e');
    }
  }

  Future<void> swapSpeakers() async {
    try {
      await AiConsultantService.swapSpeakers(consultationId.value);
      final updated = await AiConsultantService.getTranscript(consultationId.value);
      transcriptSegments.assignAll(updated);
      Get.snackbar('Speakers Swapped', 'DOCTOR ↔ PATIENT speaker tags reversed.',
          backgroundColor: const Color(0xFF0FA66A), colorText: Colors.white, duration: const Duration(seconds: 2));
    } catch (e) {
      debugPrint('[AiConsultant] Swap speakers error: $e');
    }
  }

  Future<void> injectDialogue(String text, {String speaker = 'DOCTOR'}) async {
    if (text.trim().isEmpty || consultationId.value.isEmpty) return;
    try {
      final res = await AiConsultantService.injectDialogue(
        consultationId: consultationId.value,
        text: text.trim(),
        speaker: speaker,
      );
      if (res.newSegments.isNotEmpty) {
        transcriptSegments.addAll(res.newSegments);
        latestLine.value = res.latestSegment ?? res.newSegments.last;
      }
    } catch (e) {
      debugPrint('[AiConsultant] Inject dialogue error: $e');
    }
  }

  Future<void> editSegment(String segmentId, String newText, {String? speaker}) async {
    if (consultationId.value.isEmpty) return;
    try {
      final updated = await AiConsultantService.editSegment(
        consultationId: consultationId.value,
        segmentId: segmentId,
        text: newText,
        speaker: speaker,
      );
      final idx = transcriptSegments.indexWhere((s) => s.id == segmentId);
      if (idx != -1) {
        transcriptSegments[idx] = updated;
      }
    } catch (e) {
      debugPrint('[AiConsultant] Edit segment error: $e');
    }
  }

  Future<void> resolveAlert(String alertId, {String? note}) async {
    try {
      await AiConsultantService.resolveAlert(
        consultationId: consultationId.value,
        alertId: alertId,
        resolutionNote: note,
      );
      clinicalAlerts.removeWhere((a) => a.id == alertId);
    } catch (e) {
      debugPrint('[AiConsultant] Resolve alert error: $e');
    }
  }

  // ─────────────────────────────────────────────────────────
  //  4. FINALIZE (Stop & Synthesize SOAP)
  // ─────────────────────────────────────────────────────────

  Future<bool> finalizeConsultation() async {
    try {
      _cancelTimers();
      phase.value = ConsultationPhase.finalizing;
      isLoading(true);

      final path = await _recorder.stop();

      if (path != null && File(path).existsSync() && File(path).lengthSync() > 1500) {
        final audioFile = File(path);
        final result = await AiConsultantService.processFullAudio(
          consultationId: consultationId.value,
          audioFile: audioFile,
          mimeType: 'audio/mp4',
          durationSeconds: recordingSeconds.value,
        );
        processResult.value = result;
        if (result.transcript.isNotEmpty) {
          transcriptSegments.assignAll(result.transcript);
        }
      } else {
        // Fallback: trigger synthesis from chunks already transcribed
        final result = await AiConsultantService.generateReview(consultationId.value);
        processResult.value = result;
      }

      await refreshReview();
      phase.value = ConsultationPhase.reviewPending;
      return true;
    } catch (e) {
      _setError('Error synthesizing consultation: $e');
      return false;
    } finally {
      isLoading(false);
    }
  }

  // ─────────────────────────────────────────────────────────
  //  5. REVIEW & PRESCRIPTION DRAFT
  // ─────────────────────────────────────────────────────────

  Future<void> refreshReview() async {
    try {
      final r = await AiConsultantService.getReview(consultationId.value);
      reviewData.value = r;
      editablePrescriptions.assignAll(r.prescriptions);
    } catch (e) {
      debugPrint('[AiConsultant] Review fetch error: $e');
    }
  }

  Future<void> savePrescriptions(List<SuggestedMedication> list) async {
    try {
      isLoading(true);
      final r = await AiConsultantService.updatePrescription(
        consultationId: consultationId.value,
        prescriptions: list,
      );
      reviewData.value = r;
      editablePrescriptions.assignAll(r.prescriptions);

      if (r.safetyWarnings.isNotEmpty) {
        Get.snackbar(
          '⚠️ Clinical Warning',
          r.safetyWarnings.map((w) => w.message).join('\n'),
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          duration: const Duration(seconds: 6),
        );
      }
    } catch (e) {
      _setError('Error saving prescriptions: $e');
    } finally {
      isLoading(false);
    }
  }

  void addPrescriptionItem(SuggestedMedication med) {
    editablePrescriptions.add(med);
    savePrescriptions(editablePrescriptions.toList());
  }

  void removePrescriptionItem(int index) {
    if (index >= 0 && index < editablePrescriptions.length) {
      editablePrescriptions.removeAt(index);
      savePrescriptions(editablePrescriptions.toList());
    }
  }

  void updatePrescriptionItem(int index, SuggestedMedication updated) {
    if (index >= 0 && index < editablePrescriptions.length) {
      editablePrescriptions[index] = updated;
      savePrescriptions(editablePrescriptions.toList());
    }
  }

  Future<bool> approveConsultation({
    String? advice,
    String? nextVisitQty,
    String? nextVisitTime,
  }) async {
    try {
      phase.value = ConsultationPhase.approving;
      isLoading(true);

      final result = await AiConsultantService.approveConsultation(
        consultationId: consultationId.value,
        advice: advice,
        nextVisitQty: nextVisitQty,
        nextVisitTime: nextVisitTime,
      );

      if (result['success'] == true) {
        phase.value = ConsultationPhase.completed;
        Get.snackbar(
          'Consultation Approved ✓',
          'Clinical notes saved and consultation marked COMPLETED.',
          backgroundColor: const Color(0xFF0FA66A),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        return true;
      }
      return false;
    } catch (e) {
      _setError('Error approving consultation: $e');
      return false;
    } finally {
      isLoading(false);
    }
  }

  // ─────────────────────────────────────────────────────────
  //  Helpers
  // ─────────────────────────────────────────────────────────

  void _setError(String msg) {
    phase.value = ConsultationPhase.error;
    errorMessage.value = msg;
    Get.snackbar(
      'AI Transcriber',
      msg,
      backgroundColor: Colors.red.shade700,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
  }

  void _cancelTimers() {
    _chunkTimer?.cancel();
    _memoryPollTimer?.cancel();
    _recordingTimer?.cancel();
  }

  String get formattedDuration {
    final m = recordingSeconds.value ~/ 60;
    final s = recordingSeconds.value % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  bool get isRecording => phase.value == ConsultationPhase.recording;
  bool get isPaused => phase.value == ConsultationPhase.paused;
  bool get isInReview => phase.value == ConsultationPhase.reviewPending;

  @override
  void onClose() {
    _cancelTimers();
    _recorder.dispose();
    super.onClose();
  }
}
