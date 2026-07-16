enum TokenStatus { empty, waiting, active, completed,booked }

class TokenModel {
  final int id;
  int tokenNumber;
  TokenStatus status;
  bool isMine;
  final String? label;
  // 🔥 NEW (for time based)
  final String? startTime;
  final String? endTime;

  TokenModel({
    required this.id,
    required this.tokenNumber,
    required this.status,
    required this.isMine,
    this.startTime,
    this.endTime,
    this.label,
  });
}