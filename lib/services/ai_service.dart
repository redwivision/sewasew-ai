import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// AIService handles all AI chat API logic and fallback.
/// Updated to support Groq API for better reliability and performance.
class AIService {
  static const String _defaultKey = '';
  static const String _prefKey = 'groq_api_key'; // Changed key to differentiate
  static const String _modelPrefKey = 'selected_model_groq';
  static const String _defaultModel = 'llama3-8b-8192';
  
  static const String _baseUrl = 'https://api.groq.com/openai/v1/chat/completions';

  /// Sends a message to the AI and returns the response.
  static Future<String> sendMessage({
    required String userMessage,
    required String langMode,
  }) async {
    final apiKey = await _getApiKey();
    final model = await _getSelectedModel();
    
    if (apiKey.isEmpty) {
      return _mockResponse(userMessage, langMode);
    }

    try {
      final prompt = _buildPrompt(userMessage, langMode);
      
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': model,
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['choices']?[0]?['message']?['content'];
        if (text is String && text.trim().isNotEmpty) {
          return text.trim();
        } else {
          throw Exception('Empty AI response');
        }
      } else {
        final error = jsonDecode(response.body)['error']?['message'] ?? 'Unknown error';
        throw Exception('API Error (${response.statusCode}): $error');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Tries to find the best available model for the current Groq API key.
  static Future<String> autoDetectModel() async {
    try {
      final models = await listModels();
      if (models.isEmpty) return _defaultModel;

      // Priority list for Groq
      final priorities = [
        'llama3-70b-8192',
        'llama3-8b-8192',
        'mixtral-8x7b-32768',
        'gemma-7b-it',
      ];

      for (var p in priorities) {
        if (models.any((m) => m['id'] == p)) {
          await setSelectedModel(p);
          return p;
        }
      }

      final first = models.first['id'];
      await setSelectedModel(first);
      return first;
    } catch (e) {
      return _defaultModel;
    }
  }

  /// Fetches a list of available Groq models.
  static Future<List<dynamic>> listModels() async {
    final apiKey = await _getApiKey();
    if (apiKey.isEmpty) throw Exception('API Key is missing');

    final response = await http.get(
      Uri.parse('https://api.groq.com/openai/v1/models'),
      headers: {'Authorization': 'Bearer $apiKey'},
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to list models (${response.statusCode}): ${response.body}');
    }
  }

  static Future<String> _getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefKey) ?? _defaultKey;
  }
  
  static Future<void> setApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, key.trim());
    await autoDetectModel();
  }

  static Future<String> _getSelectedModel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_modelPrefKey) ?? _defaultModel;
  }

  static Future<void> setSelectedModel(String model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modelPrefKey, model);
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
    return 'Demo Mode (No API Key). Go to Settings to add your Groq API Key.\n\nSimulated reply to: "$userMessage"';
  }
}
