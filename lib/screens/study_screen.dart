import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/chat_provider.dart';
import '../core/language_provider.dart';
import '../core/main_home.dart'; // import MainHome to switch tabs

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  final List<Map<String, dynamic>> _scenarios = const [
    {
      'title': 'Explain Grammar',
      'icon': Icons.menu_book,
      'color': Colors.blueAccent,
      'prompt': 'Teach me a basic Amharic grammar rule with examples.',
    },
    {
      'title': 'Vocabulary Quiz',
      'icon': Icons.quiz,
      'color': Colors.orangeAccent,
      'prompt': 'Quiz me on 5 common Amharic words. Ask one by one.',
    },
    {
      'title': 'Translate This',
      'icon': Icons.translate,
      'color': Colors.purpleAccent,
      'prompt': 'Give me a short English paragraph and help me translate it to Amharic.',
    },
    {
      'title': 'Roleplay: Market',
      'icon': Icons.store,
      'color': Colors.greenAccent,
      'prompt': 'Let\'s roleplay. You are a shopkeeper in Addis Ababa, and I am a customer. Start the conversation in Amharic.',
    },
    {
      'title': 'Daily Phrase',
      'icon': Icons.today,
      'color': Colors.tealAccent,
      'prompt': 'Teach me a useful Amharic phrase for daily life and explain when to use it.',
    },
    {
      'title': 'Debug Code',
      'icon': Icons.code,
      'color': Colors.redAccent,
      'prompt': 'I have a Flutter issue. Can you help me debug it?',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1A0E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AI Practice',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose a scenario to start practicing with AI.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: _scenarios.length,
                  itemBuilder: (context, index) {
                    final item = _scenarios[index];
                    return _ScenarioCard(
                      title: item['title'] as String,
                      icon: item['icon'] as IconData,
                      color: item['color'] as Color,
                      prompt: item['prompt'] as String,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String prompt;

  const _ScenarioCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.prompt,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 1. Get providers
        final chatProvider = context.read<ChatProvider>();
        final langProvider = context.read<LanguageProvider>();
        
        // 2. Send message
        chatProvider.sendMessage(prompt, langProvider.language);
        
        // 3. Switch to Chat Tab (Index 1)
        final homeState = context.findAncestorStateOfType<MainHomeState>();
        if (homeState != null) {
           homeState.switchTab(1); // 1 = Chat
        } else {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Starting scenario in Chat...')),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}