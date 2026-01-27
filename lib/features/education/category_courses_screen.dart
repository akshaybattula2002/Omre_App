import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import 'controllers/education_controller.dart';

class CategoryCoursesScreen extends StatelessWidget {
  final String categoryName;
  const CategoryCoursesScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final EducationController controller = Get.find<EducationController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final courses = controller.getCategoryCourses(categoryName);
    final categoryColor = controller.getCategoryColor(categoryName);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C10) : Colors.white,
      appBar: AppBar(
        title: Text(categoryName, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          // Hero Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [categoryColor, categoryColor.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: categoryColor.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8)),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Master $categoryName',
                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Hand-picked courses to help you advance your career.',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.school, color: Colors.white, size: 32),
                ),
              ],
            ),
          ),

          // Course List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                 final course = courses[index];
                 return _buildWideCourseCard(course, controller, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWideCourseCard(CourseModel course, EducationController controller, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF11141B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: !isDark ? [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ] : null,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(course.thumbnailUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('POPULAR', style: TextStyle(color: Colors.purple, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    const Spacer(),
                    Icon(Icons.star, size: 16, color: Colors.amber[700]),
                    const SizedBox(width: 4),
                    Text(course.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(' (${course.students})', style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, height: 1.3)),
                const SizedBox(height: 4),
                Text(course.instructor, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text('\$${course.price}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppPalette.accentBlue)),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => controller.enrollInCourse(course),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Enroll', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
