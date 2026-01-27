import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/education_controller.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/palette.dart';

class CourseDetailScreen extends GetView<EducationController> {
  final CourseModel course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF07090C) : Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, isDark),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCourseHeader(isDark),
                  const SizedBox(height: 32),
                  _buildAboutSection(isDark),
                  const SizedBox(height: 32),
                  _buildCurriculum(isDark),
                  const SizedBox(height: 32),
                  _buildInstructorSection(isDark),
                  const SizedBox(height: 120), // Spacer for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomEnrollBar(isDark),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: isDark ? const Color(0xFF0F1218) : Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
        onPressed: () => Get.back(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(course.thumbnailUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseHeader(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppPalette.accentBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Development', // Mock category
            style: const TextStyle(color: AppPalette.accentBlue, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        Text(course.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 18),
            const SizedBox(width: 4),
            Text(course.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(' (${course.students} students)', style: const TextStyle(color: Colors.grey)),
            const Spacer(),
            Text(course.duration, style: const TextStyle(fontWeight: FontWeight.w600, color: AppPalette.accentBlue)),
          ],
        ),
      ],
    );
  }

  Widget _buildAboutSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('About this course', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(
          'Master professional development with this industry-leading course. Learn through hands-on projects, expert instruction, and a curriculum designed to take you from beginner to advanced professional.',
          style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], height: 1.5, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildCurriculum(bool isDark) {
    final modules = [
      {'title': 'Introduction to the Course', 'lessons': 4, 'duration': '45m'},
      {'title': 'Setting Up Your Environment', 'lessons': 6, 'duration': '1h 20m'},
      {'title': 'Core Principles & Fundamentals', 'lessons': 12, 'duration': '4h 15m'},
      {'title': 'Advanced Implementation Techniques', 'lessons': 8, 'duration': '3h 10m'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Curriculum', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...modules.map((module) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF11141B) : Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: ExpansionTile(
            title: Text(module['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            subtitle: Text('${module['lessons']} lessons • ${module['duration']}', 
              style: TextStyle(color: Colors.grey[500], fontSize: 13)),
            children: List.generate(3, (i) => ListTile(
              leading: const Icon(Icons.play_circle_outline, size: 20),
              title: Text('Lesson ${i + 1}: Modern Best Practices', style: const TextStyle(fontSize: 14)),
              trailing: const Text('15:00', style: TextStyle(color: Colors.grey, fontSize: 12)),
            )),
          ),
        )),
      ],
    );
  }

  Widget _buildInstructorSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Instructor', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: AssetImage(AppAssets.avatar1)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.instructor, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const Text('Senior Software Engineer & Lead Instructor', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'With over 10 years of experience in the industry, ${course.instructor} has taught over 500,000 students worldwide and is known for breaking down complex topics into easy-to-understand concepts.',
          style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], height: 1.5, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildBottomEnrollBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F1218) : Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Full lifetime access', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('\$${course.price}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppPalette.accentBlue)),
              ],
            ),
          ),
          SizedBox(
            width: 180,
            height: 56,
            child: ElevatedButton(
              onPressed: () => controller.enroll(course),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.accentBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text('Enroll Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
