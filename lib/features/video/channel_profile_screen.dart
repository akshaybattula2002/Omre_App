import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'video_player_screen.dart';
import 'playlist_details_screen.dart';
import '../shorts/shorts_screen.dart';
import '../../core/constants/app_assets.dart';

class ChannelProfileScreen extends StatefulWidget {
  final String channelName;
  final Color avatarColor;

  const ChannelProfileScreen({
    super.key,
    required this.channelName,
    required this.avatarColor,
  });

  @override
  State<ChannelProfileScreen> createState() => _ChannelProfileScreenState();
}

class _ChannelProfileScreenState extends State<ChannelProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSubscribed = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.textTheme.bodyLarge?.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 120,
              backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.blue[50],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              actions: [
                IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
                IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: widget.avatarColor.withOpacity(0.8),
                  child: Center(
                    child: Icon(Icons.code, size: 64, color: Colors.white.withOpacity(0.5)),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: widget.avatarColor,
                          child: Text(widget.channelName[0], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.channelName,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '@${widget.channelName.replaceAll(' ', '').toLowerCase()} • 1.2M subscribers • 450 videos',
                                style: TextStyle(color: theme.hintColor, fontSize: 13),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Teaching you how to code with practical examples. Flutter, React, Node.js and more!',
                                      style: TextStyle(color: theme.hintColor, fontSize: 13),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, size: 16),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => setState(() => _isSubscribed = !_isSubscribed),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isSubscribed ? (isDark ? Colors.grey[800] : Colors.grey[200]) : (isDark ? Colors.white : Colors.black),
                          foregroundColor: _isSubscribed ? textColor : (isDark ? Colors.black : Colors.white),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: Text(_isSubscribed ? 'Subscribed' : 'Subscribe', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: textColor,
                  unselectedLabelColor: theme.hintColor,
                  indicatorColor: textColor,
                  isScrollable: true,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  tabs: const [
                    Tab(text: 'Home'),
                    Tab(text: 'Videos'),
                    Tab(text: 'Shorts'),
                    Tab(text: 'Playlists'),
                  ],
                ),
                backgroundColor: theme.scaffoldBackgroundColor,
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildHomeTab(isDark, textColor, theme),
            _buildVideosTab(isDark, textColor, theme),
            _buildShortsTab(isDark, textColor, theme),
            _buildPlaylistsTab(isDark, textColor, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab(bool isDark, Color? textColor, ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Featured', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor)),
        const SizedBox(height: 12),
        _buildVideoItem('Flutter 3.0 Full Course', '1.2M views • 1 year ago', AppAssets.thumbnail1, isDark, textColor),
        const SizedBox(height: 24),
        Text('Latest Videos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor)),
        const SizedBox(height: 12),
        _buildVideoItem('Dart Patterns Explained', '45K views • 2 days ago', AppAssets.thumbnail2, isDark, textColor),
        _buildVideoItem('State Management 2026', '12K views • 5 days ago', AppAssets.thumbnail3, isDark, textColor),
      ],
    );
  }

  Widget _buildVideosTab(bool isDark, Color? textColor, ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildVideoItem('Video Title #$index - Tutorial', '${(index * 5 + 2)}K views • ${index + 1} days ago', AppAssets.getRandomThumbnail(), isDark, textColor),
        );
      },
    );
  }

  Widget _buildShortsTab(bool isDark, Color? textColor, ThemeData theme) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Get.to(() => const ShortsScreen()),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  AppAssets.getRandomPost(),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Row(
                  children: [
                    const Icon(Icons.play_arrow, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text('${(index + 1) * 12}K', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaylistsTab(bool isDark, Color? textColor, ThemeData theme) {
    final playlists = [
      {'name': 'Flutter Tutorials', 'count': 45, 'thumbnail': AppAssets.thumbnail1},
      {'name': 'UI/UX Design Course', 'count': 12, 'thumbnail': AppAssets.thumbnail2},
      {'name': 'Backend with Node.js', 'count': 28, 'thumbnail': AppAssets.thumbnail3},
      {'name': 'Coding Tips & Tricks', 'count': 89, 'thumbnail': AppAssets.thumbnail1},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return GestureDetector(
          onTap: () => Get.to(() => PlaylistDetailsScreen(playlist: playlist)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(playlist['thumbnail'] as String, width: 140, height: 80, fit: BoxFit.cover),
                    ),
                    Container(
                      width: 50,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${playlist['count']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          const Icon(Icons.playlist_play, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(playlist['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text('View full playlist', style: TextStyle(color: theme.hintColor, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoItem(String title, String subtitle, String url, bool isDark, Color? textColor) {
    return GestureDetector(
      onTap: () {
        final parts = subtitle.split(' • ');
        final views = parts.isNotEmpty ? parts[0] : '0 views';
        final time = parts.length > 1 ? parts[1] : 'recently';
        
        Get.to(() => VideoPlayerScreen(
          title: title,
          channel: widget.channelName,
          views: views,
          time: time,
          thumbnailUrl: url,
          avatarColor: widget.avatarColor,
          videoUrl: AppAssets.sampleVideo,
        ));
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(url, height: 200, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
                     const SizedBox(height: 4),
                     Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                   ],
                 ),
               ),
               const Icon(Icons.more_vert, size: 20),
             ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, {required this.backgroundColor});

  final TabBar _tabBar;
  final Color backgroundColor;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
