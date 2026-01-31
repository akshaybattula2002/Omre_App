import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';
import '../../core/services/mock_service.dart';
import '../messenger/chat_detail_screen.dart';
import '../messenger/new_chat_screen.dart';
import 'orbit_topic_detail_screen.dart';
import 'orbit_detail_screens.dart';
import 'controllers/orbit_controller.dart';

// --- Shared Components for Orbit Drawer Screens ---

Widget _buildOrbitScreenHeader(String title, BuildContext context, {List<Widget>? actions}) {
  final theme = Theme.of(context);
  return AppBar(
    backgroundColor: theme.scaffoldBackgroundColor,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
      onPressed: () => Get.back(),
    ),
    title: Text(
      title,
      style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
    ),
    actions: actions,
  );
}

Widget _buildSectionTitle(String title, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
    ),
  );
}

// --- Screen Implementations ---

class OrbitExploreScreen extends StatelessWidget {
  const OrbitExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildOrbitScreenHeader('Explore Orbit', context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Trending Topics', theme),
            _buildTrendingTile('SpaceX Mars Mission', '45.2K posts', Icons.rocket_launch, Colors.deepPurple, assetPath: 'assets/images/orbit_icon_3d.png', onTap: () => _navigateToTopic('Mars Colonization')),
            _buildTrendingTile('Flutter 3.16 Release', '32.1K posts', Icons.flutter_dash, Colors.blue, onTap: () => _navigateToTopic('AI Ethics & Safety')),
            _buildTrendingTile('Global News', '28.5K posts', Icons.public, Colors.green, assetPath: AppAssets.languageIcon3d, onTap: () => _navigateToTopic('Global Climate Action')),
            
            _buildSectionTitle('Recommended Spaces', theme),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                   _buildSpaceCard('Tech Talk', '1.2K listening', AppAssets.avatar1, Colors.blue, 'Marcus Neo'),
                   _buildSpaceCard('Future of Web', '850 listening', AppAssets.avatar2, Colors.purple, 'Sarah Jenkins'),
                   _buildSpaceCard('Career Growth', '500 listening', AppAssets.avatar3, Colors.orange, 'Harvey Specter'),
                ],
              ),
            ),
            
            _buildSectionTitle('Active Communities', theme),
            _buildCommunityTile('Developers Circle', '125K members', Icons.code, Colors.indigo),
            _buildCommunityTile('Startup Founders', '42K members', Icons.lightbulb, Colors.amber),
            _buildCommunityTile('Design Masters', '18K members', Icons.palette, Colors.pink),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _navigateToTopic(String title) {
    try {
      final controller = Get.find<OrbitController>();
      final topic = controller.allTopics.firstWhere((t) => t.title == title);
      Get.to(() => OrbitTopicDetailScreen(topic: topic));
    } catch (e) {
      Get.snackbar('Error', 'Topic not found');
    }
  }

  Widget _buildTrendingTile(String title, String posts, IconData icon, Color color, {String? assetPath, VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: assetPath != null
            ? Image.asset(assetPath, width: 20, height: 20)
            : Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text(posts, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      trailing: const Icon(Icons.trending_up, color: Colors.green, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSpaceCard(String title, String listening, String hostAvatar, Color color, String hostName) {
    return GestureDetector(
      onTap: () => Get.to(() => OrbitSpaceDetailScreen(title: title, host: hostName)),
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(backgroundImage: AssetImage(hostAvatar), radius: 20),
            const Spacer(),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.graphic_eq, size: 12, color: Colors.grey),
                const SizedBox(width: 4),
                Text(listening, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityTile(String name, String members, IconData icon, Color color) {
    final controller = Get.find<OrbitController>();
    return ListTile(
      leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text(members, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      trailing: Obx(() {
        final isJoined = controller.joinedCommunities.contains(name);
        return OutlinedButton(
          onPressed: () => controller.toggleCommunity(name),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: isJoined ? color.withOpacity(0.1) : null,
          ),
          child: Text(isJoined ? 'Joined' : 'Join', style: const TextStyle(fontSize: 12)),
        );
      }),
      onTap: () => Get.to(() => OrbitCommunityDetailScreen(name: name)),
    );
  }
}

class OrbitNotificationsScreen extends StatelessWidget {
  const OrbitNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildOrbitScreenHeader('Notifications', context),
      ),
      body: ListView(
        children: [
          _buildNotificationItem('Sarah Liked your post in SpaceX', '12m ago', Icons.favorite, Colors.pink),
          _buildNotificationItem('John mentioned you in Tech Talk', '45m ago', Icons.alternate_email, Colors.blue),
          _buildNotificationItem('New space starting: AI Ethics', '1h ago', Icons.graphic_eq, Colors.purple),
          _buildNotificationItem('Dev Circle has 5 new topics', '3h ago', Icons.groups, Colors.teal),
          _buildNotificationItem('Your topic is trending!', '5h ago', Icons.trending_up, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String text, String time, IconData icon, Color color) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 18)),
      title: Text(text, style: const TextStyle(fontSize: 14)),
      subtitle: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      onTap: () {
          final controller = Get.find<OrbitController>();
          Get.to(() => OrbitTopicDetailScreen(topic: controller.allTopics[0]));
      },
    );
  }
}

class OrbitMessagesScreen extends StatelessWidget {
  const OrbitMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chats = MockService.chats;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Messages',
          style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note),
            onPressed: () => Get.to(() => const NewChatScreen()),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return _buildChatItem(chat);
        },
      ),
    );
  }

  Widget _buildChatItem(MockChat chat) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(chat.avatarUrl)),
      title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text(chat.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(chat.time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          if (chat.unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Text(chat.unreadCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
      onTap: () => Get.to(() => const ChatDetailScreen(), arguments: chat),
    );
  }
}

class OrbitSpacesScreen extends StatelessWidget {
  const OrbitSpacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildOrbitScreenHeader('Audio Spaces', context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildLiveSpaceCard('AI and the Future of Work', 'Hosted by Sam Altman', '15.4K listening', [Colors.blue, Colors.red, Colors.green], Colors.deepPurple),
            _buildLiveSpaceCard('Building with Flutter 2026', 'Hosted by Eric Seidel', '8.2K listening', [Colors.orange, Colors.purple, Colors.teal], Colors.blue),
            _buildLiveSpaceCard('Mental Health Awareness', 'Hosted by Dr. Phil', '5.1K listening', [Colors.pink, Colors.amber], Colors.green),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.snackbar('Spaces', 'Preparing to start a new space...'),
        backgroundColor: Colors.deepPurple,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Start a Space', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildLiveSpaceCard(String title, String host, String listening, List<Color> avatarColors, Color cardColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [cardColor, cardColor.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: cardColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  children: [
                    Icon(Icons.mic, size: 12, color: Colors.white),
                    SizedBox(width: 4),
                    Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.white70),
                onPressed: () => Get.snackbar('Options', 'More options for this space coming soon'),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Image.asset(AppAssets.personalInfoIcon3d, width: 16, height: 16),
              const SizedBox(width: 4),
              Text(host, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                width: 80,
                height: 30,
                child: Stack(
                  children: avatarColors.asMap().entries.map((e) {
                    return Positioned(
                      left: e.key * 20.0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: CircleAvatar(
                          radius: 13, 
                          backgroundColor: e.value.withOpacity(0.2),
                          child: Icon(Icons.person, size: 16, color: e.value),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 8),
              Text(listening, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Get.to(() => OrbitSpaceDetailScreen(title: title, host: host)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, 
                  foregroundColor: cardColor, 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                ),
                child: const Text('Join Space', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrbitCommunitiesScreen extends StatelessWidget {
  const OrbitCommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildOrbitScreenHeader('Communities', context, actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(AppAssets.communitiesIcon3d, width: 28, height: 28),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(AppAssets.statusIcon3d, width: 28, height: 28),
          ),
        ]),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildCommunityCard('Global News', '5M followers', Icons.public, Colors.blue, assetPath: AppAssets.languageIcon3d, onTap: () => Get.to(() => const OrbitCommunityDetailScreen(name: 'Global News'))),
          _buildCommunityCard('Gaming Zone', '2.5M followers', Icons.sports_esports, Colors.purple, assetPath: 'assets/images/games_icon_3d.png', onTap: () => Get.to(() => const OrbitCommunityDetailScreen(name: 'Gaming Zone'))),
          _buildCommunityCard('Foodies', '1.2M followers', Icons.restaurant, Colors.orange, onTap: () => Get.to(() => const OrbitCommunityDetailScreen(name: 'Foodies'))),
          _buildCommunityCard('Photography', '800K followers', Icons.camera_alt, Colors.pink, onTap: () => Get.to(() => const OrbitCommunityDetailScreen(name: 'Photography'))),
          _buildCommunityCard('Music Junkies', '1.5M followers', Icons.music_note, Colors.indigo, onTap: () => Get.to(() => const OrbitCommunityDetailScreen(name: 'Music Junkies'))),
          _buildCommunityCard('Health & Fitness', '1.1M followers', Icons.fitness_center, Colors.teal, onTap: () => Get.to(() => const OrbitCommunityDetailScreen(name: 'Health & Fitness'))),
        ],
      ),
    );
  }

  Widget _buildCommunityCard(String name, String followers, IconData icon, Color color, {String? assetPath, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            assetPath != null
                ? Image.asset(assetPath, width: 40, height: 40)
                : Icon(icon, color: color, size: 40),
            const SizedBox(height: 12),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(followers, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class OrbitListsScreen extends StatelessWidget {
  const OrbitListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildOrbitScreenHeader('Your Lists', context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildListTile('Tech News', '15 members', Icons.computer, Colors.blue),
          _buildListTile('Finance', '8 members', Icons.attach_money, Colors.green),
          _buildListTile('Marketing', '22 members', Icons.campaign, Colors.orange),
          _buildListTile('Design Inspiration', '12 members', Icons.palette, Colors.pink),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.snackbar('Lists', 'Creating a new list...'),
        backgroundColor: AppPalette.accentBlue,
        child: const Icon(Icons.add_task, color: Colors.white),
      ),
    );
  }

  Widget _buildListTile(String name, String members, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(members, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        onTap: () => Get.to(() => OrbitListDetailScreen(name: name)),
      ),
    );
  }
}

class OrbitBookmarksScreen extends StatelessWidget {
  const OrbitBookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildOrbitScreenHeader('Bookmarks', context),
      ),
      body: Obx(() {
        final controller = Get.find<OrbitController>();
        final bookmarked = controller.allTopics.where((t) => controller.bookmarkedTopics.contains(t.title)).toList();
        
        if (bookmarked.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bookmark_border, size: 64, color: Colors.grey.withOpacity(0.5)),
                const SizedBox(height: 16),
                const Text('No bookmarks yet', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Save interesting topics to read later', style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bookmarked.length,
          itemBuilder: (context, index) {
            final topic = bookmarked[index];
            return _buildBookmarkTile(
              topic.title, 
              'Saved recently', 
              Icons.article_outlined, 
              Colors.blue,
              onRemove: () => controller.toggleBookmark(topic.title),
              onTap: () => Get.to(() => OrbitTopicDetailScreen(topic: topic)),
            );
          },
        );
      }),
    );
  }

  Widget _buildBookmarkTile(String title, String time, IconData icon, Color color, {String? assetPath, VoidCallback? onRemove, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.2)), borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: assetPath != null
            ? Image.asset(assetPath, width: 24, height: 24)
            : Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        subtitle: Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        trailing: IconButton(
          icon: const Icon(Icons.bookmark_remove, color: Colors.grey, size: 20),
          onPressed: onRemove,
        ),
        onTap: onTap,
      ),
    );
  }
}

