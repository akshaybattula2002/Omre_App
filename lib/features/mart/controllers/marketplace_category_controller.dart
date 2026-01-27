import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/services/mock_service.dart';
import '../../messenger/chat_detail_screen.dart';
import '../post_requirement_screen.dart';

class MarketplaceCategoryController extends GetxController {
  final searchQuery = ''.obs;
  final categoryName = ''.obs;
  
  final providers = <Map<String, dynamic>>[].obs;

  void initCategory(String name) {
    categoryName.value = name;
    _loadMockDataForCategory(name);
  }

  void _loadMockDataForCategory(String name) {
    // Sharing same mock data for all categories for now as per requirement
    providers.value = [
      {
        'name': '$name Pro Provider 1',
        'rating': 4.4,
        'reviews': 50,
        'location': 'Location 1, City',
        'distance': '1 km',
        'fastResponse': true,
        'verified': true,
        'image': AppAssets.post1,
      },
      {
        'name': '$name Specialist 2',
        'rating': 4.8,
        'reviews': 120,
        'location': 'Main Street, City',
        'distance': '2.5 km',
        'fastResponse': true,
        'verified': true,
        'image': AppAssets.post2,
      },
      {
        'name': 'Expert $name Solutions',
        'rating': 4.2,
        'reviews': 85,
        'location': 'Downtown, City',
        'distance': '3.2 km',
        'fastResponse': false,
        'verified': false,
        'image': AppAssets.post3,
      },
      {
        'name': 'Premium $name Center',
        'rating': 4.6,
        'reviews': 200,
        'location': 'Suburb Area, City',
        'distance': '5.0 km',
        'fastResponse': true,
        'verified': true,
        'image': AppAssets.post4,
      },
    ];
  }

  List<Map<String, dynamic>> get filteredProviders {
    if (searchQuery.value.isEmpty) return providers;
    return providers.where((p) => 
      p['name'].toString().toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }

  void callProvider(String name) {
    Get.snackbar(
      'Calling',
      'Connecting to $name...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void chatProvider(String name) {
    // Navigate to chat detail with mock provider data
    Get.to(() => const ChatDetailScreen(), arguments: MockChat(
      id: 'provider_chat_${name.toLowerCase().replaceAll(' ', '_')}',
      name: name,
      avatarUrl: AppAssets.post1, // Default avatar for mock
      lastMessage: 'Hi, I saw your profile and wanted to inquire about your services.',
      time: 'Just now',
      unreadCount: 0,
      category: 'Provider',
    ));
  }

  void postRequirement() {
    Get.to(() => const PostRequirementScreen());
  }

  void saveProvider(String name) {
    Get.snackbar('Saved', '$name added to your saved providers', snackPosition: SnackPosition.BOTTOM);
  }

  void reportProvider(String name) {
    Get.snackbar('Reported', 'Thank you for reporting $name. We will investigate.', snackPosition: SnackPosition.BOTTOM);
  }

  void shareProvider(String name) {
    Get.snackbar('Shared', 'Sharing $name with your contacts...', snackPosition: SnackPosition.BOTTOM);
  }
}
