import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../social/widgets/create_post_widget.dart';

class PageDetailScreen extends StatefulWidget {
  final String title;
  final String category;
  final String followers;
  final String image;
  final String cover;
  final bool isJoined;

  const PageDetailScreen({
    super.key,
    required this.title,
    required this.category,
    required this.followers,
    required this.image,
    required this.cover,
    this.isJoined = false,
  });

  @override
  State<PageDetailScreen> createState() => _PageDetailScreenState();
}

class _PageDetailScreenState extends State<PageDetailScreen> {
  late bool _isFollowing;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.isJoined;
  }

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
              background: Image.asset(widget.cover, fit: BoxFit.cover),
            ),
            leading: IconButton(
              icon: const CircleAvatar(backgroundColor: Colors.black45, child: Icon(Icons.arrow_back, color: Colors.white)),
              onPressed: () => Get.back(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: isDark ? const Color(0xFF242526) : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF242526) : Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(radius: 40, backgroundImage: AssetImage(widget.image)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title, style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black
                              )),
                              Text(widget.category, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(widget.followers, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isFollowing = !_isFollowing;
                            });
                             Get.snackbar(
                               'Success', 
                               _isFollowing ? 'Following ${widget.title}' : 'Unfollowed ${widget.title}', 
                               snackPosition: SnackPosition.BOTTOM,
                               backgroundColor: Colors.blue,
                               colorText: Colors.white,
                             );
                          },
                          icon: Icon(_isFollowing ? Icons.check : Icons.add),
                          label: Text(_isFollowing ? 'Following' : 'Follow'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isFollowing ? Colors.grey[300] : Colors.blue,
                            foregroundColor: _isFollowing ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.snackbar('Message', 'Opening chat with ${widget.title}', snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1));
                          },
                          icon: const Icon(Icons.message),
                          label: const Text('Message'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            foregroundColor: isDark ? Colors.white : Colors.black,
                            elevation: 0,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            Container(
                              color: isDark ? const Color(0xFF242526) : Colors.white,
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.share),
                                    title: Text('Share Page', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                                    onTap: () {
                                      Get.back();
                                      Get.snackbar('Share', 'Sharing link copied!', snackPosition: SnackPosition.BOTTOM);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.report),
                                    title: Text('Report Page', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                                    onTap: () {
                                      Get.back();
                                      Get.snackbar('Report', 'Page reported', snackPosition: SnackPosition.BOTTOM);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.block),
                                    title: Text('Block Page', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                                    onTap: () {
                                      Get.back();
                                      Get.snackbar('Block', 'Page blocked', snackPosition: SnackPosition.BOTTOM);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.more_horiz),
                        color: isDark ? Colors.white : Colors.black,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 8)),
          SliverToBoxAdapter(
             child: Container(
               color: isDark ? const Color(0xFF242526) : Colors.white,
               padding: const EdgeInsets.all(16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                   const SizedBox(height: 8),
                   Text('Official page for ${widget.title}. Sharing the latest updates and community news.', style: TextStyle(color: isDark ? Colors.grey[300] : Colors.grey[600])),
                   const SizedBox(height: 8),
                   Row(children: [Icon(Icons.link, size: 16, color: Colors.blue), SizedBox(width: 4), Text('www.${widget.title.removeAllWhitespace.toLowerCase()}.com', style: TextStyle(color: Colors.blue))]),
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
                            CircleAvatar(backgroundImage: AssetImage(widget.image)),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                                Text('2 hours ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Check out our latest update! #${widget.category}', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                        const SizedBox(height: 12),
                        Image.asset(AppAssets.post1, width: double.infinity, height: 200, fit: BoxFit.cover),
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
              childCount: 3,
            ),
          ),
        ],
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