class OrbitProfileScreen extends StatelessWidget {
  const OrbitProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Orbit Profile',
          style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Get.to(() => const OrbitLanguageScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(radius: 50, backgroundImage: AssetImage(AppAssets.avatar1)),
            const SizedBox(height: 16),
            const Text('Alex Richards', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('@alex_orbit', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.snackbar('Profile', 'Opening profile editor...'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.accentBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 32),
              ),
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 24),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProfileStat('Reputation', '4.8K', Icons.star, Colors.amber),
                _buildProfileStat('Posts', '124', Icons.edit_note, Colors.blue),
                _buildProfileStat('Spaces', '12', Icons.graphic_eq, Colors.purple),
              ],
            ),
            
            const SizedBox(height: 32),
            _buildSectionTitle('Active In', theme),
            _buildCommunityTile('Global News', 'Member since 2024', Icons.public, Colors.blue, assetPath: AppAssets.languageIcon3d, onTap: () => Get.to(() => const OrbitCommunityDetailScreen(name: 'Global News'))),
            _buildCommunityTile('Gaming Zone', 'Member since 2023', Icons.sports_esports, Colors.purple, assetPath: 'assets/images/games_icon_3d.png', onTap: () => Get.to(() => const OrbitCommunityDetailScreen(name: 'Gaming Zone'))),
            
            const SizedBox(height: 24),
            _buildSectionTitle('Recent Activity', theme),
            _buildActivityItem('Posted in SpaceX Mars Mission', '2h ago', Icons.chat_bubble_outline),
            _buildActivityItem('Joined Future of Web space', '5h ago', Icons.graphic_eq),
            _buildActivityItem('Liked Dr. Sarah\'s insight', '1d ago', Icons.favorite_border),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildCommunityTile(String name, String status, IconData icon, Color color, {String? assetPath, VoidCallback? onTap}) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: assetPath != null ? Image.asset(assetPath, width: 20, height: 20) : Icon(icon, color: color, size: 20)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text(status, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      onTap: onTap,
    );
  }

  Widget _buildActivityItem(String text, String time, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey, size: 20),
      title: Text(text, style: const TextStyle(fontSize: 14)),
      trailing: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }
}

