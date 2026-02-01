import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/social_models.dart';
import '../controllers/home_controller.dart';
import '../post_detail_screen.dart';
import '../user_profile_screen.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.find<HomeController>();

    return GestureDetector(
      onTap: () => Get.to(() => PostDetailScreen(post: post)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? AppPalette.darkSurface : AppPalette.lightSurface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => UserProfileScreen(
                      username: post.username,
                      avatarUrl: post.avatarUrl,
                    )),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(post.avatarUrl),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.to(() => UserProfileScreen(
                        username: post.username,
                        avatarUrl: post.avatarUrl,
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.username,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            post.timestamp,
                            style: TextStyle(color: Colors.grey[500], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () => controller.showPostOptions(post.id),
                  ),
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  post.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Obx(() => GestureDetector(
                    onTap: () => controller.toggleLike(post.id),
                    child: Icon(
                      post.isLiked.value ? Icons.favorite : Icons.favorite_border,
                      size: 28,
                      color: post.isLiked.value ? Colors.red : null,
                    ),
                  )),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => controller.commentOnPost(post.id),
                    child: const Icon(Icons.comment_outlined, size: 26),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => controller.sharePost(post.id),
                    child: const Icon(Icons.send_outlined, size: 26),
                  ),
                  const Spacer(),
                  Obx(() => GestureDetector(
                    onTap: () => controller.toggleSave(post.id),
                    child: Image.asset(
                      AppAssets.savedIcon3d,
                      width: 28,
                      height: 28,
                      color: post.isSaved.value ? null : Colors.grey,
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                    '${post.likes.value} likes',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: '${post.username} ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: post.caption),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    if (post.comments.isNotEmpty) {
                      return GestureDetector(
                        onTap: () => controller.commentOnPost(post.id),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'View all ${post.comments.length} comments',
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
