import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';

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
        children: const [
          EducationCourseCard(
            title: 'Complete Flutter Bootcamp', 
            author: 'Dr. Angela Yu', 
            progress: '0.45', 
            progressLabel: '45%', 
            image: AppAssets.thumbnail1,
          ),
          EducationCourseCard(
            title: 'Python for Data Science', 
            author: 'Jose Portilla', 
            progress: '0.80', 
            progressLabel: '80%', 
            image: AppAssets.thumbnail2,
          ),
          EducationCourseCard(
            title: 'UI/UX Design Masterclass', 
            author: 'Gary Simon', 
            progress: '0.10', 
            progressLabel: '10%', 
            image: AppAssets.thumbnail3,
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
                onPressed: () {},
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
        trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () {}),
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
                onPressed: () {},
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
