import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/theme/palette.dart';

class ActiveSessionsScreen extends StatelessWidget {
  const ActiveSessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppPalette.darkBackground : AppPalette.lightBackground,
      appBar: AppBar(
        title: const Text('Active Sessions', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppPalette.accentBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                   const Icon(Icons.info_outline, color: AppPalette.accentBlue),
                   const SizedBox(width: 12),
                   Expanded(
                     child: Text(
                       'Manage devices where you are currently signed in.',
                       style: TextStyle(color: isDark ? Colors.grey[300] : Colors.grey[800], fontSize: 13),
                     ),
                   ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildActiveDeviceTile(
              context,
              device: 'iPhone 15 Pro (Current)',
              location: 'San Francisco, USA',
              time: 'Active now',
              isCurrent: true,
            ),
            _buildActiveDeviceTile(
              context,
              device: 'MacBook Pro 16"',
              location: 'New York, USA',
              time: '2 hours ago',
            ),
            _buildActiveDeviceTile(
              context,
              device: 'iPad Air',
              location: 'London, UK',
              time: 'Yesterday',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'Success',
                    'Logged out of all other sessions',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Log out of all other sessions', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveDeviceTile(
    BuildContext context, {
    required String device,
    required String location,
    required String time,
    bool isCurrent = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppPalette.darkSurface : AppPalette.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isCurrent ? AppPalette.accentBlue.withOpacity(0.3) : Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isCurrent ? AppPalette.accentBlue : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              device.contains('iPhone') ? Icons.phone_iphone : Icons.laptop_mac,
              color: isCurrent ? Colors.white : Colors.grey,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text('$location • $time', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
          if (!isCurrent)
            IconButton(
              onPressed: () {},
              icon: Image.asset(AppAssets.logoutIcon3d, width: 20, height: 20),
            ),
        ],
      ),
    );
  }
}
