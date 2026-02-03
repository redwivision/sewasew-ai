import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';
import '../core/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B05),
      appBar: AppBar(
        title: const Text('Sewasew Chat'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_outlined),
            onPressed: () {
               context.read<ChatProvider>().clear();
            },
          ),
        ],
      ),
      body: Column(
        children: [
           Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chat, _) {
                final messages = chat.messages;
                if (messages.isEmpty) {
                   return Center(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(Icons.auto_awesome, size: 60, color: Colors.white.withValues(alpha: 0.2)),
                         const SizedBox(height: 16),
                         Text(
                           'Start a new conversation', 
                           style: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                         ),
                       ],
                     ),
                   );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: messages.length + (chat.isTyping ? 1 : 0),
                  itemBuilder: (context, i) {
                    if (i < messages.length) {
                      final msg = messages[i];
                      return ChatBubble(text: msg.text, isUser: msg.isUser);
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sewasew is typing...',
                            style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic, fontSize: 12),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
          const ChatInput(),
        ],
      ),
    );
  }
}
