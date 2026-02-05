import 'package:flutter/material.dart';
import '../widgets/language_tile.dart';
import 'package:provider/provider.dart';
import '../core/language_provider.dart';
import 'chat_screen.dart';



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late AppLanguage selectedLanguage;

  @override
  void initState() {
    super.initState();
    final lang = context.read<LanguageProvider>().language;
    selectedLanguage = lang;
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    selectedLanguage = langProvider.language;
    return Scaffold(
      backgroundColor: const Color(0xFF020202), // Infinite Black
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // App Icon
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D0D12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.psychology,
                  color: Color(0xFF7000FF), // Electric Violet
                  size: 40,
                ),
              ),

              const SizedBox(height: 24),

              // Amharic Title
              const Text(
                'የሚናገር እና የሚረዳ AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'AI that speaks your language',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 40),

              // Radar circles
              Stack(
                alignment: Alignment.center,
                children: [
                  _circle(260),
                  _circle(180),
                  _circle(100),
                  const Icon(Icons.public, color: Color(0xFF00E0FF)), // Neon Cyan
                ],
              ),

              const SizedBox(height: 40),


              // Section title
              const Text(
                'CHOOSE YOUR LANGUAGE / ቋንቋ ይምረጡ',
                style: TextStyle(
                  letterSpacing: 1.2,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 20),


              // Language options
              LanguageTile(
                label: 'አማርኛ (Amharic)',
                icon: Icons.language,
                isSelected: selectedLanguage == AppLanguage.amharic,
                onTap: () {
                  langProvider.setLanguage(AppLanguage.amharic);
                },
              ),
              LanguageTile(
                label: 'English',
                icon: Icons.public,
                isSelected: selectedLanguage == AppLanguage.english,
                onTap: () {
                  langProvider.setLanguage(AppLanguage.english);
                },
              ),
              LanguageTile(
                label: 'ሁለቱም (Both)',
                icon: Icons.translate,
                isSelected: selectedLanguage == AppLanguage.both,
                onTap: () {
                  langProvider.setLanguage(AppLanguage.both);
                },
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7000FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _circle(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.green.withOpacity(0.2),
        ),
      ),
    );
  }
}
