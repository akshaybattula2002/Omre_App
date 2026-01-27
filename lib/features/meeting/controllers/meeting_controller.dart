import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../messenger/call_screen.dart';
import '../../../core/constants/app_assets.dart';

class MeetingController extends GetxController {
  final cameraStatus = PermissionStatus.denied.obs;
  final micStatus = PermissionStatus.denied.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    cameraStatus.value = await Permission.camera.status;
    micStatus.value = await Permission.microphone.status;
  }

  Future<void> requestCameraPermission() async {
    cameraStatus.value = await Permission.camera.request();
  }

  Future<void> requestMicPermission() async {
    micStatus.value = await Permission.microphone.request();
  }

  final upcomingMeetings = <Map<String, dynamic>>[
    {
      'title': 'Project Kickoff',
      'host': 'Alice Smith',
      'time': '10:00 AM',
      'duration': '45 min',
      'avatar': AppAssets.avatar1,
      'code': 'abc-kick-off'
    },
    {
      'title': 'Design Review',
      'host': 'Bob Johnson',
      'time': '2:00 PM',
      'duration': '1 hr',
      'avatar': AppAssets.avatar2,
      'code': 'xyz-design-rev'
    },
  ].obs;

  void startInstantMeeting() {
    Get.back(); // Close modal if open
    Get.to(() => const CallScreen(
      caller: {'name': 'Instant Meeting', 'avatarUrl': AppAssets.avatar1},
      isVideo: true,
    ));
  }

  void joinMeeting(String code) {
    if (code.isEmpty) {
      Get.snackbar('Error', 'Please enter a valid meeting code', 
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.red, 
        colorText: Colors.white
      );
      return;
    }
    Get.back(); // Close dialog if open
    Get.to(() => CallScreen(
      caller: {'name': 'Meeting: $code', 'avatarUrl': AppAssets.avatar3},
      isVideo: true,
    ));
  }

  void scheduleMeeting() {
    // Determine context or use Get.bottomSheet/dialog
    Get.back(); // Close previous modal
    // Add dummy meeting for demo
    upcomingMeetings.add({
      'title': 'New Scheduled Meeting',
      'host': 'You',
      'time': 'Tomorrow, 9:00 AM',
      'duration': '30 min',
      'avatar': AppAssets.avatar1,
      'code': 'new-meet-123'
    });
    Get.snackbar('Success', 'Meeting scheduled successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void shareScreen() {
    Get.back(); // Close dialog
    // Simulate share screen by opening call screen with a specific indicator or just regular call
    Get.to(() => const CallScreen(
      caller: {'name': 'Screen Share', 'avatarUrl': AppAssets.avatar4},
      isVideo: false, // Maybe audio only + visual indicator
    ));
    // In a real app coverage, this might toggle a boolean in the call screen or start a foreground service
    Get.snackbar('Screen Share', 'Your screen is being shared',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }
}
