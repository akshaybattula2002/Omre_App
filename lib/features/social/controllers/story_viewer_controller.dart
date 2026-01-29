import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/social_models.dart';
import 'package:share_plus/share_plus.dart';
import 'package:omre/core/theme/palette.dart';
import './home_controller.dart';

class StoryViewerController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  
  final groupIndex = 0.obs;
  final storyIndex = 0.obs;
  final progress = 0.0.obs;
  Timer? _timer;

  final messageController = TextEditingController();
  final isPaused = false.obs;
  
  UserStoryGroup get currentGroup => homeController.stories[groupIndex.value];
  StoryModel get currentStory => currentGroup.stories[storyIndex.value];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      groupIndex.value = args['groupIndex'] ?? 0;
      storyIndex.value = args['storyIndex'] ?? 0;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Validate that the current indices point to a valid story
      if (!_isValidIndex()) {
        // Try to find the first valid story
        if (!_findFirstValidStory()) {
          // If no stories at all, close the viewer
          Get.back();
          return;
        }
      }

      _startTimer();
      _markAsViewed();
    });
  }

  bool _isValidIndex() {
    if (groupIndex.value < 0 || groupIndex.value >= homeController.stories.length) {
      return false;
    }
    final group = homeController.stories[groupIndex.value];
    if (storyIndex.value < 0 || storyIndex.value >= group.stories.length) {
      return false;
    }
    return true;
  }

  bool _findFirstValidStory() {
    for (int i = 0; i < homeController.stories.length; i++) {
      if (homeController.stories[i].stories.isNotEmpty) {
        groupIndex.value = i;
        storyIndex.value = 0;
        return true;
      }
    }
    return false;
  }

  @override
  void onClose() {
    _timer?.cancel();
    messageController.dispose();
    super.onClose();
  }

  void pauseTimer() {
    isPaused.value = true;
  }

  void resumeTimer() {
    isPaused.value = false;
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    Get.snackbar(
      'Message Sent',
      'You replied: $text',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.7),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
    messageController.clear();
    resumeTimer(); // Resume if paused for typing
  }

  void sendReaction(String emoji) {
    if (emoji == '❤️') {
      toggleLike();
      return;
    }
    Get.showSnackbar(GetSnackBar(
      messageText: Text(
        'Reacted with $emoji',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 300),
    ));
  }

  void toggleLike() {
    currentStory.isLiked.toggle();
    // Optional: Show feedback only when liking, or maybe a small animation
    if (currentStory.isLiked.value) {
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          '❤️ Liked',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 1),
        animationDuration: const Duration(milliseconds: 300),
      ));
    }
  }



  void shareStory() {
    pauseTimer();
    
    // Collect unique users from posts to mock "friends"
    final friends = homeController.posts.map((p) => {'name': p.username, 'avatar': p.avatarUrl}).toSet().toList();
    // Track sent status for this specific session
    final Set<String> sentUsers = {};

    Get.bottomSheet(
      DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Handle
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Get.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Friends Grid
                    Expanded(
                      child: GridView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.6, // Taller for name + button
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: friends.length,
                        itemBuilder: (context, index) {
                          final friend = friends[index];
                          final username = friend['name']!;
                          final isSent = sentUsers.contains(username);
  
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(friend['avatar']!),
                                  ),
                                  if (!isSent) // Show online indicator only if not sent involved? actually keep it
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.green, // Online indicator mock
                                        shape: BoxShape.circle,
                                        border: Border(), 
                                      ),
                                      child: const SizedBox(width: 4, height: 4), 
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                username,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 28,
                                width: 70,
                                child: ElevatedButton(
                                  onPressed: isSent ? null : () {
                                    setState(() {
                                      sentUsers.add(username);
                                    });
                                    // Optional toast/snackbar
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: isSent ? Colors.grey[800] : AppPalette.accentBlue,
                                    disabledBackgroundColor: Colors.grey.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    isSent ? 'Sent' : 'Send',
                                    style: TextStyle(
                                      fontSize: 11, 
                                      color: isSent ? Colors.grey : Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // Bottom Actions Divider
                    const Divider(height: 1),
                    // Bottom Actions
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildShareOption(Icons.share, 'Share to...', () {
                            Get.back(); 
                            Share.share('Check out this story by ${currentGroup.username}: ${currentStory.imageUrl}');
                          }),
                          _buildShareOption(Icons.copy, 'Copy link', () {
                            Get.back();
                            Get.snackbar('Copied', 'Link copied to clipboard');
                          }),
                          _buildShareOption(Icons.message_outlined, 'SMS', () {
                             Get.back();
                             Get.snackbar('SMS', 'Opening Messages...');
                          }),
                          _buildShareOption(Icons.more_horiz, 'More', () {}),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          );
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(() => resumeTimer());
  }

  Widget _buildShareOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.grey[200],
            child: Icon(icon, color: Get.isDarkMode ? Colors.white : Colors.black, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    progress.value = 0.0;
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (isPaused.value) return; // Don't advance if paused
      
      progress.value += 0.01;
      if (progress.value >= 1.0) {
        nextStory();
      }
    });
  }

  void nextStory() {
    if (storyIndex.value < currentGroup.stories.length - 1) {
      storyIndex.value++;
      _startTimer();
      _markAsViewed();
    } else {
      nextUser();
    }
  }

  void previousStory() {
    if (storyIndex.value > 0) {
      storyIndex.value--;
      _startTimer();
      _markAsViewed();
    } else {
      previousUser();
    }
  }

  void nextUser() {
    int newGroupIndex = groupIndex.value + 1;
    while (newGroupIndex < homeController.stories.length &&
        homeController.stories[newGroupIndex].stories.isEmpty) {
      newGroupIndex++;
    }

    if (newGroupIndex < homeController.stories.length) {
      groupIndex.value = newGroupIndex;
      storyIndex.value = 0;
      _startTimer();
      _markAsViewed();
    } else {
      Get.back();
    }
  }

  void previousUser() {
    int newGroupIndex = groupIndex.value - 1;
    while (newGroupIndex >= 0 &&
        homeController.stories[newGroupIndex].stories.isEmpty) {
      newGroupIndex--;
    }

    if (newGroupIndex >= 0) {
      groupIndex.value = newGroupIndex;
      storyIndex.value =
          homeController.stories[groupIndex.value].stories.length - 1;
      _startTimer();
      _markAsViewed();
    } else {
      Get.back();
    }
  }

  void _markAsViewed() {
    currentStory.isViewed.value = true;
    homeController.stories.refresh();
  }
}
