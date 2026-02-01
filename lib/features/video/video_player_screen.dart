import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';
import 'channel_profile_screen.dart';
import 'video_comments_sheet.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String channel;
  final String views;
  final String time;
  final String thumbnailUrl;
  final Color avatarColor;
  final String videoUrl;

  const VideoPlayerScreen({
    super.key,
    required this.title,
    required this.channel,
    required this.views,
    required this.time,
    required this.thumbnailUrl,
    required this.avatarColor,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isLiked = false;
  bool _isDisliked = false;
  bool _isSubscribed = false;
  bool _isSaved = false;
  
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    if (widget.videoUrl.startsWith('http')) {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    } else {
      _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
    }
    
    try {
      await _videoPlayerController.initialize();
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          looping: false,
          aspectRatio: _videoPlayerController.value.aspectRatio,
          showControls: true,
          allowFullScreen: true,
          allowMuting: true,
          allowPlaybackSpeedChanging: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.red,
            handleColor: Colors.red,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.white.withOpacity(0.5),
          ),
          placeholder: Image.asset(widget.thumbnailUrl, fit: BoxFit.cover),
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
      });
    } catch (e) {
      debugPrint("Error initializing video: $e");
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scaffoldColor = theme.scaffoldBackgroundColor;
    final textColor = theme.textTheme.bodyLarge?.color;

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: const Text('Videos', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: scaffoldColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Video Player
            Stack(
              children: [
                GestureDetector(
                  onDoubleTap: () => _chewieController?.enterFullScreen(),
                  child: Container(
                    height: 240,
                    width: double.infinity,
                    color: Colors.black,
                    child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                        ? Chewie(controller: _chewieController!)
                        : const Center(child: CircularProgressIndicator()),
                  ),
                ),
                if (_chewieController != null)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.fullscreen, color: Colors.white, size: 28),
                      onPressed: () => _chewieController?.enterFullScreen(),
                    ),
                  ),
              ],
            ),
            
            // Info & Recommendations
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video Info
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold, 
                              color: textColor,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                               Text('${widget.views} • ${widget.time}', style: TextStyle(color: theme.hintColor, fontSize: 13)),
                               const SizedBox(width: 8),
                               Text('...more', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Channel Row
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ChannelProfileScreen(
                                channelName: widget.channel,
                                avatarColor: widget.avatarColor,
                              ));
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: widget.avatarColor,
                                  child: Text(widget.channel[0], style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.channel, style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 16)),
                                      const Text('1.2M', style: TextStyle(color: Colors.grey, fontSize: 13)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() => _isSubscribed = !_isSubscribed),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _isSubscribed 
                                          ? (isDark ? Colors.grey[800] : Colors.grey[300]) 
                                          : (isDark ? Colors.white : Colors.black),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Text(
                                      _isSubscribed ? 'Subscribed' : 'Subscribe',
                                      style: TextStyle(
                                        color: _isSubscribed 
                                            ? (isDark ? Colors.white : Colors.black) 
                                            : (isDark ? Colors.black : Colors.white),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Actions Row (Scrollable)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildActionButton(_isLiked ? Icons.thumb_up : Icons.thumb_up_outlined, '12K', isDark, textColor, onTap: () => setState(() => _isLiked = !_isLiked)),
                                const SizedBox(width: 8),
                                _buildActionButton(_isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined, '', isDark, textColor, onTap: () => setState(() => _isDisliked = !_isDisliked)),
                                const SizedBox(width: 8),
                                _buildActionButton(Icons.share_outlined, 'Share', isDark, textColor, onTap: _handleShare),
                                const SizedBox(width: 8),
                                _buildActionButton(Icons.download_outlined, 'Download', isDark, textColor, onTap: _handleDownload),
                                const SizedBox(width: 8),
                                _buildActionButton(
                                  Icons.bookmark, 
                                  _isSaved ? 'Saved' : 'Save', 
                                  isDark, 
                                  textColor,
                                  onTap: _handleSave,
                                  assetPath: AppAssets.savedIcon3d
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const Divider(),
                    
                    // Comments Preview
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const VideoCommentsSheet(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                             Row(
                               children: [
                                 const Text('Comments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                 const SizedBox(width: 8),
                                 const Text('1.4K', style: TextStyle(color: Colors.grey)),
                                 const Spacer(),
                                 const Icon(Icons.unfold_more, size: 20),
                               ],
                             ),
                             const SizedBox(height: 12),
                             Row(
                               children: [
                                 const CircleAvatar(radius: 12, backgroundColor: Colors.purple),
                                 const SizedBox(width: 12),
                                 Expanded(
                                   child: Text(
                                     'This tutorial was exactly what I needed! Thanks so much for explaining the concepts clearly.',
                                     style: TextStyle(color: textColor, fontSize: 13),
                                     maxLines: 2,
                                     overflow: TextOverflow.ellipsis,
                                   ),
                                 ),
                               ],
                             ),
                          ],
                        ),
                      ),
                    ),
                    
                    Container(height: 6, color: isDark ? Colors.grey[900] : Colors.grey[100]),
                    
                    // Up Next / Recommended
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('Up Next', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
                           const SizedBox(height: 16),
                           _buildRecommendedVideo('Advance Flutter Animations', 'Flutter Dev', '45K views', '1 day ago', AppAssets.thumbnail1, isDark, textColor, AppAssets.sampleVideo2),
                           _buildRecommendedVideo('Dart Macros: Everything You Need to Know', 'Dart Side', '22K views', '3 days ago', AppAssets.thumbnail2, isDark, textColor, AppAssets.sampleVideo3),
                           _buildRecommendedVideo('State Management Showdown 2026', 'Code With Me', '110K views', '1 week ago', AppAssets.thumbnail3, isDark, textColor, AppAssets.sampleVideo),
                           _buildRecommendedVideo('System Design Interview Guide', 'TechLead', '500K views', '1 month ago', AppAssets.thumbnail1, isDark, textColor, AppAssets.sampleVideo2),
                           _buildRecommendedVideo('Mastering Impeller: The New Renderer', 'Flutter Team', '89K views', '2 weeks ago', AppAssets.thumbnail2, isDark, textColor, AppAssets.sampleVideo3),
                           _buildRecommendedVideo('Server Driven UI in Flutter', 'Dev Hub', '34K views', '4 days ago', AppAssets.thumbnail3, isDark, textColor, AppAssets.sampleVideo),
                           _buildRecommendedVideo('Effective GetX Patterns', 'State Masters', '67K views', '1 week ago', AppAssets.thumbnail1, isDark, textColor, AppAssets.sampleVideo2),
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

  void _handleShare() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Share via', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShareOption(Icons.copy, 'Copy Link'),
                _buildShareOption(Icons.message, 'WhatsApp'),
                _buildShareOption(Icons.email, 'Email'),
                _buildShareOption(Icons.more_horiz, 'More'),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  void _handleDownload() {
    Get.snackbar(
      'Downloading',
      'Saving video to offline...',
      showProgressIndicator: true,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
    
    Future.delayed(const Duration(seconds: 2), () {
      Get.snackbar(
        'Downloaded',
        'Video saved to your library.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }

  void _handleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });
    Get.snackbar(
      _isSaved ? 'Saved' : 'Removed',
      _isSaved ? 'Added to Watch Later' : 'Removed from Watch Later',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  Widget _buildActionButton(IconData icon, String label, bool isDark, Color? textColor, {VoidCallback? onTap, String? assetPath}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
         decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            assetPath != null
                ? Image.asset(assetPath, width: 20, height: 20, color: textColor)
                : Icon(icon, size: 20, color: textColor),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedVideo(String title, String channel, String views, String time, String tUrl, bool isDark, Color? textColor, String videoUrl) {
    return InkWell(
      onTap: () {
        Get.off(() => VideoPlayerScreen(
          title: title,
          channel: channel,
          views: views,
          time: time,
          thumbnailUrl: tUrl,
          avatarColor: Colors.blue[100]!, 
          videoUrl: videoUrl,
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                tUrl,
                width: 140,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textColor, height: 1.2),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text('$channel', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  Text('$views • $time', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, size: 18),
              color: Colors.grey,
              onPressed: () {
                 Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.watch_later_outlined),
                            title: const Text('Save to Watch Later'),
                            onTap: () {
                              Get.back();
                              Get.snackbar('Saved', 'Added to Watch Later');
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.share_outlined),
                            title: const Text('Share'),
                            onTap: () {
                              Get.back();
                              _handleShare();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.not_interested),
                            title: const Text('Not interested'),
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    )
                 );
              },
            ),
          ],
        ),
      ),
    );
  }
}
