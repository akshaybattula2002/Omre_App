import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'jobs_screen.dart';
import '../../core/theme/palette.dart';

class GigDetailScreen extends StatelessWidget {
  final GigModel gig;

  const GigDetailScreen({super.key, required this.gig});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF07090C) : Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(gig.thumbnailUrl, fit: BoxFit.cover),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.black26,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 20, backgroundImage: AssetImage(gig.sellerAvatarUrl)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(gig.sellerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(gig.sellerLevel, style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text('${gig.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(' (${gig.reviewsCount})', style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(gig.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text('About this gig', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    'I will provide high-quality professional services tailored to your specific needs. With years of experience and a passion for excellence, I guarantee satisfaction and timely delivery.',
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  const Text('Packages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildPackageCard('Basic', '\$25', '3 Days Delivery', isDark),
                  _buildPackageCard('Standard', gig.price, '5 Days Delivery', isDark),
                  _buildPackageCard('Premium', '\$250', '1 Week Delivery', isDark),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF11141B) : Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text('Starting at', style: TextStyle(color: Colors.grey, fontSize: 12)),
                   Text(gig.price, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppPalette.accentBlue)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.snackbar('Order Placed', 'Proceeding to payment...', backgroundColor: Colors.green, colorText: Colors.white);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.accentBlue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(String title, String price, String time, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}
