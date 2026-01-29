import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';

class LiveNewsCoverageScreen extends StatelessWidget {
  const LiveNewsCoverageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = theme.scaffoldBackgroundColor;
    final textPrimary = theme.textTheme.bodyLarge?.color ?? (isDark ? Colors.white : Colors.black);
    final textSecondary = theme.textTheme.bodyMedium?.color?.withOpacity(0.7) ?? (isDark ? const Color(0xFFB0BEC5) : Colors.black54);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.circle, color: Colors.red, size: 12),
            const SizedBox(width: 8),
            Text('LIVE COVERAGE', style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        backgroundColor: bgColor,
        iconTheme: IconThemeData(color: textPrimary),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Main Video Player Area
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: isDark ? Colors.black : Colors.black87,
                  child: Center(
                    child: Icon(Icons.play_circle_outline, size: 64, color: Colors.white.withOpacity(0.5)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BREAKING NEWS: Global Climate Summit Update',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Live from Geneva • 24.5k watching',
                          style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Breaking Ticker
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.red[900],
            child: const Row(
              children: [
                Text('BREAKING', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Market reaches all-time high... Tech stocks surge... New policies announced...',
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Upcoming / Related
          Expanded(
            flex: 5,
            child: Container(
              color: bgColor,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Coming Up Next', style: TextStyle(color: textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildLiveItem(textPrimary, textSecondary, 'Political Debate: The Future of AI', '14:00 PM', AppAssets.thumbnail1),
                  _buildLiveItem(textPrimary, textSecondary, 'Tech Talk: Quantum Computing', '15:30 PM', AppAssets.thumbnail2),
                  _buildLiveItem(textPrimary, textSecondary, 'Sports Roundup', '17:00 PM', AppAssets.thumbnail3),
                  
                  const SizedBox(height: 24),
                  Text('Recent Highlights', style: TextStyle(color: textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildHighlightItem(textPrimary, textSecondary, 'Prime Minister addresses the nation', '2h ago', AppAssets.post1),
                  _buildHighlightItem(textPrimary, textSecondary, 'SpaceX launch successful', '4h ago', AppAssets.post2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveItem(Color textPrimary, Color textSecondary, String title, String time, String image) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 45,
            decoration: BoxDecoration(
              color: textSecondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: textPrimary, fontWeight: FontWeight.w500)),
                Text(time, style: TextStyle(color: textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.notifications_none, color: textSecondary, size: 20),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(Color textPrimary, Color textSecondary, String title, String time, String image) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 45,
            decoration: BoxDecoration(
              color: textSecondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
               image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
            child: const Center(child: Icon(Icons.play_arrow, color: Colors.white, size: 20)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: textPrimary, fontWeight: FontWeight.w500)),
                Text(time, style: TextStyle(color: textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
