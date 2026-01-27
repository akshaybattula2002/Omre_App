import 'package:flutter/material.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Saved', style: TextStyle(fontWeight: FontWeight.bold)),
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Posts'),
              Tab(text: 'Collections'),
            ],
            indicatorColor: AppPalette.accentBlue,
            labelColor: AppPalette.accentBlue,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            _buildSavedGrid(),
            _buildCollections(),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: 18,
      itemBuilder: (context, index) {
        return Image.asset(
          AppAssets.getRandomPost(),
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildCollections() {
    final collections = [
      {'name': 'Design Inspiration', 'count': 42},
      {'name': 'Travel 2024', 'count': 15},
      {'name': 'Coding Tips', 'count': 89},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final collection = collections[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppAssets.getRandomThumbnail(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(collection['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${collection['count']} items', style: TextStyle(color: Colors.grey[500])),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
    );
  }
}

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({super.key});

  final faqs = [
    'How do I change my password?',
    'What is OMRE Business?',
    'How to report a post?',
    'Managing privacy settings',
    'Updating profile information',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search help articles...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildOption(Icons.headset_mic_outlined, 'Contact Support', 'Get help from our team 24/7'),
            _buildOption(Icons.info_outline, 'About OMRE', 'Learn about our community and values'),
            _buildOption(Icons.description_outlined, 'Terms & Privacy', 'Read our policies'),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Frequently Asked Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            ...faqs.map((faq) => _buildFaqTile(faq)),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: AppPalette.accentBlue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () {},
      ),
    );
  }

  Widget _buildFaqTile(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: const Icon(Icons.add, size: 20, color: Colors.grey),
      shape: Border(bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
      onTap: () {},
    );
  }
}
