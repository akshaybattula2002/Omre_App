import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';

class ShortModel {
  final String id;
  final String videoUrl;
  final String creatorName;
  final String creatorHandle;
  final String creatorAvatar;
  final String description;
  final String likes;
  final String comments;
  final String shares;

  ShortModel({
    required this.id,
    required this.videoUrl,
    required this.creatorName,
    required this.creatorHandle,
    required this.creatorAvatar,
    required this.description,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}

class ShortsController extends GetxController {
  final shorts = <ShortModel>[
    ShortModel(
      id: '1',
      videoUrl: AppAssets.sampleVideo,
      creatorName: 'Flutter Dev',
      creatorHandle: '@flutter_dev',
      creatorAvatar: AppAssets.avatar1,
      description: 'Building beautiful apps with Flutter! 🚀 #flutter #dart #mobiledev',
      likes: '12.4k',
      comments: '852',
      shares: '1.2k',
    ),
    ShortModel(
      id: '2',
      videoUrl: AppAssets.sampleVideo2,
      creatorName: 'Nature Lover',
      creatorHandle: '@nature_fan',
      creatorAvatar: AppAssets.avatar2,
      description: 'The beauty of nature in slow motion. 🐝🌼 #nature #slowmo #beauty',
      likes: '8.1k',
      comments: '432',
      shares: '561',
    ),
    ShortModel(
      id: '3',
      videoUrl: AppAssets.sampleVideo3,
      creatorName: 'Animation Studio',
      creatorHandle: '@bunny_anim',
      creatorAvatar: AppAssets.avatar3,
      description: 'Big Buck Bunny classic animation snippet. 🐰🎨 #animation #classic #art',
      likes: '25k',
      comments: '1.2k',
      shares: '4.5k',
    ),
  ].obs;

  final currentIndex = 0.obs;

  final likedShorts = <String>{}.obs;
  final followedCreators = <String>{}.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void toggleFollow(String handle) {
    if (followedCreators.contains(handle)) {
      followedCreators.remove(handle);
    } else {
      followedCreators.add(handle);
      Get.snackbar('Following', 'You are now following $handle',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.blue.withOpacity(0.1),
          colorText: Colors.blue);
    }
  }

  void likeShort(String id) {
    if (likedShorts.contains(id)) {
      likedShorts.remove(id);
    } else {
      likedShorts.add(id);
      Get.snackbar('Liked', 'You liked this short!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  void shareShort(String id) {
     Get.snackbar('Shared', 'Short link copied to clipboard!', snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1));
  }
}
