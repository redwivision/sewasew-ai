import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const SewasewApp());
}

class SewasewApp extends StatelessWidget {
  const SewasewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sewasew AI',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Sans',
      ),
      home: const WelcomeScreen(),
    );
  }
}


