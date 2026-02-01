import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'channel_content_screen.dart';
import 'analytics_screen.dart';
import '../../core/theme/palette.dart';
import 'studio_detail_screens.dart';

class StudioContentDashboardScreen extends StatelessWidget {
  const StudioContentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChannelContentScreen();
  }
}

class StudioEarningsScreen extends StatelessWidget {
  const StudioEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Earnings & Monetization',
          style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Estimated Revenue Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF059669), Color(0xFF10B981)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Estimated Revenue', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('\$1,245.50', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
                        child: const Row(
                          children: [
                            Icon(Icons.trending_up, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text('+18% from last month', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            _buildSectionHeader('Revenue Sources', theme),
            const SizedBox(height: 16),
            _buildSourceItem('Video Ads', '\$842.00', Icons.play_circle_fill, Colors.red, theme, isDark),
            _buildSourceItem('Channel Memberships', '\$215.50', Icons.card_membership, Colors.purple, theme, isDark),
            _buildSourceItem('Super Chat & Stickers', '\$188.00', Icons.bolt, Colors.amber, theme, isDark),

            const SizedBox(height: 32),

            _buildSectionHeader('Payout Schedule', theme),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  _buildPayoutRow('Next Payout', 'Feb 21, 2026', true, theme),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider()),
                  _buildPayoutRow('Minimum Threshold', '\$100.00', false, theme),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: 1.0,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    color: Colors.green,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  const Text('Threshold reached! Payout pending.', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 32),

            _buildSectionHeader('Monetization Status', theme),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(isDark ? 0.1 : 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.blue, size: 48),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Policy Compliant', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                        const SizedBox(height: 4),
                        const Text('Your channel is in good standing and eligible for all revenue features.', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
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

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
    );
  }

  Widget _buildSourceItem(String title, String amount, IconData icon, Color color, ThemeData theme, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPayoutRow(String label, String value, bool isBold, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: theme.textTheme.bodyLarge?.color)),
      ],
    );
  }
}

class StudioAnalyticsScreen extends StatelessWidget {
  const StudioAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnalyticsScreen();
  }
}

// --- Expanded Studio Screens ---

class StudioOverviewScreen extends StatelessWidget {
  const StudioOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Channel Overview'),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatCard('Total Views', '1.2M', '+5.4%', Colors.blue),
            const SizedBox(height: 12),
            _buildStatCard('Watch Time (hrs)', '45.2K', '+2.1%', Colors.purple),
            const SizedBox(height: 12),
            _buildStatCard('Subscribers', '125K', '+120', Colors.red),
            const SizedBox(height: 24),
            Text('Recent Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
            const SizedBox(height: 12),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark ? Colors.grey[900] : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Icon(Icons.show_chart, size: 80, color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String growth, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
            child: Text(growth, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class StudioOmreAIScreen extends StatelessWidget {
  const StudioOmreAIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Omre AI Suite'),
         backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          GestureDetector(onTap: () => Get.to(() => const StudioScriptGenScreen()), child: _buildToolCard('Script Gen', Icons.description, Colors.blue)),
          GestureDetector(onTap: () => Get.to(() => const StudioIdeaLabScreen()), child: _buildToolCard('Idea Lab', Icons.lightbulb, Colors.orange)),
          GestureDetector(onTap: () => Get.snackbar('SEO', 'SEO Optimizer coming soon'), child: _buildToolCard('SEO Optimizer', Icons.search, Colors.green)),
          GestureDetector(onTap: () => Get.to(() => const StudioImageEditorScreen()), child: _buildToolCard('Thumbnail AI', Icons.image, Colors.purple)),
        ],
      ),
    );
  }

  Widget _buildToolCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

class StudioIdeaLabScreen extends StatelessWidget {
  const StudioIdeaLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Idea Lab'), backgroundColor: theme.scaffoldBackgroundColor, elevation: 0, leading: IconButton(icon: Icon(Icons.arrow_back, color: theme.iconTheme.color), onPressed: () => Get.back())),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Top Viral Trends for You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildIdeaCard('Behind the scenes of tech startups', 'High Potential', Colors.orange),
          _buildIdeaCard('Day in the life of a Flutter Dev', 'Trending', Colors.blue),
          _buildIdeaCard('Top 10 AI tools in 2026', 'Evergreen', Colors.green),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.snackbar('Idea Lab', 'Ideas refreshed!'),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Widget _buildIdeaCard(String title, String tag, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () => Get.to(() => IdeaDetailScreen(title: title, tag: tag, color: color)),
        child: ListTile(
          leading: Icon(Icons.lightbulb_outline, color: color),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Chip(label: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 10)), backgroundColor: color),
        ),
      ),
    );
  }
}

