import 'package:flutter/material.dart';
import '../core/main_home.dart';
import '../widgets/language_tile.dart';



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String selectedLanguage = 'am';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1A0E),
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
                  color: const Color(0xFF121212),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.psychology,
                  color: Colors.greenAccent,
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

              // Fake radar circles (simple)
              Stack(
                alignment: Alignment.center,
                children: [
                  _circle(260),
                  _circle(180),
                  _circle(100),
                  const Icon(Icons.public, color: Colors.greenAccent),
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
                isSelected: selectedLanguage == 'am',
                onTap: () => setState(() => selectedLanguage = 'am'),
              ),

              LanguageTile(
                label: 'English',
                icon: Icons.public,
                isSelected: selectedLanguage == 'en',
                onTap: () => setState(() => selectedLanguage = 'en'),
              ),

              LanguageTile(
                label: 'ሁለቱም (Both)',
                icon: Icons.translate,
                isSelected: selectedLanguage == 'both',
                onTap: () => setState(() => selectedLanguage = 'both'),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
onPressed: () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => MainHome(),
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

  Widget languageTile({
    required String code,
    required String label,
    required IconData icon,
  }) {
    final bool isSelected = selectedLanguage == code;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = code;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green.withOpacity(0.15)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.greenAccent : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black26,
              child: Icon(icon, color: Colors.greenAccent),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.greenAccent)
            else
              const Icon(Icons.radio_button_unchecked,
                  color: Colors.white38),
          ],
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
