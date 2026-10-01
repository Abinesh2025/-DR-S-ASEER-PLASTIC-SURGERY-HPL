// ─────────────────────────────────────────────────────────────
//  AI Transcriber — Data Models
//  Maps 1-to-1 with the Aura AI API contract
// ─────────────────────────────────────────────────────────────

// ── Vitals (structured from memory) ──────────────────────────
class VitalsExtracted {
  final String? bp;
  final String? pulse;
  final String? spo2;
  final String? temperature;
  final String? weight;
  final String? height;
  final String? rr;

  VitalsExtracted({
    this.bp,
    this.pulse,
    this.spo2,
    this.temperature,
    this.weight,
    this.height,
    this.rr,
  });

  factory VitalsExtracted.fromJson(Map<String, dynamic> json) => VitalsExtracted(
        bp: json['bp']?.toString(),
        pulse: json['pulse']?.toString(),
        spo2: json['spo2']?.toString() ?? json['SpO2']?.toString(),
        temperature: json['temperature']?.toString() ?? json['temp']?.toString(),
        weight: json['weight']?.toString(),
        height: json['height']?.toString(),
        rr: json['rr']?.toString() ?? json['respiratoryRate']?.toString(),
      );
}

// ── Chief Complaint ────────────────────────────────────────────
class ChiefComplaint {
  final String complaint;
  final String? duration;
  final String? severity;

  ChiefComplaint({
    required this.complaint,
    this.duration,
    this.severity,
  });

  factory ChiefComplaint.fromJson(Map<String, dynamic> json) => ChiefComplaint(
        complaint: json['complaint'] ?? json['name'] ?? '',
        duration: json['duration'],
        severity: json['severity'],
      );
}

// ── Symptom Item ───────────────────────────────────────────────
class SymptomItem {
  final String name;
  final bool isNegativeFinding;
  final String? context;

  SymptomItem({
    required this.name,
    this.isNegativeFinding = false,
    this.context,
  });

  factory SymptomItem.fromJson(Map<String, dynamic> json) => SymptomItem(
        name: json['name'] ?? json['symptom'] ?? '',
        isNegativeFinding: json['isNegative'] ?? json['isNegativeFinding'] ?? false,
        context: json['context'],
      );
}

// ── Patient Profile ───────────────────────────────────────────
class AiPatientProfile {
  final int patientId;
  final String name;
  final String? dob;
  final String? gender;
  final List<String> knownAllergies;
  final List<String> chronicConditions;
  final List<String> activeMedications;

  AiPatientProfile({
    required this.patientId,
    required this.name,
    this.dob,
    this.gender,
    this.knownAllergies = const [],
    this.chronicConditions = const [],
    this.activeMedications = const [],
  });

  factory AiPatientProfile.fromJson(Map<String, dynamic> json) => AiPatientProfile(
        patientId: json['patientId'] ?? 0,
        name: json['name'] ?? '',
        dob: json['dob'],
        gender: json['gender'],
        knownAllergies: List<String>.from(json['knownAllergies'] ?? []),
        chronicConditions: List<String>.from(json['chronicConditions'] ?? []),
        activeMedications: List<String>.from(json['activeMedications'] ?? []),
      );
}

// ── Session Responses ─────────────────────────────────────────
class StartSessionResponse {
  final bool success;
  final String consultationId;
  final String status;
  final String specialty;
  final AiPatientProfile? patientProfile;

  StartSessionResponse({
    required this.success,
    required this.consultationId,
    required this.status,
    required this.specialty,
    this.patientProfile,
  });

  factory StartSessionResponse.fromJson(Map<String, dynamic> json) => StartSessionResponse(
        success: json['success'] ?? false,
        consultationId: json['consultationId'] ?? '',
        status: json['status'] ?? '',
        specialty: json['specialty'] ?? '',
        patientProfile: json['patientProfile'] != null
            ? AiPatientProfile.fromJson(json['patientProfile'])
            : null,
      );
}

class SessionStatusResponse {
  final bool success;
  final String status;
  final String? specialty;
  final AiPatientProfile? patientProfile;
  final int? updatedAt;

  SessionStatusResponse({
    required this.success,
    required this.status,
    this.specialty,
    this.patientProfile,
    this.updatedAt,
  });

