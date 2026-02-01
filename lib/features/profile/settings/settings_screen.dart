import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';
import 'personal_info_screen.dart';
import 'security_details_screen.dart';
import 'notification_settings_screen.dart';
import 'language_screen.dart';
import 'theme_settings_screen.dart';
import 'data_usage_screen.dart';
import 'privacy_settings_screen.dart';
import 'blocked_accounts_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSection('Account', [
            _buildTile(Icons.person_pin_outlined, 'Personal Information', onTap: () => Get.to(() => const PersonalInfoScreen()), assetPath: AppAssets.personalInfoIcon3d),
            _buildTile(Icons.security_outlined, 'Security', onTap: () => Get.to(() => const SecurityDetailsScreen()), assetPath: AppAssets.securitySafeIcon3d),
            _buildTile(Icons.language_outlined, 'Language', onTap: () => Get.to(() => const LanguageScreen()), assetPath: AppAssets.languageIcon3d),
          ]),
          _buildSection('App Settings', [
            _buildTile(Icons.notifications_none_outlined, 'Notifications', onTap: () => Get.to(() => const NotificationSettingsScreen()), assetPath: AppAssets.notificationIcon3d),
            _buildTile(Icons.dark_mode_outlined, 'Appearance', onTap: () => Get.to(() => const ThemeSettingsScreen()), assetPath: AppAssets.appearanceIcon3d),
            _buildTile(Icons.data_usage_outlined, 'Data Usage', onTap: () => Get.to(() => const DataUsageScreen()), assetPath: AppAssets.dataUsageIcon3d),
          ]),
          _buildSection('Privacy', [
            _buildTile(Icons.lock_outline_rounded, 'Account Privacy', onTap: () => Get.to(() => const PrivacySettingsScreen()), assetPath: AppAssets.accountPrivacyIcon3d),
            _buildTile(Icons.block_flipped, 'Blocked Accounts', onTap: () => Get.to(() => const BlockedAccountsScreen()), assetPath: AppAssets.blockedAccountsIcon3d),
          ]),
          const SizedBox(height: 32),
          Center(
            child: TextButton(
              onPressed: () => Get.offAllNamed('/login'),
              child: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text('Version 1.0.42 (Beta)', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppPalette.accentBlue)),
        ),
        ...children,
      ],
    );
  }

  Widget _buildTile(IconData icon, String title, {Widget? trailing, VoidCallback? onTap, String? assetPath}) {
    return ListTile(
      leading: assetPath != null 
          ? Image.asset(assetPath, width: 22, height: 22)
          : Icon(icon, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
      onTap: onTap ?? (trailing == null ? () {} : null),
    );
  }
}
