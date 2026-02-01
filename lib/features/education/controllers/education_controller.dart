import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../streak_screen.dart';
import '../certificates_screen.dart';
import '../explore_courses_screen.dart';
import '../course_player_screen.dart';
import '../course_detail_screen.dart';
import '../category_courses_screen.dart';
import '../weekly_goal_screen.dart';

class CourseCategory {
  final String name;
  final int count;
  final IconData icon;
  final Color color;
  final String? assetPath;

  CourseCategory({
    required this.name,
    required this.count,
    required this.icon,
    required this.color,
    this.assetPath,
  });
}

class CourseModel {
  final String title;
  final String instructor;
  final int students;
  final String duration;
  final double price;
  final double rating;
  final String thumbnailUrl;

  CourseModel({
    required this.title,
    required this.instructor,
    required this.students,
    required this.duration,
    required this.price,
    required this.rating,
    required this.thumbnailUrl,
  });
}

class EducationController extends GetxController {
  final categories = <CourseCategory>[
    CourseCategory(name: 'Development', count: 2450, icon: Icons.code, color: Colors.blue, assetPath: 'assets/images/video_icon_3d.png'),
    CourseCategory(name: 'Design', count: 1230, icon: Icons.palette, color: Colors.pink, assetPath: 'assets/images/studio_icon_3d.png'),
    CourseCategory(name: 'Business', count: 980, icon: Icons.bar_chart, color: Colors.orange, assetPath: 'assets/images/biz_icon_3d.png'),
    CourseCategory(name: 'Photography', count: 650, icon: Icons.camera_alt, color: Colors.green, assetPath: AppAssets.imagesIcon3d),
  ].obs;

  final recommendedCourses = <CourseModel>[
    CourseModel(
      title: 'Complete Development Bootcamp 2026',
      instructor: 'Jose Portilla',
      students: 1000,
      duration: '10h 0m',
      price: 19.99,
      rating: 4.8,
      thumbnailUrl: AppAssets.getRandomThumbnail(),
    ),
    CourseModel(
      title: 'Advanced Flutter Mastery',
      instructor: 'Maximilian Schwarzmüller',
      students: 1500,
      duration: '15h 30m',
      price: 24.99,
      rating: 4.9,
      thumbnailUrl: AppAssets.getRandomThumbnail(),
    ),
  ].obs;

  final learningStreak = 12.obs;
  final weeklyProgress = 0.6.obs; // 3 of 5 lessons
  final certificatesEarned = 8.obs;
  
  // Weekly Goal Settings
  final weeklyLessonTarget = 5.obs;
  final studyReminderTime = '8:00 PM'.obs;
  final difficultyLevel = 'Intermediate'.obs;

  final enrolledCourses = <String>{}.obs;

  void enroll(CourseModel course) {
    if (!enrolledCourses.contains(course.title)) {
      enrolledCourses.add(course.title);
      Get.back();
      Get.snackbar(
        'Successfully Enrolled',
        'You can now start learning ${course.title}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void enrollInCourse(CourseModel course) {
    Get.to(() => CourseDetailScreen(course: course));
  }

  void continueStreak() {
    Get.to(() => const StreakScreen());
  }

  void resumeCourse() {
    Get.to(() => const CoursePlayerScreen());
  }

  void viewCategory(String categoryName) {
    Get.to(() => CategoryCoursesScreen(categoryName: categoryName));
  }

  List<CourseModel> getCategoryCourses(String category) {
    // Mock Data based on category
    if (category == 'Development') {
      return [
        CourseModel(title: 'Flutter & Dart - The Complete Guide', instructor: 'Maximilian', students: 5000, duration: '40h', price: 14.99, rating: 4.8, thumbnailUrl: AppAssets.thumbnail1),
        CourseModel(title: 'Node.js, Express, MongoDB & More', instructor: 'Jonas', students: 3000, duration: '35h', price: 18.99, rating: 4.7, thumbnailUrl: AppAssets.thumbnail2),
      ];
    } else if (category == 'Design') {
      return [
        CourseModel(title: 'Figma for UI/UX Design', instructor: 'Gary Simon', students: 2500, duration: '12h', price: 12.99, rating: 4.9, thumbnailUrl: AppAssets.thumbnail3),
        CourseModel(title: 'Complete Web Design Bootcamp', instructor: 'Dr. Angela Yu', students: 4000, duration: '20h', price: 15.99, rating: 4.8, thumbnailUrl: AppAssets.thumbnail2),
      ];
    } else if (category == 'Business') {
      return [
         CourseModel(title: 'The Complete MBA Course', instructor: 'Chris Haroun', students: 10000, duration: '50h', price: 19.99, rating: 4.5, thumbnailUrl: AppAssets.thumbnail1),
      ];
    } else {
      return recommendedCourses.toList();
    }
  }

  Color getCategoryColor(String category) {
    return categories.firstWhere((c) => c.name == category, orElse: () => categories[0]).color;
  }
  
  void viewAllCourses() {
     Get.to(() => const ExploreCoursesScreen());
  }
  
  void viewCertificates() {
     Get.to(() => const CertificatesScreen());
  }
  
  void viewWeeklyGoal() {
     Get.to(() => const WeeklyGoalScreen());
  }
}
