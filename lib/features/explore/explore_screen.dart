import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import 'controllers/explore_controller.dart';
import 'widgets/explore_post_card.dart';
import 'widgets/explore_video_card.dart';
import 'widgets/explore_sound_tile.dart';
import 'widgets/explore_channel_card.dart';
import 'widgets/explore_user_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is registered
    final ExploreController controller = Get.put(ExploreController());
    
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Global Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  onChanged: controller.updateSearch,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Search OMRE...',
                    hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[600]),
                    prefixIcon: Icon(Icons.search, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),

            // 2. Tab Navigation
            Expanded(
              child: GetBuilder<ExploreController>(
                builder: (ctrl) {
                   // Ensure TabController is synced with current state (Search vs Main)
                   final tabs = ctrl.isSearching.value ? ctrl.searchTabs : ctrl.mainTabs;
                   
                   return Column(
                     children: [
                       TabBar(
                         controller: ctrl.tabController,
                         isScrollable: true,
                         labelColor: AppPalette.accentBlue,
                         unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
                         indicatorColor: AppPalette.accentBlue,
                         indicatorSize: TabBarIndicatorSize.label,
                         dividerColor: Colors.transparent,
                         tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                       ),
                       const Divider(height: 1),
                       
                       // 3. Tab Views
                       Expanded(
                         child: TabBarView(
                           controller: ctrl.tabController,
                           children: ctrl.isSearching.value 
                             ? _buildSearchTabViews(ctrl, isDark)
                             : _buildMainTabViews(ctrl, isDark),
                         ),
                       ),
                     ],
                   );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Main Tabs ---

  List<Widget> _buildMainTabViews(ExploreController controller, bool isDark) {
    return [
      _buildPostsTab(controller, isDark),
      _buildVideosTab(controller, isDark),
      _buildSoundsTab(controller, isDark),
      _buildChannelsTab(controller, isDark),
    ];
  }

  Widget _buildPostsTab(ExploreController controller, bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.posts.length,
      itemBuilder: (context, index) {
        return ExplorePostCard(post: controller.posts[index], isDark: isDark);
      },
    );
  }

  Widget _buildVideosTab(ExploreController controller, bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.videos.length,
      itemBuilder: (context, index) {
        return ExploreVideoCard(video: controller.videos[index], isDark: isDark);
      },
    );
  }

  Widget _buildSoundsTab(ExploreController controller, bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.sounds.length,
      itemBuilder: (context, index) {
        return ExploreSoundTile(sound: controller.sounds[index], isDark: isDark);
      },
    );
  }

  Widget _buildChannelsTab(ExploreController controller, bool isDark) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: controller.channels.length,
      itemBuilder: (context, index) {
        return ExploreChannelCard(
          channel: controller.channels[index], 
          isDark: isDark,
          onSubscribe: () => controller.toggleSubscribe(index),
        );
      },
    );
  }

  // --- Search Tabs ---

  List<Widget> _buildSearchTabViews(ExploreController controller, bool isDark) {
    // "For You" (Mixed), "People", "Posts", "Videos"
    return [
      _buildSearchForYouTab(controller, isDark),
      _buildPeopleTab(controller, isDark),
      _buildPostsTab(controller, isDark), // Reusing existing post list logic
      _buildVideosTab(controller, isDark), // Reusing existing video list logic
    ];
  }

  Widget _buildSearchForYouTab(ExploreController controller, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text('People', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? Colors.white : Colors.black)),
            const SizedBox(height: 12),
            ...controller.people.take(2).map((p) => ExploreUserCard(
                user: p, 
                isDark: isDark, 
                onFollow: () => controller.toggleFollow(controller.people.indexOf(p))
            )),
            const SizedBox(height: 24),

            Text('Popular Posts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? Colors.white : Colors.black)),
            const SizedBox(height: 12),
            ...controller.posts.take(2).map((p) => ExplorePostCard(post: p, isDark: isDark)),
        ],
      ),
    );
  }

  Widget _buildPeopleTab(ExploreController controller, bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.people.length,
      itemBuilder: (context, index) {
        return ExploreUserCard(
          user: controller.people[index], 
          isDark: isDark, 
          onFollow: () => controller.toggleFollow(index)
        );
      },
    );
  }
}
