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
      'likes': 1200.obs,
      'comments': 45.obs,
      'shares': 12.obs,
      'isLiked': false.obs,
    },
    {
      'username': 'creative_studio',
      'avatar': AppAssets.avatar2,
      'time': '5h ago',
      'content': 'New design project dropping soon. Stay tuned! 🎨',
      'image': AppAssets.post2,
      'likes': 850.obs,
      'comments': 23.obs,
      'shares': 5.obs,
      'isLiked': false.obs,
    },
    {
      'username': 'tech_guru',
      'avatar': AppAssets.avatar3,
      'time': '1d ago',
      'content': 'Flutter is amazing for building cross-platform apps.',
      'image': AppAssets.post3,
      'likes': 2500.obs,
      'comments': 120.obs,
      'shares': 50.obs,
      'isLiked': false.obs,
    },
  ];

  void toggleLike(int index) {
    if (index >= 0 && index < posts.length) {
      final post = posts[index];
      final isLiked = post['isLiked'] as RxBool;
      final likes = post['likes'] as RxInt;
      
      isLiked.toggle();
      if (isLiked.value) {
        likes.value++; 
      } else {
        likes.value--;
      }
    }
  }

  void incrementShare(int index) {
    if (index >= 0 && index < posts.length) {
       (posts[index]['shares'] as RxInt).value++;
    }
  }

  final List<Map<String, dynamic>> videos = [
    {
      'title': 'Cinematic Travel Vlog',
      'thumbnail': AppAssets.thumbnail1,
      'views': '124k views',
      'duration': '12:05',
      'time': '3 days ago',
      'channel': 'Traveler Diaries',
      'avatarColor': Colors.blue[100],
      'videoUrl': AppAssets.sampleVideo,
      'isSaved': false.obs,
    },
    {
      'title': 'Flutter 3.0 Tutorial',
      'thumbnail': AppAssets.thumbnail2,
      'views': '56k views',
      'duration': '8:30',
      'time': '1 week ago',
      'channel': 'Flutter Dev',
      'avatarColor': Colors.teal[100],
      'videoUrl': AppAssets.sampleVideo2,
      'isSaved': false.obs,
    },
    {
      'title': 'Gaming Highlights',
      'thumbnail': AppAssets.thumbnail3,
      'views': '890k views',
      'duration': '15:12',
      'time': '2 weeks ago',
      'channel': 'X-Gamer',
      'avatarColor': Colors.deepOrange[100],
      'videoUrl': AppAssets.sampleVideo3,
      'isSaved': false.obs,
    },
  ];

  final List<Map<String, dynamic>> sounds = [
    {
      'title': 'Original Sound - Chill Vibes',
      'usage': '12.5k videos',
      'duration': '0:60',
      'isPlaying': false.obs,
      'isSaved': false.obs,
    },
    {
      'title': 'Epic Cinematic Build',
      'usage': '5.2k videos',
      'duration': '0:30',
      'isPlaying': false.obs,
      'isSaved': false.obs,
    },
    {
      'title': 'Funny Laugh Effect',
      'usage': '150k videos',
      'duration': '0:05',
      'isPlaying': false.obs,
      'isSaved': false.obs,
    },
    {
      'title': 'Travel Pop Beat',
      'usage': '22k videos',
      'duration': '0:15',
      'isPlaying': false.obs,
      'isSaved': false.obs,
    },
  ];

  final List<Map<String, dynamic>> channels = [
    {
      'name': 'Tech Insider',
      'subscribers': '2.4M',
      'thumbnail': AppAssets.avatar4,
      'isSubscribed': false.obs,
      'avatarColor': Colors.blue[100],
    },
    {
      'name': 'Foodie Adventures',
      'subscribers': '890K',
      'thumbnail': AppAssets.avatar5,
      'isSubscribed': false.obs,
      'avatarColor': Colors.orange[100],
    },
    {
      'name': 'Gaming Central',
      'subscribers': '1.2M',
      'thumbnail': AppAssets.avatar1,
      'isSubscribed': true.obs,
      'avatarColor': Colors.purple[100],
    },
    {
      'name': 'Fitness Goals',
      'subscribers': '450K',
      'thumbnail': AppAssets.avatar2,
      'isSubscribed': false.obs,
      'avatarColor': Colors.green[100],
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
      if (channels[index]['isSubscribed'] is RxBool) {
         (channels[index]['isSubscribed'] as RxBool).toggle();
      }
    }
  }

  void toggleFollow(int index) {
     if (index >= 0 && index < people.length) {
       if (people[index]['isFollowing'] is RxBool) {
         (people[index]['isFollowing'] as RxBool).toggle();
       }
    }
  }

  void toggleVideoSave(int index) {
    if (index >= 0 && index < videos.length) {
       if (videos[index]['isSaved'] is RxBool) {
         (videos[index]['isSaved'] as RxBool).toggle();
       }
    }
  }

  void toggleSoundSave(int index) {
    if (index >= 0 && index < sounds.length) {
       if (sounds[index]['isSaved'] is RxBool) {
         (sounds[index]['isSaved'] as RxBool).toggle();
       }
    }
  }

  void toggleSoundPlay(int index) {
    if (index >= 0 && index < sounds.length) {
       // Stop others
       for (var i = 0; i < sounds.length; i++) {
         if (i != index && sounds[i]['isPlaying'] is RxBool) {
           (sounds[i]['isPlaying'] as RxBool).value = false;
         }
       }
       
       if (sounds[index]['isPlaying'] is RxBool) {
         (sounds[index]['isPlaying'] as RxBool).toggle();
       }
    }
  }
}
