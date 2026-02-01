import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/games_controller.dart';

// --- Shared Game Card Component ---
class _GameCard extends StatelessWidget {
  final String title;
  final String category;
  final String rating;
  final String players;
  final String imagePath; // Using assets or placeholders
  final String? badgeText;
  final Color? badgeColor;
  final VoidCallback? onTap;
  final VoidCallback? onPlay;

  const _GameCard({
    required this.title,
    required this.category,
    required this.rating,
    required this.players,
    this.imagePath = 'assets/images/placeholder_game.png',
    this.badgeText,
    this.badgeColor,
    this.onTap,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E222B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
          border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image / Placeholder
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white12 : Colors.deepPurple.shade50,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.sports_esports,
                        size: 48,
                        color: isDark ? Colors.white24 : Colors.deepPurple.shade200,
                      ),
                    ),
                    if (badgeText != null)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: badgeColor ?? Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badgeText!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 10),
                            const SizedBox(width: 4),
                            Text(
                              rating,
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: TextStyle(
                      color: isDark ? Colors.white54 : Colors.grey[600],
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 12, color: isDark ? Colors.white38 : Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        players,
                        style: TextStyle(color: isDark ? Colors.white38 : Colors.grey[500], fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: onPlay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? Colors.white10 : Colors.deepPurple.shade50,
                        foregroundColor: isDark ? Colors.white : Colors.deepPurple,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Play Now', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GamesWebBasedScreen extends StatelessWidget {
  const GamesWebBasedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.isRegistered<GamesController>() ? Get.find<GamesController>() : Get.put(GamesController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Web Based Games', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          final title = 'Cyber City Run ${index + 1}';
          return _GameCard(
            title: title,
            category: 'Action • WebGL',
            rating: '4.8',
            players: '12k Playing',
            badgeText: 'POPULAR',
            badgeColor: Colors.purple,
            onTap: () => controller.onGameTap(title),
            onPlay: () => Get.snackbar('Web Games', 'Launching $title...', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.deepPurple, colorText: Colors.white),
          );
        },
      ),
    );
  }
}

class GamesHTML5Screen extends StatelessWidget {
  const GamesHTML5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.isRegistered<GamesController>() ? Get.find<GamesController>() : Get.put(GamesController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('HTML5 Games', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          final title = 'Bubble Shooter ${index + 5}';
          return _GameCard(
            title: title,
            category: 'Casual • HTML5',
            rating: '4.5',
            players: '5k Playing',
            badgeText: 'INSTANT PLAY',
            badgeColor: Colors.green,
            onTap: () => controller.onGameTap(title),
            onPlay: () => Get.snackbar('HTML5 Games', 'Launching $title...', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white),
          );
        },
      ),
    );
  }
}

class GamesActivityScreen extends StatelessWidget {
  const GamesActivityScreen({super.key});

  Widget _buildStatCard(String label, String value, IconData icon, Color color, bool isDark, VoidCallback? onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E222B) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white54 : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentGameItem(String title, String time, String status, bool isDark, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E222B) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.videogame_asset, color: Colors.deepPurple),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: status == 'Playing' ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: status == 'Playing' ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.isRegistered<GamesController>() ? Get.find<GamesController>() : Get.put(GamesController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Gaming Activity', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildStatCard('Played', '124', Icons.gamepad, Colors.blue, isDark, () => Get.snackbar('Activity', 'Viewing played games...', snackPosition: SnackPosition.BOTTOM)),
                const SizedBox(width: 16),
                _buildStatCard('Hours', '86h', Icons.timer, Colors.orange, isDark, () => Get.snackbar('Activity', 'Viewing playtime stats...', snackPosition: SnackPosition.BOTTOM)),
                const SizedBox(width: 16),
                _buildStatCard('Wins', '42', Icons.emoji_events, Colors.amber, isDark, () => Get.snackbar('Activity', 'Viewing tournament wins...', snackPosition: SnackPosition.BOTTOM)),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecentGameItem('Cyber City Run', '2 mins ago', 'Playing', isDark, () => controller.onGameTap('Cyber City Run')),
            _buildRecentGameItem('Space Invaders 3D', 'Yesterday', 'Completed', isDark, () => controller.onGameTap('Space Invaders 3D')),
            _buildRecentGameItem('Chess Master', '2 days ago', 'Lost', isDark, () => controller.onGameTap('Chess Master')),
            _buildRecentGameItem('Bubble Shooter 5', 'Last week', 'Level 24', isDark, () => controller.onGameTap('Bubble Shooter 5')),
          ],
        ),
      ),
    );
  }
}

class GamesCategoryScreen extends StatelessWidget {
  final String category;
  const GamesCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.isRegistered<GamesController>() ? Get.find<GamesController>() : Get.put(GamesController());

    // Simulate different games based on category
    String _getGameTitle(int index) {
      if (category == 'Action') return 'Action Hero ${index + 1}';
      if (category == 'Adventure') return 'Quest Legend ${index + 1}';
      if (category == 'Arcade') return 'Retro Blast ${index + 1}';
      if (category == 'Battle') return 'War Zone ${index + 1}';
      if (category == 'Board') return 'Tabletop King ${index + 1}';
      if (category == 'Builder') return 'City Skylines ${index + 1}';
      if (category == 'Card') return 'Poker Face ${index + 1}';
      return 'Game Title ${index + 1}';
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('$category Games', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          final title = _getGameTitle(index);
          return _GameCard(
            title: title,
            category: '$category • Mobile',
            rating: '4.${9 - (index % 5)}',
            players: '${(index + 1) * 100}k Playing',
            badgeText: index == 0 ? 'TOP RATED' : null,
            badgeColor: Colors.orange,
            onTap: () => controller.onGameTap(title),
            onPlay: () => Get.snackbar(category, 'Launching $title...', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.orange, colorText: Colors.white),
          );
        },
      ),
    );
  }
}
