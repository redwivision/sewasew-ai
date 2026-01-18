import 'package:flutter/material.dart';
import '../widgets/progress_card.dart';
import '../widgets/feature_card.dart';
import '../widgets/recent_tile.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1A0E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Header(),
              SizedBox(height: 20),
              _Greeting(),
              SizedBox(height: 20),
              ProgressCard(),
              SizedBox(height: 24),
              _FeatureGrid(),
              SizedBox(height: 24),
              _RecentSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.school, color: Colors.greenAccent),
        Spacer(),
        Text(
          'Sewasew AI',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(Icons.person, color: Colors.white),
      ],
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'ትምህርትዎን እንቀጥል?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'ዛሬ ምን መማር ትፈልጋለህ?',
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: const [
        FeatureCard(
          title: 'ጽሑፍ ማስተካከያ',
          icon: Icons.edit,
          color: Colors.green,
        ),
        FeatureCard(
          title: 'ትርጉም',
          icon: Icons.translate,
          color: Colors.orange,
        ),
        FeatureCard(
          title: 'ሰዋሰው',
          icon: Icons.rule,
          color: Colors.blueGrey,
        ),
        FeatureCard(
          title: 'AI ያነጋግሩ',
          icon: Icons.chat,
          color: Colors.greenAccent,
        ),
      ],
    );
  }
}

class _RecentSection extends StatelessWidget {
  const _RecentSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('የቀጠለ ክፍሎች',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        RecentTile(title: 'የአማርኛ ትርጉም', icon: Icons.translate),
        RecentTile(title: 'ጽሑፍ ማስተካከያ', icon: Icons.edit),
      ],
    );
  }
}



