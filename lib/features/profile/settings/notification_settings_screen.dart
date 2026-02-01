import 'package:flutter/material.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // State variables
  bool _pauseAll = false;
  bool _likes = true;
  bool _comments = true;
  bool _photosOfYou = true;
  bool _newFollowers = true;
  bool _acceptedFollowRequests = false;
  bool _messageRequests = true;
  bool _groupRequests = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(AppAssets.notificationIcon3d, width: 28, height: 28),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildToggle('Pause All', _pauseAll, (val) => setState(() => _pauseAll = val)),
          const Divider(),
          _buildSection('Posts, Stories and Comments'),
          _buildToggle('Likes', _likes, (val) => setState(() => _likes = val)),
          _buildToggle('Comments', _comments, (val) => setState(() => _comments = val)),
          _buildToggle('Photos of You', _photosOfYou, (val) => setState(() => _photosOfYou = val)),
          _buildSection('Following and Followers'),
          _buildToggle('New Followers', _newFollowers, (val) => setState(() => _newFollowers = val)),
          _buildToggle('Accepted Follow Requests', _acceptedFollowRequests, (val) => setState(() => _acceptedFollowRequests = val)),
          _buildSection('Messages'),
          _buildToggle('Message Requests', _messageRequests, (val) => setState(() => _messageRequests = val)),
          _buildToggle('Group Requests', _groupRequests, (val) => setState(() => _groupRequests = val)),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildToggle(String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: _pauseAll && title != 'Pause All' ? null : onChanged, // Disable others if Pause All is on? Or just let them toggle independently? User didn't specify logic. I'll just let them toggle unless "Pause All" implies disabling. A common pattern is Pause All creates an override. Let's keep it simple and just allow toggling for now to match specific user request "working".
        activeThumbColor: AppPalette.accentBlue,
      ),
    );
  }
}
