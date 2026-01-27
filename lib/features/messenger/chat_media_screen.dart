import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';

class ChatMediaScreen extends StatefulWidget {
  final Map<String, dynamic> chatInfo;

  const ChatMediaScreen({super.key, required this.chatInfo});

  @override
  State<ChatMediaScreen> createState() => _ChatMediaScreenState();
}

class _ChatMediaScreenState extends State<ChatMediaScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.chatInfo['name']),
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF1F2C34) : const Color(0xFF075E54),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Media'),
            Tab(text: 'Links'),
            Tab(text: 'Docs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMediaTab(),
          _buildLinksTab(),
          _buildDocsTab(),
        ],
      ),
    );
  }

  Widget _buildMediaTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          child: Image.asset(
            AppAssets.getRandomPost(),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
          ),
        );
      },
    );
  }

  Widget _buildLinksTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.link, color: Colors.blue),
          ),
          title: Text('Shared Link ${index + 1}'),
          subtitle: const Text('https://example.com/shared/link'),
          onTap: () {},
        );
      },
    );
  }

  Widget _buildDocsTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.insert_drive_file, color: Colors.red, size: 40),
          title: Text('Project_Plan_v${index + 1}.pdf'),
          subtitle: const Text('2.4 MB • 12/05/2025'),
          onTap: () {},
        );
      },
    );
  }
}
