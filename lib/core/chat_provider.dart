import 'dart:async';
import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import 'language_provider.dart';

/// Model for a single chat message.
class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

/// Chat provider for managing chat state and simulating AI replies.
class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  String? _error;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;
  String? get error => _error;

  /// Add a user message and trigger AI reply using AIService.
  Future<void> sendMessage(String text, AppLanguage lang) async {
    if (text.trim().isEmpty || _isTyping) return;
    _error = null;
    _messages.add(ChatMessage(text: text, isUser: true));
    notifyListeners();
    await _getAIReply(text, lang);
  }

  /// Calls AIService and handles loading, errors, and fallback.
  Future<void> _getAIReply(String userText, AppLanguage lang) async {
    _isTyping = true;
    notifyListeners();
    try {
      final langMode = _langToString(lang);
      final aiText = await AIService.sendMessage(userMessage: userText, langMode: langMode);
      _messages.add(ChatMessage(text: aiText, isUser: false));
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    }
    _isTyping = false;
    notifyListeners();
  }

  /// Converts AppLanguage to string for AIService.
  String _langToString(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.amharic:
        return 'am';
      case AppLanguage.english:
        return 'en';
      default:
        return 'both';
    }
  }

  /// Clear chat history (optional, for testing)
  void clear() {
    _messages.clear();
    _error = null;
    notifyListeners();
  }
}
