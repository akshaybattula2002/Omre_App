import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';
import 'dart:async';

// --- Shared Components for Messenger Drawer Screens ---

Widget _buildMessengerAppBar(String title, BuildContext context, {List<Widget>? actions, VoidCallback? onBack}) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  return AppBar(
    backgroundColor: theme.scaffoldBackgroundColor,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
      onPressed: onBack ?? () => Get.back(),
    ),
    title: Text(
      title,
      style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
    ),
    actions: actions,
  );
}

// --- Status Viewer Screen ---

class StatusViewerScreen extends StatefulWidget {
  final String name;
  final String avatar;
  final String statusImage;
  const StatusViewerScreen({super.key, required this.name, required this.avatar, required this.statusImage});

  @override
  State<StatusViewerScreen> createState() => _StatusViewerScreenState();
}

class _StatusViewerScreenState extends State<StatusViewerScreen> {
  double progress = 0.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      if (!mounted) {
        timer?.cancel();
        return;
      }
      setState(() {
        progress += 0.01;
        if (progress >= 1.0) {
          timer?.cancel();
          Get.back();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              widget.statusImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 2,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(backgroundImage: AssetImage(widget.avatar), radius: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          const Text('Just now', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(bottom: 30, left: 20, right: 20, child: Container(padding: const EdgeInsets.symmetric(horizontal: 20), height: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.white54)), child: const Row(children: [Icon(Icons.keyboard_arrow_up, color: Colors.white70), SizedBox(width: 12), Text('Reply', style: TextStyle(color: Colors.white70))]))),
        ],
      ),
    );
  }
}

// --- Messenger Status Screen ---

class MessengerStatusScreen extends StatelessWidget {
  const MessengerStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMessengerAppBar('Status', context),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Stack(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(AppAssets.avatar1), radius: 28),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(Icons.add, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
            title: Text('My Status', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
            subtitle: const Text('Tap to add status update'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Text('RECENT UPDATES', style: TextStyle(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.bold)),
          ),
          _buildStatusItem(context, 'Sarah Jenkins', '10m ago', AppAssets.avatar2, AppAssets.post1, true, isDark),
          _buildStatusItem(context, 'Mike Ross', '45m ago', AppAssets.avatar3, AppAssets.post2, false, isDark),
        ],
      ),
    );
  }

  Widget _buildStatusItem(BuildContext context, String name, String time, String avatar, String statusImage, bool isUnread, bool isDark) {
    return ListTile(
      onTap: () {
        Get.to(() => StatusViewerScreen(name: name, avatar: avatar, statusImage: statusImage));
      },
      leading: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue, width: 2.5),
        ),
        child: CircleAvatar(backgroundImage: AssetImage(avatar), radius: 25),
      ),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
      subtitle: Text(time),
    );
  }
}

// --- Channel Detail Screen ---

class ChannelDetailScreen extends StatelessWidget {
  final String name;
  final String followers;
  final IconData icon;
  final Color color;

