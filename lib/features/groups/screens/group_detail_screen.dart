import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../social/widgets/create_post_widget.dart';

class GroupDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle; // e.g. members count
  final String image;
  final String cover;
  final bool isJoined;

  const GroupDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.cover,
    this.isJoined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF18191A) : const Color(0xFFF0F2F5);

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(cover, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(title, style: const TextStyle(color: Colors.white)),
              centerTitle: false,
            ),
            leading: IconButton(
              icon: const CircleAvatar(backgroundColor: Colors.black45, child: Icon(Icons.arrow_back, color: Colors.white)),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_horiz, color: Colors.white), onPressed: () {}),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              color: isDark ? const Color(0xFF242526) : Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black
                  )),
                   const SizedBox(height: 4),
                  Text('Public Group • $subtitle', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 30,
                        child: Stack(
                          children: [
                            _buildMemberAvatar(AppAssets.avatar1, 0),
                            _buildMemberAvatar(AppAssets.avatar2, 20),
                            _buildMemberAvatar(AppAssets.avatar3, 40),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                             Get.snackbar('Success', isJoined ? 'Left Group' : 'Joined Group', snackPosition: SnackPosition.BOTTOM);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(isJoined ? 'Joined' : 'Join Group', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.grey.withOpacity(0.2), 
                           foregroundColor: isDark ? Colors.white : Colors.black,
                           elevation: 0
                        ),
                        child: const Text('Invite'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 8)),
          // Create Post Box
          SliverToBoxAdapter(
            child: Container(
              color: isDark ? const Color(0xFF242526) : Colors.white,
              padding: const EdgeInsets.all(12),
               child: Row(
                children: [
                  CircleAvatar(backgroundImage: AssetImage(AppAssets.avatar1)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text('Write something...', style: TextStyle(color: Colors.grey[600])),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.photo_library, color: Colors.green),
                ],
              ),
            ),
          ),
           SliverToBoxAdapter(child: const SizedBox(height: 8)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                   color: isDark ? const Color(0xFF242526) : Colors.white,
                   padding: const EdgeInsets.all(12),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Row(
                          children: [
                            CircleAvatar(backgroundImage: AssetImage(image)),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Member Name $index', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                                Text('5 hours ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Anyone wants to collaborate on a new project? I have some ideas for a Flutter app.', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildAction(Icons.thumb_up_outlined, 'Like'),
                            _buildAction(Icons.comment_outlined, 'Comment'),
                            _buildAction(Icons.share_outlined, 'Share'),
                          ],
                        )
                     ],
                   ),
                );
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberAvatar(String img, double left) {
    return Positioned(
      left: left,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: CircleAvatar(radius: 12, backgroundImage: AssetImage(img)),
      ),
    );
  }

   Widget _buildAction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
