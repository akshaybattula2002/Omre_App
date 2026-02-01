import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsShareSheet extends StatelessWidget {
  const NewsShareSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    final shareApps = [
      {'name': 'WhatsApp', 'icon': Icons.message},
      {'name': 'Twitter', 'icon': Icons.close}, // Using close icon for X
      {'name': 'Facebook', 'icon': Icons.facebook},
      {'name': 'Instagram', 'icon': Icons.photo_camera},
      {'name': 'Copy Link', 'icon': Icons.link, 'assetPath': 'assets/images/link_icon_3d.png'},
      {'name': 'Threads', 'icon': Icons.alternate_email},
      {'name': 'Messenger', 'icon': Icons.chat_bubble},
      {'name': 'SMS', 'icon': Icons.sms},
    ];

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(77),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                'Share Story',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.close, color: textColor),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
              ),
              itemCount: shareApps.length,
              itemBuilder: (context, index) {
                final app = shareApps[index];
                return GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.snackbar(
                      'Shared',
                      'News link shared successfully via ${app['name']}',
                      backgroundColor: Colors.blue.withAlpha(25),
                      colorText: Colors.blue,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: app['assetPath'] != null
                            ? Image.asset(app['assetPath'] as String, width: 28, height: 28)
                            : Icon(app['icon'] as IconData, color: textColor, size: 28),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        app['name'] as String,
                        style: TextStyle(color: textColor, fontSize: 11),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
