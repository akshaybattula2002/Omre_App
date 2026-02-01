import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';

class BlockedAccountsScreen extends StatelessWidget {
  const BlockedAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blockedUsers = [
      {'name': 'Spambot 2000', 'handle': '@spam_master', 'avatar': AppAssets.avatar3},
      {'name': 'Toxic User', 'handle': '@toxic_talk', 'avatar': AppAssets.avatar5},
      {'name': 'Annoying Account', 'handle': '@annoying_user', 'avatar': AppAssets.avatar2},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked Accounts', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(AppAssets.blockedAccountsIcon3d, width: 28, height: 28),
          ),
        ],
      ),
      body: blockedUsers.isEmpty
          ? const Center(child: Text('You haven\'t blocked anyone yet.'))
          : ListView.builder(
              itemCount: blockedUsers.length,
              itemBuilder: (context, index) {
                final user = blockedUsers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(user['avatar']!),
                  ),
                  title: Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(user['handle']!, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  trailing: OutlinedButton(
                    onPressed: () {
                      Get.snackbar('Unblocked', 'You have unblocked ${user['name']}', snackPosition: SnackPosition.BOTTOM);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppPalette.accentBlue),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Unblock', style: TextStyle(color: AppPalette.accentBlue, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                );
              },
            ),
    );
  }
}
