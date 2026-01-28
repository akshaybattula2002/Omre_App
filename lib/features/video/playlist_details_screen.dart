import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import 'video_player_screen.dart';

class PlaylistDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> playlist;

  const PlaylistDetailsScreen({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, dynamic>> playlistVideos = [
      {
        'title': 'Introduction to ${playlist['name']}',
        'views': '15K views',
        'time': '2 months ago',
        'thumbnail': playlist['thumbnail'],
        'duration': '12:45',
      },
      {
        'title': 'Advanced Techniques in ${playlist['name']}',
        'views': '8.2K views',
        'time': '1 month ago',
        'thumbnail': AppAssets.getRandomThumbnail(),
        'duration': '45:20',
      },
      {
        'title': '${playlist['name']} Best Practices',
        'views': '12K views',
        'time': '3 weeks ago',
        'thumbnail': AppAssets.getRandomThumbnail(),
        'duration': '22:10',
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(playlist['thumbnail'] as String, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          theme.scaffoldBackgroundColor,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          playlist['name'] as String,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${playlist['count']} videos • Updated recently',
                          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Play all'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.shuffle),
                              label: const Text('Shuffle'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                elevation: 0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final video = playlistVideos[index];
                  return _buildPlaylistVideoItem(video, index + 1, isDark, theme);
                },
                childCount: playlistVideos.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistVideoItem(Map<String, dynamic> video, int index, bool isDark, ThemeData theme) {
    return InkWell(
      onTap: () {
        Get.to(() => VideoPlayerScreen(
          title: video['title'],
          channel: 'Omre Creator',
          views: video['views'],
          time: video['time'],
          thumbnailUrl: video['thumbnail'],
          avatarColor: Colors.blue,
          videoUrl: AppAssets.sampleVideo,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              child: Text('$index', style: TextStyle(color: theme.hintColor, fontSize: 14)),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Image.asset(video['thumbnail'], width: 120, height: 68, fit: BoxFit.cover),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video['duration'],
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${video['views']} • ${video['time']}',
                    style: TextStyle(color: theme.hintColor, fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, size: 20),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
