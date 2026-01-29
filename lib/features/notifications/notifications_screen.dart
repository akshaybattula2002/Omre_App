
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import 'notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Facebook-style Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
                    onPressed: () => Get.back(),
                  ),
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                  const Spacer(),
                  _buildHeaderButton(Icons.search, isDark),
                  const SizedBox(width: 12),
                  _buildHeaderButton(Icons.settings, isDark),
                ],
              ),
            ),
            
            // Notification List
            Expanded(
              child: Obx(() {
                if (controller.notifications.isEmpty) {
                  return _buildEmptyState(isDark, theme);
                }

                final newNotifications = controller.notifications.where((n) => !n.isRead).toList();
                final earlierNotifications = controller.notifications.where((n) => n.isRead).toList();

                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    if (newNotifications.isNotEmpty) ...[
                      _buildSectionHeader('New', theme),
                      ...newNotifications.map((n) => _buildNotificationItem(context, n, controller, isDark)),
                    ],
                    if (earlierNotifications.isNotEmpty) ...[
                      _buildSectionHeader('Earlier', theme),
                      ...earlierNotifications.map((n) => _buildNotificationItem(context, n, controller, isDark)),
                    ],
                    const SizedBox(height: 100), // Bottom padding
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: isDark ? Colors.white : Colors.black, size: 20),
        onPressed: () {},
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: theme.textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    NotificationItem notification,
    NotificationsController controller,
    bool isDark,
  ) {
    final theme = Theme.of(context);
    final bool isUnread = !notification.isRead;
    
    return InkWell(
      onTap: () {
        controller.markAsRead(notification.id);
      },
      child: Container(
        color: isUnread 
            ? (isDark ? Colors.blue.withOpacity(0.1) : Colors.blue.withOpacity(0.05))
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar with Type Icon Badge
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(notification.avatarUrl),
                  backgroundColor: Colors.grey[800],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _getIconColor(notification.type),
                      shape: BoxShape.circle,
                      border: Border.all(color: isDark ? const Color(0xFF121212) : Colors.white, width: 2),
                    ),
                    child: Icon(_getIcon(notification.type), size: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 15, 
                        color: theme.textTheme.bodyLarge?.color,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(
                          text: notification.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: notification.message,
                          style: TextStyle(fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal),
                        ),
                      ],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.time,
                    style: TextStyle(
                      fontSize: 13, 
                      color: isUnread ? Colors.blue[400] : theme.hintColor,
                      fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  
                  // Action Buttons for Friend Requests
                  if (notification.type == NotificationType.friendRequest && !notification.isRead) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.acceptRequest(notification.id, notification.username),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              minimumSize: const Size(0, 36),
                            ),
                            child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.declineRequest(notification.id, notification.username),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
                              foregroundColor: isDark ? Colors.white : Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              minimumSize: const Size(0, 36),
                            ),
                            child: const Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            // Three dot menu & Unread indicator
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.more_horiz, color: theme.hintColor, size: 20),
                  onPressed: () => _buildOptionsModal(context, notification, controller, isDark),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 24),
                ),
                if (isUnread)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _buildOptionsModal(BuildContext context, NotificationItem n, NotificationsController c, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionTile(Icons.delete_outline, 'Remove this notification', () {
                c.removeNotification(n.id);
                Get.back();
              }, isDark),
              _buildOptionTile(Icons.notifications_off_outlined, 'Turn off notifications from ${n.username}', () {
                Get.back();
              }, isDark),
              _buildOptionTile(Icons.report_problem_outlined, 'Report issue to notification team', () {
                Get.back();
              }, isDark),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionTile(IconData icon, String label, VoidCallback onTap, bool isDark) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: isDark ? Colors.white : Colors.black),
      ),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  Widget _buildEmptyState(bool isDark, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_outlined, size: 100, color: isDark ? Colors.white10 : Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            'You have no notifications',
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
              color: theme.textTheme.displayLarge?.color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for updates!',
            style: TextStyle(color: theme.hintColor),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.like: return Icons.thumb_up_alt;
      case NotificationType.comment: return Icons.chat_bubble;
      case NotificationType.friendRequest: return Icons.person_add_alt_1;
      case NotificationType.mention: return Icons.alternate_email;
      case NotificationType.groupInvite: return Icons.group_add;
    }
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.like: return Colors.blue;
      case NotificationType.comment: return Colors.green;
      case NotificationType.friendRequest: return Colors.blue;
      case NotificationType.mention: return Colors.orange;
      case NotificationType.groupInvite: return Colors.blue;
    }
  }
}
