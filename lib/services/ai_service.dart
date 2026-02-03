import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// AIService handles all AI chat API logic and fallback.
/// Supports Gemini API (free tier) and mock responses if no key is set.
class AIService {
  static const String _defaultKey = ''; // Intentionally empty to force user input or mock
  static const String _prefKey = 'gemini_api_key';
  
  // Using gemini-1.5-flash for better speed/cost/limits
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=';

  /// Sends a message to the AI and returns the response.
  static Future<String> sendMessage({
    required String userMessage,
    required String langMode,
  }) async {
    final apiKey = await _getApiKey();
    
    if (apiKey.isEmpty) {
      return _mockResponse(userMessage, langMode);
    }

    try {
      final prompt = _buildPrompt(userMessage, langMode);
      final response = await http.post(
        Uri.parse(_baseUrl + apiKey),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        if (text is String && text.trim().isNotEmpty) {
          return text.trim();
        } else {
          throw Exception('Empty AI response');
        }
      } else {
        // Detailed error for debugging
        final error = jsonDecode(response.body)['error']?['message'] ?? 'Unknown error';
        throw Exception('API Error (${response.statusCode}): $error');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (e) {
      // If unauthorized, maybe prompt user? For now just throw.
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  static Future<String> _getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefKey) ?? _defaultKey;
  }
  
  /// Save a new API key
  static Future<void> setApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, key.trim());
  }

  static String _buildPrompt(String userMessage, String langMode) {
    switch (langMode) {
      case 'am':
        return 'You are an Amharic AI assistant. Reply in Amharic. User: $userMessage';
      case 'en':
        return 'You are an English AI assistant. Reply in English. User: $userMessage';
      default:
        return 'You are a bilingual AI assistant. Reply in the language of the question (Amharic or English). User: $userMessage';
    }
  }

  static String _mockResponse(String userMessage, String langMode) {
    if (userMessage.trim().isEmpty) return '';
    return 'Demo Mode (No API Key). Go to Settings to add your Gemini Key.\n\nSimulated reply to: "$userMessage"';
  }
}
