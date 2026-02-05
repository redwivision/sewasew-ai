import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020202), // Infinite Black
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
                      title: 'API Configuration',
                      children: [
                         _ApiKeyTile(),
                         _ModelTile(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _SettingsSection(
                      title: 'Language',
                      children: [
                        _SettingsTile(
                          title: 'App Language',
                          subtitle: 'English',
                          icon: Icons.language,
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
            color: Color(0xFF7000FF), // Electric Violet
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
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00E0FF)), // Neon Cyan
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

class _ApiKeyTile extends StatefulWidget {
  @override
  State<_ApiKeyTile> createState() => _ApiKeyTileState();
}

class _ApiKeyTileState extends State<_ApiKeyTile> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _showEditDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF12121A),
        title: const Text('Enter Groq API Key', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Paste your Groq key (gsk_...)',
            hintStyle: TextStyle(color: Colors.white30),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
          ),
        ),
        actions: [
          TextButton(
             onPressed: () => Navigator.pop(context),
             child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
             onPressed: () {
               if (_controller.text.isNotEmpty) {
                 AIService.setApiKey(_controller.text);
               }
               Navigator.pop(context);
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Groq API Key Saved!')),
               );
             },
             child: const Text('Save', style: TextStyle(color: Color(0xFF00E0FF))), // Neon Cyan
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.key, color: Color(0xFF00E0FF)), // Neon Cyan
        title: const Text(
          'Groq API Key',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          'Tap to configure',
          style: TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.edit, color: Colors.white54),
        onTap: _showEditDialog,
      ),
    );
  }
}

class _ModelTile extends StatefulWidget {
  @override
  State<_ModelTile> createState() => _ModelTileState();
}

class _ModelTileState extends State<_ModelTile> {
  String _modelName = 'Loading...';
  bool _detecting = false;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      final m = await AIService.autoDetectModel(); 
      if (mounted) setState(() => _modelName = m);
    } catch (e) {
      if (mounted) setState(() => _modelName = 'Error detecting');
    }
  }

  Future<void> _showModelSelector() async {
    setState(() => _detecting = true);
    try {
      final models = await AIService.listModels();
      if (!mounted) return;
      
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF12121A),
          title: const Text('Select Groq Model', style: TextStyle(color: Colors.white)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: models.length,
              itemBuilder: (context, i) {
                final m = models[i]['id'] as String;
                final isCurrent = m == _modelName;
                return ListTile(
                  title: Text(
                    m,
                    style: TextStyle(
                      color: isCurrent ? const Color(0xFF00E0FF) : Colors.white,
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: isCurrent ? const Icon(Icons.check, color: Color(0xFF00E0FF)) : null,
                  onTap: () {
                    AIService.setSelectedModel(m);
                    Navigator.pop(context);
                    _loadModel();
                  },
                );
              },
            ),
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error listing models: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _detecting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.smart_toy, color: Color(0xFF00E0FF)), // Neon Cyan
        title: const Text(
          'Active Groq Model',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          _modelName,
          style: const TextStyle(color: Colors.white70),
        ),
        onTap: _detecting ? null : _showModelSelector,
        trailing: _detecting 
          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
          : const Icon(Icons.edit, color: Colors.white54, size: 20),
      ),
    );
  }
}