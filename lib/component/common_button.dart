import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    required this.color,
    required this.onTap,
    this.isIcon,
    this.isLoading = false,
    required this.textStyleConst,
  }) : super(key: key);

  final double width;
  final double height;
  final String text;
  final bool? isIcon;
  final bool isLoading;
  final Color color;
  final VoidCallback onTap;
  final TextStyle textStyleConst;

  @override
  Widget build(BuildContext context) {
    Widget loadingWidget = const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      ),
    );
    return isIcon == true
        ? ElevatedButton.icon(
      icon: isLoading ? const SizedBox.shrink() : const Icon(Icons.videocam_rounded),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: color,
              elevation: 0,
              fixedSize: Size(width, height),
            ),
      onPressed: isLoading ? null : onTap,
      label: isLoading
          ? loadingWidget
          : Text(
        text,
        textAlign: TextAlign.center,
        style: textStyleConst,
      ),
    )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: color,
              elevation: 0,
              fixedSize: Size(width, height),
            ),
      onPressed: isLoading ? null : onTap,
      child: isLoading
          ? loadingWidget
          : Text(
        text,
        style: textStyleConst,
      ),
    );
  }
}
