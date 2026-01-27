import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import 'controllers/orbit_controller.dart';

class OrbitTopicDetailScreen extends StatefulWidget {
  final OrbitTopic topic;

  const OrbitTopicDetailScreen({super.key, required this.topic});

  @override
  State<OrbitTopicDetailScreen> createState() => _OrbitTopicDetailScreenState();
}

class _OrbitTopicDetailScreenState extends State<OrbitTopicDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  String _selectedFilter = 'All';

  // Theme constants based on the design request
  final Color bgColor = const Color(0xFF0F0F12);
  final Color cardColor = const Color(0xFF1A1A1D);
  final Color accentBlue = const Color(0xFF2962FF);
  final Color textPrimary = Colors.white;
  final Color textSecondary = const Color(0xFFB0BEC5);
  final Color verifiedColor = const Color(0xFF9C27B0); // Purple for insight/verified
  final Color sourceColor = const Color(0xFF1565C0); // Blue for source
  final Color contributorColor = const Color(0xFFFF6D00); // Orange for question/contributor

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Signal Filters
          _buildSignalFilters(),
          
          // Discussion List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: Get.find<OrbitController>().getPostsForTopic(widget.topic.title).length + 1,
              itemBuilder: (context, index) {
                final posts = Get.find<OrbitController>().getPostsForTopic(widget.topic.title);
                if (index == posts.length) {
                  return const SizedBox(height: 80); // Bottom padding
                }
                
                final post = posts[index];
                if (post['type'] == 'verified') {
                  return _buildVerifiedPost(
                    name: post['name'],
                    role: post['role'],
                    time: post['time'],
                    tag: post['tag'],
                    content: post['content'],
                    reputation: post['reputation'],
                    agreements: post['agreements'],
                    avatar: post['avatar'],
                  );
                } else if (post['type'] == 'source') {
                  return _buildSourcePost(
                    name: post['name'],
                    role: post['role'],
                    time: post['time'],
                    tag: post['tag'],
                    content: post['content'],
                    link: post['link'],
                    avatar: post['avatar'],
                  );
                } else {
                  return _buildContributorPost(
                    name: post['name'],
                    role: post['role'],
                    time: post['time'],
                    tag: post['tag'],
                    content: post['content'],
                    hearts: post['hearts'],
                    avatar: post['avatar'],
                  );
                }
              },
            ),
          ),
          
          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.topic.title,
                style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 6),
              if (widget.topic.isVerified)
                const Icon(Icons.verified_user_outlined, color: Colors.blue, size: 16),
            ],
          ),
          const SizedBox(height: 2),
            Row(
            children: [
                Icon(Icons.people_alt_rounded, size: 12, color: textSecondary),
                const SizedBox(width: 4),
                Text(
                '${widget.topic.liveUsers} live',
                style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                const SizedBox(width: 8),
                Text(
                '•',
                style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                const SizedBox(width: 8),
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                    widget.topic.category,
                    style: TextStyle(color: textSecondary, fontSize: 10, fontWeight: FontWeight.bold),
                ),
                ),
            ],
            ),
        ],
      ),
      actions: [
        IconButton(
          icon: Container(
             padding: const EdgeInsets.all(2),
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               border: Border.all(color: Colors.white, width: 1.5),
             ),
            child: const Icon(Icons.more_horiz, color: Colors.white, size: 20)
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildSignalFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Text('SIGNAL FILTER:', style: TextStyle(color: textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(width: 12),
          _buildFilterChip('All', Icons.local_fire_department_rounded, true),
          const SizedBox(width: 8),
          _buildFilterChip('Insights', Icons.psychology_outlined, false),
          const SizedBox(width: 8),
          _buildFilterChip('Sources', Icons.article_outlined, false),
          const Spacer(),
          Icon(Icons.help_outline, color: textSecondary, size: 16),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1E2235) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? accentBlue.withOpacity(0.5) : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: isSelected ? accentBlue : textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? accentBlue : textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifiedPost({
    required String name,
    required String role,
    required String time,
    required String tag,
    required String content,
    required int reputation,
    required int agreements,
     required String avatar,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(role, style: TextStyle(color: textSecondary, fontSize: 10)),
                    ),
                    const SizedBox(width: 8),
                    Text('• $time', style: TextStyle(color: textSecondary, fontSize: 12)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: verifiedColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: verifiedColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.psychology, size: 12, color: verifiedColor),
                          const SizedBox(width: 4),
                          Text(tag, style: TextStyle(color: verifiedColor, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(content, style: TextStyle(color: textPrimary.withOpacity(0.9), fontSize: 14, height: 1.5)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.all_inclusive, size: 14, color: textSecondary),
                    const SizedBox(width: 6),
                    Text('$reputation', style: TextStyle(color: textSecondary, fontSize: 12)),
                    const SizedBox(width: 16),
                    Icon(Icons.sentiment_satisfied_alt, size: 14, color: textSecondary),
                    const SizedBox(width: 6),
                    Text('$agreements', style: TextStyle(color: textSecondary, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContributorPost({
    required String name,
    required String role,
    required String time,
    required String tag,
    required String content,
    required int hearts,
     required String avatar,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(width: 8),
                     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(role, style: TextStyle(color: textSecondary, fontSize: 10)),
                    ),
                    const SizedBox(width: 8),
                    Text('• $time', style: TextStyle(color: textSecondary, fontSize: 12)),
                    const Spacer(),
                     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: contributorColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: contributorColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.help_outline, size: 12, color: contributorColor),
                          const SizedBox(width: 4),
                          Text(tag, style: TextStyle(color: contributorColor, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(content, style: TextStyle(color: textPrimary.withOpacity(0.9), fontSize: 14, height: 1.5)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.favorite_border, size: 14, color: textSecondary),
                    const SizedBox(width: 6),
                    Text('$hearts', style: TextStyle(color: textSecondary, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourcePost({
    required String name,
    required String role,
    required String time,
    required String tag,
    required String content,
    required String link,
     required String avatar,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(width: 8),
                     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(role, style: TextStyle(color: textSecondary, fontSize: 10)),
                    ),
                    const SizedBox(width: 8),
                    Text('• $time', style: TextStyle(color: textSecondary, fontSize: 12)),
                    const Spacer(),
                     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: sourceColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: sourceColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                         const Icon(Icons.description_outlined, size: 12, color: Color(0xFF1565C0)), // Hardcoded for const
                          const SizedBox(width: 4),
                          Text(tag, style: TextStyle(color: sourceColor, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(content, style: TextStyle(color: textPrimary.withOpacity(0.9), fontSize: 14, height: 1.5)),
                const SizedBox(height: 4),
                Text('Link: $link', style: TextStyle(color: textSecondary, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F12),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E24),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(color: textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Contribute to the conversation...',
                      hintStyle: TextStyle(color: textSecondary.withOpacity(0.5)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
           const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.language, color: textSecondary, size: 20),
              const SizedBox(width: 16),
              Icon(Icons.library_books_outlined, color: textSecondary, size: 20),
               const SizedBox(width: 16),
              Icon(Icons.mic_none, color: textSecondary, size: 20),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: accentBlue,
                  borderRadius: BorderRadius.circular(20),
                   boxShadow: [
                     BoxShadow(color: accentBlue.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2)),
                   ]
                ),
                child: Row(
                  children: [
                    const Text('Post', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    const Icon(Icons.send_rounded, size: 14, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 12, color: textSecondary),
              const SizedBox(width: 4),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: textSecondary, fontSize: 10),
                  children: [
                    const TextSpan(text: 'Your reputation in '),
                    TextSpan(text: widget.topic.category, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    const TextSpan(text: ' influences visibility.'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
