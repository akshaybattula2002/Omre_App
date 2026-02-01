import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/constants/app_assets.dart';
import '../controllers/home_controller.dart';
import 'dart:io';

class CreatePostWidget extends GetView<HomeController> {
  const CreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      color: isDark ? AppPalette.darkSurface : AppPalette.lightSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[800],
                backgroundImage: const AssetImage(AppAssets.avatar1),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller.postTextController,
                  decoration: InputDecoration(
                    hintText: "What's happening?",
                    hintStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
              ),
            ],
          ),
          Obx(() {
             if (controller.selectedImage.value != null) {
               return Padding(
                 padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                 child: Stack(
                   children: [
                     Image.file(controller.selectedImage.value!, height: 200, fit: BoxFit.cover),
                     Positioned(right: 0, top: 0, child: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => controller.selectedImage.value = null)),
                   ],
                 ),
               );
             }
             if (controller.selectedVideo.value != null) {
               return Container(
                 padding: const EdgeInsets.all(8),
                 color: Colors.black12,
                 child: Row(children: [
                   const Icon(Icons.videocam), 
                   const SizedBox(width: 8), 
                   Expanded(child: Text(controller.selectedVideo.value!.path.split('/').last)),
                   IconButton(icon: const Icon(Icons.close), onPressed: () => controller.selectedVideo.value = null)
                 ]),
               );
             }
             return const SizedBox.shrink();
          }),
          Obx(() => controller.selectedFeeling.value != null 
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Chip(
                    label: Text('Feeling ${controller.selectedFeeling.value}'),
                    onDeleted: () => controller.selectedFeeling.value = null,
                  ),
                )
              : const SizedBox.shrink()
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _ActionButton(
                    icon: Icons.image,
                    label: 'Photo',
                    color: Colors.blue,
                    onTap: controller.pickImage,
                    assetPath: AppAssets.imagesIcon3d,
                  ),
                  const SizedBox(width: 16),
                  _ActionButton(
                    icon: Icons.videocam,
                    label: 'Video',
                    color: Colors.green,
                    onTap: controller.pickVideo,
                    assetPath: 'assets/images/video_icon_3d.png',
                  ),
                  const SizedBox(width: 16),
                  _ActionButton(
                    icon: Icons.sentiment_satisfied,
                    label: 'Feeling',
                    color: Colors.orange,
                    onTap: controller.selectFeeling,
                    assetPath: AppAssets.happyCornerIcon3d,
                  ),
                ],
              ),
              Obx(() => ElevatedButton(
                onPressed: controller.isPosting.value ? null : controller.createPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.accentBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                ),
                child: controller.isPosting.value 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Post'),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  final String? assetPath;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          assetPath != null
              ? Image.asset(assetPath!, width: 20, height: 20)
              : Icon(icon, color: color, size: 20),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
