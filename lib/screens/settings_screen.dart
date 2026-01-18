import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
              // Header
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Settings list
              Expanded(
                child: ListView(
                  children: [
                    _SettingsSection(
                      title: 'Language',
                      children: [
                        _SettingsTile(
                          title: 'App Language',
                          subtitle: 'English',
                          icon: Icons.language,
                          onTap: () {},
                        ),
                        _SettingsTile(
                          title: 'Translation Language',
                          subtitle: 'Amharic ↔ English',
                          icon: Icons.translate,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _SettingsSection(
                      title: 'Appearance',
                      children: [
                        _SettingsTile(
                          title: 'Theme',
                          subtitle: 'Dark Green',
                          icon: Icons.palette,
                          onTap: () {},
                        ),
                        _SettingsTile(
                          title: 'Font Size',
                          subtitle: 'Medium',
                          icon: Icons.text_fields,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _SettingsSection(
                      title: 'About',
                      children: [
                        _SettingsTile(
                          title: 'Version',
                          subtitle: '1.0.0',
                          icon: Icons.info,
                          onTap: () {},
                        ),
                        _SettingsTile(
                          title: 'Privacy Policy',
                          subtitle: 'Learn about data usage',
                          icon: Icons.privacy_tip,
                          onTap: () {},
                        ),
                        _SettingsTile(
                          title: 'Terms of Service',
                          subtitle: 'Read our terms',
                          icon: Icons.description,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.greenAccent),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white54),
        onTap: onTap,
      ),
    );
  }
}