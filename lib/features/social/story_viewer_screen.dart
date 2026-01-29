import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'controllers/story_viewer_controller.dart';
import '../../core/theme/palette.dart';

class StoryViewerScreen extends GetView<StoryViewerController> {
  const StoryViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final width = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < width / 3) {
            controller.previousStory();
          } else {
            controller.nextStory();
          }
        },
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Get.back();
          }
        },
        child: Stack(
          children: [
            // Story Image
            Positioned.fill(
              child: Obx(() {
                final story = controller.currentStory;
                if (story.imageUrl.startsWith('http')) {
                  return Image.network(
                    story.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: Colors.white,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.error, color: Colors.white)),
                  );
                } else if (story.imageUrl.startsWith('assets/')) {
                  return Image.asset(
                    story.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      color: Colors.grey[900],
                      child: const Center(
                          child:
                              Icon(Icons.broken_image, color: Colors.white54, size: 50)),
                    ),
                  );
                } else {
                  return Image.file(
                    File(story.imageUrl),
                    fit: BoxFit.cover,
                     errorBuilder: (ctx, err, stack) => Container(
                      color: Colors.grey[900],
                      child: const Center(
                          child:
                              Icon(Icons.broken_image, color: Colors.white54, size: 50)),
                    ),
                  );
                }
              }),
            ),

            // Progress Bars
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Obx(() {
                final group = controller.currentGroup;
                return Row(
                  children: List.generate(group.stories.length, (index) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: LinearProgressIndicator(
                          value: index < controller.storyIndex.value
                              ? 1.0
                              : index == controller.storyIndex.value
                                  ? controller.progress.value
                                  : 0.0,
                          backgroundColor: Colors.white30,
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          minHeight: 2,
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),

            // User Info Overlay
            Positioned(
              top: 65,
              left: 16,
              child: Obx(() {
                final group = controller.currentGroup;
                final story = controller.currentStory;
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: group.avatarUrl.startsWith('http')
                          ? NetworkImage(group.avatarUrl)
                          : AssetImage(group.avatarUrl) as ImageProvider,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      group.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getTimeAgo(story.timestamp),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                      ),
                    ),
                  ],
                );
              }),
            ),

            // Interaction Bar (Text Input & Reactions)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.messageController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Send message',
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            onTap: controller.pauseTimer,
                           onEditingComplete: () {
                             controller.resumeTimer();
                             FocusScope.of(context).unfocus();
                           },
                            onSubmitted: (val) {
                              controller.sendMessage(val);
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Obx(() {
                          final isLiked = controller.currentStory.isLiked.value;
                          return IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.white,
                            ),
                            onPressed: controller.toggleLike,
                          );
                        }),
                        IconButton(
                          icon: const Icon(Icons.send,
                              color: Colors.white),
                          onPressed: controller.shareStory,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Close Button
            Positioned(
              top: 65,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h';
    } else {
      return '${diff.inDays}d';
    }
  }
}
