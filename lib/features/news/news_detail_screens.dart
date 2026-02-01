import 'package:flutter/material.dart';
import '../../core/theme/palette.dart';
import 'package:get/get.dart';

// --- LIVE COVERAGE ---
class LiveCoverageScreen extends StatelessWidget {
  const LiveCoverageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Coverage')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.black,
                  child: const Center(child: Icon(Icons.play_circle_fill, size: 60, color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                        child: const Text('LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      const SizedBox(height: 8),
                      Text('Breaking News: Major Event Coverage #${index + 1}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Watch live as events unfold on the ground.', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 16),
                      SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.snackbar('Live', 'Joining stream...'), child: const Text('Watch Now'))),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- SAVED STORIES ---
class SavedStoriesScreen extends StatefulWidget {
  const SavedStoriesScreen({super.key});

  @override
  State<SavedStoriesScreen> createState() => _SavedStoriesScreenState();
}

class _SavedStoriesScreenState extends State<SavedStoriesScreen> {
  final List<String> _saved = ['Tech Week Recap', 'Global Summit Highlights', 'Future of AI Report'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Stories')),
      body: _saved.isEmpty
          ? const Center(child: Text('No saved stories'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _saved.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.bookmark, color: Colors.blue),
                    title: Text(_saved[index]),
                    subtitle: const Text('Saved 2 hours ago'),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            _saved.removeAt(index);
                          });
                          Get.snackbar('Saved', 'Story removed');
                        }),
                  ),
                );
              },
            ),
    );
  }
}

// --- LIVE SCORES ---
class LiveScoresScreen extends StatelessWidget {
  const LiveScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Scores')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildScoreCard('Soccer', 'Team A vs Team B', '2 - 1', '75:00'),
          _buildScoreCard('Basketball', 'Lakers vs Bulls', '102 - 98', 'Q4 4:30'),
          _buildScoreCard('Tennis', 'Nadal vs Federer', 'Set 3: 4-4', 'Live'),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String sport, String match, String score, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(sport, style: const TextStyle(color: Colors.grey, fontSize: 12)), const Icon(Icons.live_tv, size: 16, color: Colors.red)]),
            const SizedBox(height: 12),
            Text(match, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(score, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.blue)),
            const SizedBox(height: 8),
            Text(time, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: () => Get.snackbar('Scores', 'Showing detailed stats'), child: const Text('View Stats')),
          ],
        ),
      ),
    );
  }
}

// --- DISCOVER SCREEN (DUMMY) ---
class DiscoverDetailScreen extends StatelessWidget {
  const DiscoverDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Discover topics...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildTopicCard('Technology', Icons.computer, Colors.blue),
                _buildTopicCard('Science', Icons.science, Colors.green),
                _buildTopicCard('Health', Icons.favorite, Colors.red),
                _buildTopicCard('Business', Icons.trending_up, Colors.purple),
                _buildTopicCard('Sports', Icons.sports_soccer, Colors.orange),
                _buildTopicCard('Arts', Icons.palette, Colors.pink),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(String title, IconData icon, Color color) {
    return InkWell(
      onTap: () => Get.snackbar('Discover', 'Exploring $title'),
      child: Container(
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.3))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
