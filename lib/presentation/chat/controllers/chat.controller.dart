import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../domain/core/handler/question_limit_handler.dart';
import '../../../domain/core/static_data/static_data.dart';
import '../../../infrastructure/data/model/message/message_model.dart';

class ChatController extends GetxController {
  final count = 0.obs;
  final isLoading = false.obs;
  final isMessageLoading = false.obs;
  final messages = <Message>[].obs;
  final TextEditingController inputController = TextEditingController();
  final remainingQuestions = 10.obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadMessages();
    await updateRemainingQuestions();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> _loadMessages() async {
    final saved = await ConversationStorage.loadMessages();
    messages.addAll(saved);
  }

  Future<String> askAI(String userQuestion) async {
    isLoading.value = true;
    try {
      final url =
          Uri.parse('https://router.huggingface.co/v1/chat/completions');

      final body = jsonEncode({
        "model": MODEL,
        "messages": [
          {"role": "user", "content": userQuestion}
        ],
        // you can add optional parameters, e.g. max_tokens, temperature etc.
      });

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $HUGGINGFACE_API_KEY',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // OpenAI-style response => depends on provider
        debugPrint("askAI Response: ${response.body}");
        debugPrint("askAI Response Finish");
        return data["choices"][0]["message"]["content"] ?? "No reply";
      } else {
        isLoading.value = false;
        return "API Error: ${response.statusCode} — ${response.body}";
      }
    } catch (e) {
      isLoading.value = false;
      return "Something went wrong: $e";
    }
  }

  Future<void> sendMessage(String text) async {
    await updateRemainingQuestions();
    bool allowed = await QuestionLimiter.canAskQuestion();
    if (!allowed) {
      final limitMessage = Message(
        text: "Daily limit reached. You can ask only 10 questions/day.",
        isUser: false,
      );
      messages.add(limitMessage);
      await ConversationStorage.saveMessages(messages);
      return;
    }

    // Add user message
    final userMessage = Message(text: text, isUser: true);
    messages.add(userMessage);
    await QuestionLimiter.incrementCount();
    await updateRemainingQuestions();
    await ConversationStorage.saveMessages(messages);

    // Call AI
    try {
      final response = await askAI(text);
      final aiMessage = Message(text: response, isUser: false);
      messages.add(aiMessage);
      await ConversationStorage.saveMessages(messages);
    } catch (e) {
      final errorMessage = Message(
        text: "Error getting response: $e",
        isUser: false,
      );
      messages.add(errorMessage);
      await ConversationStorage.saveMessages(messages);
    }
  }

  Future<void> updateRemainingQuestions() async {
    final remaining = await QuestionLimiter.getRemaining();
    if (remainingQuestions.value != remaining) {
      remainingQuestions.value = remaining;
    }
  }
}
