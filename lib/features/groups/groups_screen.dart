import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import 'screens/create_group_screen.dart';
import 'screens/group_detail_screen.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF18191A) : const Color(0xFFF0F2F5);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text('Groups', style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: isDark ? const Color(0xFF242526) : Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(icon: Icon(Icons.search, color: isDark ? Colors.white : Colors.black), onPressed: () {}),
            IconButton(
              icon: Icon(Icons.add_circle_outline, color: isDark ? Colors.white : Colors.black), 
              onPressed: () => Get.to(() => const CreateGroupScreen()),
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
            indicatorColor: Colors.blue,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'For You'),
              Tab(text: 'Your Groups'),
              Tab(text: 'Discover'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildForYouTab(theme, isDark),
            _buildYourGroupsTab(theme, isDark),
            _buildDiscoverTab(theme, isDark),
          ],
        ),
      ),
    );
  }

  // --- TAB 1: FOR YOU ---
  Widget _buildForYouTab(ThemeData theme, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        _buildGroupPostCard(
          groupName: 'Flutter Developers',
          userName: 'Sarah Williams',
          time: '2 hrs ago',
          content: 'Just released a new package for handling state! Check it out.',
          groupImg: AppAssets.post1,
          userImg: AppAssets.avatar1,
          postImg: AppAssets.cover1,
          isDark: isDark,
        ),
        _buildGroupPostCard(
          groupName: 'Minimalist Design',
          userName: 'David Brown',
          time: '5 hrs ago',
          content: 'Does anyone have good resources for typography pairing?',
          groupImg: AppAssets.post2,
          userImg: AppAssets.avatar2,
          postImg: null,
          isDark: isDark,
        ),
        _buildGroupPostCard(
          groupName: 'Hikers Club',
          userName: 'Emily Blunt',
          time: 'Yesterday',
          content: 'The view from the summit this weekend was breathtaking!',
          groupImg: AppAssets.post3,
          userImg: AppAssets.avatar3,
          postImg: AppAssets.cover2,
          isDark: isDark,
        ),
      ],
    );
  }

  // --- TAB 2: YOUR GROUPS ---
  Widget _buildYourGroupsTab(ThemeData theme, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pinned', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)),
              Text('Edit', style: TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildPinnedGroupItem('Flutter Devs', AppAssets.post1, isDark),
                _buildPinnedGroupItem('Design Hub', AppAssets.post2, isDark),
                _buildPinnedGroupItem('Startup Life', AppAssets.post3, isDark),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 8),
          Text('All Groups', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)),
          const SizedBox(height: 12),
          _buildGroupListItem('Flutter Developers', 'Last active 2m ago', AppAssets.post1, isDark),
          _buildGroupListItem('Minimalist Design', '3 posts today', AppAssets.post2, isDark),
          _buildGroupListItem('Hikers Club', '9+ posts this week', AppAssets.post3, isDark),
          _buildGroupListItem('Tech News', 'Last active yesterday', AppAssets.post4, isDark),
        ],
      ),
    );
  }

  // --- TAB 3: DISCOVER ---
  Widget _buildDiscoverTab(ThemeData theme, bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryChip('Comedy', true),
              _buildCategoryChip('Tech', false),
              _buildCategoryChip('Buy & Sell', false),
              _buildCategoryChip('Sports', false),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Suggested for You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
        const SizedBox(height: 12),
        _buildSuggestedGroupCard('Vintage Car Lovers', '25K Members', AppAssets.cover1, AppAssets.post5, isDark),
        _buildSuggestedGroupCard('Indie Game Devs', '12K Members', AppAssets.cover2, AppAssets.post1, isDark),
        _buildSuggestedGroupCard('Remote Workers', '50K Members', AppAssets.cover3, AppAssets.post2, isDark),
      ],
    );
  }

  // --- COMPONENTS ---

  Widget _buildGroupPostCard({
    required String groupName, required String userName, required String time, 
    required String content, required String groupImg, required String userImg, 
    String? postImg, required bool isDark
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: isDark ? const Color(0xFF242526) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () => Get.to(() => GroupDetailScreen(
                        title: groupName, 
                        subtitle: '10K Members',
                        image: groupImg,
                        cover: AppAssets.cover1,
                        isJoined: true
                    )),
                  child: Stack(
                    children: [
                       Container(
                         padding: const EdgeInsets.all(2),
                         decoration: BoxDecoration(color: isDark ? Colors.white : Colors.white, borderRadius: BorderRadius.circular(10)),
                         child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(groupImg, width: 36, height: 36, fit: BoxFit.cover)),
                       ),
                       Positioned(
                         bottom: 0, right: 0,
                         child: CircleAvatar(radius: 10, backgroundImage: AssetImage(userImg)),
                       )
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => GroupDetailScreen(
                          title: groupName, 
                          subtitle: '10K Members',
                          image: groupImg,
                          cover: AppAssets.cover1,
                          isJoined: true
                        )),
                        child: Row(
                          children: [
                            Text(groupName, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                            Icon(Icons.chevron_right, size: 16, color: Colors.grey[600]),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(userName, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                          Text(' • $time', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_horiz, color: Colors.grey[600]),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(content, style: TextStyle(fontSize: 14, color: isDark ? Colors.white : Colors.black)),
          ),
          const SizedBox(height: 12),
          if (postImg != null)
            Image.asset(postImg, width: double.infinity, height: 250, fit: BoxFit.cover),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAction(Icons.thumb_up_outlined, 'Like', isDark),
                _buildAction(Icons.comment_outlined, 'Comment', isDark),
                _buildAction(Icons.share_outlined, 'Share', isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction(IconData icon, String label, bool isDark) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildPinnedGroupItem(String name, String img, bool isDark) {
    return GestureDetector(
      onTap: () {
        Get.to(() => GroupDetailScreen(
            title: name,
            subtitle: '1.2K Members',
            image: img,
            cover: AppAssets.cover2,
            isJoined: true,
        ));
      },
      child: Container(
        width: 70,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 4),
            Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupListItem(String name, String status, String img, bool isDark) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(img, width: 50, height: 50, fit: BoxFit.cover)),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
      subtitle: Text(status, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: IconButton(icon: const Icon(Icons.star_border), onPressed: () {}),
      onTap: () {
         Get.to(() => GroupDetailScreen(
            title: name,
            subtitle: status,
            image: img,
            cover: AppAssets.cover3,
            isJoined: true,
        ));
      },
    );
  }

  Widget _buildSuggestedGroupCard(String name, String info, String cover, String profile, bool isDark) {
    return GestureDetector(
      onTap: () {
         Get.to(() => GroupDetailScreen(
            title: name,
            subtitle: info,
            image: profile,
            cover: cover,
            isJoined: false,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF242526) : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: Stack(
                children: [
                  ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: Image.asset(cover, width: double.infinity, height: 120, fit: BoxFit.cover)),
                  Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 40, decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withOpacity(0.6), Colors.transparent])))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(profile, width: 50, height: 50, fit: BoxFit.cover)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)),
                        Text(info, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                       Get.snackbar('Request Sent', 'You requested to join $name', backgroundColor: Colors.blue, colorText: Colors.white);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      foregroundColor: isDark ? Colors.white : Colors.black,
                      elevation: 0,
                    ),
                    child: const Text('Join'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {},
        backgroundColor: Colors.grey.withOpacity(0.1),
        selectedColor: Colors.blue.withOpacity(0.2),
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.grey,
          fontWeight: FontWeight.bold
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
      ),
    );
  }
}
