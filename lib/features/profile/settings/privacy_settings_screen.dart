import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';
import 'blocked_accounts_screen.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _isPrivateAccount = false;
  bool _showActivityStatus = true;
  
  String _mentions = 'Everyone';
  String _tags = 'Everyone';
  String _comments = 'Everyone';
  String _messages = 'Everyone';

  void _showSelector(String title, String currentValue, Function(String) onSelect) {
    final options = ['Everyone', 'People You Follow', 'No One'];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 20,
          top: 20,
          left: 16,
          right: 16
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...options.map((option) => ListTile(
              title: Text(option),
              trailing: option == currentValue 
                  ? const Icon(Icons.check_circle, color: AppPalette.accentBlue) 
                  : null,
              onTap: () {
                onSelect(option);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(AppAssets.accountPrivacyIcon3d, width: 28, height: 28),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSection('Account Privacy', [
            _buildToggle(
              'Private Account', 
              _isPrivateAccount, 
              'Only people you approve can see your photos and videos.',
              (val) => setState(() => _isPrivateAccount = val),
            ),
             _buildToggle(
              'Activity Status', 
              _showActivityStatus, 
              'Allow accounts you follow and anyone you message to see when you were last active.',
              (val) => setState(() => _showActivityStatus = val),
            ),
          ]),
          _buildSection('Interactions', [
            _buildTile(Icons.alternate_email, 'Mentions', _mentions, 
              onTap: () => _showSelector('Allow Mentions From', _mentions, (val) => setState(() => _mentions = val))),
            _buildTile(Icons.label_outline, 'Tags', _tags, 
              onTap: () => _showSelector('Allow Tags From', _tags, (val) => setState(() => _tags = val))),
            _buildTile(Icons.comment_outlined, 'Comments', _comments, 
              onTap: () => _showSelector('Allow Comments From', _comments, (val) => setState(() => _comments = val))),
            _buildTile(Icons.message_outlined, 'Messages', _messages, 
              onTap: () => _showSelector('Message Requests From', _messages, (val) => setState(() => _messages = val))),
          ]),
          _buildSection('Connections', [
            _buildTile(Icons.block_flipped, 'Blocked Accounts', null, 
              onTap: () => Get.to(() => const BlockedAccountsScreen()), assetPath: AppAssets.blockedAccountsIcon3d),
            _buildTile(Icons.person_off_outlined, 'Restricted Accounts', null,
              onTap: () => Get.to(() => const GenericUserListScreen(title: 'Restricted Accounts', emptyMessage: 'No accounts restricted.'))),
            _buildTile(Icons.visibility_off_outlined, 'Muted Accounts', null,
              onTap: () => Get.to(() => const GenericUserListScreen(title: 'Muted Accounts', emptyMessage: 'No accounts muted.'))),
          ]),
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

  Widget _buildToggle(String title, bool value, String subtitle, Function(bool) onChanged) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppPalette.accentBlue,
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, String? value, {VoidCallback? onTap, String? assetPath}) {
    return ListTile(
      leading: assetPath != null 
          ? Image.asset(assetPath, width: 22, height: 22)
          : Icon(icon, size: 22),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null) Text(value, style: const TextStyle(color: Colors.grey)),
          const Icon(Icons.chevron_right, size: 20),
        ],
      ),
      onTap: onTap ?? () {},
    );
  }
}

class GenericUserListScreen extends StatelessWidget {
  final String title;
  final String emptyMessage;

  const GenericUserListScreen({super.key, required this.title, required this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    // Dummy data for visual verification if needed, or just empty state
    final List<Map<String, String>> users = []; 

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: users.isEmpty 
          ? Center(child: Text(emptyMessage, style: TextStyle(color: Colors.grey[600])))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(backgroundImage: AssetImage(users[index]['avatar']!)),
                title: Text(users[index]['name']!),
                subtitle: Text(users[index]['handle']!),
                trailing: TextButton(onPressed: (){}, child: const Text('Remove')),
              ),
            ),
    );
  }
}
