import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/welcome_screen.dart';
import 'core/app_providers.dart';

void main() {
  runApp(const AppProviders(child: SewasewApp()));
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
        scaffoldBackgroundColor: const Color(0xFF050B05), // Ultra dark green/black
        primaryColor: const Color(0xFF00C853), // Emerald Green
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C853),
          brightness: Brightness.dark,
          surface: const Color(0xFF0E1A0E),
        ),
        useMaterial3: true,
        fontFamily: 'Sans', // Using system sans for now, or asset font if added
        
        // Premium Card Theme
        cardTheme: CardThemeData(
          color: const Color(0xFF0E1A0E),
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
            borderRadius: BorderRadius.circular(24),
          ),
        ),

        // Modern Input Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
        ),
        
        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00C853),
            foregroundColor: Colors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5
            ),
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
