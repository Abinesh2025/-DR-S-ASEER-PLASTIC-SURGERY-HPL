// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/models/chat_message_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/services/chatbot_service.dart';
//
// class ChatbotController extends GetxController {
//   final ChatbotService _chatbotService = ChatbotService();
//
//   // Observable list of messages
//   var messages = <ChatMessageModel>[].obs;
//
//   // Typing indicator state
//   var isTyping = false.obs;
//
//   final TextEditingController textController = TextEditingController();
//   final ScrollController scrollController = ScrollController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Add an initial greeting message
//     messages.add(
//       ChatMessageModel(
//         text: "Hello! How can I assist you with your health today?",
//         isUser: false,
//         timestamp: DateTime.now(),
//       ),
//     );
//   }
//
//   void sendMessage(String text) async {
//     if (text.trim().isEmpty) return;
//
//     // Add user message
//     messages.add(
//       ChatMessageModel(
//         text: text,
//         isUser: true,
//         timestamp: DateTime.now(),
//       ),
//     );
//     textController.clear();
//     _scrollToBottom();
//
//     isTyping.value = true;
//
//     // Prepare conversation history for GPT
//     List<Map<String, String>> gptMessages = [];
//     // Add system prompt if needed: gptMessages.add({"role": "system", "content": "You are a helpful medical assistant bot."});
//     for (var msg in messages) {
//       gptMessages.add({
//         "role": msg.isUser ? "user" : "assistant",
//         "content": msg.text,
//       });
//     }
//
//     // Call API
//     String? response = await _chatbotService.sendMessageToGPT(gptMessages);
//
//     isTyping.value = false;
//
//     if (response != null && response.isNotEmpty) {
//       messages.add(
//         ChatMessageModel(
//           text: response,
//           isUser: false,
//           timestamp: DateTime.now(),
//         ),
//       );
//       _scrollToBottom();
//     }
//   }
//
//   void _scrollToBottom() {
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (scrollController.hasClients) {
//         scrollController.animateTo(
//           scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
// }
