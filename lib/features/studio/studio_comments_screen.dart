import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';

class StudioCommentsScreen extends StatefulWidget {
  const StudioCommentsScreen({super.key});

  @override
  State<StudioCommentsScreen> createState() => _StudioCommentsScreenState();
}

class _StudioCommentsScreenState extends State<StudioCommentsScreen> {
  String selectedTab = 'Published';
  final List<String> tabs = ['Published', 'Held for review'];

  final List<Map<String, dynamic>> publishedComments = [
    {
      'user': 'John Doe',
      'avatar': AppAssets.avatar1,
      'comment': 'Amazing video! Really helped me understand GetX better.',
      'video': 'Building a Modern Web App',
      'time': '2h ago',
      'isResponded': false,
    },
    {
      'user': 'Sarah Smith',
      'avatar': AppAssets.avatar2,
      'comment': 'Can you do a tutorial on Flutter animations next?',
      'video': 'Flutter 2026 Roadmap',
      'time': '5h ago',
      'isResponded': true,
    },
    {
      'user': 'Mike Wilson',
      'avatar': AppAssets.avatar3,
      'comment': 'The audio quality in this one is much better than the last one.',
      'video': 'Building a Modern Web App',
      'time': '1d ago',
      'isResponded': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, dynamic>> displayComments = selectedTab == 'Published' ? publishedComments : [];

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
          'Comments',
          style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[200]!)),
            ),
            child: Row(
              children: tabs.map((tab) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _buildFilterChip(tab, tab == selectedTab),
              )).toList(),
            ),
          ),
          Expanded(
            child: displayComments.isEmpty 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.comment_bank_outlined, size: 64, color: Colors.grey.withOpacity(0.5)),
                      const SizedBox(height: 16),
                      Text('No comments in $selectedTab', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: displayComments.length,
                  separatorBuilder: (context, index) => Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),
                  itemBuilder: (context, index) {
                    final comment = displayComments[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(comment['avatar']),
                            radius: 20,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(comment['user'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    const SizedBox(width: 8),
                                    Text(comment['time'], style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  comment['comment'],
                                  style: TextStyle(fontSize: 14, color: theme.textTheme.bodyLarge?.color),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isDark ? Colors.white10 : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'on ${comment['video']}',
                                    style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    _buildCommentAction(Icons.thumb_up_outlined, 'Like'),
                                    const SizedBox(width: 24),
                                    _buildCommentAction(Icons.thumb_down_outlined, 'Dislike'),
                                    const SizedBox(width: 24),
                                    _buildCommentAction(Icons.reply_outlined, 'Reply'),
                                    const Spacer(),
                                    if (!comment['isResponded'])
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Text('NO RESPONSE', style: TextStyle(color: Colors.red, fontSize: 9, fontWeight: FontWeight.bold)),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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
          selectedTab = label;
        });
      },
      child: Chip(
        label: Text(label, style: TextStyle(color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.grey[600]), fontSize: 13)),
        backgroundColor: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
        side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey[300]!),
      ),
    );
  }

  Widget _buildCommentAction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
