import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Saved', style: TextStyle(fontWeight: FontWeight.bold)),
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Posts'),
              Tab(text: 'Collections'),
            ],
            indicatorColor: AppPalette.accentBlue,
            labelColor: AppPalette.accentBlue,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            _buildSavedGrid(),
            _buildCollections(),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: 18,
      itemBuilder: (context, index) {
        return Image.asset(
          AppAssets.getRandomPost(),
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildCollections() {
    final collections = [
      {'name': 'Design Inspiration', 'count': 42},
      {'name': 'Travel 2024', 'count': 15},
      {'name': 'Coding Tips', 'count': 89},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final collection = collections[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppAssets.getRandomThumbnail(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(collection['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${collection['count']} items', style: TextStyle(color: Colors.grey[500])),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.snackbar('Collection', 'Opening ${collection['name']}...', snackPosition: SnackPosition.BOTTOM),
          ),
        );
      },
    );
  }
}


class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({super.key});

  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I change my password?',
      'answer': 'Go to Settings > Security > Password. You will need to enter your current password followed by your new password twice to confirm.'
    },
    {
      'question': 'What is OMRE Business?',
      'answer': 'OMRE Business provides advanced tools for creators and companies to manage their brand, run ads, and access deep analytics on their audience.'
    },
    {
      'question': 'How to report a post?',
      'answer': 'Tap the three dots (...) on the top right of any post and select "Report". Choose the reason that best describes the issue.'
    },
    {
      'question': 'Managing privacy settings',
      'answer': 'Navigate to Settings > Privacy. Here you can control who sees your posts, stories, and manage your blocked accounts list.'
    },
    {
      'question': 'Updating profile information',
      'answer': 'Go to your profile and tap on "Edit Profile". You can change your name, username, bio, and profile picture from there.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Get.snackbar('Search', 'Found 3 articles for "$value"', snackPosition: SnackPosition.BOTTOM);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search help articles...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildOption(
              Icons.headset_mic_outlined, 
              'Contact Support', 
              'Get help from our team 24/7',
              () => Get.to(() => const ContactSupportScreen()),
            ),
            _buildOption(
              Icons.info_outline, 
              'About OMRE', 
              'Learn about our community and values',
              () => Get.to(() => const AboutOmreScreen()),
            ),
            _buildOption(
              Icons.description_outlined, 
              'Terms & Privacy', 
              'Read our policies',
              () => Get.to(() => const TermsPrivacyScreen()),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Frequently Asked Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            ...faqs.map((faq) => _buildFaqTile(faq['question']!, faq['answer']!)),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: AppPalette.accentBlue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFaqTile(String question, String answer) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          question,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        iconColor: AppPalette.accentBlue,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Support', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildHelpTile(Icons.report_problem_outlined, 'Report a Problem', 'Something isn\'t working correctly', 
            () => Get.to(() => const ReportProblemScreen())),
          _buildHelpTile(Icons.help_outline, 'Help Requests', 'View status of your support tickets', 
            () => Get.to(() => const HelpRequestsScreen()), assetPath: AppAssets.helpCenterIcon3d),
          _buildHelpTile(Icons.privacy_tip_outlined, 'Privacy Help', 'Report privacy issues or concerns', 
            () => Get.to(() => const PrivacyHelpScreen()), assetPath: AppAssets.securitySafeIcon3d),
          _buildHelpTile(Icons.security_outlined, 'Security Help', 'Protect your account and data', 
            () => Get.to(() => const SecurityHelpScreen()), assetPath: AppAssets.securitySafeIcon3d),
          _buildHelpTile(Icons.verified_user_outlined, 'Account Status', 'Check if your account is in good standing', 
            () => Get.to(() => const AccountStatusScreen()), assetPath: AppAssets.securitySafeIcon3d),
        ],
      ),
    );
  }

  Widget _buildHelpTile(IconData icon, String title, String subtitle, VoidCallback onTap, {String? assetPath}) {
    return ListTile(
      leading: assetPath != null 
          ? Image.asset(assetPath, width: 24, height: 24)
          : Icon(icon, color: AppPalette.accentBlue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}

class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report a Problem')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'What would you like to report?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildReportOption('Spam or Abuse'),
            _buildReportOption('Something Isn\'t Working'),
            _buildReportOption('General Feedback'),
            const Spacer(),
            const Text(
              'Your feedback helps us make OMRE better.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildReportOption(String title) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Get.back();
        Get.snackbar('Thank You', 'We\'ve received your report and will look into it.', 
          snackPosition: SnackPosition.BOTTOM, 
          backgroundColor: Colors.green, 
          colorText: Colors.white);
      },
    );
  }
}

