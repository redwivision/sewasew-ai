import 'package:flutter/material.dart';

/// Simple translation/localization helper for Amharic/English/Both.
class AppLocalizations {
  final Locale locale;
  final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'get_started': 'Get Started',
      'chat_hint': 'Type a message...',
      'typing': 'Typing...',
      'send': 'Send',
      'translate': 'Translate',
      'study': 'Study',
      'settings': 'Settings',
      'home': 'Home',
      'today': 'TODAY',
      'progress': 'Progress',
      'lesson': 'Lesson',
      'dummy_lesson': 'This is a dummy lesson content.',
      'select_language': 'Select Language',
    },
    'am': {
      'get_started': 'ጀምር',
      'chat_hint': 'መልእክት ይፃፉ...',
      'typing': 'በመጻፍ ላይ...',
      'send': 'ላክ',
      'translate': 'ትርጉም',
      'study': 'ትምህርት',
      'settings': 'ቅንብሮች',
      'home': 'መነሻ',
      'today': 'ዛሬ',
      'progress': 'እድገት',
      'lesson': 'ትምህርት',
      'dummy_lesson': 'ይህ የሙከራ ትምህርት ይዘት ነው።',
      'select_language': 'ቋንቋ ይምረጡ',
    },
    'both': {
      'get_started': 'Get Started / ጀምር',
      'chat_hint': 'Type a message... / መልእክት ይፃፉ...',
      'typing': 'Typing... / በመጻፍ ላይ...',
      'send': 'Send / ላክ',
      'translate': 'Translate / ትርጉም',
      'study': 'Study / ትምህርት',
      'settings': 'Settings / ቅንብሮች',
      'home': 'Home / መነሻ',
      'today': 'TODAY / ዛሬ',
      'progress': 'Progress / እድገት',
      'lesson': 'Lesson / ትምህርት',
      'dummy_lesson': 'This is a dummy lesson content. / ይህ የሙከራ ትምህርት ይዘት ነው።',
      'select_language': 'Select Language / ቋንቋ ይምረጡ',
    },
  };

  AppLocalizations(this.locale);

  String text(String key, String langCode) {
    return _localizedValues[langCode]?[key] ?? key;
  }
}
