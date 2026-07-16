// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/chatbot_controller.dart';
// import 'package:intl/intl.dart';
//
// class ChatBotScreen extends StatelessWidget {
//   const ChatBotScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Initialize controller
//     final ChatbotController controller = Get.put(ChatbotController());
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6FA), // Light greyish background from design
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: AppBar(
//           backgroundColor: const Color(0xFF425BF5), // Blue background
//           elevation: 0,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 15.0),
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Image.asset(
//                 'assets/images/bot_avatar.png', // Placeholder, use icon if asset missing
//                 errorBuilder: (context, error, stackTrace) =>
//                     const Icon(Icons.smart_toy, color: Color(0xFF425BF5)),
//               ),
//             ),
//           ),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "AI",
//                 style: TextStyleConst.boldTextStyle(Colors.white, 20),
//               ),
//               Row(
//                 children: [
//                   Container(
//                     width: 8,
//                     height: 8,
//                     decoration: const BoxDecoration(
//                       color: Colors.greenAccent,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   Text(
//                     "Online",
//                     style: TextStyleConst.mediumTextStyle(Colors.greenAccent, 12),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
//               onPressed: () => Get.back(),
//             ),
//             const SizedBox(width: 10),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           // Chat List
//           Expanded(
//             child: Obx(
//               () => ListView.builder(
//                 controller: controller.scrollController,
//                 padding: const EdgeInsets.all(15),
//                 itemCount: controller.messages.length,
//                 itemBuilder: (context, index) {
//                   final message = controller.messages[index];
//                   bool isUser = message.isUser;
//                   String time = DateFormat('jm').format(message.timestamp);
//
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 15.0),
//                     child: Row(
//                       mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         if (!isUser) ...[
//                           const CircleAvatar(
//                             radius: 16,
//                             backgroundColor: Color(0xFF6B21A8), // Bot purple avatar color
//                             child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
//                           ),
//                           const SizedBox(width: 10),
//                         ],
//                         // Message Bubble
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                                 decoration: BoxDecoration(
//                                   color: isUser ? const Color(0xFF4A148C) : const Color(0xFFE2E2E2),
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: const Radius.circular(15),
//                                     topRight: const Radius.circular(15),
//                                     bottomLeft: isUser ? const Radius.circular(15) : const Radius.circular(0),
//                                     bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(15),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   message.text,
//                                   style: TextStyleConst.mediumTextStyle(
//                                       isUser ? Colors.white : Colors.black87, 14),
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               // Timestamp and checks
//                               Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     time,
//                                     style: TextStyleConst.mediumTextStyle(Colors.grey, 10),
//                                   ),
//                                   if (isUser) ...[
//                                     const SizedBox(width: 4),
//                                     const Icon(Icons.done_all, color: Colors.purpleAccent, size: 14),
//                                   ],
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         if (isUser) ...[
//                           const SizedBox(width: 10),
//                           const CircleAvatar(
//                             radius: 16,
//                             backgroundColor: Colors.blueAccent,
//                             child: Icon(Icons.person, color: Colors.white, size: 20),
//                           ),
//                         ],
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//
//           // Typing Indicator
//           Obx(() {
//             if (controller.isTyping.value) {
//               return const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text("Typing...", style: TextStyle(color: Colors.grey, fontSize: 12)),
//                 ),
//               );
//             }
//             return const SizedBox.shrink();
//           }),
//
//           // Bottom Input Area
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 10,
//                   offset: Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Quick suggestion chips
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       _buildChip("🤔 Doctor healix ?", controller),
//                       const SizedBox(width: 10),
//                       _buildChip("💰 Pricing", controller),
//                       const SizedBox(width: 10),
//                       _buildChip("🙋 FAQs", controller),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 // Text Field Container
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF1F3F4), // Light grey input box
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: controller.textController,
//                           decoration: const InputDecoration(
//                             hintText: "Type your message here...",
//                             hintStyle: TextStyle(color: Colors.grey),
//                             border: InputBorder.none,
//                           ),
//                           onSubmitted: (val) {
//                             controller.sendMessage(val);
//                           },
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.send_outlined, color: Color(0xFF425BF5)),
//                         onPressed: () {
//                           controller.sendMessage(controller.textController.text);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildChip(String label, ChatbotController controller) {
//     return ActionChip(
//       label: Text(
//         label,
//         style: TextStyleConst.mediumTextStyle(Colors.black87, 12),
//       ),
//       backgroundColor: const Color(0xFFF1F3F4),
//       side: BorderSide.none,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       onPressed: () {
//         controller.sendMessage(label);
//       },
//     );
//   }
// }
