import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Stories'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSavedItem(
            context,
            'SpaceX Successfully Lands Starship Rocket',
            'TechDaily',
            '2 days ago',
            AppAssets.post1,
          ),
          _buildSavedItem(
            context,
            'Top 10 Healthy Habits for 2026',
            'Wellness Weekly',
            '1 week ago',
            AppAssets.post2,
          ),
          _buildSavedItem(
            context,
            'Global Markets Rally to New Highs',
            'Finance Insider',
            '3 days ago',
            AppAssets.post3,
          ),
           _buildSavedItem(
            context,
            'Review: The Best Electric Cars of the Year',
            'AutoGear',
            '5 days ago',
            AppAssets.thumbnail1,
          ),
        ],
      ),
    );
  }

  Widget _buildSavedItem(BuildContext context, String title, String source, String time, String image) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 100,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(source, style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    const Icon(Icons.circle, size: 4, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark, color: Colors.blue),
            onPressed: () {
              // Mock Unsave
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Removed from Saved Stories')));
            },
          ),
        ],
      ),
    );
  }
}
