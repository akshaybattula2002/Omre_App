import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omre/core/constants/app_assets.dart';
import 'screens/friend_profile_screen.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Friends', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search, color: theme.iconTheme.color), onPressed: () {}),
          IconButton(icon: Icon(Icons.person_add, color: theme.iconTheme.color), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildRequestSection(theme, isDark),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Friends',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
              ),
              Text(
                '245 Friends',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFriendItem('Sarah Williams', true, AppAssets.avatar1, AppAssets.cover1, isDark),
          _buildFriendItem('Mike Chen', false, AppAssets.avatar2, AppAssets.cover2, isDark),
          _buildFriendItem('Emma Wilson', true, AppAssets.avatar3, AppAssets.cover3, isDark),
          _buildFriendItem('David Brown', false, AppAssets.avatar1, AppAssets.cover1, isDark),
          _buildFriendItem('Lisa Wang', true, AppAssets.avatar2, AppAssets.cover2, isDark),
        ],
      ),
    );
  }

  Widget _buildRequestSection(ThemeData theme, bool isDark) {
    return Column(
      children: [
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text('Friend Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
             Text('See All', style: TextStyle(color: Colors.blue)),
           ],
        ),
        const SizedBox(height: 12),
        _buildRequestItem('John Doe', '2 mutual friends', AppAssets.avatar1, isDark),
        _buildRequestItem('Jane Smith', '1 mutual friend', AppAssets.avatar2, isDark),
      ],
    );
  }

  Widget _buildRequestItem(String name, String mutual, String img, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 30, backgroundImage: AssetImage(img)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)),
                Text(mutual, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () { Get.snackbar('Confirmed', 'You are now friends with $name', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white); },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 0)),
                        child: const Text('Confirm'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () { Get.snackbar('Deleted', 'Request removed', snackPosition: SnackPosition.BOTTOM); },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 0)),
                        child: const Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem(String name, bool isOnline, String img, String cover, bool isDark) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: GestureDetector(
        onTap: () => Get.to(() => FriendProfileScreen(name: name, image: img, cover: cover, isFriend: true)),
        child: Stack(
          children: [
            CircleAvatar(radius: 24, backgroundImage: AssetImage(img)),
            if (isOnline)
              Positioned(
                right: 0, bottom: 0,
                child: Container(
                  width: 12, height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: isDark ? Colors.black : Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
      trailing: IconButton(
        icon: Icon(Icons.chat_bubble_outline, color: Colors.grey[600]),
        onPressed: () {},
      ),
      onTap: () => Get.to(() => FriendProfileScreen(name: name, image: img, cover: cover, isFriend: true)),
    );
  }
}
