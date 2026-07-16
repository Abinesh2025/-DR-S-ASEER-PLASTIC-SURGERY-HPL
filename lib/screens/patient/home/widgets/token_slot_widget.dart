// import 'package:flutter/material.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/token_model.dart';

import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/token_model.dart';

class TokenSlotWidget extends StatefulWidget {
  final TokenModel token;

  const TokenSlotWidget({Key? key, required this.token}) : super(key: key);

  @override
  State<TokenSlotWidget> createState() => _TokenSlotWidgetState();
}

class _TokenSlotWidgetState extends State<TokenSlotWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: ColorConst.redColor,
      end: ColorConst.redColor.withOpacity(0.5),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _getBorderColor(),
          width: 2,
        ),
        boxShadow:
        widget.token.isMine && widget.token.status == TokenStatus.active
            ? [
          BoxShadow(
            color: ColorConst.redColor.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${(widget.token.label != null && widget.token.label!.isNotEmpty) ? widget.token.label : widget.token.tokenNumber}",
            style: TextStyleConst.boldTextStyle(
              _getTextColor(),
              20,
            ),
          ),
          if (widget.token.isMine)
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: ColorConst.whiteColor,
                shape: BoxShape.circle,
              ),
            )
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    if (widget.token.isMine) {
      if (widget.token.status == TokenStatus.active) {
        return _colorAnimation.value ?? ColorConst.redColor;
      }
      return ColorConst.greenColor;
    }

    switch (widget.token.status) {
      case TokenStatus.empty:
        return ColorConst.lightGreyColor;

      case TokenStatus.waiting:
        return ColorConst.blueColor.withOpacity(0.5);

      case TokenStatus.booked: // 🔥 NEW COLOR
        return Colors.purple.withOpacity(0.7);

      case TokenStatus.active:
        return ColorConst.orangeColor.withOpacity(0.7);

      case TokenStatus.completed:
        return ColorConst.hintGreyColor;
    }
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }

  Color _getBorderColor() {
    if (widget.token.isMine && widget.token.status == TokenStatus.active) {
      return ColorConst.redColor;
    }
    return Colors.transparent;
  }

  Color _getTextColor() {
    if (widget.token.status == TokenStatus.empty) return ColorConst.hintGreyColor;
    if (widget.token.isMine && widget.token.status == TokenStatus.active)
      return ColorConst.redColor;
    return ColorConst.whiteColor;
  }
}
// class TokenSlotWidget extends StatefulWidget {
//   final TokenModel token;
//
//   const TokenSlotWidget({Key? key, required this.token}) : super(key: key);
//
//   @override
//   State<TokenSlotWidget> createState() => _TokenSlotWidgetState();
// }
//
// class _TokenSlotWidgetState extends State<TokenSlotWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Color?> _colorAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     )..repeat(reverse: true);
//
//     _colorAnimation = ColorTween(
//       begin: Colors.red,
//       end: Colors.redAccent.withOpacity(0.5),
//     ).animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 50,
//       height: 50,
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       decoration: BoxDecoration(
//         // color: _getBackgroundColor(),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: _getBorderColor(),
//           width: 2,
//         ),
//         boxShadow:
//             widget.token.isMine && widget.token.status == TokenStatus.active
//                 ? [
//                     BoxShadow(
//                       color: Colors.red.withOpacity(0.5),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                     )
//                   ]
//                 : null,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "${widget.token.tokenNumber}",
//             style: TextStyleConst.boldTextStyle(
//               _getTextColor(),
//               20,
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(bottom: 12),
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 20, vertical: 10),
//             decoration: BoxDecoration(
//                shape: BoxShape.circle
//                    ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.confirmation_number_outlined,
//                     color: Colors.white, size: 20),
//                 const SizedBox(width: 10),
//                 Text("5",
//                     style: TextStyleConst.mediumTextStyle(
//                         Colors.white, 14)),
//
//               ],
//             ),
//           ),
//           if (widget.token.isMine)
//             Container(
//               margin: const EdgeInsets.only(top: 2),
//               width: 8,
//               height: 8,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//             )
//         ],
//       ),
//     );
//   }
//
//   Color _getBackgroundColor() {
//     if (widget.token.isMine) {
//       if (widget.token.status == TokenStatus.active) {
//         return _colorAnimation.value ?? Colors.red;
//       }
//       return Colors.green;
//     }
//
//     switch (widget.token.status) {
//       case TokenStatus.empty:
//         return Colors.grey.shade300;
//       case TokenStatus.waiting:
//         return Colors.blue.shade300;
//       case TokenStatus.active:
//         return Colors.orange.shade300;
//       case TokenStatus.completed:
//         return Colors.grey.shade400;
//     }
//   }
//
//   Widget _buildAnimatedBackground() {
//     return AnimatedBuilder(
//       animation: _colorAnimation,
//       builder: (context, child) {
//         return Container(
//           decoration: BoxDecoration(
//             color: _colorAnimation.value,
//             borderRadius: BorderRadius.circular(8),
//           ),
//         );
//       },
//     );
//   }
//
//   Color _getBorderColor() {
//     if (widget.token.isMine && widget.token.status == TokenStatus.active) {
//       return Colors.red;
//     }
//     return Colors.transparent;
//   }
//
//   Color _getTextColor() {
//     if (widget.token.status == TokenStatus.empty) return Colors.grey.shade600;
//     if (widget.token.isMine && widget.token.status == TokenStatus.active)
//       return Colors.red;
//     return Colors.white;
//   }
// }