  const ChannelDetailScreen({
    super.key, 
    required this.name, 
    required this.followers, 
    required this.icon, 
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: color,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
              background: Container(
                color: color.withOpacity(0.8),
                child: Center(
                  child: Icon(icon, size: 80, color: Colors.white.withOpacity(0.5)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(followers, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          const Text('followers', style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.snackbar('Channel', 'You followed $name', snackPosition: SnackPosition.BOTTOM);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('Follow'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Channel Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  Text(
                    'Stay updated with the latest from $name. We provide daily news, exclusive content, and community polls directly to your messenger.',
                    style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                  ),
                  const Divider(height: 48),
                  const Text('LATEST UPDATES', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildChannelPost(context, isDark),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelPost(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
             children: [
               CircleAvatar(backgroundColor: color.withOpacity(0.1), radius: 14, child: Icon(icon, color: color, size: 14)),
               const SizedBox(width: 8),
               Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
               const Spacer(),
               const Text('Today', style: TextStyle(color: Colors.grey, fontSize: 11)),
             ],
          ),
          const SizedBox(height: 12),
          Text(
            'Check out our latest update regarding the new features! We are excited to announce integration with OMRE.',
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.favorite_border, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text('1.2K', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(width: 16),
              Icon(Icons.share_outlined, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text('45', style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Find Channels Screen ---

class FindChannelsScreen extends StatelessWidget {
  const FindChannelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMessengerAppBar('Find Channels', context),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for channels',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: theme.brightness == Brightness.dark ? Colors.white10 : Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildDiscoverChannel(context, 'Real Madrid CF', '124M followers', Icons.sports_soccer, Colors.purple),
                _buildDiscoverChannel(context, 'Netflix', '56M followers', Icons.movie, Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverChannel(BuildContext context, String name, String followers, IconData icon, Color color) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
      title: Text(name),
      subtitle: Text(followers),
      trailing: const Icon(Icons.add),
      onTap: () {
        Get.to(() => ChannelDetailScreen(name: name, followers: followers, icon: icon, color: color));
      },
    );
  }
}

// --- Messenger Channels Screen ---

class MessengerChannelsScreen extends StatelessWidget {
  const MessengerChannelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMessengerAppBar('Channels', context, actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () => Get.to(() => const FindChannelsScreen())),
        ]),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildChannelItem(context, 'OMRE News Official', '245K followers', Icons.newspaper, Colors.blue, isDark),
          _buildChannelItem(context, 'Flutter Daily', '85K followers', Icons.flutter_dash, Colors.cyan, isDark),
        ],
      ),
    );
  }

  Widget _buildChannelItem(BuildContext context, String name, String followers, IconData icon, Color color, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          Get.to(() => ChannelDetailScreen(name: name, followers: followers, icon: icon, color: color));
        },
      ),
    );
  }
}

// --- Community Detail Screen (NEW) ---

class CommunityDetailScreen extends StatelessWidget {
  final String name;
  final String members;
  final IconData icon;
  final Color color;
  final List<String> subgroups;

  const CommunityDetailScreen({
    super.key, 
    required this.name, 
    required this.members, 
    required this.icon, 
    required this.color,
    required this.subgroups,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: color,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(child: Icon(icon, size: 64, color: Colors.white.withOpacity(0.4))),
              ),
              title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: const Text('Verified Community', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const Spacer(),
                      Text(members, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('About this Community', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                  const SizedBox(height: 8),
                  Text(
                    'Welcome to $name! A place for like-minded individuals to collaborate, share ideas, and grow together in the OMRE ecosystem.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('SUB-GROUPS', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                       IconButton(icon: const Icon(Icons.add, size: 18), onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final sub = subgroups[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Card(
                    elevation: 0,
                    color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(Icons.groups, color: color, size: 20)),
                      title: Text(sub, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: const Text('24 new messages', style: TextStyle(color: Colors.blue, fontSize: 11)),
                      trailing: const Icon(Icons.chevron_right, size: 18),
                      onTap: () {
                        Get.snackbar('Sub-Group', 'Entering chat for $sub');
                      },
                    ),
                  ),
                );
              },
              childCount: subgroups.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

// --- Messenger Communities Screen (Updated) ---

class MessengerCommunitiesScreen extends StatelessWidget {
  const MessengerCommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMessengerAppBar('Communities', context, actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ]),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            // New Community FAB-style action
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                   Get.snackbar('Coming Soon', 'Community creation will be available in next update.');
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.add, color: Colors.white)),
                      SizedBox(width: 16),
                      Text('New Community', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            
            _buildCommunitySectionHeader('MY COMMUNITIES'),
            _buildCommunityLargeItem(context, 'Developers Circle', '125K Members', Icons.code, Colors.indigo, ['Web Devs', 'Mobile App Devs', 'Cloud Architects'], isDark),
            _buildCommunityLargeItem(context, 'Gaming Universe', '2.5M Members', Icons.sports_esports, Colors.purple, ['FPS Pro League', 'RPG Adventurers'], isDark),
            _buildCommunityLargeItem(context, 'Creative Hub', '45K Members', Icons.palette, Colors.pink, ['Digital Art', 'Photography'], isDark),
            
            const SizedBox(height: 20),
            _buildCommunitySectionHeader('DISCOVER'),
            _buildDiscoveryListItem('Global News Network', '5M Members', Icons.public, Colors.blue),
            _buildDiscoveryListItem('Startup Founders', '85K Members', Icons.lightbulb, Colors.amber),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunitySectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
      ),
    );
  }

  Widget _buildCommunityLargeItem(BuildContext context, String name, String members, IconData icon, Color color, List<String> subgroups, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200]!),
          boxShadow: [if (!isDark) BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (val) {
               // Logic to expand/collapse
            },
            leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 24)),
            title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(members, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            children: [
              ...subgroups.map((sub) => ListTile(
                contentPadding: const EdgeInsets.only(left: 72, right: 16),
                title: Text(sub, style: const TextStyle(fontSize: 14)),
                trailing: const Icon(Icons.chevron_right, size: 16),
                onTap: () {
                   Get.snackbar('Sub-Group', 'Opening $sub conversation...');
                },
              )),
              Padding(
                padding: const EdgeInsets.only(left: 72, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => CommunityDetailScreen(name: name, members: members, icon: icon, color: color, subgroups: subgroups));
                    }, 
                    child: const Text('View Community Page', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoveryListItem(String name, String members, IconData icon, Color color) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(members, style: const TextStyle(fontSize: 11)),
      trailing: ElevatedButton(
        onPressed: () {}, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.withOpacity(0.1),
          foregroundColor: Colors.blue,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: const Text('Join', style: TextStyle(fontSize: 12))
      ),
    );
  }
}

// --- Messenger Groups Screen ---

class MessengerGroupsScreen extends StatelessWidget {
  const MessengerGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildMessengerAppBar('Groups', context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGroupItem('Family Group', 'Sarah: Coming home early!', AppAssets.avatar1, '2m ago', isDark),
          _buildGroupItem('Office Team', 'Mike: Updated the docs.', AppAssets.avatar2, '1h ago', isDark),
        ],
      ),
    );
  }

  Widget _buildGroupItem(String name, String lastMsg, String avatar, String time, bool isDark) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(avatar), radius: 24),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
      subtitle: Text(lastMsg, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
    );
  }
}