class OrbitSpecialScreen extends StatelessWidget {
  const OrbitSpecialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildOrbitScreenHeader('Premium Orbit', context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.amber, Colors.orange], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Level Up to Pro', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Unlock exclusive features and support the Orbit community.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Text('\$9.99/mo', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Icon(Icons.stars, color: Colors.white, size: 32),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('Pro Features', theme),
            _buildFeatureRow(Icons.verified, 'Verified Badge', 'Show everyone you are authentic'),
            _buildFeatureRow(Icons.analytics, 'Deep Analytics', 'Detailed insights into your reach'),
            _buildFeatureRow(Icons.ads_click, 'Ad-Free Orbit', 'Focus on what matters'),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0, left: 20, right: 20),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.amber.withOpacity(0.1), child: Icon(icon, color: Colors.orange)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrbitLanguageScreen extends StatelessWidget {
  const OrbitLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildOrbitScreenHeader('Language Settings', context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
           _buildLangTile('English (US)', true),
           _buildLangTile('Español (ES)', false),
           _buildLangTile('Français (FR)', false),
           _buildLangTile('Deutsch (DE)', false),
           _buildLangTile('हिन्दी (IN)', false),
        ],
      ),
    );
  }

  Widget _buildLangTile(String name, bool isSelected) {
    return ListTile(
      title: Text(name, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.blue) : null,
      onTap: () {
        Get.back();
        Get.snackbar('Language', 'System updated to $name');
      },
    );
  }
}
