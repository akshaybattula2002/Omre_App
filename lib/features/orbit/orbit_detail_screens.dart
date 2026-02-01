import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import 'controllers/orbit_controller.dart';
import 'orbit_topic_detail_screen.dart';

class OrbitSpaceDetailScreen extends StatelessWidget {
  final String title;
  final String host;

  const OrbitSpaceDetailScreen({super.key, required this.title, required this.host});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down, color: theme.iconTheme.color, size: 32),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(color: Colors.deepPurple.withOpacity(0.3), blurRadius: 30, spreadRadius: 10),
              ],
            ),
            child: const Icon(Icons.graphic_eq, size: 80, color: Colors.white),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Hosted by $host',
            style: TextStyle(color: theme.textTheme.bodySmall?.color, fontSize: 16),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildParticipant(AppAssets.avatar1, 'Host'),
              _buildParticipant(AppAssets.avatar2, 'Sarah'),
              _buildParticipant(AppAssets.avatar3, 'Mike'),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.exit_to_app, size: 18),
                  label: const Text('Leave quietly'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.1),
                    foregroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.front_hand_outlined),
                  onPressed: () => Get.snackbar('Spaces', 'Requesting to speak...'),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: IconButton(
                    icon: const Icon(Icons.mic_none, color: Colors.white),
                    onPressed: () => Get.snackbar('Spaces', 'Mic is muted by host'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipant(String avatar, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          CircleAvatar(radius: 30, backgroundImage: AssetImage(avatar)),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class OrbitCommunityDetailScreen extends StatelessWidget {
  final String name;

  const OrbitCommunityDetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.find<OrbitController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(name),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(child: Icon(Icons.groups, size: 80, color: Colors.white.withOpacity(0.5))),
              ),
            ),
            actions: [
              Obx(() {
                final isJoined = controller.joinedCommunities.contains(name);
                return TextButton(
                  onPressed: () => controller.toggleCommunity(name),
                  child: Text(
                    isJoined ? 'Joined' : 'Join',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About this Community',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A space for enthusiasts to discuss latest updates, share insights, and connect with like-minded individuals in the $name sphere.',
                    style: TextStyle(color: theme.textTheme.bodySmall?.color, height: 1.5),
                  ),
                  const Divider(height: 40),
                  const Text(
                    'Recent Discussions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final topic = controller.allTopics[index % controller.allTopics.length];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.chat_bubble_outline, size: 18)),
                  title: Text(topic.title),
                  subtitle: Text(topic.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () => Get.to(() => OrbitTopicDetailScreen(topic: topic)),
                );
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class OrbitListDetailScreen extends StatelessWidget {
  final String name;

  const OrbitListDetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrbitController>();

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          final topic = controller.allTopics[index % controller.allTopics.length];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(topic.description),
              ),
              onTap: () => Get.to(() => OrbitTopicDetailScreen(topic: topic)),
            ),
          );
        },
      ),
    );
  }
}