class StudioScriptGenScreen extends StatelessWidget {
  const StudioScriptGenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Script Generator')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter Video Topic',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(value: 'funny', child: Text('Funny')),
                DropdownMenuItem(value: 'educational', child: Text('Educational')),
                DropdownMenuItem(value: 'dramatic', child: Text('Dramatic')),
              ],
              onChanged: null,
              decoration: const InputDecoration(labelText: 'Tone', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Get.to(() => const ScriptResultScreen(topic: 'My Video Topic', tone: 'Educational')),
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Generate Script'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StudioVideoEditorScreen extends StatelessWidget {
  const StudioVideoEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Video Editor', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
         leading: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Get.back()),
        actions: [TextButton(onPressed: () => Get.snackbar('Export', 'Video exported successfully!'), child: const Text('EXPORT', style: TextStyle(color: Colors.blue)))],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[900],
              child: const Center(child: Icon(Icons.play_circle, size: 64, color: Colors.white)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[850],
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                children: [
                  _buildTimelineClip(Colors.blue, 100),
                  _buildTimelineClip(Colors.red, 150),
                  _buildTimelineClip(Colors.green, 80),
                  _buildTimelineClip(Colors.orange, 120),
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            color: Colors.black,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.cut, color: Colors.white),
                Icon(Icons.speed, color: Colors.white),
                Icon(Icons.text_fields, color: Colors.white),
                Icon(Icons.music_note, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTimelineClip(Color color, double width) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.8), borderRadius: BorderRadius.circular(4)),
    );
  }
}

class StudioImageEditorScreen extends StatelessWidget {
  const StudioImageEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
       appBar: AppBar(
        title: const Text('Image Editor', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Get.back()),
        actions: [IconButton(onPressed: () => Get.snackbar('Save', 'Image saved to gallery!'), icon: const Icon(Icons.save, color: Colors.blue))],
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.white,
          child: const Center(child: Text('Canvas', style: TextStyle(color: Colors.black))),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.crop), label: 'Crop'),
          BottomNavigationBarItem(icon: Icon(Icons.filter), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: 'Text'),
          BottomNavigationBarItem(icon: Icon(Icons.brush), label: 'Draw'),
        ],
      ),
    );
  }
}

class StudioSchedulerScreen extends StatelessWidget {
  const StudioSchedulerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Content Scheduler'), backgroundColor: theme.scaffoldBackgroundColor, elevation: 0, leading: IconButton(icon: Icon(Icons.arrow_back, color: theme.iconTheme.color), onPressed: () => Get.back())),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildScheduledItem('Flutter 3.19 Review', 'Today, 5:00 PM', Colors.blue),
          _buildScheduledItem('State Management Guide', 'Tomorrow, 10:00 AM', Colors.purple),
          _buildScheduledItem('Q&A Live Stream', 'Fri, 6:00 PM', Colors.red),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Get.to(() => const ScheduledItemEditorScreen()), child: const Icon(Icons.add)),
    );
  }

  Widget _buildScheduledItem(String title, String time, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color, child: const Icon(Icons.schedule, color: Colors.white)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Scheduled for: $time'),
        trailing: IconButton(icon: const Icon(Icons.edit), onPressed: () => Get.to(() => ScheduledItemEditorScreen(initialTitle: title))),
      ),
    );
  }
}

class StudioSafetyCheckScreen extends StatelessWidget {
  const StudioSafetyCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Safety Checks'), backgroundColor: theme.scaffoldBackgroundColor, elevation: 0, leading: IconButton(icon: Icon(Icons.arrow_back, color: theme.iconTheme.color), onPressed: () => Get.back())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCheckItem('Copyright Status', 'No issues found', true),
            _buildCheckItem('Community Guidelines', 'Good Standing', true),
            _buildCheckItem('Ad Suitability', 'Limited (Video #4)', false),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(String title, String status, bool isGood) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(isGood ? Icons.check_circle : Icons.warning, color: isGood ? Colors.green : Colors.amber),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(status),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Get.to(() => SafetyDetailScreen(title: title, status: status, isGood: isGood)),
      ),
    );
  }
}

