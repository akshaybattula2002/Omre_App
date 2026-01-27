import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';

class CoursePlayerScreen extends StatefulWidget {
  const CoursePlayerScreen({super.key});

  @override
  State<CoursePlayerScreen> createState() => _CoursePlayerScreenState();
}

class _CoursePlayerScreenState extends State<CoursePlayerScreen> {
  bool isPlaying = false;
  double _currentSliderValue = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Video Area
            Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF1E1E1E),
                    // Mock Video Content (Image as placeholder for now, or use a container)
                    child: Image.asset(
                      AppAssets.post1, // Reusing existing asset
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.5),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: IconButton(
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 30, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black87],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text('04:12', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                trackHeight: 2,
                                thumbColor: Colors.red,
                                activeTrackColor: Colors.red,
                                inactiveTrackColor: Colors.white.withOpacity(0.3),
                              ),
                              child: Slider(
                                value: _currentSliderValue,
                                onChanged: (value) {
                                  setState(() {
                                    _currentSliderValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text('12:45', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                          const SizedBox(width: 8),
                          const Icon(Icons.fullscreen, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Lesson Info & List
            Expanded(
              flex: 6,
              child: Container(
                color: const Color(0xFF121212), // Dark background for content
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Full Stack Development Bootcamp',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12, 
                                backgroundImage: AssetImage(AppAssets.avatar1),
                              ),
                              const SizedBox(width: 8),
                              const Text('Angela Yu', style: TextStyle(color: Colors.grey, fontSize: 13)),
                              const Spacer(),
                              const Icon(Icons.thumb_up_alt_outlined, color: Colors.grey, size: 16),
                              const SizedBox(width: 4),
                              const Text('2.4k', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.white10),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        children: [
                          _buildLessonItem('01. Introduction to Web Development', '10:00', isCompleted: true),
                          _buildLessonItem('02. HTML 5 Basics', '15:30', isCompleted: true),
                          _buildLessonItem('03. CSS Styling', '20:45', isCompleted: true),
                          _buildLessonItem('04. Flexbox Layouts', '12:45', isPlaying: true),
                          _buildLessonItem('05. CSS Grid', '18:20'),
                          _buildLessonItem('06. Javascript Fundamentals', '25:10'),
                          _buildLessonItem('07. DOM Manipulation', '22:15'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonItem(String title, String duration, {bool isCompleted = false, bool isPlaying = false}) {
    return Container(
      color: isPlaying ? const Color(0xFF252525) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          if (isCompleted)
            const Icon(Icons.check_circle, color: Colors.green, size: 20)
          else if (isPlaying)
            const Icon(Icons.play_circle_fill, color: Colors.red, size: 20)
          else
            Icon(Icons.lock_open, color: Colors.grey[700], size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isPlaying ? Colors.white : Colors.grey[400],
                    fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
