import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;

  const ImageDetailScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Main Image
          Center(
            child: Hero(
              tag: imageUrl,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Top Controls
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircularButton(
                  Icons.arrow_back,
                  onTap: () => Get.back(),
                ),
                Row(
                  children: [
                    _buildCircularButton(Icons.share_outlined, onTap: () {
                      Get.snackbar('Shared', 'Image link copied to clipboard', snackPosition: SnackPosition.BOTTOM);
                    }),
                    const SizedBox(width: 12),
                    _buildCircularButton(Icons.more_vert, onTap: () {}),
                  ],
                ),
              ],
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.snackbar('Processing', 'Setting as wallpaper...', snackPosition: SnackPosition.BOTTOM);
                    },
                    icon: const Icon(Icons.wallpaper),
                    label: const Text('Set as Wallpaper'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2555C8),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                _buildCircularButton(
                  Icons.download_outlined,
                  size: 56,
                  iconSize: 28,
                  onTap: () {
                    Get.snackbar('Download', 'Saving image to gallery...', snackPosition: SnackPosition.BOTTOM);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton(IconData icon, {VoidCallback? onTap, double size = 44, double iconSize = 22}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: iconSize),
      ),
    );
  }
}
