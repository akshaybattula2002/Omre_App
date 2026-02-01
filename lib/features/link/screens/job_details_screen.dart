import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/link_controller.dart';
import '../../../core/theme/palette.dart';
import '../../../core/constants/app_assets.dart';

class JobDetailsScreen extends StatelessWidget {
  final JobModel job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.find<LinkController>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Job Details'),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() {
            final isSaved = controller.savedJobIds.contains(job.id);
            return IconButton(
              icon: Image.asset(
                AppAssets.savedIcon3d,
                width: 24,
                height: 24,
                color: isSaved ? AppPalette.accentBlue : theme.iconTheme.color,
              ),
              onPressed: () => controller.toggleSaveJob(job.id),
            );
          }),
          IconButton(
            icon: Icon(Icons.share_outlined, color: theme.iconTheme.color),
            onPressed: () => Get.snackbar(
              'Share',
              'Sharing ${job.title} job link...',
              snackPosition: SnackPosition.BOTTOM,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header Section
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: job.themeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(Icons.business, size: 40, color: job.themeColor),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          job.title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                         Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Text(
                               job.company,
                               style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                             ),
                             const SizedBox(width: 8),
                             Icon(Icons.circle, size: 4, color: Colors.grey[500]),
                             const SizedBox(width: 8),
                             Text(
                               job.location,
                               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                             ),
                           ],
                         ),
                        const SizedBox(height: 8),
                        Text(
                          'Posted ${job.postedAgo} • ${job.type}',
                          style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 24),

                  // 2. Job Statistics / Highlights
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildHighlight(Icons.people_outline, 'Applicants', '142', isDark),
                      _buildHighlight(Icons.work_outline, 'Type', job.type, isDark),
                      _buildHighlight(Icons.attach_money, 'Salary', job.salary, isDark),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),

                  // 3. About the job
                  const Text(
                    'About the job',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    job.description,
                    style: TextStyle(fontSize: 15, height: 1.6, color: theme.textTheme.bodyMedium?.color?.withOpacity(0.9)),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 4. Skills / Requirements
                  const Text(
                    'Skills & Requirements',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      'Flutter', 'Dart', 'State Management', 'REST APIs', 
                      'Git', 'Agile', 'UI/UX Basics', 'Clean Architecture'
                    ].map((skill) => Chip(
                      label: Text(skill, style: TextStyle(fontSize: 12, color: isDark ? Colors.white : Colors.black87)),
                      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[100],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      side: BorderSide.none,
                    )).toList(),
                  ),

                  const SizedBox(height: 24),
                  
                  if (job.requirements.isNotEmpty) ...[
                    const Text(
                      'Requirements', // Or specific requirements if you prefer, but the list looks like reqs
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ...job.requirements.map((req) => _buildRequirementItem(req)),
                    const SizedBox(height: 32),
                  ],
                  
                  // 5. About the company
                   Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('About the company', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                                width: 48, 
                                height: 48,
                                decoration: BoxDecoration(
                                  color: job.themeColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.business, color: job.themeColor),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(job.company, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                  const SizedBox(height: 4),
                                  Text('Internet • 50-200 employees', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              child: const Text('Follow'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                         Text(
                          job.companyDescription,
                          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Space for fixed bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[200]!)),
        ),
        child: ElevatedButton(
          onPressed: () {
             Get.snackbar(
              'Application Sent',
              'Your application for ${job.title} at ${job.company} has been submitted!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPalette.accentBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: const Text('Easy Apply', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 6, color: Color(0xFF4F46E5)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  Widget _buildHighlight(IconData icon, String label, String value, bool isDark) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[600], size: 24),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}
