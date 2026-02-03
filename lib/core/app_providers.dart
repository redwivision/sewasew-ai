import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_provider.dart';
import 'language_provider.dart';
import 'progress_service.dart';

/// App-level providers for state management.
class AppProviders extends StatelessWidget {
  final Widget child;
  const AppProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ProgressService()),
      ],
      child: child,
    );
  }
}
