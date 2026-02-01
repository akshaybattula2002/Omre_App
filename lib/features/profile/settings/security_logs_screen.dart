import 'package:flutter/material.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';

class SecurityLogsScreen extends StatelessWidget {
  const SecurityLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final logs = [
      {
        'title': 'New Login',
        'device': 'iPhone 15 Pro',
        'location': 'San Francisco, USA',
        'time': 'Just now',
        'icon': Icons.login,
        'color': Colors.green,
      },
      {
        'title': 'Password Changed',
        'device': 'Web Browser',
        'location': 'San Francisco, USA',
        'time': '2 hours ago',
        'icon': Icons.lock_reset,
        'color': Colors.orange,
      },
      {
        'title': '2FA Enabled',
        'device': 'MacBook Pro',
        'location': 'New York, USA',
        'time': 'Yesterday',
        'icon': Icons.security,
        'assetPath': AppAssets.securitySafeIcon3d,
        'color': AppPalette.accentBlue,
      },
      {
        'title': 'Failed Login Attempt',
        'device': 'Unknown Device',
        'location': 'London, UK',
        'time': '2 days ago',
        'icon': Icons.warning_amber_rounded,
        'color': Colors.red,
      },
       {
        'title': 'Recovery Email Added',
        'device': 'iPhone 15 Pro',
        'location': 'San Francisco, USA',
        'time': '3 days ago',
        'icon': Icons.mark_email_read,
        'color': Colors.purple,
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? AppPalette.darkBackground : AppPalette.lightBackground,
      appBar: AppBar(
        title: const Text('Security Logs', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: logs.length,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 56, top: 8, bottom: 8),
          child: Divider(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        itemBuilder: (context, index) {
          final log = logs[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (log['color'] as Color).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: log['assetPath'] != null 
                    ? Image.asset(log['assetPath'] as String, width: 20, height: 20)
                    : Icon(log['icon'] as IconData, color: log['color'] as Color, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${log['device']} • ${log['location']}',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                  ],
                ),
              ),
              Text(
                log['time'] as String,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          );
        },
      ),
    );
  }
}
