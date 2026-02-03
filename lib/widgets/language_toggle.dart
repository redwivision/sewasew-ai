import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/language_provider.dart';


class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>().language;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _LangChip(
            label: 'Amharic',
            active: lang == AppLanguage.amharic,
            onTap: () => context.read<LanguageProvider>().setLanguage(AppLanguage.amharic),
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz, color: Colors.white54),
            onPressed: () {
              final provider = context.read<LanguageProvider>();
              if (lang == AppLanguage.amharic) {
                provider.setLanguage(AppLanguage.english);
              } else if (lang == AppLanguage.english) {
                provider.setLanguage(AppLanguage.both);
              } else {
                provider.setLanguage(AppLanguage.amharic);
              }
            },
            tooltip: 'Switch Language',
          ),
          _LangChip(
            label: 'English',
            active: lang == AppLanguage.english,
            onTap: () => context.read<LanguageProvider>().setLanguage(AppLanguage.english),
          ),
          _LangChip(
            label: 'Both',
            active: lang == AppLanguage.both,
            onTap: () => context.read<LanguageProvider>().setLanguage(AppLanguage.both),
          ),
        ],
      ),
    );
  }
}


class _LangChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _LangChip({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.green.withOpacity(0.3) : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
