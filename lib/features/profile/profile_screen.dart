import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_detail_screens.dart';
import 'settings/settings_screen.dart';
import '../../core/constants/app_assets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(AppAssets.avatar1),
          ),
          const SizedBox(height: 16),
          Text(
            'Alex Johnson',
            style: theme.textTheme.headlineMedium,
          ),
          Text(
            '@alexj_design',
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(label: 'Posts', value: '128'),
              _StatItem(label: 'Followers', value: '12.4k'),
              _StatItem(label: 'Following', value: '450'),
            ],
          ),
          const SizedBox(height: 32),
          _ProfileOption(icon: Icons.settings, label: 'Settings', onTap: () => Get.to(() => const SettingsScreen())),
          _ProfileOption(icon: Icons.bookmark_outline, label: 'Saved', onTap: () => Get.to(() => const SavedScreen())),
          _ProfileOption(icon: Icons.help_outline, label: 'Help Center', onTap: () => Get.to(() => HelpCenterScreen())),
          _ProfileOption(
            icon: Icons.logout, 
            label: 'Logout', 
            isDestructive: true,
            onTap: () => Get.offAllNamed('/login'),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
      ],
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;
  final VoidCallback? onTap;

  const _ProfileOption({
    required this.icon,
    required this.label,
    this.isDestructive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : null),
      title: Text(
        label,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
