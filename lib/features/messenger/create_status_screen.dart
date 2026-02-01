import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';

class CreateStatusScreen extends StatefulWidget {
  const CreateStatusScreen({super.key});

  @override
  State<CreateStatusScreen> createState() => _CreateStatusScreenState();
}

class _CreateStatusScreenState extends State<CreateStatusScreen> {
  final TextEditingController _textController = TextEditingController();
  Color _backgroundColor = Colors.purple;
  
  final List<Color> _colors = [
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.orange,
    Colors.blueGrey,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette, color: Colors.white),
            onPressed: _cycleColor,
          ),
          IconButton(
            icon: const Icon(Icons.text_fields, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                controller: _textController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Type a status...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                maxLines: 5,
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  Get.back();
                  Get.snackbar('Success', 'Status updated successfully!');
                }
              },
              child: const Icon(Icons.send, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  void _cycleColor() {
    setState(() {
      int currentIndex = _colors.indexOf(_backgroundColor);
      int nextIndex = (currentIndex + 1) % _colors.length;
      _backgroundColor = _colors[nextIndex];
    });
  }
}
