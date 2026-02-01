import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = [
      {'name': 'English (US)', 'code': 'en_US', 'native': 'English'},
      {'name': 'English (UK)', 'code': 'en_GB', 'native': 'English'},
      {'name': 'Hindi', 'code': 'hi_IN', 'native': 'हिन्दी'},
      {'name': 'Spanish', 'code': 'es_ES', 'native': 'Español'},
      {'name': 'French', 'code': 'fr_FR', 'native': 'Français'},
      {'name': 'German', 'code': 'de_DE', 'native': 'Deutsch'},
      {'name': 'Chinese', 'code': 'zh_CN', 'native': '中文'},
      {'name': 'Japanese', 'code': 'ja_JP', 'native': '日本語'},
      {'name': 'Arabic', 'code': 'ar_SA', 'native': 'العربية'},
    ];

    final currentLanguage = 'en_US'; // Mock current language

    return Scaffold(
      appBar: AppBar(
        title: const Text('Language', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(AppAssets.languageIcon3d, width: 28, height: 28),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: languages.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final lang = languages[index];
          final isSelected = lang['code'] == currentLanguage;

          return ListTile(
            title: Text(lang['name']!),
            subtitle: Text(lang['native']!, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            trailing: isSelected 
                ? const Icon(Icons.check_circle, color: AppPalette.accentBlue) 
                : null,
            onTap: () {
              Get.back();
              Get.snackbar('Language Changed', 'App language set to ${lang['name']}', snackPosition: SnackPosition.BOTTOM);
            },
          );
        },
      ),
    );
  }
}
