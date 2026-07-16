import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';

class CommonShimmer extends StatefulWidget {
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const CommonShimmer({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 12,
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<CommonShimmer> createState() => _CommonShimmerState();
}

class _CommonShimmerState extends State<CommonShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.baseColor ?? ColorConst.shimmerBaseColor;
    final highlightColor =
        widget.highlightColor ?? ColorConst.shimmerHighlightColor;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                _animation.value - 1,
                _animation.value,
                _animation.value + 1,
              ],
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
            ),
          ),
        );
      },
    );
  }
}
