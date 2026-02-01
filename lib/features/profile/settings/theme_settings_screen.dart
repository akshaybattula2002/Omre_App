import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(AppAssets.appearanceIcon3d, width: 28, height: 28),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildThemePreview(context),
          const SizedBox(height: 32),
          _buildThemeOption(
            context,
            'Light Mode',
            Icons.light_mode_outlined,
            ThemeMode.light,
          ),
          _buildThemeOption(
            context,
            'Dark Mode',
            Icons.dark_mode_outlined,
            ThemeMode.dark,
          ),
          _buildThemeOption(
            context,
            'System Default',
            Icons.settings_suggest_outlined,
            ThemeMode.system,
          ),
        ],
      ),
    );
  }

  Widget _buildThemePreview(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppPalette.accentBlue.withValues(alpha: 0.3), width: 2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20, backgroundColor: AppPalette.accentBlue.withValues(alpha: 0.2), child: const Icon(Icons.person, color: AppPalette.accentBlue)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 100, height: 10, decoration: BoxDecoration(color: isDark ? Colors.white : Colors.black, borderRadius: BorderRadius.circular(5))),
                  const SizedBox(height: 6),
                  Container(width: 60, height: 8, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(4))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Text(
              'This is a preview of how the app looks in your selected theme.',
              style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, String title, IconData icon, ThemeMode mode) {
    final isSelected = (mode == ThemeMode.dark && Get.isDarkMode) || (mode == ThemeMode.light && !Get.isDarkMode);

    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: isSelected 
          ? const Icon(Icons.radio_button_checked, color: AppPalette.accentBlue)
          : const Icon(Icons.radio_button_off, color: Colors.grey),
      onTap: () {
        Get.changeThemeMode(mode);
      },
    );
  }
}
