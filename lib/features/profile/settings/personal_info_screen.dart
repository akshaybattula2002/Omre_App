import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController(text: 'Alex Johnson');
  final usernameController = TextEditingController(text: 'alexj_design');
  final emailController = TextEditingController(text: 'alex.j@example.com');
  final phoneController = TextEditingController(text: '+1 (555) 123-4567');
  final bioController = TextEditingController(text: 'Digital Nomad | UI/UX Enthusiast');

  final Rx<String?> profileImagePath = Rx<String?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        profileImagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.onClose();
  }
}

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Success', 'Profile updated', snackPosition: SnackPosition.BOTTOM);
            },
            child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold, color: AppPalette.accentBlue)),
          ),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: controller.pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: controller.profileImagePath.value != null
                    ? FileImage(File(controller.profileImagePath.value!)) as ImageProvider
                    : const AssetImage(AppAssets.avatar1),
              ),
            ),
            TextButton(
              onPressed: controller.pickImage,
              child: const Text('Change Profile Photo', style: TextStyle(color: AppPalette.accentBlue, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
            _buildEditField('Name', controller.nameController, isDark),
            _buildEditField('Username', controller.usernameController, isDark),
            _buildEditField('Email', controller.emailController, isDark),
            _buildEditField('Phone', controller.phoneController, isDark),
            _buildEditField('Bio', controller.bioController, isDark, maxLines: 3),
          ],
        ),
      )),
    );
  }

  Widget _buildEditField(String label, TextEditingController textController, bool isDark, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
        TextField(
          controller: textController,
          maxLines: maxLines,
          style: const TextStyle(fontWeight: FontWeight.w500),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppPalette.accentBlue)),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