  factory SessionStatusResponse.fromJson(Map<String, dynamic> json) => SessionStatusResponse(
        success: json['success'] ?? false,
        status: json['status'] ?? '',
        specialty: json['specialty'],
        patientProfile: json['patientProfile'] != null
            ? AiPatientProfile.fromJson(json['patientProfile'])
            : null,
        updatedAt: json['updatedAt'],
      );
}

// ── Transcript Segment ────────────────────────────────────────
class TranscriptSegment {
  final String id;
  final String speaker;
  final String text;
  final double startTime;
  final double endTime;
  final double confidence;
  final bool? isUncertain;

  TranscriptSegment({
    required this.id,
    required this.speaker,
    required this.text,
    required this.startTime,
    required this.endTime,
    required this.confidence,
    this.isUncertain,
  });

  factory TranscriptSegment.fromJson(Map<String, dynamic> json) => TranscriptSegment(
        id: json['id'] ?? '',
        speaker: json['speaker'] ?? 'UNKNOWN',
        text: json['text'] ?? '',
        startTime: (json['startTime'] ?? 0).toDouble(),
        endTime: (json['endTime'] ?? 0).toDouble(),
        confidence: (json['confidence'] ?? 0).toDouble(),
        isUncertain: json['isUncertain'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'speaker': speaker,
        'text': text,
        'startTime': startTime,
        'endTime': endTime,
        'confidence': confidence,
        'isUncertain': isUncertain,
      };
}

// ── Audio Chunk Response ──────────────────────────────────────
class ChunkSummary {
  final List<Map<String, dynamic>> complaints;
  final List<Map<String, dynamic>> symptoms;
  final Map<String, dynamic> vitals;

  ChunkSummary({
    this.complaints = const [],
    this.symptoms = const [],
    this.vitals = const {},
  });

  factory ChunkSummary.fromJson(Map<String, dynamic> json) => ChunkSummary(
        complaints: List<Map<String, dynamic>>.from(json['complaints'] ?? []),
        symptoms: List<Map<String, dynamic>>.from(json['symptoms'] ?? []),
        vitals: Map<String, dynamic>.from(json['vitals'] ?? {}),
      );
}

class AudioChunkResponse {
  final bool success;
  final List<TranscriptSegment> newSegments;
  final TranscriptSegment? latestSegment;
  final double? audioDuration;
  final bool isSilent;
  final bool? maxDurationReached;
  final String? message;
  final List<Map<String, dynamic>> alerts;
  final ChunkSummary? summary;

  AudioChunkResponse({
    required this.success,
    this.newSegments = const [],
    this.latestSegment,
    this.audioDuration,
    this.isSilent = false,
    this.maxDurationReached,
    this.message,
    this.alerts = const [],
    this.summary,
  });

  factory AudioChunkResponse.fromJson(Map<String, dynamic> json) => AudioChunkResponse(
        success: json['success'] ?? false,
        newSegments: (json['newSegments'] as List? ?? [])
            .map((s) => TranscriptSegment.fromJson(s))
            .toList(),
        latestSegment: json['latest_segment'] != null
            ? TranscriptSegment.fromJson(json['latest_segment'])
            : null,
        audioDuration: json['audioDuration']?.toDouble(),
        isSilent: json['isSilent'] ?? false,
        maxDurationReached: json['maxDurationReached'],
        message: json['message'],
        alerts: List<Map<String, dynamic>>.from(json['alerts'] ?? []),
        summary: json['summary'] != null ? ChunkSummary.fromJson(json['summary']) : null,
      );
}

// ── SOAP Note ─────────────────────────────────────────────────
class SoapNote {
  final String subjective;
  final String objective;
  final String assessment;
  final String plan;

  SoapNote({
    required this.subjective,
    required this.objective,
    required this.assessment,
    required this.plan,
  });

  factory SoapNote.fromJson(Map<String, dynamic> json) => SoapNote(
        subjective: json['subjective'] ?? '',
        objective: json['objective'] ?? '',
        assessment: json['assessment'] ?? '',
        plan: json['plan'] ?? '',
      );
}

// ── Suggested Medication ──────────────────────────────────────
class SuggestedMedication {
  int? medicineId;
  String medicineName;
  String? saltComposition;
  String? dosage;
  String? duration;
  String? frequency;
  String? foodTiming;
  String? instruction;
  bool isFormularyMatched;
  bool requiresDoctorConfirmation;

