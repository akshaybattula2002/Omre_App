import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreUserCard extends StatelessWidget {
  final Map<String, dynamic> user;
  final bool isDark;
  final VoidCallback onFollow;

  const ExploreUserCard({
    super.key,
    required this.user,
    required this.isDark,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
         border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(user['avatar']),
        ),
        title: Text(
          user['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          '${user['handle']} • ${user['followers']} followers',
          style: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: Obx(() {
          final rxIsFollowing = user['isFollowing'];
          final isFollowing = rxIsFollowing is RxBool ? rxIsFollowing.value : false;
          return SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: onFollow,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowing ? (isDark ? Colors.grey[800] : Colors.grey[300]) : Colors.blueAccent,
                foregroundColor: isFollowing ? (isDark ? Colors.white : Colors.black) : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                elevation: 0,
              ),
              child: Text(
                isFollowing ? 'Following' : 'Follow',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }),
      ),
    );
  }
}
