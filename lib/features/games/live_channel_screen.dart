import 'package:omre/core/constants/app_assets.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class LiveChannelScreen extends StatefulWidget {
  final Map<String, dynamic> channel;

  const LiveChannelScreen({super.key, required this.channel});

  @override
  State<LiveChannelScreen> createState() => _LiveChannelScreenState();
}

class _LiveChannelScreenState extends State<LiveChannelScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  final TextEditingController _chatController = TextEditingController();
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.asset(AppAssets.sampleVideo);
    await _videoPlayerController.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        isLive: true,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowFullScreen: true,
      );
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Video Player Area
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.black,
                    child: _chewieController != null
                        ? Chewie(controller: _chewieController!)
                        : const Center(child: CircularProgressIndicator(color: Colors.purple)),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.black38,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                    child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),

            // Stream Info & Chat
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0F0F0F) : Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    // Streamer Info
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(widget.channel['avatar'] ?? AppAssets.avatar1),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.channel['title'],
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  widget.channel['streamer'],
                                  style: TextStyle(color: Colors.grey, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isFollowing = !_isFollowing;
                              });
                              Get.snackbar(
                                _isFollowing ? 'Followed' : 'Unfollowed',
                                _isFollowing 
                                  ? 'You are now following ${widget.channel['streamer']}!' 
                                  : 'You have unfollowed ${widget.channel['streamer']}.',
                                backgroundColor: _isFollowing ? Colors.purple : Colors.grey[800],
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isFollowing ? Colors.grey[800] : Colors.purple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Text(_isFollowing ? 'Following' : 'Follow'),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    // Chat Area (Simulated)
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'User${index + 100}: ',
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purpleAccent, fontSize: 13),
                                  ),
                                  TextSpan(
                                    text: index % 3 == 0 ? 'GGWP! WHAT A PLAY! 🔥' : 'Is this 4k?',
                                    style: TextStyle(color: isDark ? Colors.white70 : Colors.black87, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Chat Input
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1A1A1A) : Colors.grey[100],
                        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _chatController,
                              style: TextStyle(color: isDark ? Colors.white : Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Send a message...',
                                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send, color: Colors.purple),
                            onPressed: () => _chatController.clear(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
