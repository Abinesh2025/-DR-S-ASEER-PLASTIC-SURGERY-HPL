import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class CommonLoader {
  static bool _isShowing = false;

  static void showLoader({
    String title = "Please wait...",
    String subtitle = "Loading...",
  }) {
    if (_isShowing) return;

    final context = Get.context;
    if (context == null) return;

    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) => _CustomLoader(
        title: title,
        subtitle: subtitle,
      ),
    ).then((_) => _isShowing = false);
  }

  static void hideLoader() {
    if (_isShowing) {
      final context = Get.context;
      if (context == null) return;

      Navigator.of(context, rootNavigator: true).pop();
      _isShowing = false;
    }
  }
}

class _CustomLoader extends StatefulWidget {
  final String title;
  final String subtitle;

  const _CustomLoader({
    this.title = "Please wait...",
    this.subtitle = "Loading...",
  });

  @override
  State<_CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<_CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 65,
                  height: 65,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorConst.primaryColor),
                    strokeWidth: 3,
                    backgroundColor: ColorConst.primaryColor.withOpacity(0.1),
                  ),
                ),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Icon(
                    Icons.medical_services_rounded,
                    color: ColorConst.primaryColor,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
            ),
            const SizedBox(height: 8),
            Text(
              widget.subtitle,
              style: TextStyleConst.mediumTextStyle(Colors.grey, 12),
            ),
          ],
        ),
      ),
    );
  }
}
