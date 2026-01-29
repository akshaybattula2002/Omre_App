import 'package:flutter/material.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Scores')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildScoreCard('Cricket', 'IND vs AUS', 'IND 280/4 (45.2)', 'AUS Yet to Bat', true),
          _buildScoreCard('Football', 'Real Madrid vs Barcelona', '2 - 1', 'Full Time', false),
          _buildScoreCard('Tennis', 'Alcaraz vs Djokovic', '6-4, 5-7, 6-6', 'Set 3 Tie Break', true),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String sport, String match, String score, String status, bool isLive) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(sport, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                if (isLive) 
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                    child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  )
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(match, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(score, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 8),
            Text(status, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
