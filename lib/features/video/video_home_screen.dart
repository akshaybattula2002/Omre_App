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
    final bgColor = isDark ? const Color(0xFF18191A) : const Color(0xFFF0F2F5);
    final cardColor = isDark ? const Color(0xFF242526) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Watch Header
            SliverAppBar(
              backgroundColor: cardColor,
              floating: true,
              title: const Text('Watch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              actions: [
                _buildHeaderIcon(Image.asset('assets/images/profile_icon_3d.png', width: 24, height: 24), isDark),
                const SizedBox(width: 8),
                _buildHeaderIcon(Image.asset('assets/images/search_icon_3d.png', width: 24, height: 24), isDark),
                const SizedBox(width: 16),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildTabChip('For You', true, isDark),
                      _buildTabChip('Live', false, isDark),
                      _buildTabChip('Gaming', false, isDark),
                      _buildTabChip('Following', false, isDark),
                      _buildTabChip('Saved', false, isDark),
                    ],
                  ),
                ),
              ),
            ),

            // Video Feed
            SliverList(
              delegate: SliverChildListDelegate([
                 _buildVideoPost(
                  context,
                  title: 'Building a Modern Web Application with Next.js 14',
                  channel: 'Tech Tutorials',
                  views: '125K',
                  time: '2d',
                  duration: '15:42',
                  thumbnailUrl: AppAssets.thumbnail1,
                  avatarColor: Colors.blue[100]!,
                  theme: theme,
                  isDark: isDark,
                ),
                _buildVideoPost(
                  context,
                  title: 'Complete Guide to React Server Components',
                  channel: 'Code Masters',
                  views: '89K',
                  time: '5d',
                  duration: '22:15',
                  thumbnailUrl: AppAssets.thumbnail2,
                  avatarColor: Colors.orange[100]!,
                  theme: theme,
                  isDark: isDark,
                ),
                _buildVideoPost(
                  context,
                  title: 'TypeScript Tips and Tricks for Advanced Developers',
                  channel: 'Dev Academy',
                  views: '234K',
                  time: '1w',
                  duration: '18:30',
                  thumbnailUrl: AppAssets.thumbnail3,
                  avatarColor: Colors.purple[100]!,
                  theme: theme,
                  isDark: isDark,
                ),
                 _buildVideoPost(
                  context,
                  title: 'UI/UX Design Principles Every Developer Should Know',
                  channel: 'Design Hub',
                  views: '456K',
                  time: '3d',
                  duration: '25:18',
                  thumbnailUrl: AppAssets.thumbnail1,
                  avatarColor: Colors.green[100]!,
                  theme: theme,
                  isDark: isDark,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(Widget iconWidget, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: SizedBox(width: 20, height: 20, child: Center(child: iconWidget)),
    );
  }

  Widget _buildTabChip(String label, bool isSelected, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected 
            ? (Colors.blue.withOpacity(0.1)) 
            : (isDark ? Colors.grey[800] : Colors.grey[200]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.blue : (isDark ? Colors.white : Colors.black),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }


  Widget _buildVideoPost(
    BuildContext context, {
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
    final cardColor = isDark ? const Color(0xFF242526) : Colors.white;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => ChannelProfileScreen(channelName: channel, avatarColor: avatarColor));
                  },
                  child: CircleAvatar(
                    backgroundColor: avatarColor,
                    child: Text(channel[0], style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(channel, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black)),
                          const SizedBox(width: 4),
                          Text('• Follow', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      Text('$time • $views views', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
                Icon(Icons.more_horiz, color: isDark ? Colors.grey[400] : Colors.grey[600]),
              ],
            ),
          ),

          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              title,
              style: TextStyle(fontSize: 15, color: isDark ? Colors.white : Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),

          // Video Player Area
          GestureDetector(
            onTap: () {
              Get.to(() => VideoPlayerScreen(
                title: title,
                channel: channel,
                views: '$views views',
                time: '$time ago',
                thumbnailUrl: thumbnailUrl,
                avatarColor: avatarColor,
                videoUrl: AppAssets.sampleVideo,
              ));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  thumbnailUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
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
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Action Bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _buildActionButton(Icons.thumb_up_outlined, 'Like', isDark),
                _buildActionButton(Icons.chat_bubble_outline, 'Comment', isDark),
                _buildActionButton(Icons.share_outlined, 'Share', isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, bool isDark) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
