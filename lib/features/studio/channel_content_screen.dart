import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'video_details_editing_screen.dart';
import '../../core/constants/app_assets.dart';
import '../shorts/shorts_screen.dart';

class ChannelContentScreen extends StatefulWidget {
  const ChannelContentScreen({super.key});

  @override
  State<ChannelContentScreen> createState() => _ChannelContentScreenState();
}

class _ChannelContentScreenState extends State<ChannelContentScreen> {
  String selectedFilter = 'Videos';
  final List<String> filters = ['Videos', 'Shorts', 'Live', 'Playlists'];

  final List<Map<String, dynamic>> allVideos = [
    {
      'title': 'Building a Modern Web App',
      'views': '12.5K',
      'date': 'Jan 22, 2026',
      'visibility': 'Public',
      'likes': '1.2K',
      'comments': '156',
      'thumbnail': AppAssets.thumbnail1,
    },
    {
      'title': 'Flutter 2026 Roadmap',
      'views': '45.2K',
      'date': 'Jan 15, 2026',
      'visibility': 'Public',
      'likes': '5.4K',
      'comments': '432',
      'thumbnail': AppAssets.thumbnail2,
    },
    {
      'title': 'AI in Mobile Development',
      'views': '8.1K',
      'date': 'Jan 10, 2026',
      'visibility': 'Private',
      'likes': '320',
      'comments': '12',
      'thumbnail': AppAssets.thumbnail3,
    },
  ];

  final List<Map<String, dynamic>> allShorts = [
    {
      'title': 'Quick Flutter Tip #1',
      'views': '102K',
      'date': 'Jan 28, 2026',
      'visibility': 'Public',
      'likes': '12K',
      'comments': '89',
      'thumbnail': AppAssets.post1,
    },
    {
      'title': 'Why use GetX?',
      'views': '85K',
      'date': 'Jan 25, 2026',
      'visibility': 'Public',
      'likes': '9.5K',
      'comments': '124',
      'thumbnail': AppAssets.post2,
    },
  ];

  final List<Map<String, dynamic>> allLive = [
    {
      'title': 'Live Coding: Omre Social App',
      'views': '1.5K watching',
      'date': 'Streaming now',
      'visibility': 'Public',
      'likes': '450',
      'comments': '1.2K',
      'thumbnail': AppAssets.thumbnail3,
    },
  ];

  final List<Map<String, dynamic>> allPlaylists = [
    {
      'title': 'Mastering Flutter 2026',
      'videoCount': '24',
      'updatedDate': 'Jan 20, 2026',
      'visibility': 'Public',
      'thumbnail': AppAssets.thumbnail1,
    },
    {
      'title': 'React Native vs Flutter',
      'videoCount': '12',
      'updatedDate': 'Jan 15, 2026',
      'visibility': 'Unlisted',
      'thumbnail': AppAssets.thumbnail2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, dynamic>> displayItems;
    if (selectedFilter == 'Videos') {
      displayItems = allVideos;
    } else if (selectedFilter == 'Shorts') {
      displayItems = allShorts;
    } else if (selectedFilter == 'Live') {
      displayItems = allLive;
    } else {
      displayItems = allPlaylists;
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Channel Content',
          style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: theme.iconTheme.color),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[200]!)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildFilterChip(filter, filter == selectedFilter),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: displayItems.isEmpty 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.video_library_outlined, size: 64, color: Colors.grey.withOpacity(0.5)),
                      const SizedBox(height: 16),
                      Text('No $selectedFilter yet', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: displayItems.length,
                  separatorBuilder: (context, index) => Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),
                  itemBuilder: (context, index) {
                    final item = displayItems[index];
                    final isPlaylist = selectedFilter == 'Playlists';
                    final isShort = selectedFilter == 'Shorts';
                    
                    return GestureDetector(
                      onTap: () {
                        if (isPlaylist) {
                          Get.snackbar('Playlist', 'Opening playlist details...', snackPosition: SnackPosition.BOTTOM);
                        } else if (isShort) {
                          Get.to(() => const ShortsScreen());
                        } else {
                          Get.to(() => VideoDetailsEditingScreen(video: item));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item['thumbnail'],
                                    width: 120,
                                    height: 68,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (isPlaylist)
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(item['videoCount'], style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                          const Icon(Icons.playlist_play, color: Colors.white, size: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        item['visibility'] == 'Public' ? Icons.visibility : (item['visibility'] == 'Private' ? Icons.lock : Icons.link),
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(item['visibility'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                      const SizedBox(width: 12),
                                      Text(isPlaylist ? 'Updated ${item['updatedDate']}' : item['date'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                                  if (!isPlaylist) ...[
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        _buildMiniStat(Icons.visibility_outlined, item['views']),
                                        const SizedBox(width: 16),
                                        _buildMiniStat(Icons.thumb_up_outlined, item['likes']),
                                        const SizedBox(width: 16),
                                        _buildMiniStat(Icons.comment_outlined, item['comments']),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert, size: 20),
                              onSelected: (value) {
                                switch (value) {
                                  case 'edit':
                                    if (isPlaylist) {
                                      Get.snackbar('Edit', 'Playlist editing coming soon...', snackPosition: SnackPosition.BOTTOM);
                                    } else {
                                      Get.to(() => VideoDetailsEditingScreen(video: item));
                                    }
                                    break;
                                  case 'view':
                                    if (isShort) {
                                      Get.to(() => const ShortsScreen());
                                    } else {
                                      Get.snackbar('View', 'Opening on OMRE...', snackPosition: SnackPosition.BOTTOM);
                                    }
                                    break;
                                  case 'delete':
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text('Delete ${isPlaylist ? 'Playlist' : 'Content'}?'),
                                        content: const Text('This action cannot be undone.'),
                                        actions: [
                                          TextButton(onPressed: () => Get.back(), child: const Text('CANCEL')),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.snackbar('Deleted', 'Content has been removed.', snackPosition: SnackPosition.BOTTOM);
                                            },
                                            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    );
                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                                const PopupMenuItem(value: 'view', child: Text('View on OMRE')),
                                const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Chip(
        label: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w500)),
        backgroundColor: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
        side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey[300]!),
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  Widget _buildMiniStat(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(value, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
