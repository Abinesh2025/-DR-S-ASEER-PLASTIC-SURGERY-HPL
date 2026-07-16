import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';

// class DisplaySnackBar {
//   static displaySnackBar(String content, [int? sec, Color? bgColor]) {
//     final context = Get.context;
//     if (context == null) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//       backgroundColor: bgColor ?? ColorConst.redColor,
//         content: Text(
//           content,
//           style: TextStyleConst.mediumTextStyle(Colors.white, 15),
//         ),
//         duration: Duration(seconds: sec ?? 3),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//         margin: const EdgeInsets.all(10),
//       ),
//     );
//   }
// }

class DisplaySnackBar {
  static displaySnackBar(String content, [int? sec, Color? bgColor]) {
    Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: sec ?? 3,
      backgroundColor: bgColor ?? ColorConst.redColor,
      textColor: Colors.white,
      fontSize: 15.0,
    );
  }
}
