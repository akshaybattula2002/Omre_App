import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/link_controller.dart';
import 'job_details_screen.dart';

class CategoryJobsScreen extends StatelessWidget {
  final String category;
  final IconData icon;
  final Color themeColor;

  const CategoryJobsScreen({
    super.key,
    required this.category,
    required this.icon,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LinkController>()) {
      Get.put(LinkController());
    }
    final controller = Get.find<LinkController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Filter jobs based on category name or title related keywords
    // Filter jobs based on category name
    final categoryJobs = controller.allJobs.where((job) {
      if (job.category.toLowerCase() == category.toLowerCase()) {
        return true;
      }
      
      // Fallback to title matching if category field is generic or missing (robustness)
      final title = job.title.toLowerCase();
      final cat = category.toLowerCase();
      
      if (cat == 'eng' || cat == 'engineering') {
        return title.contains('engineer') || title.contains('dev') || title.contains('developer');
      }
      
      return title.contains(cat);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Jobs'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: categoryJobs.isEmpty 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 64, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  "No $category jobs available yet.",
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  "Check back later for new opportunities.",
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categoryJobs.length,
            itemBuilder: (context, index) {
              final job = categoryJobs[index];
              return _buildJobTile(job, isDark);
            },
          ),
    );
  }

  Widget _buildJobTile(JobModel job, bool isDark) {
    return GestureDetector(
      onTap: () => Get.to(() => JobDetailsScreen(job: job)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: themeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: themeColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${job.company} • ${job.location}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildMiniTag(job.type, isDark),
                      const SizedBox(width: 8),
                      Text(
                        job.salary,
                        style: TextStyle(
                          color: themeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniTag(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, color: isDark ? Colors.grey[400] : Colors.grey[700]),
      ),
    );
  }
}
