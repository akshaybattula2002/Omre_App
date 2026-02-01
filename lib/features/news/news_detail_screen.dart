import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/news_share_sheet.dart';
import '../../core/constants/app_assets.dart';

class NewsDetailScreen extends StatefulWidget {
  final Map<String, String> story;

  const NewsDetailScreen({super.key, required this.story});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  bool _isBookmarked = false;

  void _handleShare() {
    Get.bottomSheet(
      const NewsShareSheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void _handleSave() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    Get.snackbar(
      _isBookmarked ? 'Saved' : 'Removed',
      _isBookmarked ? 'Article added to bookmarks' : 'Article removed from bookmarks',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withOpacity(0.1),
      colorText: Colors.blue,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black26,
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.story['image']!,
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const CircleAvatar(
                  backgroundColor: Colors.black26,
                  child: Icon(Icons.share, color: Colors.white, size: 20),
                ),
                onPressed: _handleShare,
              ),
              IconButton(
                icon: CircleAvatar(
                  backgroundColor: Colors.black26,
                  child: Image.asset(
                    AppAssets.savedIcon3d,
                    width: 20,
                    height: 20,
                    color: _isBookmarked ? Colors.blue : Colors.white,
                  ),
                ),
                onPressed: _handleSave,
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2555C8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('NEWS', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${widget.story['source']} • ${widget.story['time']}',
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.story['title']!,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      height: 1.2,
                    ),
                  ),
                  if (widget.story.containsKey('summary')) ...[
                    const SizedBox(height: 16),
                    Text(
                      widget.story['summary']!,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  Text(
                    'In a significant development that marks a milestone for the industry, today\'s news brings forward multiple layers of impact. According to reports from various sources, this event has been long-awaited by experts and enthusiasts alike.\n\n"The implications here are vast," stated a senior analyst who has been following these events closely. "We are looking at a transition period that could redefine how we approach these challenges in the future."\n\nAs the situation unfolds, more details are expected to emerge from the official channels. Stay tuned with OMRE News for continuous updates and in-depth analysis of these historic developments.\n\nThe global community has already begun reacting to these events, with many praising the forward-thinking approach taken by the stakeholders involved. As we move into the next quarter, all eyes will be on the subsequent steps and the long-term sustainability of this initiative.',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor.withOpacity(0.8),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Written by OMRE Editorial', style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                          const Text('24 Jan 2026', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
