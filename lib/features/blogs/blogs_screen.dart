import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omre/core/constants/app_assets.dart';
import 'screens/create_blog_screen.dart';
import 'screens/blog_detail_screen.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Blogs', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: Image.asset('assets/images/search_icon_3d.png', width: 24, height: 24), onPressed: () {}),
          IconButton(icon: Icon(Icons.bookmark_border, color: theme.iconTheme.color), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const CreateBlogScreen()),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeaturedBlog(isDark),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest Articles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
              ),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const SizedBox(height: 12),
          _buildBlogItem(
            'The Future of Flutter Development',
            'Technology • 5 min read',
            AppAssets.post1,
            isDark,
          ),
           _buildBlogItem(
            'Healthy Habits for Remote Workers',
            'Lifestyle • 8 min read',
            AppAssets.post2,
            isDark,
          ),
           _buildBlogItem(
            'Travel Guide: exploring Tokyo',
            'Travel • 12 min read',
            AppAssets.post3,
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBlog(bool isDark) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const BlogDetailScreen(
          title: 'Mastering State Management',
          category: 'Development',
          author: 'John Doe',
          time: '10 min read',
          image: AppAssets.cover1,
        ));
      },
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(AppAssets.cover1),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Featured', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Mastering State Management',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'A comprehensive guide to GetX, Provider, and Bloc.',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogItem(String title, String subtitle, String imageUrl, bool isDark) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BlogDetailScreen(
          title: title,
          category: subtitle.split('•')[0].trim(),
          author: 'Jane Smith',
          time: subtitle.split('•')[1].trim(),
          image: imageUrl,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageUrl,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
