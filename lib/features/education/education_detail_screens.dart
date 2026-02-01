import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';

// --- MY LEARNING ---
class CoursePlayerScreen extends StatelessWidget {
  final String title;
  const CoursePlayerScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Container(
            height: 250,
            color: Colors.black,
            child: const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 64)),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Course Description goes here. Learn everything about this topic in depth.'),
                const SizedBox(height: 24),
                const Text('Lessons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const ListTile(leading: Icon(Icons.play_arrow), title: Text('Introduction'), subtitle: Text('5:30')),
                const ListTile(leading: Icon(Icons.lock), title: Text('Chapter 1: Basics'), subtitle: Text('15:00')),
                const ListTile(leading: Icon(Icons.lock), title: Text('Chapter 2: Advanced'), subtitle: Text('20:45')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- TUTOR MARKETPLACE ---
class TutorProfileScreen extends StatelessWidget {
  final String name;
  const TutorProfileScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundImage: AssetImage(AppAssets.avatar1)),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('English, Spanish • \$15/hr'),
            const SizedBox(height: 16),
             Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.star, color: Colors.amber), Text(' 4.9 (120 reviews)')]),
            const SizedBox(height: 24),
            const Text('About Me', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('I am an experienced tutor with over 5 years of teaching...'),
            const SizedBox(height: 32),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.snackbar('Success', 'Booking Request Sent!'), child: const Text('Book a Session'))),
          ],
        ),
      ),
    );
  }
}

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            const Text('Booking Confirmed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => Get.back(), child: const Text('Back to Home')),
          ],
        ),
      ),
    );
  }
}

// --- WISHLIST & CART ---
class CourseCheckoutScreen extends StatelessWidget {
  const CourseCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Total Amount: \$28.98', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            const TextField(decoration: InputDecoration(labelText: 'Card Number', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            Row(
              children: [
                 Expanded(child: TextField(decoration: InputDecoration(labelText: 'Expiry', border: OutlineInputBorder()))),
                 const SizedBox(width: 16),
                 Expanded(child: TextField(decoration: InputDecoration(labelText: 'CVV', border: OutlineInputBorder()))),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.snackbar('Success', 'Payment Successful!');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: const Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- TEACHER DASHBOARD ---
class TeacherCourseDetailScreen extends StatelessWidget {
    final String title;
    const TeacherCourseDetailScreen({super.key, required this.title});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: Text('Analytics and Tools for $title')),
      );
    }
}
