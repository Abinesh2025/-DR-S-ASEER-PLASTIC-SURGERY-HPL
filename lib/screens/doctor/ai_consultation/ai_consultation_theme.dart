import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiTheme {
  // Vibrant luxury clinical palette
  static const Color primaryEmerald = Color(0xFF0FA66A);
  static const Color primaryDark = Color(0xFF084E31);
  static const Color accentTeal = Color(0xFF00C48C);
  static const Color softTealBg = Color(0xFFE8F8F2);

  static const Color bgDark = Color(0xFF0F172A); // Slate 900
  static const Color cardDark = Color(0xFF1E293B); // Slate 800
  static const Color surfaceLight = Color(0xFFF8FAFC); // Slate 50
  static const Color cardLight = Colors.white;

  static const Color doctorBubble = Color(0xFFE6F7F0);
  static const Color doctorAccent = Color(0xFF0FA66A);
  static const Color patientBubble = Color(0xFFF1F5F9);
  static const Color patientAccent = Color(0xFF475569);

  static const Color alertCritical = Color(0xFFEF4444);
  static const Color alertWarning = Color(0xFFF59E0B);
  static const Color alertInfo = Color(0xFF3B82F6);
  static const Color alertSuccess = Color(0xFF10B981);

  // Modern typography
  static TextStyle titleStyle({Color color = const Color(0xFF0F172A), double size = 20}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -0.3,
      );

  static TextStyle headingStyle({Color color = const Color(0xFF0F172A), double size = 16}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: -0.2,
      );

  static TextStyle bodyStyle({Color color = const Color(0xFF334155), double size = 14}) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.45,
      );

  static TextStyle labelStyle({Color color = const Color(0xFF64748B), double size = 12}) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle monoStyle({Color color = const Color(0xFF0FA66A), double size = 14}) =>
      GoogleFonts.jetBrainsMono(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // Box shadows
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: primaryEmerald.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> glowingShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.35),
      blurRadius: 20,
      spreadRadius: 1,
      offset: const Offset(0, 6),
    ),
  ];
}
