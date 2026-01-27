import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/library_controller.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LibraryController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final bgColor = isDark ? const Color(0xFF0D0D0D) : Colors.grey[50];
    final cardColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(context, controller, textColor),
            
            // Tab / Filter Bar
            _buildTabRow(controller, isDark, textColor),
            
            const SizedBox(height: 16),
            
            // Main Content Area (Empty or Grid)
            Expanded(
              child: Obx(() {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: controller.isLibraryEmpty
                      ? _buildEmptyState(controller, isDark, textColor)
                      : _buildGamesGrid(controller, isDark, textColor, cardColor),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, LibraryController controller, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 16, color: textColor),
                    const SizedBox(width: 4),
                    Text('Back to GameVerse', 
                      style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 14)),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: controller.browseMore,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: textColor.withOpacity(0.3)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text('+ Browse More', 
                  style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('My Library', 
            style: TextStyle(color: textColor, fontSize: 28, fontWeight: FontWeight.bold)),
          Text('Your saved games and collections', 
            style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildTabRow(LibraryController controller, bool isDark, Color textColor) {
    return Obx(() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: controller.tabs.map((tab) {
          final isSelected = controller.currentTab.value == tab;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.setTab(tab),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.transparent : Colors.transparent,
                  border: isSelected ? Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 1.5) : null,
                  boxShadow: isSelected ? [BoxShadow(color: Colors.blueAccent.withOpacity(0.2), blurRadius: 8)] : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected ? Colors.white : textColor.withOpacity(0.6),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      shadows: isSelected ? [const Shadow(color: Colors.blueAccent, blurRadius: 10)] : null,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ));
  }

  Widget _buildEmptyState(LibraryController controller, bool isDark, Color textColor) {
    return Center(
      key: const ValueKey('EmptyState'),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow, color: Colors.purple, size: 64),
            ),
            const SizedBox(height: 24),
            Text(
              'YOUR LIBRARY IS EMPTY',
              style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 12),
            Text(
              'Start adding games to your collection to keep track of them here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 14),
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.purple, Colors.deepPurple]),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: ElevatedButton(
                onPressed: controller.addMockGames, // For demo purposes to populate
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Browse GameVerse →', 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGamesGrid(LibraryController controller, bool isDark, Color textColor, Color cardColor) {
    return GridView.builder(
      key: const ValueKey('PopulatedState'),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: controller.currentDisplayList.length,
      itemBuilder: (context, index) {
        final game = controller.currentDisplayList[index];
        return _buildGameCard(game, controller, isDark, textColor, cardColor);
      },
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game, LibraryController controller, bool isDark, Color textColor, Color cardColor) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(game['image'], width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(game['title'], 
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.play_circle_fill, color: Colors.purple, size: 28),
                      onPressed: () => controller.playGame(game['title']),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                    IconButton(
                      icon: Icon(game['isFavorite'] ? Icons.favorite : Icons.favorite_border, 
                        color: Colors.redAccent, size: 20),
                      onPressed: () => controller.toggleFavorite(game['title']),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: textColor.withOpacity(0.5), size: 20),
                      onPressed: () => controller.removeGame(game['title']),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
