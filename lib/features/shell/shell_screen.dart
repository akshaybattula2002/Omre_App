import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:omre/core/constants/app_assets.dart';
import 'package:animations/animations.dart';
import '../../core/services/state_providers.dart';
import '../../core/theme/palette.dart';
import '../../core/routing/router.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/explore/explore_screen.dart';

import '../../features/messenger/messenger_home_screen.dart';
import '../../features/shorts/shorts_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/profile/settings/settings_screen.dart';
import '../../features/mart/social_marketplace_screen.dart';
import '../../features/mart/mart_services_screen.dart';
import '../../features/mart/exclusive_deals_screen.dart';
import '../../features/mart/controllers/social_marketplace_controller.dart';
import '../../features/mart/cart_screen.dart';
import '../../features/biz/biz_home_screen.dart';
import '../../features/jobs/jobs_screen.dart';
import '../../features/education/education_screen.dart';
import '../../features/studio/studio_home_screen.dart';
import '../../features/studio/video_upload_screen.dart';
import '../../features/studio/write_script_screen.dart';
import '../../features/studio/studio_comments_screen.dart';
import '../../features/games/game_verse_screen.dart';
import '../../features/games/tournament_screen.dart';
import '../../features/games/squad_finder_screen.dart';
import '../../features/games/library_screen.dart';
import '../../features/meeting/meeting_screen.dart';
import '../../features/pages/pages_screen.dart';
import '../../features/groups/groups_screen.dart';
import '../../features/town_hall/town_hall_screen.dart';
import '../../features/birthday/birthday_screen.dart';
import '../../features/blogs/blogs_screen.dart';
import '../../features/weather/weather_screen.dart';
import '../../features/friends/friends_screen.dart';
import '../../features/video/video_home_screen.dart';
import '../../features/movies/movies_screen.dart';
import '../../features/images/images_screen.dart';

import '../../features/omni_suite/omni_know_screen.dart';
import '../../features/omni_suite/happy_corner_screen.dart';
import '../../features/omni_suite/virtual_world_screen.dart';
import '../../features/omni_suite/digital_citizen_screen.dart';
import '../../features/omni_suite/omni_ai_screen.dart';
import '../../core/widgets/generic_placeholder_screen.dart';
import '../../features/news/controllers/news_controller.dart';
import '../../features/news/saved_news_screen.dart';
import '../../features/news/scores_screen.dart';
import '../../features/news/live_news_coverage_screen.dart';
import '../../features/video/video_drawer_screens.dart';
import '../../features/link/link_drawer_screens.dart';
import '../../features/education/education_drawer_screens.dart';
import '../../features/education/certificates_screen.dart';
import '../../features/orbit/orbit_home_screen.dart';
import '../../features/orbit/orbit_create_topic_screen.dart';
import '../../features/orbit/orbit_drawer_screens.dart';
import '../../features/studio/studio_drawer_screens.dart';
import '../../features/meeting/meeting_drawer_screens.dart';
import '../../features/games/games_drawer_screens.dart';
import '../../features/messenger/messenger_drawer_screens.dart';

class ShellScreen extends GetView<AppController> {
  const ShellScreen({super.key});

