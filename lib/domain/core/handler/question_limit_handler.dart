import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/data/model/message/message_model.dart';


class ConversationStorage {
  static const String keyMessages = 'messages';

  static Future<void> saveMessages(List<Message> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = messages.map((m) => m.toJson()).toList();
    await prefs.setString(keyMessages, jsonEncode(jsonList));
  }

  static Future<List<Message>> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(keyMessages);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => Message.fromJson(e)).toList();
    }
    return [];
  }

  static Future<void> clearMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyMessages);
  }
}

class QuestionLimiter {
  static const String keyDate = 'lastDate';
  static const String keyCount = 'questionCount';
  static const int dailyLimit = 10;

  static Future<bool> canAskQuestion() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastDate = prefs.getString(keyDate) ?? '';
    int count = prefs.getInt(keyCount) ?? 0;

    if (lastDate != today) {
      // New day → reset count
      await prefs.setString(keyDate, today);
      await prefs.setInt(keyCount, 0);
      // Also clear conversation for new day
      await ConversationStorage.clearMessages();
      count = 0;
    }

    return count < dailyLimit;
  }

  static Future<void> incrementCount() async {
    final prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt(keyCount) ?? 0;
    count++;
    await prefs.setInt(keyCount, count);
  }

  static Future<int> getRemaining() async {
    final prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt(keyCount) ?? 0;
    return dailyLimit - count;
  }
}
