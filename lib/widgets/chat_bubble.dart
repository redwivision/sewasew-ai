import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../services/voice_service.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({
    required this.text,
    required this.isUser,
    super.key,
  });

  bool _isAmharic(String text) {
    // Basic regex for Ethiopic characters (U+1200 to U+137F)
    return RegExp(r'[\u1200-\u137F]').hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    // Premium Gradients
    final gradient = isUser
        ? const LinearGradient(
            colors: [Color(0xFF7000FF), Color(0xFF00E0FF)], // Violet to Cyan
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.08),
              Colors.white.withValues(alpha: 0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(4),
      bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(20),
    );

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
          boxShadow: isUser
              ? [
                  BoxShadow(
                    color: const Color(0xFF7000FF).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isUser) const SizedBox(height: 12), // Gap for the icon
                isUser
                    ? Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      )
                    : MarkdownBody(
                        data: text,
                        styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
                          strong: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          code: const TextStyle(
                            backgroundColor: Colors.black26, 
                            color: Color(0xFF00E0FF), // Neon Cyan
                            fontFamily: 'Courier',
                          ),
                          codeblockDecoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
              ],
            ),
            Positioned(
              top: -8,
              right: -8,
              child: IconButton(
                onPressed: () => VoiceService.speak(
                  text, 
                  langCode: _isAmharic(text) ? 'am-ET' : 'en-US'
                ),
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: const Icon(Icons.volume_up, color: Color(0xFF00E0FF), size: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