  void _onItemTapped(int index) {
    controller.bottomNavIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        
        return Scaffold(
          drawer: Obx(() => _buildDrawer(context, theme, isDark)),
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: theme.iconTheme.color),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Obx(() {
                if (controller.isSearching.value) {
                  return TextField(
                    controller: controller.searchController,
                    autofocus: true,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Search OMRE...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      controller.isSearching.value = false;
                      Get.snackbar('Search', 'Results for "$value" coming soon!');
                    },
                  );
                }
                return PopupMenuButton<AppMode>(
                  initialValue: controller.appMode,
                  onSelected: (mode) {
                    controller.appMode = mode;
                    controller.bottomNavIndex = 0;
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  offset: const Offset(0, 40),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_getModeIcon(controller.appMode), size: 18, color: AppPalette.accentBlue),
                        const SizedBox(width: 8),
                        Text(
                          _getModeLabel(controller.appMode),
                          style: TextStyle(
                            fontWeight: FontWeight.w600, 
                            fontSize: 14,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => [
                    _buildMenuItem(AppMode.social, 'Social', Icons.people_outline),
                    _buildMenuItem(AppMode.messenger, 'Chat', Icons.chat_bubble_outline),
                    _buildMenuItem(AppMode.biz, 'Biz', Icons.business),
                    _buildMenuItem(AppMode.link, 'Link', Icons.link),
                    _buildMenuItem(AppMode.education, 'Learn', Icons.school_outlined),
                    _buildMenuItem(AppMode.studio, 'Studio', Icons.palette_outlined),
                    _buildMenuItem(AppMode.news, 'News', Icons.article_outlined),
                    _buildMenuItem(AppMode.video, 'Video', Icons.play_circle_outline),
                    _buildMenuItem(AppMode.orbit, 'Orbit', Icons.rocket_launch_outlined),
                    _buildMenuItem(AppMode.games, 'Games', Icons.sports_esports_outlined),
                    _buildMenuItem(AppMode.meeting, 'Meeting', Icons.videocam_outlined),
                    _buildMenuItem(AppMode.mart, 'Mart', Icons.store_mall_directory_outlined),
                  ],
                );
              }),
            ),
            actions: [
              Obx(() => IconButton(
                onPressed: () {
                  controller.isSearching.toggle();
                  if (!controller.isSearching.value) {
                    controller.searchController.clear();
                  }
                },
                icon: Icon(
                  controller.isSearching.value ? Icons.close : Icons.search, 
                  color: theme.iconTheme.color
                ),
              )),
              Stack(
                children: [
                   IconButton(
                     onPressed: () {
                       Get.to(() => const NotificationsScreen());
                     },
                     icon: Icon(Icons.notifications_outlined, color: theme.iconTheme.color),
                   ),
                   Positioned(
                     top: 8,
                     right: 8,
                     child: Container(
                       width: 8,
                       height: 8,
                       decoration: const BoxDecoration(
                         color: Colors.red,
                         shape: BoxShape.circle,
                       ),
                     ),
                   ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                child: GestureDetector(
                  onTap: () => _onItemTapped(3), // Go to Profile
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(AppAssets.avatar1),
                  ),
                ),
              ),
            ],
          ),
          body: Row(
            children: [
              if (isWide)
                Obx(() => NavigationRail(
                  selectedIndex: controller.bottomNavIndex,
                  onDestinationSelected: _onItemTapped,
                  labelType: NavigationRailLabelType.none,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  selectedIconTheme: const IconThemeData(color: AppPalette.accentBlue),
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('Home')),
                    NavigationRailDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: Text('Explore')),
                    NavigationRailDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: Text('Inbox')),
                    NavigationRailDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: Text('Profile')),
                  ],
                )),
              Expanded(
                child: Obx(() {
                  final isSocial = controller.appMode == AppMode.social;
                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isWide && isSocial ? 600 : 1200),
                      child: _getPageContent(controller.bottomNavIndex),
                    ),
                  );
                }),
              ),
              Obx(() {
                final isSocial = controller.appMode == AppMode.social;
                if (isWide && isSocial) {
                  return Container(
                    width: 300,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Colors.grey.withOpacity(0.1))),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Trending topics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 16),
                        _SidebarItem(label: '#OMRE_Beta', sublabel: '12.4k posts'),
                        _SidebarItem(label: '#FlutterDev', sublabel: '8.1k posts'),
                        _SidebarItem(label: '#CleanArchitecture', sublabel: '5.2k posts'),
                        const SizedBox(height: 32),
                        const Text('Who to follow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 16),
                        _FollowItem(name: 'Sarah Drasner', handle: '@sdras'),
                        _FollowItem(name: 'Tim Sneath', handle: '@timsneath'),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
          bottomNavigationBar: !isWide ? Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
              boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.05),
                   blurRadius: 10,
                   offset: const Offset(0, -5),
                 ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Reduced vertical padding
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home', theme),
                   _buildNavItem(1, Icons.explore_outlined, Icons.explore, 'Explore', theme),
                   _buildNavItem(2, Icons.chat_bubble_outline, Icons.chat_bubble, 'Inbox', theme), // Using Chat Bubble for Inbox
                   _buildNavItem(3, Icons.person_outline, Icons.person, 'Profile', theme),
                ],
              ),
            ),
          ) : null,
        );
      },
    );
  }

  Widget _getPageContent(int index) {
    if (index == 0) {
      switch (controller.appMode) {
        case AppMode.social:
          return const HomeContent();
        case AppMode.biz:
          return const BizHomeScreen();
        case AppMode.link:
          return const JobsScreen();
        case AppMode.education:
          return const EducationScreen();
        case AppMode.studio:
          return const StudioHomeScreen();
        case AppMode.games:
          return const GameVerseScreen();
        case AppMode.video:
          return const VideoHomeScreen();
        case AppMode.messenger:
          return const MessengerHomeScreen();
        case AppMode.meeting:
          return const MeetingScreen();
        case AppMode.mart:
          return Obx(() => controller.isMartServicesView.value 
             ? MartServicesScreen() 
             : const SocialMarketplaceScreen());
        default:
          return const HomeContent();
      }
    }
    switch (index) {
      case 1:
        return const ExploreScreen();
      case 2:
        return const MessengerHomeScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeContent();
    }
  }

  String _getModeLabel(AppMode mode) {
    switch (mode) {
      case AppMode.social: return 'Social';
      case AppMode.messenger: return 'Chat';
      case AppMode.biz: return 'Biz';
      case AppMode.link: return 'Link';
      case AppMode.education: return 'Learn';
      case AppMode.studio: return 'Studio';
      case AppMode.news: return 'News';
      case AppMode.video: return 'Video';
      case AppMode.orbit: return 'Orbit';
      case AppMode.games: return 'Games';

      case AppMode.meeting: return 'Meeting';
      case AppMode.mart: return 'Mart';
    }
  }

  IconData _getModeIcon(AppMode mode) {
    switch (mode) {
      case AppMode.social: return Icons.people_outline;
      case AppMode.messenger: return Icons.chat_bubble_outline;
      case AppMode.biz: return Icons.business;
      case AppMode.link: return Icons.link;
      case AppMode.education: return Icons.school_outlined;
      case AppMode.studio: return Icons.palette_outlined;
      case AppMode.news: return Icons.article_outlined;
      case AppMode.video: return Icons.play_circle_outline;
      case AppMode.orbit: return Icons.rocket_launch_outlined;
      case AppMode.games: return Icons.sports_esports_outlined;
      case AppMode.meeting: return Icons.videocam_outlined;
      case AppMode.mart: return Icons.store_mall_directory_outlined;
    }
  }

  PopupMenuItem<AppMode> _buildMenuItem(AppMode mode, String label, IconData icon) {
    return PopupMenuItem(
      value: mode,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label, ThemeData theme, {bool hasBadge = false}) {
    return Obx(() {
      final isSelected = controller.bottomNavIndex == index;
      return GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected ? AppPalette.accentBlue : theme.iconTheme.color?.withOpacity(0.6),
                  size: 26, // Slightly reduced size
                ),
                if (hasBadge)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppPalette.accentBlue : theme.iconTheme.color?.withOpacity(0.6),
                fontSize: 10, // Small text size
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDrawer(BuildContext context, ThemeData theme, bool isDark) {
    return Drawer(
      backgroundColor: isDark ? Colors.black : theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    isDark ? AppAssets.logoDark : AppAssets.logoLight,
                    height: 40,
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 20, color: isDark ? Colors.white70 : Colors.grey[500]),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Dynamic Navigation List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  ..._buildDrawerItems(context, isDark),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Colors.transparent),
                  ),

                  // Standard Footer Items (Logout)
                  _buildDrawerFeatureItem(
                    Icons.logout, 'Logout', Colors.red, isDark,
                    onTap: () { 
                      Navigator.pop(context);
                      Get.offAllNamed('/login'); 
                    }
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context, bool isDark) {
    switch (controller.appMode) {
      case AppMode.news:
        return _buildNewsDrawerItems(context, isDark);
      case AppMode.video:
        return _buildVideoDrawerItems(context, isDark);
      case AppMode.link:
        return _buildLinkDrawerItems(context, isDark);
      case AppMode.education:
        return _buildLearnDrawerItems(context, isDark);
      case AppMode.orbit:
        return _buildOrbitDrawerItems(context, isDark);
      case AppMode.mart:
        return _buildMartDrawerItems(context, isDark);
      case AppMode.messenger:
        return _buildChatDrawerItems(context, isDark);
      case AppMode.biz:
        return _buildBizDrawerItems(context, isDark);
      case AppMode.studio:
        return _buildStudioDrawerItems(context, isDark);
      case AppMode.meeting:
        return _buildMeetingDrawerItems(context, isDark);
      case AppMode.games:
        return _buildGamesDrawerItems(context, isDark);
      case AppMode.social:
      default:
        return _buildSocialDrawerItems(context, isDark);
    }
  }

  List<Widget> _buildNewsDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('NEWS', isDark),
      _buildDrawerItem(Icons.newspaper, 'For You', iconColor: Colors.blue, isDark: isDark, isActive: true, onTap: () {
        Navigator.pop(context);
        if (Get.isRegistered<NewsController>()) Get.find<NewsController>().selectCategory('For You');
      }),
      _buildDrawerItem(Icons.live_tv, 'Live Coverage', iconColor: Colors.red, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const LiveNewsCoverageScreen());
      }),
      _buildDrawerItem(Icons.star_outline, 'Following', iconColor: Colors.amber, isDark: isDark, onTap: () {
        Navigator.pop(context);
        if (Get.isRegistered<NewsController>()) Get.find<NewsController>().selectCategory('Following');
      }),
      _buildDrawerItem(Icons.explore_outlined, 'Discover', iconColor: Colors.purple, isDark: isDark, onTap: () {
        Navigator.pop(context);
        if (Get.isRegistered<NewsController>()) Get.find<NewsController>().selectCategory('Technology');
      }),
      _buildDrawerItem(Icons.public, 'World', iconColor: Colors.green, isDark: isDark, onTap: () {
        Navigator.pop(context);
        if (Get.isRegistered<NewsController>()) Get.find<NewsController>().selectCategory('World');
      }),
      _buildDrawerItem(Icons.bookmark_border, 'Saved', iconColor: Colors.blueGrey, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const SavedNewsScreen());
      }),
      _buildDrawerItem(Icons.scoreboard_outlined, 'Scores', iconColor: Colors.orange, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const ScoresScreen());
      }),
    ];
  }

  List<Widget> _buildVideoDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('VIDEO', isDark),
      _buildDrawerItem(Icons.home_outlined, 'Home', iconColor: Colors.red, isDark: isDark, isActive: true, onTap: () => Navigator.pop(context)),
      _buildDrawerItem(Icons.videocam_outlined, 'Shorts', iconColor: Colors.redAccent, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const ShortsScreen());
      }),
      _buildDrawerItem(Icons.subscriptions_outlined, 'Subscriptions', iconColor: Colors.blue, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const VideoSubscriptionsScreen());
      }),
      _buildDrawerItem(Icons.video_library_outlined, 'Library', iconColor: Colors.purple, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const VideoLibraryScreen());
      }),
      _buildDrawerItem(Icons.history, 'History', iconColor: Colors.grey, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const VideoHistoryScreen());
      }),
      _buildDrawerItem(Icons.watch_later_outlined, 'Watch Later', iconColor: Colors.amber, isDark: isDark, onTap: () {
         Navigator.pop(context);
         Get.to(() => const VideoWatchLaterScreen());
      }),
      _buildDrawerItem(Icons.thumb_up_outlined, 'Liked Videos', iconColor: Colors.pink, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const VideoLikedVideosScreen());
      }),
      _buildDrawerItem(Icons.local_fire_department_outlined, 'Trending', iconColor: Colors.orange, isDark: isDark, onTap: () {
        Navigator.pop(context);
         Get.to(() => const VideoTrendingScreen());
      }),
      _buildDrawerItem(Icons.movie_outlined, 'Movies & Shows', iconColor: Colors.indigo, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const MoviesScreen());
      }),
    ];
  }

  List<Widget> _buildLinkDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('JOBS', isDark),
      _buildDrawerItem(Icons.work_outline, 'Jobs Home', iconColor: Colors.teal, isDark: isDark, isActive: true, onTap: () => Navigator.pop(context)),
      _buildDrawerItem(Icons.people_outline, 'My Network', iconColor: Colors.blue, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const LinkMyNetworkScreen());
      }),
      _buildDrawerItem(Icons.search, 'Job Search', iconColor: Colors.grey, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const LinkJobSearchScreen());
      }),
      _buildDrawerItem(Icons.assignment_outlined, 'Applications', iconColor: Colors.purple, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const LinkApplicationsScreen());
      }),
      _buildDrawerItem(Icons.bookmark_border, 'Saved Jobs', iconColor: Colors.amber, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const LinkSavedJobsScreen());
      }),
      _buildDrawerItem(Icons.notifications_none, 'Job Alerts', iconColor: Colors.red, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const LinkJobAlertsScreen());
      }),
      _buildDrawerItem(Icons.business, 'Company Pages', iconColor: Colors.indigo, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const LinkCompanyPagesScreen());
      }),
      _buildDrawerItem(Icons.monetization_on_outlined, 'Salary Insights', iconColor: Colors.green, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const LinkSalaryInsightsScreen());
      }),
    ];
  }

  List<Widget> _buildLearnDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('LEARN', isDark),
      _buildDrawerItem(Icons.explore_outlined, 'Discover', iconColor: Colors.orange, isDark: isDark, isActive: true, onTap: () => Navigator.pop(context)),
      _buildDrawerItem(Icons.school_outlined, 'My Learning', iconColor: Colors.blue, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const EducationMyLearningScreen());
      }),
      _buildDrawerItem(Icons.cast_for_education, 'Tutor Marketplace', iconColor: Colors.purple, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const EducationTutorMarketplaceScreen());
      }),
      _buildDrawerItem(Icons.favorite_border, 'Wishlist', iconColor: Colors.pink, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const EducationWishlistScreen());
      }),
      _buildDrawerItem(Icons.shopping_cart_outlined, 'Cart', iconColor: Colors.green, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const EducationCartScreen());
      }),
      _buildDrawerItem(Icons.workspace_premium_outlined, 'Certificates', iconColor: Colors.amber, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const CertificatesScreen());
      }),
    ];
  }
  
  List<Widget> _buildOrbitDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('ORBIT', isDark),
      _buildDrawerItem(Icons.home_outlined, 'Home', iconColor: Colors.deepPurple, isDark: isDark, isActive: true, onTap: () {
        Navigator.pop(context);
        // Home is already handled by ShellScreen when appMode is orbit
      }),
      _buildDrawerItem(Icons.add_circle_outline, 'New Topic', iconColor: Colors.amber, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitCreateTopicScreen());
      }),
      _buildDrawerItem(Icons.explore_outlined, 'Explore', iconColor: Colors.blue, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitExploreScreen());
      }),
      _buildDrawerItem(Icons.notifications_outlined, 'Notifications', iconColor: Colors.red, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitNotificationsScreen());
      }),
      _buildDrawerItem(Icons.chat_bubble_outline, 'Messages', iconColor: Colors.green, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitMessagesScreen());
      }),
      _buildDrawerItem(Icons.space_dashboard_outlined, 'Spaces', iconColor: Colors.orange, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitSpacesScreen());
      }),
      _buildDrawerItem(Icons.groups_outlined, 'Communities', iconColor: Colors.teal, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitCommunitiesScreen());
      }),
      _buildDrawerItem(Icons.list_alt, 'Lists', iconColor: Colors.amber, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitListsScreen());
      }),
      _buildDrawerItem(Icons.bookmark_border, 'Bookmarks', iconColor: Colors.indigo, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitBookmarksScreen());
      }),
      _buildDrawerItem(Icons.person_outline, 'Profile', iconColor: Colors.blueGrey, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitProfileScreen());
      }),
      _buildDrawerItem(Icons.star_outline, 'Special', iconColor: Colors.purple, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitSpecialScreen());
      }),
      _buildDrawerItem(Icons.translate, 'Language (EN/ES)', iconColor: Colors.grey, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const OrbitLanguageScreen());
      }),
    ];
  }

  List<Widget> _buildMartDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('MART', isDark),
      _buildDrawerItem(Icons.store_mall_directory_outlined, 'Home', iconColor: Colors.deepOrange, isDark: isDark, isActive: true, onTap: () {
        controller.isMartServicesView.value = false;
        Navigator.pop(context);
      }),
      _buildDrawerItem(Icons.search, 'Search', iconColor: Colors.grey, isDark: isDark, onTap: () {
        controller.isMartServicesView.value = false;
        Navigator.pop(context);
        // Focus the search bar in SocialMarketplaceScreen
        if (Get.isRegistered<SocialMarketplaceController>()) {
          Get.find<SocialMarketplaceController>().focusSearch();
        }
      }),
      _buildDrawerItem(Icons.category_outlined, 'Categories', iconColor: Colors.blue, isDark: isDark, onTap: () {
        debugPrint('OMRE: Navigating to Mart Categories (View All)');
        Navigator.pop(context);
        Get.to(() => Scaffold(
          appBar: AppBar(
            title: const Text('Categories'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
          body: const MartServicesScreen(),
        ));
      }),
      _buildDrawerItem(Icons.local_offer_outlined, 'Deals', iconColor: Colors.red, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const ExclusiveDealsScreen());
      }),
      _buildDrawerItem(Icons.shopping_cart_outlined, 'Cart', iconColor: Colors.green, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => const CartScreen());
      }),
      _buildDrawerItem(Icons.person_outline, 'Profile', iconColor: Colors.indigo, isDark: isDark, onTap: () {
        Navigator.pop(context);
        Get.to(() => Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
          body: const ProfileScreen(),
        ));
      }),
    ];
  }

  // 🟦 SOCIAL
  List<Widget> _buildSocialDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildDrawerItem(Icons.home, 'Home', iconColor: Colors.blue, isActive: controller.bottomNavIndex == 0, isDark: isDark, onTap: () { controller.bottomNavIndex = 0; Navigator.pop(context); }),
      _buildDrawerItem(Icons.explore_outlined, 'Explore', iconColor: Colors.purple, isActive: controller.bottomNavIndex == 1, isDark: isDark, onTap: () { controller.bottomNavIndex = 1; Navigator.pop(context); }),
      _buildDrawerItem(Icons.videocam_outlined, 'Shorts', iconColor: Colors.red, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const ShortsScreen()); }),
      _buildDrawerItem(Icons.chat_bubble_outline, 'Messages', iconColor: Colors.green, isActive: controller.bottomNavIndex == 2, isDark: isDark, onTap: () { controller.bottomNavIndex = 2; Navigator.pop(context); }),
      _buildDrawerItem(Icons.favorite_border, 'Notifications', iconColor: Colors.pink, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const NotificationsScreen()); }),
      _buildDrawerItem(Icons.person_outline, 'Profile', iconColor: Colors.blue, isActive: controller.bottomNavIndex == 3, isDark: isDark, onTap: () { controller.bottomNavIndex = 3; Navigator.pop(context); }),
      _buildDrawerItem(Icons.settings_outlined, 'Settings', iconColor: Colors.grey, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const SettingsScreen()); }),
      
      _buildDrawerItem(Icons.lightbulb_outline, 'OmniKnow', iconColor: Colors.orange, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const OmniKnowScreen()); }),
      _buildDrawerItem(Icons.sentiment_satisfied_alt, 'Happy Corner', iconColor: Colors.amber, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const HappyCornerScreen()); }),
      _buildDrawerItem(Icons.language, 'Virtual World', iconColor: Colors.cyan, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const VirtualWorldScreen()); }),
      _buildDrawerItem(Icons.security_outlined, 'Digital Citizen', iconColor: Colors.green, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const DigitalCitizenScreen()); }),
      _buildDrawerItem(Icons.smart_toy_outlined, 'Omni AI', iconColor: Colors.deepPurpleAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const OmniAIScreen()); }),
      
      _buildDrawerItem(Icons.article_outlined, 'Pages', iconColor: Colors.blue, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const PagesScreen()); }),
      _buildDrawerItem(Icons.groups_outlined, 'Groups', iconColor: Colors.blueAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const GroupsScreen()); }),
      _buildDrawerItem(Icons.account_balance_outlined, 'Town Hall', iconColor: Colors.orange, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const TownHallScreen()); }),
      _buildDrawerItem(Icons.cake_outlined, 'Birthday', iconColor: Colors.pink, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const BirthdayScreen()); }),
      
      _buildDrawerItem(Icons.edit_note_outlined, 'Blogs', iconColor: Colors.green, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const BlogsScreen()); }),
      _buildDrawerItem(Icons.wb_sunny_outlined, 'Weather', iconColor: Colors.lightBlue, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const WeatherScreen()); }),
      _buildDrawerItem(Icons.person_add_outlined, 'Friends', iconColor: Colors.purpleAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const FriendsScreen()); }),
      _buildDrawerItem(Icons.live_tv_outlined, 'Watch', iconColor: Colors.red, isDark: isDark, onTap: () { controller.appMode = AppMode.video; controller.bottomNavIndex = 0; Navigator.pop(context); }),
      _buildDrawerItem(Icons.movie_outlined, 'Movies', iconColor: Colors.deepPurpleAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const MoviesScreen()); }),
      _buildDrawerItem(Icons.image_outlined, 'Images', iconColor: Colors.cyan, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const ImagesScreen()); }),
    ];
  }

  // 🟩 CHAT
  List<Widget> _buildChatDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('MESSENGER', isDark),
      _buildDrawerItem(Icons.chat_bubble_outline, 'Messages', iconColor: Colors.greenAccent, isActive: controller.bottomNavIndex == 2, isDark: isDark, onTap: () { controller.bottomNavIndex = 2; Navigator.pop(context); }),
      _buildDrawerItem(Icons.donut_large, 'Status', iconColor: Colors.blueAccent, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const MessengerStatusScreen()); 
      }),
      _buildDrawerItem(Icons.broadcast_on_personal, 'Channels', iconColor: Colors.orange, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const MessengerChannelsScreen()); 
      }),
      _buildDrawerItem(Icons.people_outline, 'Communities', iconColor: Colors.teal, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const MessengerCommunitiesScreen()); 
      }),
      _buildDrawerItem(Icons.group_outlined, 'Groups', iconColor: Colors.purple, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const MessengerGroupsScreen()); 
      }),

      const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(color: Colors.transparent)),
      
      _buildSectionHeader('GENERAL', isDark),
      _buildDrawerItem(Icons.home_outlined, 'Home', iconColor: Colors.blue, isActive: controller.bottomNavIndex == 0, isDark: isDark, onTap: () { controller.bottomNavIndex = 0; Navigator.pop(context); }),
      _buildDrawerItem(Icons.explore_outlined, 'Explore', iconColor: Colors.purpleAccent, isActive: controller.bottomNavIndex == 1, isDark: isDark, onTap: () { controller.bottomNavIndex = 1; Navigator.pop(context); }),
      _buildDrawerItem(Icons.favorite_border, 'Notifications', iconColor: Colors.pinkAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const NotificationsScreen()); }),
      _buildDrawerItem(Icons.person_outline, 'Profile', iconColor: Colors.indigoAccent, isActive: controller.bottomNavIndex == 3, isDark: isDark, onTap: () { controller.bottomNavIndex = 3; Navigator.pop(context); }),
      _buildDrawerItem(Icons.settings_outlined, 'Settings', iconColor: Colors.grey, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const SettingsScreen()); }),
    ];
  }

  // 💼 BIZ
  List<Widget> _buildBizDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('BIZ', isDark),
      _buildDrawerItem(Icons.business, 'Home', iconColor: Colors.blue, isActive: true, isDark: isDark, onTap: () { controller.bottomNavIndex = 0; Navigator.pop(context); }),
      _buildDrawerItem(Icons.explore_outlined, 'Explore', iconColor: Colors.purpleAccent, isDark: isDark, onTap: () { controller.bottomNavIndex = 1; Navigator.pop(context); }),
      _buildDrawerItem(Icons.videocam_outlined, 'Shorts', iconColor: Colors.redAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const ShortsScreen()); }),
      _buildDrawerItem(Icons.chat_bubble_outline, 'Messages', iconColor: Colors.greenAccent, isDark: isDark, onTap: () { controller.bottomNavIndex = 2; Navigator.pop(context); }),
      _buildDrawerItem(Icons.favorite_border, 'Notifications', iconColor: Colors.pinkAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const NotificationsScreen()); }),
      _buildDrawerItem(Icons.person_outline, 'Profile', iconColor: Colors.indigoAccent, isDark: isDark, onTap: () { controller.bottomNavIndex = 3; Navigator.pop(context); }),
      _buildDrawerFeatureItem(Icons.article_outlined, 'Pages', Colors.blue, isDark, onTap: () { Navigator.pop(context); Get.to(() => const PagesScreen()); }),
      _buildDrawerFeatureItem(Icons.groups_outlined, 'Groups', Colors.deepPurple, isDark, onTap: () { Navigator.pop(context); Get.to(() => const GroupsScreen()); }),
      _buildDrawerFeatureItem(Icons.account_balance_outlined, 'Town Hall', Colors.orange[800]!, isDark, onTap: () { Navigator.pop(context); Get.to(() => const TownHallScreen()); }),
      _buildDrawerFeatureItem(Icons.cake_outlined, 'Birthday', Colors.pink, isDark, onTap: () { Navigator.pop(context); Get.to(() => const BirthdayScreen()); }),
      _buildDrawerFeatureItem(Icons.settings, 'Settings', Colors.grey, isDark, onTap: () { Navigator.pop(context); Get.to(() => const SettingsScreen()); }),
    ];
  }

  // 🎥 STUDIO
  List<Widget> _buildStudioDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('STUDIO', isDark),
      _buildDrawerItem(Icons.palette_outlined, 'Home', iconColor: Colors.purple, isDark: isDark, isActive: true, onTap: () => Navigator.pop(context)),
      _buildDrawerItem(Icons.explore_outlined, 'Explore', iconColor: Colors.purpleAccent, isDark: isDark, onTap: () { controller.bottomNavIndex = 1; Navigator.pop(context); }),
      _buildDrawerItem(Icons.videocam_outlined, 'Shorts', iconColor: Colors.redAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const ShortsScreen()); }),
      _buildDrawerItem(Icons.chat_bubble_outline, 'Messages', iconColor: Colors.greenAccent, isDark: isDark, onTap: () { controller.bottomNavIndex = 2; Navigator.pop(context); }),
      _buildDrawerItem(Icons.favorite_border, 'Notifications', iconColor: Colors.pinkAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const NotificationsScreen()); }),
      _buildDrawerItem(Icons.person_outline, 'Profile', iconColor: Colors.indigoAccent, isDark: isDark, onTap: () { controller.bottomNavIndex = 3; Navigator.pop(context); }),
      
      const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(color: Colors.transparent)),
      _buildSectionHeader('CHANNEL TOOLS', isDark),
      
      _buildDrawerItem(Icons.dashboard_outlined, 'Content Dashboard', iconColor: Colors.blue, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const StudioContentDashboardScreen()); 
      }),
      _buildDrawerItem(Icons.upload, 'Upload Video', iconColor: Colors.blueAccent, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const VideoUploadScreen()); 
      }),
      _buildDrawerItem(Icons.edit_note, 'Write Script', iconColor: Colors.orange, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const WriteScriptScreen()); 
      }),
      _buildDrawerItem(Icons.comment_outlined, 'Comments', iconColor: Colors.teal, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const StudioCommentsScreen()); 
      }),
      _buildDrawerItem(Icons.monetization_on_outlined, 'Earnings', iconColor: Colors.green, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const StudioEarningsScreen()); 
      }),
      _buildDrawerItem(Icons.bar_chart, 'Analytics', iconColor: Colors.deepOrange, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const StudioAnalyticsScreen()); 
      }),
      _buildDrawerItem(Icons.settings, 'Settings', iconColor: Colors.grey, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const SettingsScreen()); }),
    ];
  }

  // 📅 MEETINGS
  List<Widget> _buildMeetingDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('MEETINGS', isDark),
      _buildDrawerItem(Icons.videocam_outlined, 'Home', iconColor: Colors.blue, isDark: isDark, isActive: true, onTap: () => Navigator.pop(context)),
      _buildDrawerItem(Icons.explore_outlined, 'Explore', iconColor: Colors.purpleAccent, isDark: isDark, onTap: () { controller.bottomNavIndex = 1; Navigator.pop(context); }),
      _buildDrawerItem(Icons.chat_bubble_outline, 'Messages', iconColor: Colors.greenAccent, isDark: isDark, onTap: () { controller.bottomNavIndex = 2; Navigator.pop(context); }),
      _buildDrawerItem(Icons.favorite_border, 'Notifications', iconColor: Colors.pinkAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const NotificationsScreen()); }),
      _buildDrawerItem(Icons.person_outline, 'Profile', iconColor: Colors.indigoAccent, isDark: isDark, onTap: () { controller.bottomNavIndex = 3; Navigator.pop(context); }),
      _buildDrawerItem(Icons.calendar_today, 'Upcoming Meetings', iconColor: Colors.teal, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const MeetingUpcomingScreen()); 
      }),
      _buildDrawerItem(Icons.add_box_outlined, 'Join Meeting', iconColor: Colors.blue, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const MeetingJoinScreen()); 
      }),
      _buildDrawerItem(Icons.schedule, 'Schedule', iconColor: Colors.orange, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const MeetingScheduleScreen()); 
      }),
      _buildDrawerItem(Icons.mic_none_outlined, 'Recordings', iconColor: Colors.red, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const MeetingRecordingsScreen()); 
      }),
      _buildDrawerItem(Icons.settings, 'Settings', iconColor: Colors.grey, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const SettingsScreen()); }),
    ];
  }

  // 🎮 GAMES
  List<Widget> _buildGamesDrawerItems(BuildContext context, bool isDark) {
    return [
      _buildSectionHeader('GAMES', isDark),
      _buildDrawerItem(Icons.sports_esports, 'Home', iconColor: Colors.indigo, isDark: isDark, isActive: true, onTap: () => Navigator.pop(context)),
      _buildDrawerItem(Icons.web, 'Web Based Games', iconColor: Colors.blue, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const GamesWebBasedScreen()); 
      }),
      _buildDrawerItem(Icons.html, 'HTML5 Games', iconColor: Colors.orange, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const GamesHTML5Screen()); 
      }),
      _buildDrawerItem(Icons.emoji_events_outlined, 'Tournaments', iconColor: Colors.amber, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const TournamentScreen()); }),
      _buildDrawerItem(Icons.group_add_outlined, 'LFG / Squad Finder', iconColor: Colors.green, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const SquadFinderScreen()); }),
      _buildDrawerItem(Icons.library_books_outlined, 'My Library', iconColor: Colors.purple, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const LibraryScreen()); }),
      _buildDrawerItem(Icons.local_activity_outlined, 'Gaming Activity', iconColor: Colors.redAccent, isDark: isDark, onTap: () { 
        Navigator.pop(context); 
        Get.to(() => const GamesActivityScreen()); 
      }),
      _buildDrawerItem(Icons.notifications_outlined, 'Notifications', iconColor: Colors.pink, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const NotificationsScreen()); }),
      
      const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(color: Colors.transparent)),
      
      _buildSectionHeader('CATEGORIES', isDark),
      _buildDrawerItem(Icons.flash_on, 'Action', iconColor: Colors.red, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const GenericPlaceholderScreen(title: 'Action Games')); }),
      _buildDrawerItem(Icons.map_outlined, 'Adventure', iconColor: Colors.green, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const GenericPlaceholderScreen(title: 'Adventure Games')); }),
      _buildDrawerItem(Icons.videogame_asset, 'Arcade', iconColor: Colors.amber, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const GenericPlaceholderScreen(title: 'Arcade Games')); }),
      _buildDrawerItem(Icons.security, 'Battle', iconColor: Colors.grey, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const GenericPlaceholderScreen(title: 'Battle Games')); }),
      _buildDrawerItem(Icons.grid_on, 'Board', iconColor: Colors.teal, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const GenericPlaceholderScreen(title: 'Board Games')); }),
      _buildDrawerItem(Icons.construction, 'Builder', iconColor: Colors.brown, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const GenericPlaceholderScreen(title: 'Builder Games')); }),
      _buildDrawerItem(Icons.style, 'Card', iconColor: Colors.purpleAccent, isDark: isDark, onTap: () { Navigator.pop(context); Get.to(() => const GenericPlaceholderScreen(title: 'Card Games')); }),
    ];
  }

  Widget _buildDrawerItem(IconData icon, String label, {required Color iconColor, bool isActive = false, VoidCallback? onTap, required bool isDark}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive 
            ? (isDark ? Colors.grey[900] : AppPalette.accentBlue.withOpacity(0.1)) 
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(
          icon, 
          color: isActive ? (isDark ? Colors.white : AppPalette.accentBlue) : iconColor,
          size: 24,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isActive ? (isDark ? Colors.white : AppPalette.accentBlue) : (isDark ? Colors.grey[400] : Colors.grey[800]),
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            fontSize: 16,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        onTap: onTap,
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.grey[600] : Colors.grey[500],
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildDrawerFeatureItem(IconData icon, String label, Color color, bool isDark, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        label,
        style: TextStyle(
          color: isDark ? Colors.grey[400] : Colors.grey[700],
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      onTap: onTap,
      dense: true,
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String label;
  final String sublabel;
  const _SidebarItem({required this.label, required this.sublabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(sublabel, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }
}

class _FollowItem extends StatelessWidget {
  final String name;
  final String handle;
  const _FollowItem({required this.name, required this.handle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          CircleAvatar(radius: 16, backgroundImage: AssetImage(AppAssets.avatar1)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                Text(handle, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: const Text('Follow', style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}


