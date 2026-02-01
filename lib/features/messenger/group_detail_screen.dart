import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';

class GroupDetailScreen extends StatelessWidget {
  final String name;
  final String avatar;
  
  const GroupDetailScreen({super.key, required this.name, required this.avatar});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Group Header Info
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(backgroundImage: AssetImage(avatar), radius: 40),
                const SizedBox(height: 12),
                Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Active today', style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(Icons.search, 'Search', isDark),
                    _buildActionButton(Icons.notifications_outlined, 'Mute', isDark),
                    _buildActionButton(Icons.person_add_outlined, 'Add', isDark, assetPath: AppAssets.personalInfoIcon3d),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          
          // Members List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('32 Members', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
          ),
          
          Expanded(
            child: ListView(
              children: [
                _buildMemberItem('You', 'Admin', AppAssets.avatar1, isDark),
                _buildMemberItem('Sarah Jenkins', null, AppAssets.avatar2, isDark),
                _buildMemberItem('Mike Ross', null, AppAssets.avatar3, isDark),
                _buildMemberItem('John Doe', null, AppAssets.avatar4, isDark),
                _buildMemberItem('Alice Smith', null, AppAssets.avatar5, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, bool isDark, {String? assetPath}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[800] : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: assetPath != null 
              ? Image.asset(assetPath, width: 24, height: 24)
              : Icon(icon, color: isDark ? Colors.white : Colors.black87),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildMemberItem(String name, String? role, String avatar, bool isDark) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(avatar)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: role != null ? Text(role, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)) : null,
      trailing: role == 'Admin' ? null : IconButton(icon: const Icon(Icons.message_outlined), onPressed: () {}),
    );
  }
}
