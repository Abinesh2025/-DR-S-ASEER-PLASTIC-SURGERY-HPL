import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback leadOnTap;
  final Icon leadIcon;
  final bool isGradient;
  const CommonAppBar({
    Key? key,
    required this.title,
    required this.leadOnTap,
    required this.leadIcon,
    this.isGradient = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: isGradient 
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorConst.primaryColor,
                    ColorConst.primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorConst.primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              )
            : null,
        child: AppBar(
          leading: Builder(builder: (context) {
            return GestureDetector(
              onTap: leadOnTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isGradient 
                          ? Colors.white.withOpacity(0.2)
                          : ColorConst.blackColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      leadIcon.icon,
                      color: isGradient ? Colors.white : ColorConst.blackColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            );
          }),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isGradient ? Brightness.light : Brightness.dark, // Black icons on white, white on blue
            statusBarBrightness:
                isGradient ? Brightness.dark : Brightness.light, // iOS: light background means dark icons
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          centerTitle: true,
          toolbarHeight: kToolbarHeight + 15,
          title: Text(
            title,
            style: TextStyleConst.boldTextStyle(
              isGradient ? Colors.white : ColorConst.blackColor,
              width * 0.05,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
