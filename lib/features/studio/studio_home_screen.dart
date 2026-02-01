import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/studio_controller.dart';
import '../../core/constants/app_assets.dart';

class StudioHomeScreen extends StatelessWidget {
  const StudioHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudioController());
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Channel Dashboard',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                       Text(
                        'Welcome back, Alex.',
                        style: TextStyle(color: theme.hintColor),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/notification_icon_3d.png', width: 24, height: 24),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: controller.openScriptEditor,
                    icon: Icon(Icons.edit_note, size: 20, color: theme.textTheme.bodyLarge?.color),
                    label: Text('Write Script', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: controller.openUploadVideo,
                    icon: const Icon(Icons.upload, size: 20, color: Colors.white),
                    label: const Text('Upload Video', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6), // Blue
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Stats Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final double itemWidth = (constraints.maxWidth - 16) / 2;
                return Obx(() => Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    GestureDetector(
                      onTap: controller.openAnalytics,
                      child: SizedBox(
                        width: itemWidth,
                        child: _buildStatCard(
                          title: 'Total Subscribers',
                          value: controller.subscribers.value,
                          change: '+1,240',
                          isPositive: true,
                          icon: Icons.people_outline,
                          color: Colors.blue,
                          theme: theme,
                          isDark: isDark,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.openAnalytics,
                      child: SizedBox(
                        width: itemWidth,
                        child: _buildStatCard(
                          title: 'Total Views',
                          value: controller.totalViews.value,
                          change: '+12%',
                          isPositive: true,
                          icon: Icons.visibility_outlined,
                          color: Colors.green,
                          theme: theme,
                          isDark: isDark,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.openAnalytics,
                      child: SizedBox(
                        width: itemWidth,
                        child: _buildStatCard(
                          title: 'Watch Time (Hrs)',
                          value: controller.watchTime.value,
                          change: '+8.5%',
                          isPositive: true,
                          icon: Icons.access_time,
                          color: Colors.purple,
                          theme: theme,
                          isDark: isDark,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.openAnalytics,
                      child: SizedBox(
                        width: itemWidth,
                        child: _buildStatCard(
                          title: 'Estimated Rev',
                          value: controller.revenue.value,
                          change: '+15%',
                          isPositive: true,
                          icon: Icons.attach_money,
                          color: Colors.orange,
                          theme: theme,
                          isDark: isDark,
                        ),
                      ),
                    ),
                  ],
                ));
              },
            ),

            const SizedBox(height: 32),
            
            Text(
              'Latest Video Performance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
            ),
            const SizedBox(height: 8),
            Text(
              'How your most recent upload compares to average.',
              style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey),
            ),
            
            const SizedBox(height: 16),
            
            // Video Performance Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(isDark ? 0.2 : 0.02),
                     blurRadius: 10,
                     offset: const Offset(0, 4),
                   ),
                 ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      AppAssets.thumbnail3,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(() => Text(
                    controller.recentVideoTitle.value,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
                  )),
                  const Text(
                    'Published 2 days ago',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildVideoMetric('Views', controller.recentVideoViews.value, theme),
                      _buildVideoMetric('CTR', controller.recentVideoCTR.value, theme),
                      _buildVideoMetric('Avg Duration', controller.recentVideoAvgDuration.value, theme),
                    ],
                  )),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: controller.openAnalytics,
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text('Go to Video Analytics'),
                      ),
                      TextButton(
                        onPressed: controller.openComments,
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text('See Comments'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: controller.openChannelContent,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Manage All Content'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatCard({
    required String title,
    required String value,
    required String change,
    required bool isPositive,
    required IconData icon,
    required Color color,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 4,
            child: Container(color: color),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600], height: 1.2),
                        maxLines: 2,
                      ),
                    ),
                    Icon(icon, size: 16, color: isDark ? Colors.grey[500] : Colors.grey[400]),
                 ],
               ),
               const SizedBox(height: 12),
               Text(
                 value,
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
               ),
               const SizedBox(height: 8),
               Text(
                 '$change last 28 days',
                 style: TextStyle(
                   fontSize: 11,
                   color: isPositive ? Colors.green : Colors.red,
                   fontWeight: FontWeight.w500,
                 ),
               ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildVideoMetric(String label, String value, ThemeData theme) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
      ],
    );
  }
}
