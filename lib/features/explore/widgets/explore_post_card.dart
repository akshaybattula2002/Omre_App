import 'package:flutter/material.dart';
import '../../../../core/theme/palette.dart';

class ExplorePostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  final bool isDark;

  const ExplorePostCard({super.key, required this.post, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(post['avatar']),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['username'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    post['time'],
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post['content'],
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              post['image'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(post['likes'], style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.chat_bubble_outline, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(post['comments'], style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.share_outlined, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(post['shares'], style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