class HelpRequestsScreen extends StatelessWidget {
  const HelpRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Requests'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppPalette.accentBlue),
            onPressed: () => Get.to(() => const CreateHelpRequestScreen()),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTicketTile(
            'Problem with Payment', 
            'Ticket #8492 - Resolved', 
            'Jan 20, 2026', 
            'I was charged twice for my subscription last month. Please refund the duplicate amount.',
            true
          ),
          _buildTicketTile(
            'Unable to upload video', 
            'Ticket #9102 - In Progress', 
            'Today', 
            'The upload gets stuck at 99% every time I try to share my latest vlog.',
            false
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => const CreateHelpRequestScreen()),
        backgroundColor: AppPalette.accentBlue,
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text('New Request', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildTicketTile(String title, String status, String date, String message, bool isResolved) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(status, style: TextStyle(color: isResolved ? Colors.green : Colors.orange, fontWeight: FontWeight.w500, fontSize: 13)),
            const SizedBox(height: 2),
            Text(message, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
          ],
        ),
        onTap: () => Get.to(() => TicketDetailScreen(
          title: title,
          status: status,
          date: date,
          message: message,
          isResolved: isResolved,
        )),
      ),
    );
  }
}

class TicketDetailScreen extends StatelessWidget {
  final String title;
  final String status;
  final String date;
  final String message;
  final bool isResolved;

