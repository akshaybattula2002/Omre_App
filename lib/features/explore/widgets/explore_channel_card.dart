import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreChannelCard extends StatelessWidget {
  final Map<String, dynamic> channel;
  final bool isDark;
  final VoidCallback onSubscribe;
  final VoidCallback? onTap;

  const ExploreChannelCard({
    super.key,
    required this.channel,
    required this.isDark,
    required this.onSubscribe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(channel['thumbnail']),
                ),
                const SizedBox(height: 12),
                Text(
                  channel['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${channel['subscribers']} Subs',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Obx(() {
            final rxIsSubscribed = channel['isSubscribed'];
            final isSubscribed = rxIsSubscribed is RxBool ? rxIsSubscribed.value : false;
            return SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed: onSubscribe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSubscribed ? Colors.grey[800] : Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                child: Text(
                  isSubscribed ? 'Subscribed' : 'Subscribe',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
