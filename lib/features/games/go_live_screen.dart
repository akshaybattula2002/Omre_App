import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';

class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({super.key});

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _titleController = TextEditingController();
  String _selectedGame = 'Neon Vanguard';
  String _selectedCategory = 'Gaming';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Go Live'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Camera Preview Dummy
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: FadeTransition(
                      opacity: _controller,
                      child: const Icon(Icons.videocam_off, color: Colors.white38, size: 48),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                    child: const Row(
                      children: [
                        CircleAvatar(radius: 4, backgroundColor: Colors.red),
                        SizedBox(width: 8),
                        Text('PREVIEW', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Row(
                    children: [
                      _buildCameraAction(Icons.flip_camera_ios, isDark),
                      const SizedBox(width: 12),
                      _buildCameraAction(Icons.mic, isDark),
                      const SizedBox(width: 12),
                      _buildCameraAction(Icons.flash_on, isDark),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Stream Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
                   const SizedBox(height: 20),

                   // Title Input
                   TextField(
                     controller: _titleController,
                     decoration: InputDecoration(
                       labelText: 'Stream Title',
                       hintText: 'What are you playing today?',
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                       prefixIcon: const Icon(Icons.title),
                     ),
                   ),
                   const SizedBox(height: 20),

                   // Game Selection
                   Text('Select Game', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor.withOpacity(0.7))),
                   const SizedBox(height: 8),
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16),
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey.withOpacity(0.5)),
                       borderRadius: BorderRadius.circular(12),
                     ),
                     child: DropdownButtonHideUnderline(
                       child: DropdownButton<String>(
                         value: _selectedGame,
                         isExpanded: true,
                         items: ['Neon Vanguard', 'Elden Ring', 'Among Us', 'Valorant'].map((game) {
                           return DropdownMenuItem(value: game, child: Text(game));
                         }).toList(),
                         onChanged: (val) => setState(() => _selectedGame = val!),
                       ),
                     ),
                   ),
                   const SizedBox(height: 20),

                   // Category Selection
                   Text('Category', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor.withOpacity(0.7))),
                   const SizedBox(height: 8),
                   Wrap(
                     spacing: 8,
                     children: ['Gaming', 'Talking', 'Music', 'Creative'].map((cat) {
                       final isSelected = _selectedCategory == cat;
                       return ChoiceChip(
                         label: Text(cat),
                         selected: isSelected,
                         onSelected: (selected) => setState(() => _selectedCategory = cat),
                         selectedColor: Colors.redAccent.withOpacity(0.2),
                         labelStyle: TextStyle(color: isSelected ? Colors.redAccent : textColor),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: isSelected ? Colors.redAccent : Colors.grey.withOpacity(0.3))),
                       );
                     }).toList(),
                   ),

                   const SizedBox(height: 48),

                   // Start Button
                   SizedBox(
                     width: double.infinity,
                     height: 56,
                     child: ElevatedButton(
                       onPressed: () {
                         Get.snackbar('Coming Soon', 'Streaming services are being integrated!', backgroundColor: Colors.redAccent, colorText: Colors.white);
                       },
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.red,
                         foregroundColor: Colors.white,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                         elevation: 8,
                         shadowColor: Colors.red.withOpacity(0.4),
                       ),
                       child: const Text('Start Streaming', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                     ),
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraAction(IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
