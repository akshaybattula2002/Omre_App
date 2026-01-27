import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/social_models.dart';
import '../../../core/constants/app_assets.dart';
import './home_controller.dart';

class AddStoryController extends GetxController {
  final _picker = ImagePicker();
  final selectedMedia = Rxn<File>();
  final caption = ''.obs;
  final isUploading = false.obs;

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1920,
      );
      if (image != null) {
        selectedMedia.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> uploadStory() async {
    if (selectedMedia.value == null) return;

    isUploading.value = true;
    
    // Simulate upload delay
    await Future.delayed(const Duration(seconds: 1));

    final newStory = StoryModel(
      id: 'my_story_${DateTime.now().millisecondsSinceEpoch}',
      username: 'Your Story',
      avatarUrl: AppAssets.avatar1,
      imageUrl: selectedMedia.value!.path,
      timestamp: DateTime.now(),
      isMe: true,
    );

    final homeController = Get.find<HomeController>();
    homeController.addStory(newStory);

    isUploading.value = false;
    Get.back();
    Get.snackbar('Success', 'Story uploaded!', snackPosition: SnackPosition.BOTTOM);
  }
}
