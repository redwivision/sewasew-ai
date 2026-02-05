import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../core/chat_provider.dart';
import '../core/language_provider.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController controller = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _sending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    try {
      await _speech.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('Speech init error: $e');
    }
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => debugPrint('onStatus: $val'),
        onError: (val) => debugPrint('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            controller.text = val.recognizedWords;
          }),
          localeId: context.read<LanguageProvider>().language == AppLanguage.amharic ? 'am_ET' : 'en_US',
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _send() async {
    final text = controller.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    final chat = context.read<ChatProvider>();
    final lang = context.read<LanguageProvider>().language;
    
    // Pass a flag if it was sent via voice to trigger auto-speak (logic in provider/bubble)
    await chat.sendMessage(text, lang);
    
    if (chat.error != null) {
      if (mounted) setState(() => _error = chat.error);
    } else {
      controller.clear();
    }
    if (mounted) setState(() => _sending = false);
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatProvider>();
    final isBusy = _sending || chat.isTyping;
    
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF020202), // Infinite Black
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Column(
        children: [
          if (_error != null)
            Padding(
               padding: const EdgeInsets.only(bottom: 8),
               child: Text('Error: $_error', style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
            ),
          Row(
            children: [
              IconButton(
                onPressed: isBusy ? null : _listen,
                icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: _isListening ? const Color(0xFF00E0FF) : Colors.white54,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onSubmitted: (_) => _send(),
                  enabled: !isBusy,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: _isListening ? 'Listening...' : 'Message Sewasew AI...',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7000FF), Color(0xFF00E0FF)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7000FF).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: IconButton(
                  onPressed: isBusy ? null : _send,
                  icon: isBusy 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.arrow_upward_rounded, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
