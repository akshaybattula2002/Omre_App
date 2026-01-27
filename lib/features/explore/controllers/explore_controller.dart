import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';

class ExploreController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final searchText = ''.obs;
  final isSearching = false.obs;

  // Tabs
  final List<String> mainTabs = ['Posts', 'Videos', 'Sounds', 'Channels'];
  final List<String> searchTabs = ['For You', 'People', 'Posts', 'Videos'];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: mainTabs.length, vsync: this);
    
    // Listen to search text changes
    debounce(searchText, (val) {
      if (val.isNotEmpty && !isSearching.value) {
        isSearching.value = true;
        // Re-init controller for search tabs
        tabController.dispose();
        tabController = TabController(length: searchTabs.length, vsync: this);
        update(); // Force rebuild to show new tabs
      } else if (val.isEmpty && isSearching.value) {
        isSearching.value = false;
        // Re-init controller for main tabs
        tabController.dispose();
        tabController = TabController(length: mainTabs.length, vsync: this);
        update(); // Force rebuild
      }
    }, time: const Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void updateSearch(String val) {
    searchText.value = val;
  }

  // --- Mock Data ---

  final List<Map<String, dynamic>> posts = [
    {
      'username': 'josh_travels',
      'avatar': AppAssets.avatar1,
      'time': '2h ago',
      'content': 'Exploring the mountains! 🏔️ #travel #nature',
      'image': AppAssets.post1,
      'likes': '1.2k',
      'comments': '45',
      'shares': '12',
    },
    {
      'username': 'creative_studio',
      'avatar': AppAssets.avatar2,
      'time': '5h ago',
      'content': 'New design project dropping soon. Stay tuned! 🎨',
      'image': AppAssets.post2,
      'likes': '850',
      'comments': '23',
      'shares': '5',
    },
    {
      'username': 'tech_guru',
      'avatar': AppAssets.avatar3,
      'time': '1d ago',
      'content': 'Flutter is amazing for building cross-platform apps.',
      'image': AppAssets.post3,
      'likes': '2.5k',
      'comments': '120',
      'shares': '50',
    },
  ];

  final List<Map<String, dynamic>> videos = [
    {
      'title': 'Cinematic Travel Vlog',
      'thumbnail': AppAssets.thumbnail1,
      'views': '124k views',
      'duration': '12:05',
      'time': '3 days ago',
    },
    {
      'title': 'Flutter 3.0 Tutorial',
      'thumbnail': AppAssets.thumbnail2,
      'views': '56k views',
      'duration': '8:30',
      'time': '1 week ago',
    },
    {
      'title': 'Gaming Highlights',
      'thumbnail': AppAssets.thumbnail3,
      'views': '890k views',
      'duration': '15:12',
      'time': '2 weeks ago',
    },
  ];

  final List<Map<String, dynamic>> sounds = [
    {
      'title': 'Original Sound - Chill Vibes',
      'usage': '12.5k videos',
      'duration': '0:60',
    },
    {
      'title': 'Epic Cinematic Build',
      'usage': '5.2k videos',
      'duration': '0:30',
    },
    {
      'title': 'Funny Laugh Effect',
      'usage': '150k videos',
      'duration': '0:05',
    },
    {
      'title': 'Travel Pop Beat',
      'usage': '22k videos',
      'duration': '0:15',
    },
  ];

  final List<Map<String, dynamic>> channels = [
    {
      'name': 'Tech Insider',
      'subscribers': '2.4M',
      'thumbnail': AppAssets.avatar4,
      'isSubscribed': false.obs,
    },
    {
      'name': 'Foodie Adventures',
      'subscribers': '890K',
      'thumbnail': AppAssets.avatar5,
      'isSubscribed': false.obs,
    },
    {
      'name': 'Gaming Central',
      'subscribers': '1.2M',
      'thumbnail': AppAssets.avatar1,
      'isSubscribed': true.obs,
    },
    {
      'name': 'Fitness Goals',
      'subscribers': '450K',
      'thumbnail': AppAssets.avatar2,
      'isSubscribed': false.obs,
    },
  ];

   final List<Map<String, dynamic>> people = [
    {
      'name': 'Sarah Jenkins',
      'handle': '@sarah_j',
      'avatar': AppAssets.avatar3,
      'followers': '12k',
      'isFollowing': false.obs,
    },
    {
      'name': 'Mike Chen',
      'handle': '@mikeos',
      'avatar': AppAssets.avatar4,
      'followers': '5.4k',
      'isFollowing': true.obs,
    },
    {
      'name': 'Jessica Alva',
      'handle': '@jess_designs',
      'avatar': AppAssets.avatar1,
      'followers': '890',
      'isFollowing': false.obs,
    },
  ];

  void toggleSubscribe(int index) {
    if (index >= 0 && index < channels.length) {
      channels[index]['isSubscribed'].toggle();
    }
  }

  void toggleFollow(int index) {
     if (index >= 0 && index < people.length) {
      people[index]['isFollowing'].toggle();
    }
  }
}
