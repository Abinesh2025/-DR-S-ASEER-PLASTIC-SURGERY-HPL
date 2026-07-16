// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/token_model.dart';
// // Note: Ensure you import collection if firstWhereOrNull is used
// import 'package:collection/collection.dart';
//
// import '../../../../utils/string_utils.dart';
// //
// // class LiveTokenStatusWidget extends StatelessWidget {
// //   final PatientHomeController controller;
// //
// //   const LiveTokenStatusWidget({super.key, required this.controller});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(() {
// //       if (!controller.hasActiveToken.value) return const SizedBox.shrink();
// //
// //       // If there are no tokens at all from the socket, hide the widget
// //       if (controller.tokens.isEmpty) return const SizedBox.shrink();
// //
// //       // Find my token safely
// //       final myToken = controller.tokens.firstWhereOrNull((t) => t.isMine);
// //
// //       // Filter the list to ONLY show other people who are actually waiting/booked/active
// //       // (This hides the empty "Available" tokens)
// //       final ongoingTokens = controller.tokens
// //           .where((t) => !t.isMine && t.status != TokenStatus.empty)
// //           .toList();
// //
// //       // If we don't have our own token AND there are no ongoing tokens, hide the widget entirely
// //       if (myToken == null && ongoingTokens.isEmpty) return const SizedBox.shrink();
// //
// //       return Container(
// //
// //         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF2D6A4F), // Dark green background
// //           borderRadius: BorderRadius.circular(10),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.1),
// //               blurRadius: 10,
// //               offset: const Offset(0, 4),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           children: [
// //             // List of ongoing tokens
// //             Expanded(
// //               child: SizedBox(
// //                 height: 55, // Increased slightly to prevent yellow dot clipping
// //                 child: ongoingTokens.isEmpty
// //                     ? Row(
// //                   children: [
// //                     Container(
// //                       width: 36,
// //                       height: 36,
// //                       decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.2),
// //                         shape: BoxShape.circle,
// //                       ),
// //                       child: const Icon(
// //                         Icons.verified,
// //                         color: Color(0xFFFFC107),
// //                         size: 20,
// //                       ),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     Expanded(
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             StringUtils.appointmentConfirmed,
// //                             style: TextStyleConst.boldTextStyle(
// //                               Colors.white,
// //                               12,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 2),
// //                           Text(
// //                             StringUtils.arriveOnTime,
// //                             style: TextStyleConst.mediumTextStyle(
// //                               Colors.white70,
// //                               10,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 )
// //                     : ListView.builder(
// //                   scrollDirection: Axis.horizontal,
// //                   physics: const BouncingScrollPhysics(),
// //                   itemCount: ongoingTokens.length,
// //                   itemBuilder: (context, index) {
// //                     return _buildSmallTokenCard(ongoingTokens[index]);
// //                   },
// //                 ),
// //               ),
// //             ),
// //
// //             const SizedBox(width: 4),
// //
// //             // My Token Highlight
// //             if (myToken != null) _buildMyTokenCard(myToken),
// //           ],
// //         ),
// //       );
// //     });
// //   }
// //
// //   // Widget _buildSmallTokenCard(TokenModel token) {
// //   //   // Check if this specific token is the one currently checked in / active
// //   //   bool isActive = token.status == TokenStatus.active;
// //   //
// //   //   return Container(
// //   //     width: 45,
// //   //     margin: const EdgeInsets.only(right: 10),
// //   //     child: Stack(
// //   //       clipBehavior: Clip.none,
// //   //       alignment: Alignment.center,
// //   //       children: [
// //   //         // Base rounded square background
// //   //         Container(
// //   //           width: 45,
// //   //           height: 45,
// //   //           decoration: BoxDecoration(
// //   //             // Lighter background for active token, darker for waiting tokens
// //   //             color: isActive
// //   //                 ? Colors.white.withOpacity(0.3)
// //   //                 : Colors.white.withOpacity(0.15),
// //   //             borderRadius: BorderRadius.circular(12),
// //   //             // Optional subtle border for the active token to make it pop like the image
// //   //             border: isActive
// //   //                 ? Border.all(color: Colors.white.withOpacity(0.5), width: 1)
// //   //                 : null,
// //   //           ),
// //   //           alignment: Alignment.center,
// //   //           child: token.startTime != null
// //   //               ? Column(
// //   //             mainAxisAlignment: MainAxisAlignment.center,
// //   //             children: [
// //   //               Text(
// //   //                 token.startTime!,
// //   //                 style: TextStyleConst.mediumTextStyle(
// //   //                   Colors.white,
// //   //                   10,
// //   //                 ),
// //   //               ),
// //   //               Text(
// //   //                 token.endTime ?? "",
// //   //                 style: TextStyleConst.mediumTextStyle(
// //   //                   Colors.white70,
// //   //                   8,
// //   //                 ),
// //   //               ),
// //   //             ],
// //   //           )
// //   //               : Text(
// //   //             "${token.tokenNumber}",
// //   //             style: TextStyleConst.boldTextStyle(
// //   //               Colors.white,
// //   //               18,
// //   //             ),
// //   //           ),
// //   //         ),
// //   //
// //   //         // Yellow Indicator dot for the active/checked-in token
// //   //         if (isActive)
// //   //           Positioned(
// //   //             bottom: -2, // Positions it half-way outside the bottom edge
// //   //             child: Container(
// //   //               width: 12,
// //   //               height: 12,
// //   //               decoration: const BoxDecoration(
// //   //                 color: Color(0xFFFFC107), // Amber/Yellow
// //   //                 shape: BoxShape.circle,
// //   //               ),
// //   //             ),
// //   //           ),
// //   //       ],
// //   //     ),
// //   //   );
// //   // }
// //   Widget _buildSmallTokenCard(TokenModel token) {
// //     bool isActive = token.status == TokenStatus.active;
// //
// //     bool isTimeSlot = token.startTime != null;
// //
// //     return Container(
// //       margin: const EdgeInsets.only(right: 10),
// //       alignment: Alignment.center,
// //       child: Stack(
// //         clipBehavior: Clip.none,
// //         alignment: Alignment.center,
// //         children: [
// //           Container(
// //             constraints: BoxConstraints(
// //               minWidth: 45,
// //               maxWidth: isTimeSlot ? 150 : 45, // 🔥 Wider for time slot
// //             ),
// //             padding: const EdgeInsets.symmetric(horizontal: 4),
// //             height: 35,
// //             decoration: BoxDecoration(
// //               color: isActive
// //                   ? Colors.white.withOpacity(0.3)
// //                   : Colors.white.withOpacity(0.15),
// //               borderRadius: BorderRadius.circular(12),
// //               border: isActive
// //                   ? Border.all(
// //                 color: Colors.white.withOpacity(0.5),
// //                 width: 1,
// //               )
// //                   : null,
// //             ),
// //             alignment: Alignment.center,
// //             child: token.startTime != null
// //                 ? Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text(
// //                   token.startTime!,
// //                   style: TextStyleConst.mediumTextStyle(
// //                     Colors.white,
// //                     10,
// //                   ),
// //                 ),
// //                 Text(
// //                   token.endTime ?? "",
// //                   style: TextStyleConst.mediumTextStyle(
// //                     Colors.white70,
// //                     8,
// //                   ),
// //                 ),
// //               ],
// //             )
// //                 : Text(
// //               "${token.tokenNumber}",
// //               style: TextStyleConst.boldTextStyle(
// //                 Colors.white,
// //                 18,
// //               ),
// //             ),
// //           ),
// //
// //           if (isActive)
// //             Positioned(
// //               bottom: isTimeSlot ? -4 : -6,
// //               child: Container(
// //                 width: 12,
// //                 height: 12,
// //                 decoration: const BoxDecoration(
// //                   color: Color(0xFFFFC107),
// //                   shape: BoxShape.circle,
// //                 ),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //   Widget _buildMyTokenCard(TokenModel token) {
// //     bool isActive = token.status == TokenStatus.active;
// //
// //     bool isTimeSlot = token.startTime != null;
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //       decoration: BoxDecoration(
// //         color: Color(0xFF2D6A4F),
// //         borderRadius: BorderRadius.circular(10),
// //         border: Border.all(color: Colors.white38),
// //       ),
// //       child: Row(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //
// //           // const SizedBox(width: 8),
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //
// //               isTimeSlot
// //                   ?
// //               Text(
// //                 StringUtils.mySlot,
// //                 style: TextStyleConst.mediumTextStyle(Colors.white70, 10),
// //               ):Text(
// //                 StringUtils.myToken,
// //                 style: TextStyleConst.mediumTextStyle(Colors.white70, 10),
// //               ),
// //
// //               token.startTime != null
// //                   ? Column(
// //                 crossAxisAlignment: CrossAxisAlignment.end,
// //                 children: [
// //
// //                   Text(
// //                     token.startTime!,
// //                     style: TextStyleConst.boldTextStyle(Colors.white, 12),
// //                   ),
// //                   // Text(
// //                   //  "To  ${token.endTime}" ?? "",
// //                   //   style: TextStyleConst.boldTextStyle(Colors.white70, 12),
// //                   // ),
// //                 ],
// //               )
// //                   :  _buildTicketShape(token.tokenNumber),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildTicketShape(int number) {
// //     return CustomPaint(
// //       size: const Size(40, 55),
// //       painter: TicketPainter(),
// //       child: Center(
// //         child: Container(
// //           width: 40,
// //           height: 35,
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //           alignment: Alignment.center,
// //           child: Text(
// //             "$number",
// //             style: TextStyleConst.boldTextStyle(const Color(0xFF2D6A4F), 18),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class TicketPainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()
// //       ..color = Colors.white.withOpacity(0.3)
// //       ..style = PaintingStyle.fill;
// //
// //     final path = Path();
// //     double radius = 8.0;
// //     double cutOut = 6.0;
// //
// //     path.moveTo(radius, 0);
// //     path.lineTo(size.width - radius, 0);
// //     path.arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius));
// //
// //     // Right side cut out
// //     path.lineTo(size.width, size.height / 2 - cutOut);
// //     path.arcToPoint(Offset(size.width, size.height / 2 + cutOut), radius: Radius.circular(cutOut), clockwise: false);
// //
// //     path.lineTo(size.width, size.height - radius);
// //     path.arcToPoint(Offset(size.width - radius, size.height), radius: Radius.circular(radius));
// //     path.lineTo(radius, size.height);
// //     path.arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius));
// //
// //     // Left side cut out
// //     path.lineTo(0, size.height / 2 + cutOut);
// //     path.arcToPoint(Offset(0, size.height / 2 - cutOut), radius: Radius.circular(cutOut), clockwise: false);
// //
// //     path.lineTo(0, radius);
// //     path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
// //
// //     canvas.drawPath(path, paint);
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// // }
//
// class LiveTokenStatusWidget extends StatelessWidget {
//   final PatientHomeController controller;
//   const LiveTokenStatusWidget({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (!controller.hasActiveToken.value || controller.tokens.isEmpty) return const SizedBox.shrink();
//
//       final myToken = controller.tokens.firstWhereOrNull((t) => t.isMine);
//       final ongoingTokens = controller.tokens
//           .where((t) => !t.isMine && t.status != TokenStatus.empty)
//           .toList();
//
//       return Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2D6A4F),
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 4))],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: SizedBox(
//                 height: 75, // 🔥 Increased height to show both message and tokens
//                 child: _buildDoctorStatusContent(ongoingTokens),
//               ),
//             ),
//             const SizedBox(width: 8),
//             if (myToken != null) _buildMyTokenCard(myToken),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget _buildDoctorStatusContent(List<TokenModel> ongoingTokens) {
//     String status = controller.doctorStatus.value.trim().toLowerCase();
//     String reason = controller.doctorReason.value;
//
//     // Determine if we need to show an alert message
//     Widget? statusAlert;
//     if (status == "not started") {
//       statusAlert = _buildCompactStatusAlert(Icons.timer_outlined, "Starting Soon", Colors.white70);
//     } else if (status == "paused") {
//       statusAlert = _buildCompactStatusAlert(
//           Icons.pause_circle_filled,
//           reason.isNotEmpty ? "$reason" : "Doctor is on a break",
//           Colors.orangeAccent
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // 🔥 Show Status Alert if applicable
//         if (statusAlert != null) ...[
//           statusAlert,
//           const SizedBox(height: 6),
//         ],
//
//         // 🔥 Always show the Token List or Confirmed State
//         Expanded(
//           child: ongoingTokens.isEmpty
//               ? _buildConfirmedState()
//               : ListView.builder(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             itemCount: ongoingTokens.length,
//             itemBuilder: (context, index) => _buildSmallTokenCard(ongoingTokens[index]),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Compact Alert for the top row
//   Widget _buildCompactStatusAlert(IconData icon, String message, Color color) {
//     return Row(
//       children: [
//         Icon(icon, color: color, size: 14),
//         const SizedBox(width: 6),
//         Expanded(
//           child: Text(
//             message,
//             style: TextStyleConst.boldTextStyle(color, 10),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSmallTokenCard(TokenModel token) {
//     bool isActive = token.status == TokenStatus.active;
//     bool hasTime = token.endTime != null;
//
//     return Container(
//       margin: const EdgeInsets.only(right: 12),
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.center,
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             padding: const EdgeInsets.symmetric(vertical: 2),
//             decoration: BoxDecoration(
//               color: isActive ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.15),
//               borderRadius: BorderRadius.circular(8),
//               border: isActive ? Border.all(color: Colors.white54) : null,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "${token.tokenNumber}",
//                   style: TextStyleConst.boldTextStyle(Colors.white, 14),
//                 ),
//                 if (hasTime)
//                   FittedBox(
//                     child: Text(
//                       token.endTime!,
//                       style: TextStyleConst.mediumTextStyle(Colors.white70, 7),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           if (isActive)
//             Positioned(
//               bottom:3,
//               child: Container(
//                 width: 10, height: 10,
//                 decoration: const BoxDecoration(color: Color(0xFFFFC107), shape: BoxShape.circle),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMyTokenCard(TokenModel token) {
//     bool hasTime = token.startTime != null;
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1B4332),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.white24),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             hasTime ? StringUtils.mySlot : StringUtils.myToken,
//             style: TextStyleConst.mediumTextStyle(Colors.white70, 9),
//           ),
//           Text(
//             "${token.tokenNumber}",
//             style: TextStyleConst.boldTextStyle(Colors.white, 16),
//           ),
//           if (hasTime)
//             Text(
//               token.startTime!,
//               style: TextStyleConst.boldTextStyle(const Color(0xFFFFC107), 10),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildConfirmedState() {
//     return Row(
//       children: [
//         const Icon(Icons.verified, color: Color(0xFFFFC107), size: 20),
//         const SizedBox(width: 8),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(StringUtils.appointmentConfirmed, style: TextStyleConst.boldTextStyle(Colors.white, 11)),
//             Text(StringUtils.arriveOnTime, style: TextStyleConst.mediumTextStyle(Colors.white70, 9)),
//           ],
//         ),
//       ],
//     );
//   }
// }
// // class LiveTokenStatusWidget extends StatelessWidget {
// //   final PatientHomeController controller;
// //   const LiveTokenStatusWidget({super.key, required this.controller});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(() {
// //       if (!controller.hasActiveToken.value || controller.tokens.isEmpty) return const SizedBox.shrink();
// //
// //       final myToken = controller.tokens.firstWhereOrNull((t) => t.isMine);
// //
// //       // Filter for ongoing tokens
// //       final ongoingTokens = controller.tokens
// //           .where((t) => !t.isMine && t.status != TokenStatus.empty)
// //           .toList();
// //
// //       return Container(
// //         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF2D6A4F),
// //           borderRadius: BorderRadius.circular(12),
// //           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
// //         ),
// //         child: Row(
// //           children: [
// //             Expanded(
// //               child: SizedBox(
// //                 height: 65,
// //                 child: _buildDoctorStatusContent(ongoingTokens),
// //               ),
// //             ),
// //             const SizedBox(width: 8),
// //             if (myToken != null) _buildMyTokenCard(myToken),
// //           ],
// //         ),
// //       );
// //     });
// //   }
// //   Widget _buildDoctorStatusContent(List<TokenModel> ongoingTokens) {
// //     // 1. Check Doctor Status First
// //     String status = controller.doctorStatus.value.trim().toLowerCase();
// //     String reason = controller.doctorReason.value;
// //
// //     if (status == "not started") {
// //       return _buildStatusAlert(
// //         Icons.timer_outlined,
// //         "Doctor hasn't started yet",
// //         "Consultation will begin shortly. Please stay tuned.",
// //       );
// //     }
// //
// //     if (status == "paused") {
// //       return _buildStatusAlert(
// //         Icons.pause_circle_filled,
// //         "Consultation Paused",
// //         reason.isNotEmpty ? reason : "The doctor is on a short break.",
// //         iconColor: Colors.orangeAccent,
// //       );
// //     }
// //
// //     // if (status == "stopped") {
// //     //   return _buildStatusAlert(
// //     //     Icons.cancel_outlined,
// //     //     "Doctor is Away",
// //     //     "The session has ended for today.",
// //     //     iconColor: Colors.redAccent,
// //     //   );
// //     // }
// //
// //     // 2. If status is 'started' (or anything else), show tokens
// //     if (ongoingTokens.isEmpty) {
// //       return _buildConfirmedState();
// //     }
// //
// //     return ListView.builder(
// //       scrollDirection: Axis.horizontal,
// //       physics: const BouncingScrollPhysics(),
// //       itemCount: ongoingTokens.length,
// //       itemBuilder: (context, index) => _buildSmallTokenCard(ongoingTokens[index]),
// //     );
// //   }
// //   // Widget _buildDoctorStatusContent(List<TokenModel> ongoingTokens) {
// //   //   String status = controller.doctorStatus.value.toLowerCase();
// //   //   String reason = controller.doctorReason.value;
// //   //
// //   //   // 🔥 Case 1: Doctor hasn't started yet
// //   //   if (status == "not started") {
// //   //     return _buildStatusAlert(
// //   //       Icons.timer_outlined,
// //   //       "Doctor hasn't started yet",
// //   //       "Please wait, consultation will begin soon.",
// //   //     );
// //   //   }
// //   //
// //   //   // 🔥 Case 2: Doctor is on a break / Paused
// //   //   if (status == "paused") {
// //   //     return _buildStatusAlert(
// //   //       Icons.pause_circle_filled,
// //   //       "Consultation Paused",
// //   //       reason.isNotEmpty ? reason : "Doctor is on a short break.",
// //   //       iconColor: Colors.orangeAccent,
// //   //     );
// //   //   }
// //   //
// //   //   // 🔥 Case 3: Doctor stopped for the day
// //   //   if (status == "stopped") {
// //   //     return _buildStatusAlert(
// //   //       Icons.block,
// //   //       "Doctor is away",
// //   //       "Consultations have stopped for now.",
// //   //     );
// //   //   }
// //   //
// //   //   // 🔥 Default Case: Doctor started, show token list
// //   //   if (ongoingTokens.isEmpty) {
// //   //     return _buildConfirmedState();
// //   //   }
// //   //
// //   //   return ListView.builder(
// //   //     scrollDirection: Axis.horizontal,
// //   //     physics: const BouncingScrollPhysics(),
// //   //     itemCount: ongoingTokens.length,
// //   //     itemBuilder: (context, index) => _buildSmallTokenCard(ongoingTokens[index]),
// //   //   );
// //   // }
// //
// //   Widget _buildStatusAlert(IconData icon, String title, String subtitle, {Color iconColor = const Color(0xFFFFC107)}) {
// //     return Row(
// //       children: [
// //         Icon(icon, color: iconColor, size: 28),
// //         const SizedBox(width: 12),
// //         Expanded(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 title,
// //                 style: TextStyleConst.boldTextStyle(Colors.white, 12),
// //                 maxLines: 1,
// //                 overflow: TextOverflow.ellipsis,
// //               ),
// //               Text(
// //                 subtitle,
// //                 style: TextStyleConst.mediumTextStyle(Colors.white70, 10),
// //                 maxLines: 2,
// //                 overflow: TextOverflow.ellipsis,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //   Widget _buildSmallTokenCard(TokenModel token) {
// //     bool isActive = token.status == TokenStatus.active;
// //     bool hasTime = token.startTime != null;
// //
// //     return Container(
// //       margin: const EdgeInsets.only(right: 12),
// //       child: Stack(
// //         clipBehavior: Clip.none,
// //         alignment: Alignment.center,
// //         children: [
// //           Container(
// //             width: 50,
// //             padding: const EdgeInsets.symmetric(vertical: 4),
// //             decoration: BoxDecoration(
// //               color: isActive ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.15),
// //               borderRadius: BorderRadius.circular(10),
// //               border: isActive ? Border.all(color: Colors.white54) : null,
// //             ),
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text(
// //                   "${token.tokenNumber}",
// //                   style: TextStyleConst.boldTextStyle(Colors.white, 15),
// //                 ),
// //                 if (hasTime)
// //                   FittedBox( // 🔥 Prevents overflow
// //                     child: Text(
// //                       token.endTime!,
// //                       style: TextStyleConst.mediumTextStyle(Colors.white70, 8),
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //           if (isActive)
// //             Positioned(
// //               bottom: -4,
// //               child: Container(
// //                 width: 10, height: 10,
// //                 decoration: const BoxDecoration(color: Color(0xFFFFC107), shape: BoxShape.circle),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildMyTokenCard(TokenModel token) {
// //     bool hasTime = token.startTime != null;
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF1B4332), // Darker green for "My" section
// //         borderRadius: BorderRadius.circular(10),
// //         border: Border.all(color: Colors.white24),
// //       ),
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Text(
// //             hasTime ? StringUtils.mySlot : StringUtils.myToken,
// //             style: TextStyleConst.mediumTextStyle(Colors.white70, 9),
// //           ),
// //           const SizedBox(height: 2),
// //           Text(
// //             "${token.tokenNumber}",
// //             style: TextStyleConst.boldTextStyle(Colors.white, 16),
// //           ),
// //           if (hasTime)
// //             Text(
// //               token.startTime!,
// //               style: TextStyleConst.boldTextStyle(const Color(0xFFFFC107), 10),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildConfirmedState() {
// //     return Row(
// //       children: [
// //         const Icon(Icons.verified, color: Color(0xFFFFC107), size: 24),
// //         const SizedBox(width: 10),
// //         Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(StringUtils.appointmentConfirmed, style: TextStyleConst.boldTextStyle(Colors.white, 12)),
// //             Text(StringUtils.arriveOnTime, style: TextStyleConst.mediumTextStyle(Colors.white70, 10)),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }
// // class LiveTokenStatusWidget extends StatelessWidget {
// //   final PatientHomeController controller;
// //   const LiveTokenStatusWidget({super.key, required this.controller});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(() {
// //       if (!controller.hasActiveToken.value || controller.tokens.isEmpty) return const SizedBox.shrink();
// //
// //       final myToken = controller.tokens.firstWhereOrNull((t) => t.isMine);
// //       final ongoingTokens = controller.tokens
// //           .where((t) => !t.isMine && t.status != TokenStatus.empty)
// //           .toList();
// //
// //       if (myToken == null && ongoingTokens.isEmpty) return const SizedBox.shrink();
// //
// //       return Container(
// //         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF2D6A4F),
// //           borderRadius: BorderRadius.circular(12),
// //           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
// //         ),
// //         child: Row(
// //           children: [
// //             Expanded(
// //               child: SizedBox(
// //                 height: 65, // 🔥 Increased height for stacking
// //                 child: ongoingTokens.isEmpty
// //                     ? _buildConfirmedState()
// //                     : ListView.builder(
// //                   scrollDirection: Axis.horizontal,
// //                   physics: const BouncingScrollPhysics(),
// //                   itemCount: ongoingTokens.length,
// //                   itemBuilder: (context, index) => _buildSmallTokenCard(ongoingTokens[index]),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(width: 8),
// //             if (myToken != null) _buildMyTokenCard(myToken),
// //           ],
// //         ),
// //       );
// //     });
// //   }
// //
// //   Widget _buildSmallTokenCard(TokenModel token) {
// //     bool isActive = token.status == TokenStatus.active;
// //     bool hasTime = token.startTime != null;
// //
// //     return Container(
// //       margin: const EdgeInsets.only(right: 12),
// //       child: Stack(
// //         clipBehavior: Clip.none,
// //         alignment: Alignment.center,
// //         children: [
// //           Container(
// //             width: 50,
// //             padding: const EdgeInsets.symmetric(vertical: 4),
// //             decoration: BoxDecoration(
// //               color: isActive ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.15),
// //               borderRadius: BorderRadius.circular(10),
// //               border: isActive ? Border.all(color: Colors.white54) : null,
// //             ),
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text(
// //                   "${token.tokenNumber}",
// //                   style: TextStyleConst.boldTextStyle(Colors.white, 15),
// //                 ),
// //                 if (hasTime)
// //                   FittedBox( // 🔥 Prevents overflow
// //                     child: Text(
// //                       token.endTime!,
// //                       style: TextStyleConst.mediumTextStyle(Colors.white70, 8),
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //           if (isActive)
// //             Positioned(
// //               bottom: -4,
// //               child: Container(
// //                 width: 10, height: 10,
// //                 decoration: const BoxDecoration(color: Color(0xFFFFC107), shape: BoxShape.circle),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildMyTokenCard(TokenModel token) {
// //     bool hasTime = token.startTime != null;
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF1B4332), // Darker green for "My" section
// //         borderRadius: BorderRadius.circular(10),
// //         border: Border.all(color: Colors.white24),
// //       ),
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Text(
// //             hasTime ? StringUtils.mySlot : StringUtils.myToken,
// //             style: TextStyleConst.mediumTextStyle(Colors.white70, 9),
// //           ),
// //           const SizedBox(height: 2),
// //           Text(
// //             "${token.tokenNumber}",
// //             style: TextStyleConst.boldTextStyle(Colors.white, 16),
// //           ),
// //           if (hasTime)
// //             Text(
// //               token.startTime!,
// //               style: TextStyleConst.boldTextStyle(const Color(0xFFFFC107), 10),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildConfirmedState() {
// //     return Row(
// //       children: [
// //         const Icon(Icons.verified, color: Color(0xFFFFC107), size: 24),
// //         const SizedBox(width: 10),
// //         Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(StringUtils.appointmentConfirmed, style: TextStyleConst.boldTextStyle(Colors.white, 12)),
// //             Text(StringUtils.arriveOnTime, style: TextStyleConst.mediumTextStyle(Colors.white70, 10)),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/token_model.dart';
import 'package:collection/collection.dart';
import '../../../../utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/token_model.dart';
import 'package:collection/collection.dart';
import '../../../../utils/string_utils.dart';

class LiveTokenStatusWidget extends StatelessWidget {
  final PatientHomeController controller;
  const LiveTokenStatusWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      if (!controller.hasActiveToken.value || controller.tokens.isEmpty) {
        return const SizedBox.shrink();
      }

      // 🔥 1. Filter out completed/checked_out from YOUR token
      final myToken = controller.tokens.firstWhereOrNull(
              (t) => t.isMine && t.status != TokenStatus.completed
      );

      // 🔥 2. Filter out completed/checked_out from EVERYONE ELSE'S tokens
      final ongoingTokens = controller.tokens
          .where((t) => !t.isMine && t.status != TokenStatus.empty && t.status != TokenStatus.completed)
          .toList();

      String status = controller.doctorStatus.value.trim().toLowerCase();
      bool hasStatusAlert = status == "not started" || status == "paused"|| status == "stopped";

      double containerHeight = hasStatusAlert ? screenHeight * 0.11 : screenHeight * 0.075;
      double indicatorBottom = hasStatusAlert ? screenHeight * 0.005 : screenHeight * 0.003;

      // 🔥 3. If your token is completed (meaning myToken is null), hide the entire widget!
      if (myToken == null) {
        return const SizedBox.shrink();
      }

      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.012,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.035,
          vertical: screenHeight * 0.012,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1B4332),
              Color(0xFF2D6A4F),
              Color(0xFF40916C),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: containerHeight,
                child: _buildDoctorStatusContent(
                  context,
                  ongoingTokens,
                  indicatorBottom,
                  screenWidth,
                  screenHeight,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            _buildMyTokenCard(
              context,
              myToken, // We know this isn't null because of the check above
              screenWidth,
              screenHeight,
            ),
          ],
        ),
      );
    });
  }
  Widget _buildDoctorStatusContent(
      BuildContext context,
      List<TokenModel> ongoingTokens,
      double indicatorBottom,
      double sw,
      double sh,
      ) {
    String status = controller.doctorStatus.value.trim().toLowerCase();
    String reason = controller.doctorReason.value;

    Widget? statusAlert;
    if (status == "not started") {
      statusAlert = _buildCompactStatusAlert(
        Icons.timer_outlined,
        "Token not started, Please wait",
        Colors.orangeAccent,
        sw,
      );
    } else if (status == "paused") {
      statusAlert = _buildCompactStatusAlert(
        Icons.pause_circle_filled,
        reason.isNotEmpty ? reason : "Doctor is on a break",
        Colors.orangeAccent,
        sw,
      );
    } else if (status == "stopped") {
      statusAlert = _buildCompactStatusAlert(
        Icons.event_busy_rounded,
        "Session ended Tokens over.",
        Colors.redAccent,
        sw,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (statusAlert != null) ...[
          statusAlert,
          SizedBox(height: sh * 0.006),
        ],
        Expanded(
          child: ongoingTokens.isEmpty
              ? _buildConfirmedState(sw, sh)
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: ongoingTokens.length,
            itemBuilder: (context, index) => _buildSmallTokenCard(
              context,
              ongoingTokens[index],
              indicatorBottom,
              sw,
              sh,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactStatusAlert(IconData icon, String message, Color color, double sw) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.02, vertical: sw * 0.008),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(sw * 0.03),
        border: Border.all(color: color.withOpacity(0.2), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          // 1. Pulsing "Live" Dot
          // TweenAnimationBuilder<double>(
          //   tween: Tween(begin: 0.3, end: 1.0),
          //   duration: const Duration(milliseconds: 800),
          //   builder: (context, value, child) {
          //     return Opacity(
          //       opacity: value,
          //       child: Container(
          //         width: sw * 0.015,
          //         height: sw * 0.015,
          //         decoration: BoxDecoration(
          //           color: color,
          //           shape: BoxShape.circle,
          //           boxShadow: [
          //             BoxShadow(
          //               color: color.withOpacity(0.5),
          //               blurRadius: 4 * value,
          //               spreadRadius: 2 * value,
          //             )
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),

          // SizedBox(width: sw * 0.02),

          // 2. Icon with a slight shadow
          Icon(
            icon,
            color: color,
            size: sw * 0.04,
            shadows: [Shadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))],
          ),

          SizedBox(width: sw * 0.015),

          // 3. Status Message
          Text(
            message,
            style: TextStyleConst.boldTextStyle(color, sw * 0.032),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  Widget _buildSmallTokenCard(
      BuildContext context,
      TokenModel token,
      double indicatorBottom,
      double sw,
      double sh,
      ) {
    bool isActive = token.status == TokenStatus.active;
    bool hasTime = token.endTime != null;
    bool isWaiting = token.status == TokenStatus.waiting;
    bool showIndicator = isActive || isWaiting;
    return Container(
      margin: EdgeInsets.only(right: sw * 0.03),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
                Container(
            width: sw * 0.12,
            height: sh * 0.055,
                  decoration: BoxDecoration(
              color: isActive ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(sw * 0.02),
              border: isActive ? Border.all(color: Colors.white54, width: 1) : null,
            ),
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                  "${(token.label != null && token.label!.isNotEmpty) ? token.label : token.tokenNumber}",
                  style: TextStyleConst.boldTextStyle(Colors.white, sw * 0.040),
                ),
                // if (hasTime)
                //   FittedBox(
                //               child: Text(
                //       token.endTime!,
                //       style: TextStyleConst.mediumTextStyle(Colors.white70, sw * 0.020),
                //               ),
                //             ),
                        ],
                      ),
          ),
          if (showIndicator)
            Positioned(
              bottom: indicatorBottom,
              child: Container(
                width: sw * 0.03,
                height: sw * 0.03,
                decoration:  BoxDecoration(
                  color: isActive
                      ? const Color(0xFFFFC107)
                      : const Color(0xEADF5F47),
                  shape: BoxShape.circle,
                ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildMyTokenCard(BuildContext context, TokenModel token, double sw, double sh) {
    bool hasTime = token.startTime != null;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: sw * 0.025,
        vertical: sh * 0.008,
      ),
            decoration: BoxDecoration(
        color: const Color(0xFF1B4332),
        borderRadius: BorderRadius.circular(sw * 0.025),
        border: Border.all(color: Colors.white24, width: 1),
            ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
              children: [
          Text(
            hasTime ? StringUtils.mySlot : StringUtils.myToken,
            style: TextStyleConst.mediumTextStyle(Colors.white70, sw * 0.025),
          ),
          Text(
            "${(token.label != null && token.label!.isNotEmpty) ? token.label : token.tokenNumber}",
            style: TextStyleConst.boldTextStyle(Colors.white, sw * 0.05),
          ),
          // if (hasTime)
          //   Text(
          //     token.startTime!,
          //     style: TextStyleConst.boldTextStyle(const Color(0xFFFFC107), sw * 0.029),
          //   ),
        ],
      ),
    );
  }
  Widget _buildConfirmedState(double sw, double sh) {
    return Row(
      children: [
        Icon(Icons.verified, color: const Color(0xFFFFC107), size: sw * 0.05),
        SizedBox(width: sw * 0.02),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text(
              StringUtils.appointmentConfirmed,
              style: TextStyleConst.boldTextStyle(Colors.white, sw * 0.028),
            ),
            Text(
              StringUtils.arriveOnTime,
              style: TextStyleConst.mediumTextStyle(Colors.white70, sw * 0.022),
              ),
            ],
          ),
      ],
    );
  }
}