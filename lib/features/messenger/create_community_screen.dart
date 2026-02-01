import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  bool _isPublic = true;
  String? _selectedImage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Community')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _selectedImage != null ? AssetImage(_selectedImage!) : null,
                    child: _selectedImage == null 
                      ? const Icon(Icons.group_add, size: 50, color: Colors.grey) 
                      : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                        onPressed: _showImagePicker,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField('Community Name', 'e.g., Tech Enthusiasts'),
            const SizedBox(height: 16),
            _buildTextField('Description', 'What is this community about?', maxLines: 3),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Privacy Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 12),
            _buildPrivacyOption('Public', 'Anyone can find and join', true, theme),
            _buildPrivacyOption('Private', 'Only invited members can join', false, theme),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.snackbar('Success', 'Community created successfully!');
                },
                child: const Text('Create Community'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePicker() {
    Get.bottomSheet(
      Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Get.back();
                // Simulate taking a photo by using a random avatar
                setState(() {
                  _selectedImage = AppAssets.avatar1;
                });
                Get.snackbar('Image', 'Photo taken (simulated)');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                // Simulate choosing from gallery
                setState(() {
                  _selectedImage = AppAssets.avatar2;
                });
                 Get.snackbar('Image', 'Image selected (simulated)');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyOption(String title, String subtitle, bool isPublicOption, ThemeData theme) {
    bool isSelected = _isPublic == isPublicOption;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPublic = isPublicOption;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.blue.withOpacity(0.05) : null,
        ),
        child: RadioListTile<bool>(
          value: isPublicOption,
          groupValue: _isPublic,
          onChanged: (val) {
             if (val != null) {
               setState(() {
                 _isPublic = val;
               });
             }
          },
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          selected: isSelected,
        ),
      ),
    );
  }
}
