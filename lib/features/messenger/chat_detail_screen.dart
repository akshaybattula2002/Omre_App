import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/chat_detail_controller.dart';
import '../../../core/theme/palette.dart';
import 'call_screen.dart';
import 'camera_screen.dart';
import '../social/user_profile_screen.dart';
import 'chat_media_screen.dart';

class ChatDetailScreen extends GetView<ChatDetailController> {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ChatDetailController>()) {
      Get.put(ChatDetailController());
    }
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final chat = controller.chat;

    Color? bgColor = isDark ? const Color(0xFF0B141A) : const Color(0xFFECE5DD);
    DecorationImage? bgImage;
    
    if (controller.wallpaperPath.value.isNotEmpty) {
       if (controller.wallpaperPath.value.startsWith('0x')) {
          try {
            bgColor = Color(int.parse(controller.wallpaperPath.value));
          } catch (_) {}
       } else {
          bgImage = DecorationImage(
            image: AssetImage(controller.wallpaperPath.value),
            fit: BoxFit.cover,
          );
       }
    }

    return Obx(() => Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: bgImage != null ? BoxDecoration(image: bgImage) : null,
        child: Column(
          children: [
            _buildAppBar(context, isDark, chat),
            Expanded(
              child: ListView.builder(
              reverse: true, // Start from bottom
              itemCount: controller.messages.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return _buildMessageBubble(message, isDark);
              },
            )),
            _buildInputBar(isDark),
          ],
        ),
      ),
    ));
  }
  
  // ... _buildAppBar and others remain ... (I need to be careful with replace_file_content range)

  // ...
  
  // I'll target _buildWallpaperOption specifically in a separate call or ensuring the range covers it.
  // Actually, I'll just rewrite the whole _buildWallpaperOption method.


  PreferredSizeWidget _buildAppBar(BuildContext context, bool isDark, dynamic chat) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: isDark ? const Color(0xFF1F2C34) : const Color(0xFF075E54), // WhatsApp AppBar
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          if (controller.isSearching.value) {
            controller.toggleSearch();
          } else {
            Get.back();
          }
        },
      ),
      title: controller.isSearching.value
          ? TextField(
              controller: controller.searchQueryController,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              onChanged: (val) {
                // Implement filter logic if needed, currently just UI
              },
            )
          : Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(chat.avatarUrl),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.to(() => UserProfileScreen(username: chat.name, avatarUrl: chat.avatarUrl)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Online', 
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      actions: [
        if (controller.isSearching.value)
           IconButton(
             icon: const Icon(Icons.close, color: Colors.white),
             onPressed: controller.toggleSearch,
           )
        else ...[
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () => Get.to(() => CallScreen(caller: {'name': chat.name, 'avatarUrl': chat.avatarUrl}, isVideo: true)),
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () => Get.to(() => CallScreen(caller: {'name': chat.name, 'avatarUrl': chat.avatarUrl}, isVideo: false)),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              _handleMenuSelection(value, chat);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(value: 'contact', child: Text('View Contact')),
                const PopupMenuItem<String>(value: 'media', child: Text('Media, links, and docs')),
                const PopupMenuItem<String>(value: 'search', child: Text('Search')),
                PopupMenuItem<String>(
                  value: 'mute', 
                  child: Text(controller.isMuted.value ? 'Unmute notifications' : 'Mute notifications')
                ),
                const PopupMenuItem<String>(value: 'wallpaper', child: Text('Wallpaper')),
                const PopupMenuItem<String>(value: 'clear', child: Text('Clear chat')),
              ];
            },
          ),
        ],
      ],
    );
  }

  void _handleMenuSelection(String value, dynamic chat) {
    switch (value) {
      case 'contact':
        Get.to(() => UserProfileScreen(username: chat.name, avatarUrl: chat.avatarUrl));
        break;
      case 'media':
        Get.to(() => ChatMediaScreen(chatInfo: {'name': chat.name, 'avatarUrl': chat.avatarUrl}));
        break;
      case 'search':
        controller.toggleSearch();
        break;
      case 'mute':
        controller.toggleMute();
        break;
      case 'wallpaper':
        _showWallpaperPicker();
        break;
      case 'clear':
        controller.messages.clear();
        break;
    }
  }

  void _showWallpaperPicker() {
    Get.bottomSheet(
      Container(
        height: 200,
        color: Get.isDarkMode ? const Color(0xFF1F2C34) : Colors.white,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Choose Wallpaper', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWallpaperOption(Colors.red.shade100, 'Red'),
                _buildWallpaperOption(Colors.blue.shade100, 'Blue'),
                _buildWallpaperOption(Colors.green.shade100, 'Green'),
                GestureDetector(
                  onTap: () => controller.setWallpaper(null),
                  child: Column(
                    children: [
                      Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Icon(Icons.format_color_reset, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      const Text('Default'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildMessageBubble(dynamic message, bool isDark) {
    final isMe = message.isMe;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(maxWidth: Get.width * 0.75),
        decoration: BoxDecoration(
          color: isMe 
              ? (isDark ? const Color(0xFF005C4B) : const Color(0xFFDCF8C6)) // WhatsApp Sent
              : (isDark ? const Color(0xFF1F2C34) : Colors.white), // WhatsApp Received
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isMe ? const Radius.circular(12) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black, // Dark mode text always white
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.timestamp,
                  style: TextStyle(
                    color: isDark ? Colors.white60 : Colors.black54,
                    fontSize: 10,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(Icons.done_all, size: 14, color: isDark ? Colors.blue.shade300 : Colors.blue),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: isDark ? const Color(0xFF1F2C34) : Colors.white, // Input Area BG
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.add, color: isDark ? Colors.grey : AppPalette.accentBlue),
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1F2C34) : Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Wrap(
                      spacing: 30, 
                      runSpacing: 30,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildAttachmentOption(Icons.insert_drive_file, Colors.purple, 'Document', onTap: () => controller.handleAttachment('Document')),
                        _buildAttachmentOption(Icons.camera_alt, Colors.pink, 'Camera', onTap: () => Get.to(() => const CameraScreen())),
                        _buildAttachmentOption(Icons.image, Colors.purpleAccent, 'Gallery', onTap: () => controller.handleAttachment('Gallery')),
                        _buildAttachmentOption(Icons.headset, Colors.orange, 'Audio', onTap: () => controller.handleAttachment('Audio')),
                        _buildAttachmentOption(Icons.location_on, Colors.green, 'Location', onTap: () => controller.handleAttachment('Location')),
                        _buildAttachmentOption(Icons.person, Colors.blue, 'Contact', onTap: () => controller.handleAttachment('Contact')),
                      ],
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A3942) : Colors.white, // Input Field BG
                  borderRadius: BorderRadius.circular(24),
                  border: isDark ? null : Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: controller.textController,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle: TextStyle(color: isDark ? Colors.grey : Colors.grey[500]),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      key: const ValueKey('camera_btn'),
                      icon: Icon(Icons.camera_alt, color: isDark ? Colors.grey : Colors.grey[500]),
                      onPressed: () => Get.to(() => const CameraScreen()),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: const Color(0xFF00A884), // WhatsApp Send Button Green
              radius: 22,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: controller.sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, Color color, String label, {VoidCallback? onTap}) {
    final isDark = Get.isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
            child: Icon(icon, size: 28, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildWallpaperOption(Color color, String label) {
    return GestureDetector(
      onTap: () {
        // Use 0xFF format for color strings so they can be parsed back
        controller.setWallpaper('0x${color.value.toRadixString(16).toUpperCase()}');
      },
      child: Column(
        children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
          ),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}
