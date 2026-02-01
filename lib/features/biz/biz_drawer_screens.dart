import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'tool_detail_screen.dart';
import 'website_builder_detail_screens.dart';

// --- INBOX TOOLS ---
class BizInboxToolsScreen extends StatelessWidget {
  const BizInboxToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inbox Tools')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildToolItem(
            context,
            Icons.quickreply_outlined,
            'Quick Replies',
            'Create preset responses for common questions',
            Colors.blue,
          ),
          _buildToolItem(
            context,
            Icons.schedule_send_outlined,
            'Away Message',
            'Send automated replies when you are unavailable',
            Colors.orange,
          ),
          _buildToolItem(
            context,
            Icons.mark_chat_unread_outlined,
            'Instant Reply',
            'Send an automated greeting to new messages',
            Colors.green,
          ),
          _buildToolItem(
            context,
            Icons.label_outlined,
            'Labels',
            'Organize your conversations with custom labels',
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildToolItem(BuildContext context, IconData icon, String title, String subtitle, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          Get.to(() => ToolDetailScreen(
            title: title,
            description: subtitle,
            icon: icon,
            color: color,
          ));
        },
      ),
    );
  }
}

// --- MONETIZATION ---
// --- MONETIZATION ---
class BizMonetizationScreen extends StatefulWidget {
  const BizMonetizationScreen({super.key});

  @override
  State<BizMonetizationScreen> createState() => _BizMonetizationScreenState();
}

class _BizMonetizationScreenState extends State<BizMonetizationScreen> {
  final Map<String, bool> _toolStates = {
    'Stars': true,
    'Gifts': true,
    'Ad Revenue': false,
    'Merch Shelf': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monetization')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatusCard(context),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Tools', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            _buildMonetizationItem(Icons.star, 'Stars', 'Earn money from your viewers', 'Stars'),
            _buildMonetizationItem(Icons.card_giftcard, 'Gifts', 'Receive virtual gifts on reels', 'Gifts'),
            _buildMonetizationItem(Icons.video_library, 'Ad Revenue', 'Earn from ads on your videos', 'Ad Revenue'),
            _buildMonetizationItem(Icons.storefront, 'Merch Shelf', 'Sell your products directly', 'Merch Shelf'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.amber, Colors.orangeAccent]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.monetization_on, size: 48, color: Colors.white),
          SizedBox(height: 12),
          Text('\$1,240.50', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          Text('Estimated Earnings (This Month)', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildMonetizationItem(IconData icon, String title, String subtitle, String key) {
    bool isEnabled = _toolStates[key] ?? false;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Switch(
          value: isEnabled,
          onChanged: (val) {
            setState(() {
              _toolStates[key] = val;
            });
            Get.snackbar(title, val ? 'Enabled' : 'Disabled', snackPosition: SnackPosition.BOTTOM);
          },
          activeColor: Colors.orange,
        ),
      ),
    );
  }
}

// --- WEBSITE BUILDER ---
class BizWebsiteBuilderScreen extends StatelessWidget {
  const BizWebsiteBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Website Builder')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.web, size: 64, color: Colors.blue),
                  const SizedBox(height: 16),
                  const Text('Preview your site', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => const WebsitePreviewScreen());
                      }, 
                      child: const Text('Open Preview')
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(context, 'Site Settings', () => Get.to(() => const WebsiteSettingsScreen())),
            _buildSection(context, 'Theme & Colors', () => Get.to(() => const WebsiteThemeScreen())),
            _buildSection(context, 'Pages', () => Get.to(() => const WebsitePagesScreen())),
            _buildSection(context, 'Domain', () => Get.to(() => const WebsiteDomainScreen())),
             const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                   Get.showSnackbar(const GetSnackBar(
                      message: 'Publishing your site...', 
                      duration: Duration(seconds: 2),
                      showProgressIndicator: true,
                    ));
                   Future.delayed(const Duration(seconds: 2), () {
                      Get.snackbar('Success', 'Your site is now live!');
                   });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: const Text('Publish Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
