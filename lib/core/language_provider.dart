import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Enum for supported languages.
enum AppLanguage { amharic, english, both }

/// Provider for app-wide language state and persistence.
class LanguageProvider extends ChangeNotifier {
  static const _key = 'selected_language';
  AppLanguage _language = AppLanguage.amharic;

  AppLanguage get language => _language;

  LanguageProvider() {
    _loadLanguage();
  }

  /// Set language and persist to SharedPreferences.
  Future<void> setLanguage(AppLanguage lang) async {
    _language = lang;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, lang.index);
  }

  /// Load language from SharedPreferences.
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final idx = prefs.getInt(_key);
    if (idx != null && idx >= 0 && idx < AppLanguage.values.length) {
      _language = AppLanguage.values[idx];
      notifyListeners();
    }
  }
}
