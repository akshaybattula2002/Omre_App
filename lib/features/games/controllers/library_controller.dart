import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';

class LibraryController extends GetxController {
  final currentTab = 'All Games'.obs;
  final tabs = ['All Games', 'Favorites', 'Local'];
  
  final allGames = <Map<String, dynamic>>[].obs;
  final favorites = <Map<String, dynamic>>[].obs;
  final localGames = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initially empty to show empty state, or mock some data if needed
    // _loadMockData(); 
  }

  void _loadMockData() {
    final mockGames = [
      {
        'title': 'Neon Vanguard',
        'image': AppAssets.post1,
        'isFavorite': true,
        'isLocal': true,
      },
      {
        'title': 'Elden Ring',
        'image': AppAssets.post2,
        'isFavorite': false,
        'isLocal': true,
      },
      {
        'title': '8 Ball Pool',
        'image': AppAssets.thumbnail1,
        'isFavorite': true,
        'isLocal': false,
      },
    ];

    allGames.value = mockGames;
    favorites.value = mockGames.where((g) => g['isFavorite'] == true).toList();
    localGames.value = mockGames.where((g) => g['isLocal'] == true).toList();
  }

  void setTab(String tab) {
    currentTab.value = tab;
  }

  List<Map<String, dynamic>> get currentDisplayList {
    if (currentTab.value == 'Favorites') return favorites;
    if (currentTab.value == 'Local') return localGames;
    return allGames;
  }

  bool get isLibraryEmpty => allGames.isEmpty;

  void addMockGames() {
    _loadMockData();
  }

  void playGame(String title) {
    Get.snackbar(
      'Playing',
      'Launching $title...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.purple,
      colorText: Colors.white,
    );
  }

  void toggleFavorite(String title) {
    final index = allGames.indexWhere((g) => g['title'] == title);
    if (index != -1) {
      allGames[index]['isFavorite'] = !allGames[index]['isFavorite'];
      favorites.value = allGames.where((g) => g['isFavorite'] == true).toList();
      allGames.refresh();
    }
  }

  void removeGame(String title) {
    allGames.removeWhere((g) => g['title'] == title);
    favorites.removeWhere((g) => g['title'] == title);
    localGames.removeWhere((g) => g['title'] == title);
  }

  void browseMore() {
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Browse More Games',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Explore the GameVerse to find new favorites!',
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
