import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/ai_consultation/ai_consultation_theme.dart';

class WaveformVisualizer extends StatefulWidget {
  final bool isRecording;
  final bool isPaused;

  const WaveformVisualizer({
    super.key,
    required this.isRecording,
    this.isPaused = false,
  });

  @override
  State<WaveformVisualizer> createState() => _WaveformVisualizerState();
}

class _WaveformVisualizerState extends State<WaveformVisualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void didUpdateWidget(WaveformVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording && !widget.isPaused) {
      if (!_controller.isAnimating) _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(24, (index) {
              final progress = _controller.value;
              final wave = math.sin((index * 0.35) + (progress * math.pi * 2));
              final normalized = (wave + 1) / 2; // 0.0 to 1.0

              double height = 8.0;
              if (widget.isRecording && !widget.isPaused) {
                height = 8.0 + (normalized * 34.0);
              } else if (widget.isPaused) {
                height = 10.0;
              }

              final isCenter = index >= 8 && index <= 15;
              final color = widget.isPaused
                  ? Colors.orange.shade300
                  : isCenter
                      ? AiTheme.primaryEmerald
                      : AiTheme.accentTeal.withOpacity(0.65);

              return Container(
                width: 3.5,
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 2.2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: widget.isRecording && !widget.isPaused && isCenter
                      ? [
                          BoxShadow(
                            color: AiTheme.primaryEmerald.withOpacity(0.4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          )
                        ]
                      : null,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
