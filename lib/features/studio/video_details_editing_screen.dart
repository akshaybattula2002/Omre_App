import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoDetailsEditingScreen extends StatefulWidget {
  final Map<String, dynamic> video;

  const VideoDetailsEditingScreen({super.key, required this.video});

  @override
  State<VideoDetailsEditingScreen> createState() => _VideoDetailsEditingScreenState();
}

class _VideoDetailsEditingScreenState extends State<VideoDetailsEditingScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  String _visibility = 'Public';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.video['title']);
    _descController = TextEditingController(text: 'This is a description for ${widget.video['title']}');
    _visibility = widget.video['visibility'] ?? 'Public';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Edit Video',
          style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                Get.snackbar('Success', 'Video details updated.', snackPosition: SnackPosition.BOTTOM);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(12),
               child: Image.asset(
                 widget.video['thumbnail'],
                 width: double.infinity,
                 height: 200,
                 fit: BoxFit.cover,
               ),
             ),
             const SizedBox(height: 24),

             _buildLabel('Title'),
             TextField(
               controller: _titleController,
               decoration: _buildInputDecoration('Video Title'),
             ),
             const SizedBox(height: 24),

             _buildLabel('Description'),
             TextField(
               controller: _descController,
               maxLines: 4,
               decoration: _buildInputDecoration('Video Description'),
             ),
             const SizedBox(height: 24),

             _buildLabel('Visibility'),
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 12),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(color: Colors.grey.withOpacity(0.3)),
               ),
               child: DropdownButtonHideUnderline(
                 child: DropdownButton<String>(
                   value: _visibility,
                   isExpanded: true,
                   items: ['Public', 'Unlisted', 'Private']
                       .map((String value) => DropdownMenuItem<String>(
                             value: value,
                             child: Text(value),
                           ))
                       .toList(),
                   onChanged: (val) {
                     setState(() => _visibility = val!);
                   },
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(12),
         borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
       ),
    );
  }
}