  SuggestedMedication({
    this.medicineId,
    required this.medicineName,
    this.saltComposition,
    this.dosage,
    this.duration,
    this.frequency,
    this.foodTiming,
    this.instruction,
    this.isFormularyMatched = false,
    this.requiresDoctorConfirmation = false,
  });

  factory SuggestedMedication.fromJson(Map<String, dynamic> json) => SuggestedMedication(
        medicineId: json['medicineId'],
        medicineName: json['medicineName'] ?? '',
        saltComposition: json['saltComposition'],
        dosage: json['dosage'],
        duration: json['duration'],
        frequency: json['frequency'],
        foodTiming: json['foodTiming'],
        instruction: json['instruction'],
        isFormularyMatched: json['isFormularyMatched'] ?? false,
        requiresDoctorConfirmation: json['requiresDoctorConfirmation'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'medicineId': medicineId,
        'medicineName': medicineName,
        'saltComposition': saltComposition,
        'dosage': dosage,
        'duration': duration,
        'frequency': frequency,
        'foodTiming': foodTiming,
        'instruction': instruction,
        'isFormularyMatched': isFormularyMatched,
        'requiresDoctorConfirmation': requiresDoctorConfirmation,
      };
}

// ── Safety Warning ────────────────────────────────────────────
class SafetyWarning {
  final String type;
  final String severity;
  final String message;
  final String? medicine;

  SafetyWarning({
    required this.type,
    required this.severity,
    required this.message,
    this.medicine,
  });

  factory SafetyWarning.fromJson(Map<String, dynamic> json) => SafetyWarning(
        type: json['type'] ?? '',
        severity: json['severity'] ?? 'LOW',
        message: json['message'] ?? '',
        medicine: json['medicine'],
      );
}

// ── Process Full / Review ─────────────────────────────────────
class ProcessFullResponse {
  final bool success;
  final String consultationId;
  final String status;
  final double? audioDuration;
  final List<TranscriptSegment> transcript;
  final SoapNote? soapNote;
  final List<SuggestedMedication> prescriptions;
  final List<Map<String, dynamic>> diagnoses;
  final List<Map<String, dynamic>> chiefComplaints;
  final List<Map<String, dynamic>> symptoms;
  final Map<String, dynamic> vitals;
  final List<SafetyWarning> safetyWarnings;
  final List<String> summaryPoints;

  ProcessFullResponse({
    required this.success,
    required this.consultationId,
    required this.status,
    this.audioDuration,
    this.transcript = const [],
    this.soapNote,
    this.prescriptions = const [],
    this.diagnoses = const [],
    this.chiefComplaints = const [],
    this.symptoms = const [],
    this.vitals = const {},
    this.safetyWarnings = const [],
    this.summaryPoints = const [],
  });

  factory ProcessFullResponse.fromJson(Map<String, dynamic> json) => ProcessFullResponse(
        success: json['success'] ?? false,
        consultationId: json['consultationId'] ?? '',
        status: json['status'] ?? '',
        audioDuration: json['audioDuration']?.toDouble(),
        transcript: (json['transcript'] as List? ?? [])
            .map((s) => TranscriptSegment.fromJson(s))
            .toList(),
        soapNote: json['soapNote'] != null ? SoapNote.fromJson(json['soapNote']) : null,
        prescriptions: (json['prescriptions'] as List? ?? [])
            .map((p) => SuggestedMedication.fromJson(p))
            .toList(),
        diagnoses: List<Map<String, dynamic>>.from(json['diagnoses'] ?? []),
        chiefComplaints: List<Map<String, dynamic>>.from(json['chiefComplaints'] ?? []),
        symptoms: List<Map<String, dynamic>>.from(json['symptoms'] ?? []),
        vitals: Map<String, dynamic>.from(json['vitals'] ?? {}),
        safetyWarnings: (json['safetyWarnings'] as List? ?? [])
            .map((w) => SafetyWarning.fromJson(w))
            .toList(),
        summaryPoints: List<String>.from(json['summaryPoints'] ?? []),
      );
}

class ReviewResponse {
  final bool success;
  final String consultationId;
  final String status;
  final SoapNote? soapNote;
  final List<SuggestedMedication> prescriptions;
  final List<SafetyWarning> safetyWarnings;
  final List<Map<String, dynamic>> formularyStatus;

