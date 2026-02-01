import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/palette.dart';
import 'recovery_email_screen.dart';
import 'security_logs_screen.dart';
import 'active_sessions_screen.dart';
import '../../../core/constants/app_assets.dart';

class SecurityDetailsScreen extends StatefulWidget {
  const SecurityDetailsScreen({super.key});

  @override
  State<SecurityDetailsScreen> createState() => _SecurityDetailsScreenState();
}

class _SecurityDetailsScreenState extends State<SecurityDetailsScreen> {
  bool _twoFactorAuth = true;
  bool _biometricLogin = false;
  bool _appLock = true;
  bool _securityAlerts = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppPalette.darkBackground : AppPalette.lightBackground,
      appBar: AppBar(
        title: const Text('Security Details', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildSecurityScoreCard(isDark),
            const SizedBox(height: 24),
            _buildSectionHeader('Login & Recovery'),
            _buildSecurityTile(
              icon: Icons.key_outlined,
              title: 'Change Password',
              subtitle: 'Last updated 3 months ago',
              onTap: () => _showChangePasswordSheet(context),
            ),
            _buildSecurityTile(
              icon: Icons.verified_user_outlined,
              title: 'Two-Factor Authentication',
              subtitle: 'Secured with Google Authenticator',
              assetPath: AppAssets.securitySafeIcon3d,
              trailing: Switch(
                value: _twoFactorAuth,
                onChanged: (val) => setState(() => _twoFactorAuth = val),
                activeColor: AppPalette.accentBlue,
              ),
            ),
            _buildSecurityTile(
              icon: Icons.alternate_email,
              title: 'Recovery Email',
              subtitle: 'a***@gmail.com',
              onTap: () => Get.to(() => const RecoveryEmailScreen()),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Device Security'),
            _buildSecurityTile(
              icon: Icons.fingerprint,
              title: 'Biometric Login',
              subtitle: 'Use FaceID or Fingerprint',
              trailing: Switch(
                value: _biometricLogin,
                onChanged: (val) => setState(() => _biometricLogin = val),
                activeColor: AppPalette.accentBlue,
              ),
            ),
            _buildSecurityTile(
              icon: Icons.phonelink_lock_outlined,
              title: 'App Lock',
              subtitle: 'Require PIN on startup',
              trailing: Switch(
                value: _appLock,
                onChanged: (val) => setState(() => _appLock = val),
                activeColor: AppPalette.accentBlue,
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Active Sessions'),
            _buildSecurityTile(
              icon: Icons.devices,
              title: 'Active Sessions',
              subtitle: 'Manage devices logged into your account',
              onTap: () => Get.to(() => const ActiveSessionsScreen()),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Advanced Settings'),
            _buildSecurityTile(
              icon: Icons.notifications_active_outlined,
              title: 'Security Alerts',
              subtitle: 'Notify on suspicious activity',
              trailing: Switch(
                value: _securityAlerts,
                onChanged: (val) => setState(() => _securityAlerts = val),
                activeColor: AppPalette.accentBlue,
              ),
            ),
            _buildSecurityTile(
              icon: Icons.history,
              title: 'Security Logs',
              subtitle: 'View all account activities',
              onTap: () => Get.to(() => const SecurityLogsScreen()),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityScoreCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppPalette.accentBlue,
            AppPalette.accentBlue.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppPalette.accentBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Security Score',
                      style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Very Secure',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Last scan today at 10:45 AM',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      value: 0.92,
                      strokeWidth: 8,
                      backgroundColor: Colors.white24,
                      color: Colors.white,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  const Text(
                    '92%',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppPalette.accentBlue),
      ),
    );
  }

  Widget _buildSecurityTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    String? assetPath,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppPalette.darkSurface : AppPalette.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppPalette.accentBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: assetPath != null 
              ? Image.asset(assetPath, width: 20, height: 20)
              : Icon(icon, color: AppPalette.accentBlue, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _showChangePasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
          top: 32,
          left: 24,
          right: 24,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildTextField('Current Password', true),
            const SizedBox(height: 16),
            _buildTextField('New Password', true),
            const SizedBox(height: 16),
            _buildTextField('Confirm New Password', true),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.accentBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Update Password', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, bool isPassword) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
