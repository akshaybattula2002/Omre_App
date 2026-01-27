import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'video_player_screen.dart';
import 'channel_profile_screen.dart';
import '../../core/constants/app_assets.dart';

class VideoHomeScreen extends StatelessWidget {
  const VideoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Recommended Videos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Discover trending content from creators you follow',
              style: TextStyle(
                fontSize: 14,
                color: theme.hintColor,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Video List
            _buildVideoCard(
              title: 'Building a Modern Web Application with Next.js 14',
              channel: 'Tech Tutorials',
              views: '125K views',
              time: '2 days ago',
              duration: '15:42',
              thumbnailUrl: AppAssets.thumbnail1,
              avatarColor: Colors.blue[100]!,
              theme: theme,
              isDark: isDark,
            ),
            _buildVideoCard(
              title: 'Complete Guide to React Server Components',
              channel: 'Code Masters',
              views: '89K views',
              time: '5 days ago',
              duration: '22:15',
              thumbnailUrl: AppAssets.thumbnail2,
              avatarColor: Colors.orange[100]!,
              theme: theme,
              isDark: isDark,
            ),
            _buildVideoCard(
              title: 'TypeScript Tips and Tricks for Advanced Developers',
              channel: 'Dev Academy',
              views: '234K views',
              time: '1 week ago',
              duration: '18:30',
              thumbnailUrl: AppAssets.thumbnail3,
              avatarColor: Colors.purple[100]!,
              theme: theme,
              isDark: isDark,
            ),
             _buildVideoCard(
              title: 'UI/UX Design Principles Every Developer Should Know',
              channel: 'Design Hub',
              views: '456K views',
              time: '3 days ago',
              duration: '25:18',
              thumbnailUrl: AppAssets.thumbnail1,
              avatarColor: Colors.green[100]!,
              theme: theme,
              isDark: isDark,
            ),
            _buildVideoCard(
              title: 'Mastering Impeller: The Future of Flutter Rendering',
              channel: 'Flutter Team',
              views: '89K views',
              time: '2 weeks ago',
              duration: '18:45',
              thumbnailUrl: AppAssets.thumbnail2,
              avatarColor: Colors.blue[100]!,
              theme: theme,
              isDark: isDark,
            ),
            _buildVideoCard(
              title: 'Building Scalable Backend with Node.js and Flutter',
              channel: 'Backend Masters',
              views: '34K views',
              time: '4 days ago',
              duration: '32:10',
              thumbnailUrl: AppAssets.thumbnail3,
              avatarColor: Colors.grey[100]!,
              theme: theme,
              isDark: isDark,
            ),
            _buildVideoCard(
              title: 'Advanced Animation Patterns in Flutter',
              channel: 'Animation Hub',
              views: '67K views',
              time: '1 week ago',
              duration: '21:15',
              thumbnailUrl: AppAssets.thumbnail1,
              avatarColor: Colors.pink[100]!,
              theme: theme,
              isDark: isDark,
            ),
             _buildVideoCard(
              title: 'Flutter Web: Performance Optimization Guide',
              channel: 'Web Devs',
              views: '12K views',
              time: '3 days ago',
              duration: '14:50',
              thumbnailUrl: AppAssets.thumbnail2,
              avatarColor: Colors.amber[100]!,
              theme: theme,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildVideoCard({
    required String title,
    required String channel,
    required String views,
    required String time,
    required String duration,
    required String thumbnailUrl,
    required Color avatarColor,
    required ThemeData theme,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => VideoPlayerScreen(
          title: title,
          channel: channel,
          views: views,
          time: time,
          thumbnailUrl: thumbnailUrl,
          avatarColor: avatarColor,
          videoUrl: AppAssets.sampleVideo,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    thumbnailUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   GestureDetector(
                    onTap: () {
                      Get.to(() => ChannelProfileScreen(
                        channelName: channel,
                        avatarColor: avatarColor,
                      ));
                    },
                    child: CircleAvatar(
                      backgroundColor: avatarColor,
                      child: Text(channel[0], style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          channel,
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.hintColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$views • $time',
                          style: TextStyle(
                            fontSize: 13,
                            color: theme.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.more_vert, color: theme.iconTheme.color),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
