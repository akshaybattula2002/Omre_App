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
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _loadDummyMessages();
  }

  void _loadDummyMessages() {
    for (int i = 0; i < 20; i++) {
        _messages.add({
          'user': 'User${i + 100}',
          'message': i % 3 == 0 ? 'GGWP! WHAT A PLAY! 🔥' : 'Is this 4k?',
          'isGift': false,
        });
    }
  }

  void _showGiftSheet() {
    final gifts = [
      {'name': 'Rose', 'icon': '🌹', 'cost': 10},
      {'name': 'GG', 'icon': '🎮', 'cost': 50},
      {'name': 'Heart', 'icon': '❤️', 'cost': 100},
      {'name': 'Fire', 'icon': '🔥', 'cost': 200},
      {'name': 'Crown', 'icon': '👑', 'cost': 500},
      {'name': 'Dragon', 'icon': '🐲', 'cost': 1000},
    ];

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Send a Gift', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: gifts.length,
                itemBuilder: (context, index) {
                  final gift = gifts[index];
                  return GestureDetector(
                    onTap: () => _sendGift(gift),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(gift['icon'] as String, style: const TextStyle(fontSize: 32)),
                          const SizedBox(height: 8),
                          Text(gift['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text('${gift['cost']} Coins', style: const TextStyle(color: Colors.amber, fontSize: 12)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendGift(Map<String, dynamic> gift) {
    Get.back();
    setState(() {
      _messages.add({
        'user': 'You',
        'message': 'Sent a ${gift['name']} ${gift['icon']}',
        'isGift': true,
        'giftColor': Colors.pinkAccent,
      });
    });
    Get.snackbar(
      'Gift Sent!', 
      'You sent a ${gift['name']} to ${widget.channel['streamer']}',
      backgroundColor: Colors.pinkAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
    );
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
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final msg = _messages[index];
                          final isGift = msg['isGift'] == true;
                          
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: isGift 
                            ? Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: (msg['giftColor'] as Color? ?? Colors.pinkAccent).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: msg['giftColor'] as Color? ?? Colors.pinkAccent),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${msg['user']}: ',
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13),
                                      ),
                                      TextSpan(
                                        text: msg['message'],
                                        style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${msg['user']}: ',
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purpleAccent, fontSize: 13),
                                    ),
                                    TextSpan(
                                      text: msg['message'],
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
                           IconButton(
                             icon: const Icon(Icons.card_giftcard, color: Colors.pinkAccent),
                             onPressed: _showGiftSheet,
                           ),
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
                            onPressed: () {
                              if (_chatController.text.isNotEmpty) {
                                setState(() {
                                  _messages.add({
                                    'user': 'You',
                                    'message': _chatController.text,
                                    'isGift': false,
                                  });
                                  _chatController.clear();
                                });
                              }
                            },
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
