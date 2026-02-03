import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/ai_service.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _output = '';
  bool _loading = false;
  String _sourceLang = 'English';
  String _targetLang = 'Amharic';

  void _translate() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      _loading = true;
      _output = '';
    });

    try {
      // Prompt engineering for translation
      final prompt = 'Translate the following $_sourceLang text to $_targetLang. Only provide the translation, no explanation.\n\nText: "$text"';
      
      // Use "both" mode to allow mixed context if needed, but the prompt guides it.
      final result = await AIService.sendMessage(userMessage: prompt, langMode: 'both');
      
      if (mounted) {
        setState(() {
          _output = result;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _output = 'Error: ${e.toString().replaceAll("Exception:", "")}';
          _loading = false;
        });
      }
    }
  }

  void _swapLanguages() {
    setState(() {
      final temp = _sourceLang;
      _sourceLang = _targetLang;
      _targetLang = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B05),
      appBar: AppBar(
        title: const Text('AI Translator'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Language Selector
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _LanguageChip(label: _sourceLang, isSource: true),
                    IconButton(
                      onPressed: _swapLanguages, 
                      icon: const Icon(Icons.swap_horiz, color: Colors.greenAccent)
                    ),
                    _LanguageChip(label: _targetLang, isSource: false),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Input Area
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _sourceLang, 
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12)
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: TextField(
                          controller: _inputController,
                          maxLines: null,
                          expands: true,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter text to translate...',
                            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                            border: InputBorder.none,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      if (_inputController.text.isNotEmpty)
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white54),
                            onPressed: () => setState(() => _inputController.clear()),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Translate Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _translate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C853),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 8,
                    shadowColor: const Color(0xFF00C853).withValues(alpha: 0.4),
                  ),
                  child: _loading 
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('TRANSLATE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                ),
              ),

              const SizedBox(height: 16),

              // Output Area
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C853).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFF00C853).withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _targetLang, 
                            style: const TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold)
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy, size: 20, color: Colors.greenAccent),
                            onPressed: () {
                              if (_output.isNotEmpty) {
                                Clipboard.setData(ClipboardData(text: _output));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Copied to clipboard')),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          child: SelectableText(
                            _output.isEmpty ? 'Translation will appear here...' : _output,
                            style: TextStyle(
                              fontSize: 20,
                              color: _output.isEmpty ? Colors.white.withValues(alpha: 0.3) : Colors.white,
                              height: 1.5,
                              fontWeight: _output.isEmpty ? FontWeight.normal : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  final String label;
  final bool isSource;

  const _LanguageChip({required this.label, required this.isSource});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSource ? Colors.transparent : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSource ? Colors.white70 : Colors.greenAccent,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}