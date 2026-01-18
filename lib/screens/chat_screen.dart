import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';
import '../widgets/language_toggle.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1A0E),
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            const SizedBox(height: 12),
            const LanguageToggle(),
            const SizedBox(height: 12),
            const _DayDivider(),
            const SizedBox(height: 12),

            // Chat messages
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  ChatBubble(
                    text: 'ሰላም! እንዴት ልረዳዎት?',
                    isUser: false,
                  ),
                  ChatBubble(
                    text: 'ስለ ሰላም ወይስ ስለ ሌላ ጉዳይ?',
                    isUser: true,
                  ),
                ],
              ),
            ),

            ChatInput(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.auto_awesome, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Sewasew AI',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text('● GENERAL CHAT',
                  style: TextStyle(
                      fontSize: 12, color: Colors.greenAccent)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.settings, color: Colors.white),
        ],
      ),
    );
  }
}

class _DayDivider extends StatelessWidget {
  const _DayDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'TODAY',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}

