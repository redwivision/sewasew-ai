import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';

/// VoiceService handles all Text-to-Speech logic.
/// Supports English and Amharic (depending on device TTS engine).
class VoiceService {
  static final FlutterTts _tts = FlutterTts();
  static bool _isInitialized = false;

  static Future<void> _init() async {
    if (_isInitialized) return;
    
    await _tts.setVolume(1.0);
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);
    
    _isInitialized = true;
  }

  /// Speaks the provided [text].
  /// [langCode] can be 'en-US' or 'am-ET'.
  static Future<void> speak(String text, {String langCode = 'en-US'}) async {
    await _init();
    
    // Simple language detection/override if needed
    // Note: Amharic support depends on the user's phone having the data installed.
    await _tts.setLanguage(langCode);
    
    if (text.isNotEmpty) {
      await _tts.speak(text);
    }
  }

  static Future<void> stop() async {
    await _tts.stop();
  }

  /// Checks if Amharic is supported on this device's TTS engine.
  static Future<bool> isAmharicSupported() async {
    if (Platform.isIOS) return true; // iOS usually has it bundled
    
    final languages = await _tts.getLanguages;
    return languages.contains('am-ET') || languages.contains('am');
  }
}
