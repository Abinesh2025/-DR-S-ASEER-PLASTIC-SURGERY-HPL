import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/ai_consultant/ai_consultant_models.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';

// ─────────────────────────────────────────────────────────────
//  AI Consultant Service
//  All API calls to Aura AI backend (port 3000)
//  Base URL is configured in ConfigUtils.aiBaseUrl
// ─────────────────────────────────────────────────────────────

class AiConsultantService {
  static String get _aiBaseUrl => ConfigUtils.aiBaseUrl;
  static const String _apiPrefix = '/api/consultant';

  static Dio get _dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: _aiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
        headers: {'Accept': 'application/json'},
      ),
    )
      ..httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.badCertificateCallback = (_, __, ___) => true; // dev only
          return client;
        },
      )
      ..interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ));
    return dio;
  }

  /// JWT token stored by HMS login — reused for AI server auth
  static String get _bearerToken {
    final token = PreferenceUtils.getStringValue('token').trim();
    if (token.isEmpty) return '';
    return token.startsWith('Bearer ') ? token : 'Bearer $token';
  }

  // ── 1. Session Management ─────────────────────────────────

  /// Start a new AI consultation session
  static Future<StartSessionResponse> startSession({
    required int patientId,
    required int doctorId,
    String specialty = 'GENERAL_PHYSICIAN',
    int? appointmentId,
  }) async {
    final body = {
      'patientId': patientId,
      'doctorId': doctorId,
      'specialty': specialty,
      if (appointmentId != null) 'appointmentId': appointmentId,
    };
    final resp = await _dio.post(
      '$_apiPrefix/sessions/start',
      data: body,
      options: Options(headers: {'Authorization': _bearerToken}),
    );
    return StartSessionResponse.fromJson(resp.data);
  }

  /// Pause a live recording session
  static Future<Map<String, dynamic>> pauseSession(String consultationId) async {
    final resp = await _dio.post('$_apiPrefix/sessions/$consultationId/pause');
    return Map<String, dynamic>.from(resp.data);
  }

  /// Resume a paused session
  static Future<Map<String, dynamic>> resumeSession(String consultationId) async {
    final resp = await _dio.post('$_apiPrefix/sessions/$consultationId/resume');
    return Map<String, dynamic>.from(resp.data);
  }

  /// Poll session status
  static Future<SessionStatusResponse> getSessionStatus(String consultationId) async {
    final resp = await _dio.get('$_apiPrefix/sessions/$consultationId/status');
    return SessionStatusResponse.fromJson(resp.data);
  }

  // ── 2. Audio Streaming ────────────────────────────────────

  /// Send a live audio chunk (multipart). Call every 3-5 seconds.
  static Future<AudioChunkResponse> sendAudioChunk({
    required String consultationId,
    required File audioFile,
    required String mimeType,
    required int chunkIndex,
    double? clientStartTime,
    String? speakerHint,
    bool? forceSnapshot,
  }) async {
    final formData = FormData.fromMap({
      'audio': await MultipartFile.fromFile(audioFile.path, filename: 'chunk_$chunkIndex.webm'),
      'mimeType': mimeType,
      'chunkIndex': chunkIndex,
      if (clientStartTime != null) 'clientStartTime': clientStartTime,
      if (speakerHint != null) 'speakerHint': speakerHint,
      if (forceSnapshot != null) 'forceSnapshot': forceSnapshot,
    });
    final resp = await _dio.post(
      '$_apiPrefix/audio/$consultationId/chunk',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    return AudioChunkResponse.fromJson(resp.data);
  }

  /// Finalize: transcribe full recording + generate SOAP note
  static Future<ProcessFullResponse> processFullAudio({
    required String consultationId,
    required File audioFile,
    required String mimeType,
    int? durationSeconds,
  }) async {
    final formData = FormData.fromMap({
      'audio': await MultipartFile.fromFile(audioFile.path, filename: 'full_recording.wav'),
      'mimeType': mimeType,
      if (durationSeconds != null) 'durationSeconds': durationSeconds,
    });
    final resp = await _dio.post(
      '$_apiPrefix/audio/$consultationId/process-full',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        receiveTimeout: const Duration(minutes: 5), // synthesis can take time
      ),
    );
    return ProcessFullResponse.fromJson(resp.data);
  }

  /// Manually inject a dialogue line (text-mode fallback)
  static Future<AudioChunkResponse> injectDialogue({
    required String consultationId,
    required String text,
    String speaker = 'DOCTOR',
  }) async {
    final resp = await _dio.post(
      '$_apiPrefix/audio/$consultationId/dialogue',
      data: {'text': text, 'speaker': speaker},
    );
    return AudioChunkResponse.fromJson(resp.data);
  }

  // ── 3. Transcript ─────────────────────────────────────────

  /// Fetch full transcript
  static Future<List<TranscriptSegment>> getTranscript(String consultationId) async {
    final resp = await _dio.get('$_apiPrefix/transcript/$consultationId');
    final data = resp.data as Map<String, dynamic>;
    return (data['segments'] as List? ?? [])
        .map((s) => TranscriptSegment.fromJson(s))
        .toList();
  }

  /// Swap all DOCTOR ↔ PATIENT labels
  static Future<Map<String, dynamic>> swapSpeakers(String consultationId) async {
    final resp = await _dio.post('$_apiPrefix/transcript/$consultationId/swap-speakers');
    return Map<String, dynamic>.from(resp.data);
  }

  /// Edit a single transcript segment
  static Future<TranscriptSegment> editSegment({
    required String consultationId,
    required String segmentId,
    String? text,
    String? speaker,
  }) async {
    final resp = await _dio.patch(
      '$_apiPrefix/transcript/$consultationId/segments/$segmentId',
      data: {
        if (text != null) 'text': text,
        if (speaker != null) 'speaker': speaker,
      },
    );
    return TranscriptSegment.fromJson(resp.data['updatedSegment']);
  }

  // ── 4. Memory (Live Clinical State) ──────────────────────

  /// Get live clinical state — poll every ~10 seconds
  static Future<MemoryResponse> getMemory(String consultationId) async {
    final resp = await _dio.get('$_apiPrefix/memory/$consultationId');
    return MemoryResponse.fromJson(resp.data);
  }

  /// Resolve a clinical alert
  static Future<void> resolveAlert({
    required String consultationId,
    required String alertId,
    String? resolutionNote,
  }) async {
    await _dio.post(
      '$_apiPrefix/memory/$consultationId/alerts/$alertId/resolve',
      data: {if (resolutionNote != null) 'resolutionNote': resolutionNote},
    );
  }

  // ── 5. Review & Sign-off ──────────────────────────────────

  /// Trigger AI synthesis from existing transcript
  static Future<ProcessFullResponse> generateReview(String consultationId) async {
    final resp = await _dio.post(
      '$_apiPrefix/review/$consultationId/generate',
      options: Options(receiveTimeout: const Duration(minutes: 5)),
    );
    return ProcessFullResponse.fromJson(resp.data);
  }

  /// Fetch current review state
  static Future<ReviewResponse> getReview(String consultationId) async {
    final resp = await _dio.get('$_apiPrefix/review/$consultationId');
    return ReviewResponse.fromJson(resp.data);
  }

  /// Doctor edits prescription draft
  static Future<ReviewResponse> updatePrescription({
    required String consultationId,
    required List<SuggestedMedication> prescriptions,
  }) async {
    final resp = await _dio.put(
      '$_apiPrefix/review/$consultationId/prescription',
      data: {'prescriptions': prescriptions.map((p) => p.toJson()).toList()},
    );
    return ReviewResponse.fromJson(resp.data);
  }

  /// Doctor approves and marks consultation COMPLETED
  static Future<Map<String, dynamic>> approveConsultation({
    required String consultationId,
    String? advice,
    String? nextVisitQty,
    String? nextVisitTime,
  }) async {
    final resp = await _dio.post(
      '$_apiPrefix/review/$consultationId/approve',
      data: {
        if (advice != null) 'advice': advice,
        if (nextVisitQty != null) 'nextVisitQty': nextVisitQty,
        if (nextVisitTime != null) 'nextVisitTime': nextVisitTime,
      },
    );
    return Map<String, dynamic>.from(resp.data);
  }
}
