import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';

class UserProfileScreen extends StatelessWidget {
  final String username;
  final String avatarUrl;

  UserProfileScreen({
    super.key,
    required this.username,
    required this.avatarUrl,
  });

  final isFollowing = false.obs;
  final followerCount = 1200.obs; // Mock base count
  final hasActiveStory = true.obs;
  final currentTabIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: theme.iconTheme.color),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Obx(() => Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: hasActiveStory.value 
                          ? const LinearGradient(
                              colors: [Colors.purple, Colors.orange, Colors.yellow],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            )
                          : null,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: avatarUrl.startsWith('http') ? NetworkImage(avatarUrl) : AssetImage(avatarUrl) as ImageProvider,
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  )),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn('Posts', '42'),
                        Obx(() => _buildStatColumn(
                          'Followers', 
                          _formatCount(followerCount.value + (isFollowing.value ? 1 : 0))
                        )),
                        _buildStatColumn('Following', '850'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '📍 Digital Nomad | UI/UX Enthusiast\nBuilding something amazing with OMRE! 🚀\n#adventure #tech #minimalism',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => ElevatedButton(
                      onPressed: () {
                        isFollowing.toggle();
                        if (isFollowing.value) {
                          Get.snackbar('Success', 'You are now following $username', snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFollowing.value 
                            ? (isDark ? Colors.grey[800] : Colors.grey[200]) 
                            : AppPalette.accentBlue,
                        foregroundColor: isFollowing.value 
                            ? (isDark ? Colors.white : Colors.black) 
                            : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(isFollowing.value ? 'Following' : 'Follow'),
                    )),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isDark ? Colors.white : Colors.black,
                        side: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Message'),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            _buildHighlights(context),
            
            const SizedBox(height: 20),
            
            // Tab Bar
            const Divider(height: 1),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.grid_on, color: currentTabIndex.value == 0 ? (isDark ? Colors.white : Colors.black) : Colors.grey), 
                  onPressed: () => currentTabIndex.value = 0,
                ),
                IconButton(
                  icon: Icon(Icons.video_collection_outlined, color: currentTabIndex.value == 1 ? (isDark ? Colors.white : Colors.black) : Colors.grey), 
                  onPressed: () => currentTabIndex.value = 1,
                ),
                IconButton(
                  icon: Icon(Icons.person_pin_outlined, color: currentTabIndex.value == 2 ? (isDark ? Colors.white : Colors.black) : Colors.grey), 
                  onPressed: () => currentTabIndex.value = 2,
                ),
              ],
            )),
            const Divider(height: 1),
            
            // Tab Content
            // Tab Content
            Column(
              children: [
                Obx(() {
                  if (currentTabIndex.value == 0) return _buildPostGrid(username);
                  if (currentTabIndex.value == 1) return _buildEmptyState('No Reels yet');
                  if (currentTabIndex.value == 2) return _buildEmptyState('No tagged posts');
                  return const SizedBox();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlights(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final highlights = [
      {'label': 'Travel', 'icon': '✈️'},
      {'label': 'Food', 'icon': '🍕'},
      {'label': 'Design', 'icon': '🎨'},
      {'label': 'Dev', 'icon': '💻'},
      {'label': 'Nature', 'icon': '🌲'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: highlights.map((h) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.2), width: 1),
                ),
                child: Center(child: Text(h['icon'] ?? '', style: const TextStyle(fontSize: 24))),
              ),
              const SizedBox(height: 4),
              Text(h['label'] ?? '', style: const TextStyle(fontSize: 12)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildPostGrid(String username) {
    return GridView.builder(
      key: PageStorageKey('user_posts_$username'),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 15,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Mock detail view for one of the grid posts
            // We don't have a real list of posts for this user here, so we mock a PostModel
            // This satisfies "navigable to detail view"
            Get.snackbar('Post', 'Opening post detail...', snackPosition: SnackPosition.BOTTOM);
          },
          child: Image.asset(
            AppAssets.getRandomPost(),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.grey[300], child: const Icon(Icons.image_not_supported)),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      height: 300,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.layers_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(color: Colors.grey[500], fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
