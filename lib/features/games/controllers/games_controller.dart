import 'package:omre/core/constants/app_assets.dart';
import 'package:get/get.dart';


import 'package:flutter/material.dart';
import '../tournament_screen.dart';
import '../library_screen.dart';
import '../squad_finder_screen.dart';
import '../live_channel_screen.dart';
import '../trending_clip_screen.dart';
import '../go_live_screen.dart';
import '../game_detail_screen.dart';

class GamesController extends GetxController {
  
  // Categories
  final categories = <String>[
    'All', 'Arcade', 'Puzzle', 'Action', 'Strategy', 'Sports', 'Casual', 'Card'
  ].obs;
  
  final selectedCategory = 'All'.obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  // Quick Actions
  final quickActions = <Map<String, dynamic>>[
    {
      'title': 'Tournaments',
      'subtitle': 'Compete for prizes',
      'icon': Icons.emoji_events_outlined,
      'color': Colors.amber,
    },
    {
      'title': 'LFG / Squad Finder',
      'subtitle': 'Find teammates',
      'icon': Icons.group_add_outlined,
      'color': Colors.green,
      'assetPath': AppAssets.groupsIcon3d,
    },
    {
      'title': 'Game Library',
      'subtitle': 'Your favorites',
      'icon': Icons.library_books_outlined,
      'color': Colors.blue,
    },
  ].obs;

  // Live Now Data
  final liveStreams = <Map<String, dynamic>>[
    {
      'game': 'Neon Vanguard',
      'streamer': 'KaiCenat',
      'viewers': '12.4K viewers',
      'image': AppAssets.post1,
      'avatar': AppAssets.avatar1,
    },
    {
      'game': 'Elden Ring',
      'streamer': 'SpeedRunnerPro',
      'viewers': '15K viewers',
      'image': AppAssets.post2,
      'avatar': AppAssets.avatar2,
    },
    {
      'game': 'Just Chatting',
      'streamer': 'Pokimane',
      'viewers': '22K viewers',
      'image': AppAssets.post3,
      'avatar': AppAssets.avatar3,
    },
  ].obs;

  // Top Picks Data
  final topPicks = <Map<String, dynamic>>[
    {
      'name': 'Ludo Club',
      'image': AppAssets.thumbnail1,
      'likes': '1.2M',
      'players': '45K playing',
    },
    {
      'name': '8 Ball Pool',
      'image': AppAssets.thumbnail2,
      'likes': '2.5M',
      'players': '120K playing',
    },
    {
      'name': 'UNO',
      'image': AppAssets.thumbnail3,
      'likes': '900K',
      'players': '30K playing',
    },
    {
      'name': 'Words With Friends',
      'image': AppAssets.post1,
      'likes': '500K',
      'players': '15K playing',
    },
     {
      'name': 'Mini Golf FRVR',
      'image': AppAssets.post2,
      'likes': '300K',
      'players': '10K playing',
    },
    {
      'name': 'Quiz Planet',
      'image': AppAssets.post3,
      'likes': '150K',
      'players': '5K playing',
    },
  ].obs;

  // Trending Data
  final trendingGames = <Map<String, dynamic>>[
    {
      'rank': 1,
      'name': 'Hero Wars',
      'icon': Icons.shield_outlined,
      'plays': '2.1M plays',
      'image': AppAssets.post1,
    },
    {
      'rank': 2,
      'name': 'MergeVille',
      'icon': Icons.location_city_outlined,
      'plays': '1.8M plays',
      'image': AppAssets.post2,
    },
     {
      'rank': 3,
      'name': 'Candy Crush',
      'icon': Icons.cookie_outlined,
      'plays': '1.5M plays',
      'image': AppAssets.post3,
    },
    {
      'rank': 4,
      'name': 'Subway Surfers',
      'icon': Icons.directions_subway_outlined,
      'plays': '1.2M plays',
      'image': AppAssets.thumbnail1,
    },
    {
      'rank': 5,
      'name': 'Clash Royale',
      'icon': Icons.castle_outlined,
      'plays': '900K plays',
      'image': AppAssets.thumbnail2,
    },
  ].obs;

  void onQuickActionTap(String title) {
    if (title == 'Tournaments') {
      Get.to(() => const TournamentScreen());
      return;
    }
    if (title == 'Game Library') {
      Get.to(() => const LibraryScreen());
      return;
    }
    if (title == 'LFG / Squad Finder') {
      Get.to(() => const SquadFinderScreen());
      return;
    }
    Get.snackbar('Quick Action', '$title clicked', 
      snackPosition: SnackPosition.BOTTOM, 
      backgroundColor: Colors.blueAccent.withOpacity(0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  void onGoLive() {
    Get.to(() => const GoLiveScreen());
  }

  void onWatchLive(Map<String, dynamic> stream) {
    Get.to(() => LiveChannelScreen(channel: {
      ...stream,
      'title': stream['game'], // Ensure title field exists for LiveChannelScreen
    }));
  }

  void onGameTap(String name) {
    final game = topPicks.firstWhere((element) => element['name'] == name, orElse: () => trendingGames.firstWhere((e) => e['name'] == name, orElse: () => {'name': name, 'image': AppAssets.post1}));
    Get.to(() => GameDetailScreen(game: game));
  }
}

