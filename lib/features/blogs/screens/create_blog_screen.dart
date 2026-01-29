import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({super.key});

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Write a Blog'),
        actions: [
          TextButton(
            onPressed: () {
               if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
                 Get.back();
                 Get.snackbar('Published', 'Your blog post has been published.', backgroundColor: Colors.green, colorText: Colors.white);
               } else {
                 Get.snackbar('Error', 'Title and content are required.', backgroundColor: Colors.red, colorText: Colors.white);
               }
            },
            child: const Text('Publish', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    Text('Add Cover Image', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
            ),
            const Divider(),
            TextField(
              controller: _contentController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                hintText: 'Tell your story...',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