  const TicketDetailScreen({
    super.key,
    required this.title,
    required this.status,
    required this.date,
    required this.message,
    required this.isResolved,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticket Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: (isResolved ? Colors.green : Colors.orange).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isResolved ? 'RESOLVED' : 'IN PROGRESS',
                style: TextStyle(
                  color: isResolved ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(date, style: const TextStyle(color: Colors.grey)),
            const Divider(height: 40),
            const Text('Your Message:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            Text(message, style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 32),
            const Text('Latest Update from Support:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.grey[900] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isResolved 
                  ? 'Hello! We have processed your refund. You should see it in your account within 3-5 business days. Thank you for your patience.'
                  : 'Hello! Our technical team is currently investigating the upload issues on our CDN servers. We will update you as soon as we have more information.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isResolved ? null : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => Get.snackbar('Chat', 'Connecting to support chat...', snackPosition: SnackPosition.BOTTOM),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPalette.accentBlue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Reply to Support', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class CreateHelpRequestScreen extends StatefulWidget {
  const CreateHelpRequestScreen({super.key});

  @override
  State<CreateHelpRequestScreen> createState() => _CreateHelpRequestScreenState();
}

class _CreateHelpRequestScreenState extends State<CreateHelpRequestScreen> {
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Technical Issue';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Request')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Category', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                filled: true,
                fillColor: Get.isDarkMode ? Colors.grey[900] : Colors.grey[100],
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              items: ['Technical Issue', 'Billing', 'Account Access', 'Report Content', 'Other']
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            const SizedBox(height: 24),
            const Text('Subject', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                hintText: 'e.g., Cannot log in',
                filled: true,
                fillColor: Get.isDarkMode ? Colors.grey[900] : Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Describe your issue in detail...',
                filled: true,
                fillColor: Get.isDarkMode ? Colors.grey[900] : Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (_subjectController.text.isEmpty || _descriptionController.text.isEmpty) {
                  Get.snackbar('Empty Fields', 'Please fill in all details', snackPosition: SnackPosition.BOTTOM);
                  return;
                }
                Get.back();
                Get.snackbar(
                  'Success', 
                  'Your ticket has been submitted successfully!', 
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.accentBlue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Submit Request', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyHelpScreen extends StatelessWidget {
  const PrivacyHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Help')),
      body: ListView(
        children: [
          _buildPrivacyTile(
            'Who can see my profile?', 
            'Learn about public vs private accounts and how to control your visibility.',
            () => Get.to(() => const PrivacyTopicScreen(
              title: 'Who can see my profile?',
              content: 'By default, your profile is public. You can change this in Settings > Privacy > Private Account. When your account is private, only people you approve can see your posts and stories.',
            )),
          ),
          _buildPrivacyTile(
            'How to block someone?', 
            'Step-by-step guide on blocking and managing your blocked list.',
            () => Get.to(() => const PrivacyTopicScreen(
              title: 'How to block someone?',
              content: 'To block someone, go to their profile, tap the three dots in the top right, and select "Block". They will not be notified, and they won\'t be able to find your profile or see your posts.',
            )),
          ),
          _buildPrivacyTile(
            'Download my data', 
            'Request a copy of everything you\'ve shared on OMRE.',
            () {
              Get.defaultDialog(
                title: 'Download Data',
                middleText: 'We will prepare a file with your photos, comments, profile information, and more. It may take up to 48 hours to collect this data and send it to your email.',
                textConfirm: 'Request Download',
                textCancel: 'Cancel',
                confirmTextColor: Colors.white,
                buttonColor: AppPalette.accentBlue,
                onConfirm: () {
                  Get.back();
                  Get.snackbar('Request Sent', 'We\'re preparing your data. You\'ll receive an email shortly.', snackPosition: SnackPosition.BOTTOM);
                },
              );
            },
          ),
          _buildPrivacyTile(
            'Activity Status', 
            'Control who can see when you\'re online.',
            () => Get.to(() => const PrivacyTopicScreen(
              title: 'Activity Status',
              content: 'When active, people you follow and anyone you message can see when you were last active or are currently active on OMRE. You can turn this off in Privacy Settings.',
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyTile(String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}

class PrivacyTopicScreen extends StatelessWidget {
  final String title;
  final String content;

  const PrivacyTopicScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(
              content,
              style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.grey),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.accentBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('I Understand', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SecurityHelpScreen extends StatelessWidget {
  const SecurityHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security Help')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lock_outline, color: AppPalette.accentBlue),
            title: const Text('Change Password'),
            subtitle: const Text('Update your password to keep your account safe'),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () => Get.to(() => const SecurityChangePasswordScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.phonelink_setup, color: AppPalette.accentBlue),
            title: const Text('Two-Factor Authentication'),
            subtitle: const Text('Add an extra layer of security to your account'),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () => Get.to(() => const TwoFactorAuthScreen()),
          ),
          ListTile(
            leading: Image.asset(AppAssets.securitySafeIcon3d, width: 24, height: 24),
            title: const Text('Security Checkup'),
            subtitle: const Text('Review recent security activity and recommendations'),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () => Get.to(() => const SecurityCheckupScreen()),
          ),
        ],
      ),
    );
  }
}

class SecurityChangePasswordScreen extends StatefulWidget {
  const SecurityChangePasswordScreen({super.key});

  @override
  State<SecurityChangePasswordScreen> createState() => _SecurityChangePasswordScreenState();
}

class _SecurityChangePasswordScreenState extends State<SecurityChangePasswordScreen> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Your password must be at least 8 characters and should include a combination of numbers, letters and special characters.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 32),
            _buildPasswordField('Current Password', _currentController),
            const SizedBox(height: 20),
            _buildPasswordField('New Password', _newController),
            const SizedBox(height: 20),
            _buildPasswordField('Confirm New Password', _confirmController),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (_currentController.text.isEmpty || _newController.text.isEmpty || _confirmController.text.isEmpty) {
                  Get.snackbar('Error', 'Please fill in all fields', snackPosition: SnackPosition.BOTTOM);
                  return;
                }
                if (_newController.text != _confirmController.text) {
                  Get.snackbar('Error', 'New passwords do not match', snackPosition: SnackPosition.BOTTOM);
                  return;
                }
                Get.back();
                Get.snackbar('Success', 'Your password has been changed successfully!', 
                  snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.accentBlue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Change Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            Center(
              child: TextButton(
                onPressed: () => Get.snackbar('Reset', 'Reset link sent to your email.', snackPosition: SnackPosition.BOTTOM),
                child: const Text('Forgot Password?', style: TextStyle(color: AppPalette.accentBlue)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Get.isDarkMode ? Colors.grey[900] : Colors.grey[100],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}

class TwoFactorAuthScreen extends StatefulWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Two-Factor Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.phonelink_lock, size: 80, color: AppPalette.accentBlue),
            const SizedBox(height: 24),
            const Text(
              'Add Extra Security',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Two-factor authentication protects your account by requiring an additional code when you log in on a new device.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 40),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: SwitchListTile(
                title: const Text('Authentication App', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Use an app like Google Authenticator'),
                value: _isToggled,
                activeColor: AppPalette.accentBlue,
                onChanged: (val) {
                  setState(() => _isToggled = val);
                  if (val) {
                    Get.snackbar('2FA', 'Redicrecting to setup flow...', snackPosition: SnackPosition.BOTTOM);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecurityCheckupScreen extends StatelessWidget {
  const SecurityCheckupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security Checkup')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Keep your account secure with these recommendations.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 24),
          _buildCheckItem(Icons.verified_user, 'Login Activity', 'Recognized device log in from Mumbai, India', 'Review', assetPath: AppAssets.securitySafeIcon3d),
          _buildCheckItem(Icons.email, 'Recovery Email', 'battula****@gmail.com', 'Update'),
          _buildCheckItem(Icons.phone_android, 'Recovery Phone', '+91 *******89', 'Update'),
          const Divider(height: 32),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Recent Security Events', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Password changed'),
            subtitle: Text('2 days ago'),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(IconData icon, String title, String subtitle, String action, {String? assetPath}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppPalette.accentBlue.withOpacity(0.1),
          child: assetPath != null 
              ? Image.asset(assetPath, width: 20, height: 20)
              : Icon(icon, color: AppPalette.accentBlue, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: TextButton(
          onPressed: () {},
          child: Text(action, style: const TextStyle(color: AppPalette.accentBlue, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class AccountStatusScreen extends StatelessWidget {
  const AccountStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Status')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified, size: 80, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              'Your Account is in Good Standing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'You haven\'t posted anything that goes against our community guidelines.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {},
              child: const Text('Community Guidelines', style: TextStyle(color: AppPalette.accentBlue)),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutOmreScreen extends StatelessWidget {
  const AboutOmreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildAboutTile('Privacy Policy'),
          _buildAboutTile('Terms of Use'),
          _buildAboutTile('Cookie Policy'),
          _buildAboutTile('Community Guidelines'),
          _buildAboutTile('Open Source Libraries'),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('OMRE for iOS/Android', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Version 1.0.42.2026', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTile(String title) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () {
        Get.to(() => PolicyDetailScreen(title: title));
      },
    );
  }
}

class TermsPrivacyScreen extends StatelessWidget {
  const TermsPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Privacy', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Our Commitment to Privacy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'OMRE is built on trust. We believe your data should be yours. This section outlines how we collect, use, and protect your information.',
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            _buildPolicySection('Data Collection', 'We only collect what we need to provide the best experience...'),
            _buildPolicySection('Your Rights', 'You have the right to access, delete, or export your data at any time...'),
            _buildPolicySection('Security', 'We use industry-standard encryption to keep your data safe...'),
            const SizedBox(height: 32),
            const Text(
              'Last Updated: Jan 28, 2026',
              style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String summary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(summary, style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.4)),
          TextButton(
            onPressed: () {},
            child: const Text('Learn More', style: TextStyle(color: AppPalette.accentBlue)),
          ),
        ],
      ),
    );
  }
}

class PolicyDetailScreen extends StatelessWidget {
  final String title;
  const PolicyDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Detailed content for $title...\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          style: const TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
    );
  }
}

class UserPostsScreen extends StatelessWidget {
  const UserPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: GridView.builder(
        padding: const EdgeInsets.all(1),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: 20, // Mock count
        itemBuilder: (context, index) {
          return Image.asset(
            AppAssets.getRandomPost(),
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Followers')),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return _UserListTile(
            name: 'User $index',
            subtitle: 'Started following you',
            avatar: AppAssets.avatar1,
            initiallyFollowing: false, // Prompt to follow back
          );
        },
      ),
    );
  }
}

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Following')),
      body: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) {
           return _UserListTile(
            name: 'Creator $index',
            subtitle: 'Graphic Designer',
            avatar: AppAssets.avatar2,
            initiallyFollowing: true, // Already following
          );
        },
      ),
    );
  }
}

class _UserListTile extends StatefulWidget {
  final String name;
  final String subtitle;
  final String avatar;
  final bool initiallyFollowing;

  const _UserListTile({
    required this.name,
    required this.subtitle,
    required this.avatar,
    required this.initiallyFollowing,
  });

  @override
  State<_UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<_UserListTile> {
  late bool isFollowing;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.initiallyFollowing;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(widget.avatar)),
      title: Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(widget.subtitle),
      trailing: isFollowing
          ? OutlinedButton(
              onPressed: () {
                setState(() => isFollowing = false);
                // Optional: Show snackbar "Unfollowed"
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(90, 30),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Following', style: TextStyle(fontSize: 12)),
            )
          : ElevatedButton(
              onPressed: () {
                setState(() => isFollowing = true);
                // Optional: Show snackbar "Followed"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.accentBlue,
                fixedSize: const Size(90, 30),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Follow', style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
    );
  }
}
