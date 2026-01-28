import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../write_script_screen.dart';
import '../studio_comments_screen.dart';
import '../video_upload_screen.dart';
import '../channel_content_screen.dart';

import '../analytics_screen.dart';

class StudioController extends GetxController {
  final subscribers = '12.4K'.obs;
  final totalViews = '45.2K'.obs;
  final watchTime = '1.2K'.obs;
  final revenue = '\$450'.obs;

  final recentVideoTitle = 'Flutter 2026 Roadmap'.obs;
  final recentVideoViews = '1.2K'.obs;
  final recentVideoCTR = '8.5%'.obs;
  final recentVideoAvgDuration = '4:30'.obs;

  void openScriptEditor() {
    Get.to(() => const WriteScriptScreen());
  }

  void openUploadVideo() {
    Get.to(() => const VideoUploadScreen());
  }

  void openAnalytics() {
     Get.to(() => const AnalyticsScreen());
  }

  void openComments() {
    Get.to(() => const StudioCommentsScreen());
  }

  void openChannelContent() {
    Get.to(() => const ChannelContentScreen());
  }
}
