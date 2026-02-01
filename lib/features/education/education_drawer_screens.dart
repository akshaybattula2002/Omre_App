import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';
import 'education_detail_screens.dart';

// --- Shared Widgets ---

class EducationCourseCard extends StatelessWidget {
  final String title;
  final String author;
  final String progress; // e.g., "0.8" for 80%
  final String progressLabel;
  final String image;
  final VoidCallback? onTap;

  const EducationCourseCard({
    super.key,
    required this.title,
    required this.author,
    required this.progress,
    required this.progressLabel,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Parse progress string to double safely
    double progressValue = 0.0;
    try {
      progressValue = double.parse(progress);
    } catch (_) {}

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(author, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(value: progressValue, minHeight: 6, borderRadius: BorderRadius.circular(3)),
                  const SizedBox(height: 4),
                  Text('$progressLabel Complete', style: TextStyle(color: Colors.grey[700], fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Screens ---

class EducationMyLearningScreen extends StatelessWidget {
  const EducationMyLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Learning')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          EducationCourseCard(
            title: 'Complete Flutter Bootcamp', 
            author: 'Dr. Angela Yu', 
            progress: '0.45', 
            progressLabel: '45%', 
            image: AppAssets.thumbnail1,
            onTap: () => Get.to(() => const CoursePlayerScreen(title: 'Complete Flutter Bootcamp')),
          ),
          EducationCourseCard(
            title: 'Python for Data Science', 
            author: 'Jose Portilla', 
            progress: '0.80', 
            progressLabel: '80%', 
            image: AppAssets.thumbnail2,
            onTap: () => Get.to(() => const CoursePlayerScreen(title: 'Python for Data Science')),
          ),
          EducationCourseCard(
            title: 'UI/UX Design Masterclass', 
            author: 'Gary Simon', 
            progress: '0.10', 
            progressLabel: '10%', 
            image: AppAssets.thumbnail3,
            onTap: () => Get.to(() => const CoursePlayerScreen(title: 'UI/UX Design Masterclass')),
          ),
        ],
      ),
    );
  }
}

class EducationTutorMarketplaceScreen extends StatelessWidget {
  const EducationTutorMarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find a Tutor')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => const Divider(height: 24),
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(AppAssets.avatars[index % AppAssets.avatars.length]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tutor Name ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text('English, Spanish • \$15/hr'),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        Text(' 4.9 (120 reviews)', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => TutorProfileScreen(name: 'Tutor Name ${index + 1}')),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12)),
                child: const Text('Book'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class EducationWishlistScreen extends StatelessWidget {
  const EducationWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _WishlistItem(title: 'Advanced React Patterns', price: '\$12.99', image: AppAssets.thumbnail1),
          _WishlistItem(title: 'Machine Learning A-Z', price: '\$15.99', image: AppAssets.thumbnail2),
          _WishlistItem(title: 'The Art of Negotiation', price: '\$9.99', image: AppAssets.thumbnail3),
        ],
      ),
    );
  }
}

class _WishlistItem extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  const _WishlistItem({required this.title, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(image, width: 60, height: 40, fit: BoxFit.cover),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(price, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => Get.snackbar('Wishlist', '$title removed')),
      ),
    );
  }
}

class EducationCartScreen extends StatelessWidget {
  const EducationCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, border: const Border(top: BorderSide(color: Colors.grey))),
        child: SafeArea( // Ensure button is reachable
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total:', style: TextStyle(color: Colors.grey)),
                  Text('\$28.98', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const CourseCheckoutScreen()),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _WishlistItem(title: 'Advanced React Patterns', price: '\$12.99', image: AppAssets.thumbnail1),
          _WishlistItem(title: 'Machine Learning A-Z', price: '\$15.99', image: AppAssets.thumbnail2),
        ],
      ),
    );
  }
}

class EducationTeacherDashboardScreen extends StatelessWidget {
  const EducationTeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview', 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 16),
            // Stats Row
            Row(
              children: [
                _buildStatCard(context, 'Total Students', '1,234', Icons.people_outline, Colors.blue),
                const SizedBox(width: 12),
                _buildStatCard(context, 'Total Earnings', '\$4,520', Icons.attach_money, Colors.green),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatCard(context, 'Course Rating', '4.8', Icons.star_outline, Colors.orange),
                const SizedBox(width: 12),
                _buildStatCard(context, 'Active Courses', '5', Icons.book_outlined, Colors.purple),
              ],
            ),
            
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Courses', 
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                ),
                TextButton(onPressed: () => Get.snackbar('Info', 'View All Clicked'), child: const Text('View All')),
              ],
            ),
            const SizedBox(height: 8),
            
            _buildCourseItem(
              context, 
              'Flutter Masterclass 2024', 
              '450 Students', 
              '\$450.00', 
              '4.9', 
              AppAssets.thumbnail1
            ),
            _buildCourseItem(
              context, 
              'Advanced Python Principles', 
              '210 Students', 
              '\$1,200.00', 
              '4.7', 
              AppAssets.thumbnail2
            ),
            _buildCourseItem(
              context, 
              'Web Design for Beginners', 
              '89 Students', 
              '\$890.00', 
              '4.5', 
              AppAssets.thumbnail3
            ),
            
            const SizedBox(height: 32),
            const Text(
              'Recent Activity', 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(backgroundColor: Colors.blue, child: Image.asset(AppAssets.personalInfoIcon3d, width: 20, height: 20)),
              title: const Text('New student enrolled in Flutter Masterclass'),
              subtitle: const Text('2 minutes ago'),
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.payment, color: Colors.white, size: 20)),
              title: const Text('Payout processed'),
              subtitle: const Text('2 hours ago'),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const EducationCreateCourseScreen());
        },
        icon: const Icon(Icons.add),
        label: const Text('New Course'),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseItem(BuildContext context, String title, String subtitle, String earnings, String rating, String image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(earnings, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 14, color: Colors.amber),
                  Text(' $rating', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EducationCreateCourseScreen extends StatelessWidget {
  const EducationCreateCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Course Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            const TextField(
              decoration: InputDecoration(
                labelText: 'Course Title',
                border: OutlineInputBorder(),
                hintText: 'e.g., Complete Python Bootcamp',
              ),
            ),
            const SizedBox(height: 16),
            
            const TextField(
              decoration: InputDecoration(
                labelText: 'Subtitle',
                border: OutlineInputBorder(),
                hintText: 'e.g., Learn Python like a Professional!',
              ),
            ),
            const SizedBox(height: 16),

            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Course Description',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: ['Development', 'Business', 'Design', 'Marketing', 'Lifestyle']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {},
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Level',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Beginner', 'Intermediate', 'Expert', 'All Levels']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) {},
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price (\$)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            const Text('Course Media', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.3), style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cloud_upload_outlined, size: 48, color: Colors.blue),
                  const SizedBox(height: 12),
                  const Text('Upload Course Thumbnail', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('1280x720 recommended', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                   Get.back();
                   Get.snackbar('Success', 'Course Created Successfully!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Create Course', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
