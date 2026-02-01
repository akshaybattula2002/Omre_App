import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';
import 'controllers/education_controller.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EducationController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C10) : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(controller, isDark),
            const SizedBox(height: 32),
            _buildContinueLearningSection(controller, isDark),
            const SizedBox(height: 32),

            // Explore by Category
            _buildSectionHeader('Explore by Category', controller, showViewAll: false),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: controller.categories.map((cat) => _buildCategoryCard(cat, controller, isDark)).toList(),
            ),

            const SizedBox(height: 40),

            // Recommended for You
            _buildSectionHeader('Recommended for You', controller, subtitle: 'Based on your interests and goals'),
            const SizedBox(height: 16),
            SizedBox(
              height: 380,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: controller.recommendedCourses.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildCourseCard(controller.recommendedCourses[index], controller, isDark);
                },
              ),
            ),

            const SizedBox(height: 40),

            // Gamification Dashboard
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildStreakCard(controller, isDark),
                  const SizedBox(height: 16),
                  _buildGoalCard(controller, isDark),
                  const SizedBox(height: 16),
                  _buildCertificatesCard(controller, isDark),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, EducationController controller, {String? subtitle, bool showViewAll = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              if (showViewAll)
                TextButton(
                  onPressed: controller.viewAllCourses,
                  child: const Text('View All', style: TextStyle(color: AppPalette.accentBlue, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryCard(CourseCategory cat, EducationController controller, bool isDark) {
    return GestureDetector(
      onTap: () => controller.viewCategory(cat.name),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF11141B) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: !isDark ? [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cat.color.withOpacity(isDark ? 0.1 : 0.05),
                shape: BoxShape.circle,
              ),
              child: cat.assetPath != null
                  ? Image.asset(cat.assetPath!, width: 28, height: 28)
                  : Icon(cat.icon, color: cat.color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(cat.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            Text('${cat.count} courses', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(CourseModel course, EducationController controller, bool isDark) {
    return Container(
      width: 280,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF11141B) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: !isDark ? [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ] : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(course.thumbnailUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(course.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Text(course.instructor, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text('${course.students} students', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(course.duration, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${course.price}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppPalette.accentBlue)),
                    ElevatedButton(
                      onPressed: () => controller.enrollInCourse(course),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: const Text('Enroll Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  Widget _buildStreakCard(EducationController controller, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFE4C24), Color(0xFFFE8F24)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                child: const Icon(Icons.local_fire_department, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Learning Streak', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
                  Obx(() => Text('${controller.learningStreak} Days', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Keep it up! You\'re on fire 🔥', style: TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.continueStreak,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFFE4C24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Continue Streak', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(EducationController controller, bool isDark) {
    return GestureDetector(
      onTap: controller.viewWeeklyGoal,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF11141B) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Weekly Goal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Obx(() => Text('${(controller.weeklyProgress.value * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
              ],
            ),
            const SizedBox(height: 8),
            const Text('3 of 5 lessons', style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 16),
            Obx(() => LinearProgressIndicator(
              value: controller.weeklyProgress.value,
              backgroundColor: Colors.grey.withOpacity(0.1),
              color: AppPalette.accentBlue,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            )),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].asMap().entries.map((entry) {
                bool completed = entry.key < 3;
                bool today = entry.key == 3;
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: completed ? const Color(0xFFEFFFF7) : (today ? const Color(0xFFF3E8FF) : Colors.grey.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(10),
                    border: today ? Border.all(color: const Color(0xFF8B5CF6)) : null,
                  ),
                  alignment: Alignment.center,
                  child: completed 
                    ? const Icon(Icons.check, size: 16, color: Color(0xFF27AE60))
                    : Text(entry.value, style: TextStyle(color: today ? const Color(0xFF8B5CF6) : Colors.grey, fontWeight: FontWeight.bold)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificatesCard(EducationController controller, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                child: const Icon(Icons.workspace_premium, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Certificates Earned', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
                  Obx(() => Text(controller.certificatesEarned.toString(), style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Complete 2 more to reach Pro level!', style: TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.viewCertificates,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF8B5CF6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('View Certificates', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueLearningSection(EducationController controller, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Continue Learning',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextButton(
                onPressed: controller.viewAllCourses,
                child: const Text('View All', style: TextStyle(color: AppPalette.accentBlue, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Text(
            'Pick up where you left off',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF11141B) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
              boxShadow: !isDark ? [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
              ] : null,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      AppAssets.getRandomPost(),
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2555C8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'In Progress',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Full Stack Development Bootcamp',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '45% Complete',
                            style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '12/28 Lessons',
                            style: TextStyle(color: Colors.grey[500], fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 0.45,
                        backgroundColor: Colors.grey.withOpacity(0.1),
                        color: const Color(0xFF2555C8),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.resumeCourse,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2555C8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('Resume Learning', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(EducationController controller, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6366F1), // Indigo
            Color(0xFF8B5CF6), // Violet
            Color(0xFFEC4899), // Pink
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🎓', style: TextStyle(fontSize: 14)),
                SizedBox(width: 8),
                Text(
                  'New courses added weekly',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Learn Without Limits',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Start, switch, or advance your career with thousands of courses, hands-on projects, and certificate programs.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'What do you want to learn?',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.white70),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Explore Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.viewAllCourses,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF8B5CF6),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Explore Courses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),

          const SizedBox(height: 40),

          // Stats
          Wrap(
            spacing: 24,
            runSpacing: 16,
            children: [
              _buildHeroStat(Icons.people_alt_outlined, '2M+ learners', assetPath: AppAssets.friendsIcon3d),
              _buildHeroStat(Icons.workspace_premium_outlined, '10K+ courses'),
              _buildHeroStat(Icons.trending_up, '95% completion rate'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(IconData icon, String label, {String? assetPath}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        assetPath != null
            ? Image.asset(assetPath, width: 20, height: 20)
            : Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ],
    );
  }
}
