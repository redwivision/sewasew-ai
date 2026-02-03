import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for simple local progress tracking.
class ProgressService extends ChangeNotifier {
  static const _key = 'lesson_progress';
  Map<String, double> _progress = {};

  Map<String, double> get progress => _progress;

  ProgressService() {
    _load();
  }

  /// Get progress for a lesson (0.0–1.0)
  double getProgress(String lessonId) => _progress[lessonId] ?? 0.0;

  /// Set progress for a lesson and persist.
  Future<void> setProgress(String lessonId, double value) async {
    _progress[lessonId] = value.clamp(0.0, 1.0);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _progress.entries.map((e) => '${e.key}:${e.value}').join(','));
  }

  /// Load progress from SharedPreferences.
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null && raw.isNotEmpty) {
      _progress = {
        for (final entry in raw.split(','))
          if (entry.contains(':'))
            entry.split(':')[0]: double.tryParse(entry.split(':')[1]) ?? 0.0
      };
      notifyListeners();
    }
  }
}