  ReviewResponse({
    required this.success,
    required this.consultationId,
    required this.status,
    this.soapNote,
    this.prescriptions = const [],
    this.safetyWarnings = const [],
    this.formularyStatus = const [],
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        success: json['success'] ?? false,
        consultationId: json['consultationId'] ?? '',
        status: json['status'] ?? '',
        soapNote: json['soapNote'] != null ? SoapNote.fromJson(json['soapNote']) : null,
        prescriptions: (json['prescriptions'] as List? ?? [])
            .map((p) => SuggestedMedication.fromJson(p))
            .toList(),
        safetyWarnings: (json['safetyWarnings'] as List? ?? [])
            .map((w) => SafetyWarning.fromJson(w))
            .toList(),
        formularyStatus: List<Map<String, dynamic>>.from(json['formularyStatus'] ?? []),
      );
}

// ── Clinical Alert ────────────────────────────────────────────
class ClinicalAlert {
  final String id;
  final String type;
  final String severity;
  final String message;
  bool isResolved;

  ClinicalAlert({
    required this.id,
    required this.type,
    required this.severity,
    required this.message,
    this.isResolved = false,
  });

  factory ClinicalAlert.fromJson(Map<String, dynamic> json) => ClinicalAlert(
        id: json['id'] ?? '',
        type: json['type'] ?? '',
        severity: json['severity'] ?? 'LOW',
        message: json['message'] ?? '',
      );
}

// ── Memory Response ───────────────────────────────────────────
class MemoryResponse {
  final bool success;
  final String consultationId;
  final String status;
  final AiPatientProfile? patientProfile;
  final List<Map<String, dynamic>> chiefComplaints;
  final List<Map<String, dynamic>> symptoms;
  final Map<String, dynamic> vitals;
  final List<String> examinationFindings;
  final List<Map<String, dynamic>> diagnoses;
  final List<Map<String, dynamic>> suggestedInvestigations;
  final List<ClinicalAlert> alerts;
  final int? updatedAt;

  MemoryResponse({
    required this.success,
    required this.consultationId,
    required this.status,
    this.patientProfile,
    this.chiefComplaints = const [],
    this.symptoms = const [],
    this.vitals = const {},
    this.examinationFindings = const [],
    this.diagnoses = const [],
    this.suggestedInvestigations = const [],
    this.alerts = const [],
    this.updatedAt,
  });

  factory MemoryResponse.fromJson(Map<String, dynamic> json) => MemoryResponse(
        success: json['success'] ?? false,
        consultationId: json['consultationId'] ?? '',
        status: json['status'] ?? '',
        patientProfile: json['patientProfile'] != null
            ? AiPatientProfile.fromJson(json['patientProfile'])
            : null,
        chiefComplaints: List<Map<String, dynamic>>.from(json['chiefComplaints'] ?? []),
        symptoms: List<Map<String, dynamic>>.from(json['symptoms'] ?? []),
        vitals: Map<String, dynamic>.from(json['vitals'] ?? {}),
        examinationFindings: List<String>.from(json['examinationFindings'] ?? []),
        diagnoses: List<Map<String, dynamic>>.from(json['diagnoses'] ?? []),
        suggestedInvestigations:
            List<Map<String, dynamic>>.from(json['suggestedInvestigations'] ?? []),
        alerts: (json['alerts'] as List? ?? []).map((a) => ClinicalAlert.fromJson(a)).toList(),
        updatedAt: json['updatedAt'],
      );

  /// Helper getters for typed access in ClinicalMemoryView
  VitalsExtracted? get vitalsExtracted =>
      vitals.isNotEmpty ? VitalsExtracted.fromJson(vitals) : null;

  List<ChiefComplaint> get typedChiefComplaints =>
      chiefComplaints.map((c) => ChiefComplaint.fromJson(c)).toList();

  List<SymptomItem> get typedSymptoms =>
      symptoms.map((s) => SymptomItem.fromJson(s)).toList();
}

