import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'controllers/shorts_controller.dart';
import 'widgets/shorts_comments_sheet.dart';
import 'widgets/shorts_share_sheet.dart';
import 'widgets/shorts_more_sheet.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';
import '../video/channel_profile_screen.dart';

class ShortsScreen extends StatelessWidget {
  const ShortsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShortsController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.shorts.length,
        onPageChanged: controller.updateIndex,
        itemBuilder: (context, index) {
          return ShortsPageItem(
            short: controller.shorts[index],
            isActive: controller.currentIndex.value == index,
          );
        },
      )),
    );
  }
}

class ShortsPageItem extends StatefulWidget {
  final ShortModel short;
  final bool isActive;

  const ShortsPageItem({super.key, required this.short, required this.isActive});

  @override
  State<ShortsPageItem> createState() => _ShortsPageItemState();
}

class _ShortsPageItemState extends State<ShortsPageItem> {
  late VideoPlayerController _videoController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    if (widget.short.videoUrl.startsWith('http')) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.short.videoUrl));
    } else {
      _videoController = VideoPlayerController.asset(widget.short.videoUrl);
    }
    await _videoController.initialize();
    _videoController.setLooping(true);
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
      if (widget.isActive) {
        _videoController.play();
      }
    }
  }

  @override
  void didUpdateWidget(ShortsPageItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isInitialized) {
      if (widget.isActive) {
        _videoController.play();
      } else {
        _videoController.pause();
      }
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShortsController>();

    return Stack(
      fit: StackFit.expand,
      children: [
        // Video Player
        _isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
              )
            : const Center(child: CircularProgressIndicator(color: Colors.white)),

        // Click to Play/Pause
        GestureDetector(
          onTap: () {
            if (_videoController.value.isPlaying) {
              _videoController.pause();
            } else {
              _videoController.play();
            }
            setState(() {});
          },
        ),

        // Gradient Overlay
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black26,
                Colors.transparent,
                Colors.transparent,
                Colors.black54,
              ],
            ),
          ),
        ),

        // Back Button
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () => Get.back(),
          ),
        ),

        // Side Actions
        Positioned(
          right: 16,
          bottom: 120,
          child: Column(
            children: [
              Obx(() {
                final isLiked = controller.likedShorts.contains(widget.short.id);
                return _buildActionItem(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  widget.short.likes,
                  isLiked ? Colors.red : Colors.white,
                  onTap: () => controller.likeShort(widget.short.id),
                );
              }),
              const SizedBox(height: 20),
              _buildActionItem(
                const Icon(Icons.comment_outlined, color: Colors.white, size: 36),
                widget.short.comments,
                Colors.white,
                onTap: () {
                  Get.bottomSheet(
                    const ShortsCommentsSheet(),
                    isScrollControlled: true,
                    ignoreSafeArea: false,
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildActionItem(
                Icons.share,
                widget.short.shares,
                Colors.white,
                onTap: () {
                  Get.bottomSheet(
                    const ShortsShareSheet(),
                    backgroundColor: Colors.transparent,
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildActionItem(
                Icons.more_horiz, 
                '', 
                Colors.white,
                onTap: () {
                  Get.bottomSheet(
                    const ShortsMoreSheet(),
                    backgroundColor: Colors.transparent,
                  );
                },
              ),
            ],
          ),
        ),

        // Bottom Info
        Positioned(
          left: 16,
          right: 80,
          bottom: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => ChannelProfileScreen(
                      channelName: widget.short.creatorName,
                      avatarColor: [
                        Colors.blueAccent,
                        Colors.purpleAccent,
                        Colors.orangeAccent,
                        Colors.greenAccent,
                      ][widget.short.id.hashCode % 4],
                    )),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            widget.short.creatorAvatar.startsWith('http') 
                                ? AppAssets.avatar1 
                                : widget.short.creatorAvatar
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          widget.short.creatorHandle,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Obx(() {
                    final isFollowing = controller.followedCreators.contains(widget.short.creatorHandle);
                    return GestureDetector(
                      onTap: () => controller.toggleFollow(widget.short.creatorHandle),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isFollowing ? Colors.white24 : AppPalette.accentBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isFollowing ? 'Following' : 'Follow', 
                          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.short.description,
                style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Play Pause Overlay icon when explicit tap
        if (!_videoController.value.isPlaying && _isInitialized)
          Center(child: Icon(Icons.play_arrow, color: Colors.white.withOpacity(0.5), size: 100)),
      ],
    );
  }

  Widget _buildActionItem(dynamic icon, String label, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          icon is IconData 
              ? Icon(icon, color: color, size: 36)
              : SizedBox(width: 36, height: 36, child: icon),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
