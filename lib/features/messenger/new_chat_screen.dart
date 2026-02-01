import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/mock_service.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';
import 'create_group_screen.dart';
import 'create_contact_screen.dart';
import 'create_community_screen.dart';
import 'create_channel_screen.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New chat',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: textColor),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 48,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2C2C2C) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: 'Search name or number',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildActionItem(Icons.group_add, 'New group', isDark, onTap: () => Get.to(() => const CreateGroupScreen())),
                  _buildActionItem(Icons.person_add, 'New contact', isDark, onTap: () => Get.to(() => const CreateContactScreen()), assetPath: AppAssets.personalInfoIcon3d),
                  _buildActionItem(Icons.groups, 'New community', isDark, onTap: () => Get.to(() => const CreateCommunityScreen())),
                  _buildActionItem(Icons.campaign, 'New channel', isDark, onTap: () => Get.to(() => const CreateChannelScreen())),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    'CONTACTS ON OMRE',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  ...MockService.chats.map((chat) => _buildContactItem(chat, textColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, bool isDark, {VoidCallback? onTap, String? assetPath}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFF00A884), // WhatsApp Green
                shape: BoxShape.circle,
              ),
              child: assetPath != null 
                  ? Center(child: Image.asset(assetPath, width: 24, height: 24))
                  : Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(MockChat chat, Color textColor) {
    // Generate a mock username based on name
    final username = chat.name.toLowerCase().replaceAll(' ', '_');
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: () {
          Get.back(); // Close modal
          Get.toNamed('/chat-detail', arguments: chat); // Open chat
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(chat.avatarUrl),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
