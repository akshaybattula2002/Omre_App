import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogDetailScreen extends StatelessWidget {
  final String title;
  final String category;
  final String author;
  final String time;
  final String image;
  final String content;

  const BlogDetailScreen({
    super.key,
    required this.title,
    required this.category,
    required this.author,
    required this.time,
    required this.image,
    this.content = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(image, fit: BoxFit.cover),
            ),
            leading: IconButton(
              icon: const CircleAvatar(backgroundColor: Colors.black45, child: Icon(Icons.arrow_back, color: Colors.white)),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(icon: const CircleAvatar(backgroundColor: Colors.black45, child: Icon(Icons.bookmark_border, color: Colors.white)), onPressed: () {}),
              IconButton(icon: const CircleAvatar(backgroundColor: Colors.black45, child: Icon(Icons.share, color: Colors.white)), onPressed: () {}),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                     decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                     child: Text(category, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
                   ),
                   const SizedBox(height: 12),
                   Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 16),
                   Row(
                     children: [
                       CircleAvatar(radius: 16, backgroundColor: Colors.grey[300], child: Icon(Icons.person, size: 20, color: Colors.grey[600])),
                       const SizedBox(width: 8),
                       Text(author, style: const TextStyle(fontWeight: FontWeight.bold)),
                       const SizedBox(width: 8),
                       const Text('•', style: TextStyle(color: Colors.grey)),
                       const SizedBox(width: 8),
                       Text(time, style: const TextStyle(color: Colors.grey)),
                     ],
                   ),
                   const SizedBox(height: 24),
                   Text(content, style: const TextStyle(fontSize: 16, height: 1.6)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
