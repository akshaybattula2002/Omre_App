import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omre/core/constants/app_assets.dart';
import 'screens/town_hall_detail_screen.dart';

class TownHallScreen extends StatelessWidget {
  const TownHallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Town Hall', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildRepSection(theme, isDark),
          const SizedBox(height: 24),
          const Text(
            'Community Discussions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildDiscussionCard(
            'New Park Proposal',
            'Proposed design for the central park renovation.',
            'City Council',
            'Yesterday',
            AppAssets.cover1,
            isDark,
          ),
          _buildDiscussionCard(
            'Traffic Safety Measures',
            'Discussion on implementing new speed bumps in residential areas.',
            'Transport Dept',
            '2 days ago',
            AppAssets.cover2,
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildRepSection(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Representatives',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.blue[900]),
          ),
          const SizedBox(height: 16),
          _buildRepItem('Mayor Sarah Connor', 'Mayor', AppAssets.avatar1, isDark),
          const Divider(),
          _buildRepItem('Councilman John Doe', 'District 9', AppAssets.avatar2, isDark),
        ],
      ),
    );
  }

  Widget _buildRepItem(String name, String role, String img, bool isDark) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundImage: AssetImage(img)),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
      subtitle: Text(role, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[700])),
      trailing: ElevatedButton(
        onPressed: () {
          Get.bottomSheet(
            Container(
              color: isDark ? const Color(0xFF242526) : Colors.white,
              child: Wrap(
                children: [
                  ListTile(leading: const Icon(Icons.email), title: const Text('Email'), onTap: () => Get.back()),
                  ListTile(leading: const Icon(Icons.phone), title: const Text('Call'), onTap: () => Get.back()),
                  ListTile(leading: const Icon(Icons.message), title: const Text('Message'), onTap: () => Get.back()),
                ],
              ),
            ),
          );
        },
        child: const Text('Contact'),
      ),
    );
  }

  Widget _buildDiscussionCard(String title, String desc, String author, String time, String img, bool isDark) {
    return GestureDetector(
      onTap: () {
        Get.to(() => TownHallDetailScreen(
          title: title,
          description: desc,
          author: author,
          time: time,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF242526) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(img, height: 150, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? Colors.white : Colors.black)),
                  const SizedBox(height: 8),
                  Text(desc, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$author • $time', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View Details'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
