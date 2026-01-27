import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'jobs_screen.dart';
import 'gig_detail_screen.dart';

class CategoryServicesScreen extends StatelessWidget {
  final String categoryName;

  const CategoryServicesScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobsController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF07090C) : Colors.white,
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.trendingGigs.length,
        itemBuilder: (context, index) {
          final gig = controller.trendingGigs[index];
          return GestureDetector(
            onTap: () => Get.to(() => GigDetailScreen(gig: gig)),
            child: _CompactGigCard(gig: gig, isDark: isDark),
          );
        },
      ),
    );
  }
}

class _CompactGigCard extends StatelessWidget {
  final GigModel gig;
  final bool isDark;

  const _CompactGigCard({required this.gig, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF11141B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.asset(gig.thumbnailUrl, width: 120, height: 100, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gig.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text('${gig.rating}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Text(gig.price, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
