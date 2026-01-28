import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/link_controller.dart';
import 'job_details_screen.dart';

class EngineeringJobsScreen extends StatelessWidget {
  const EngineeringJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LinkController>()) {
      Get.put(LinkController());
    }
    final controller = Get.find<LinkController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Filter engineering related jobs
    final engineeringJobs = controller.allJobs.where((job) => 
      job.title.toLowerCase().contains('engineer') || 
      job.title.toLowerCase().contains('dev') ||
      job.title.toLowerCase().contains('cto')
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Engineering Jobs'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: engineeringJobs.isEmpty 
        ? const Center(child: Text("No engineering jobs available at the moment."))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: engineeringJobs.length,
            itemBuilder: (context, index) {
              final job = engineeringJobs[index];
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
                color: job.themeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.engineering, color: job.themeColor),
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
                          color: job.themeColor,
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
