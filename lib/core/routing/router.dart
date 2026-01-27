import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/auth/login_screen.dart';
import '../../features/shell/shell_screen.dart';
import '../../features/link/link_home_screen.dart';
import '../../features/studio/studio_home_screen.dart';
import '../../features/social/social_home_screen.dart';
import '../../features/video/video_home_screen.dart';
import '../../features/news/news_home_screen.dart';
import '../../features/orbit/orbit_home_screen.dart';
import '../../features/games/game_verse_screen.dart';
import '../../features/messenger/messenger_home_screen.dart';
import '../../features/education/education_screen.dart';
import '../../features/meeting/meeting_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/social/add_story_screen.dart';
import '../../features/social/story_viewer_screen.dart';
import '../../features/social/controllers/add_story_controller.dart';
import '../../features/social/controllers/story_viewer_controller.dart';
import '../../features/social/controllers/home_controller.dart';
import '../../features/messenger/chat_detail_screen.dart';
import '../../features/messenger/controllers/chat_detail_controller.dart';
import '../../features/biz/biz_home_screen.dart';
import '../../features/mart/social_marketplace_screen.dart';
import '../services/state_providers.dart';

import '../../features/auth/splash_screen.dart';

class AppPages {
  static const initial = '/splash';

  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: '/signup',
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: '/', // Keeping base route point to Shell
      page: () => const ShellScreen(),
      binding: ShellBinding(),
    ),
    GetPage(
      name: '/add-story',
      page: () => const AddStoryScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddStoryController());
      }),
    ),
    GetPage(
      name: '/story-viewer',
      page: () => const StoryViewerScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => StoryViewerController());
      }),
    ),
    GetPage(
      name: '/chat-detail',
      page: () => const ChatDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChatDetailController());
      }),
    ),
  ];
}

class ShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
  }
}

class HomeContent extends GetView<AppController> {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.appMode) {
        case AppMode.social:
          return const SocialHomeScreen();
        case AppMode.messenger:
          return const MessengerHomeScreen();
        case AppMode.education:
          return const EducationScreen();
        case AppMode.biz:
          return const BizHomeScreen();
        case AppMode.link:
          return const LinkHomeScreen();
        case AppMode.studio:
          return const StudioHomeScreen();
        case AppMode.news:
          return const NewsHomeScreen();
        case AppMode.video:
          return const VideoHomeScreen();
        case AppMode.orbit:
          return const OrbitHomeScreen();
        case AppMode.games:
          return const GameVerseScreen();
        case AppMode.meeting:
          return const MeetingScreen();
        case AppMode.mart:
          return const SocialMarketplaceScreen();
      }
    });
  }
}
