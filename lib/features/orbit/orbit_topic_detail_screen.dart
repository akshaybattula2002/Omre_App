import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import 'controllers/orbit_controller.dart';

class OrbitTopicDetailScreen extends StatefulWidget {
  final OrbitTopic topic;

  const OrbitTopicDetailScreen({super.key, required this.topic});

  @override
  State<OrbitTopicDetailScreen> createState() => _OrbitTopicDetailScreenState();
}

class _OrbitTopicDetailScreenState extends State<OrbitTopicDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  late List<Map<String, dynamic>> _posts;
  String _selectedFilter = 'All';

  // Theme constants based on the design request
  final Color bgColor = const Color(0xFF0F0F12);
  final Color cardColor = const Color(0xFF1A1A1D);
  final Color accentBlue = const Color(0xFF2962FF);
  final Color textPrimary = Colors.white;
  final Color textSecondary = const Color(0xFFB0BEC5);
  final Color verifiedColor = const Color(0xFF9C27B0); // Purple for insight/verified
  final Color sourceColor = const Color(0xFF1565C0); // Blue for source
  final Color contributorColor = const Color(0xFFFF6D00); // Orange for question/contributor

  @override
  void initState() {
    super.initState();
    _posts = List.from(Get.find<OrbitController>().getPostsForTopic(widget.topic.title));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handlePost() {
    if (_messageController.text.trim().isEmpty) return;

    final newPost = {
      'type': 'contributor',
      'name': 'You',
      'role': 'Explorer',
      'time': 'Just now',
      'tag': 'COMMENT',
      'content': _messageController.text.trim(),
      'hearts': 0,
       'avatar': AppAssets.avatar1, 
    };

    setState(() {
      _posts.add(newPost);
      _messageController.clear();
    });

    // Scroll to bottom logic could be added here if we had a ScrollController
    Get.snackbar('Posted', 'Your contribution is live!', 
      snackPosition: SnackPosition.BOTTOM, 
      backgroundColor: cardColor, 
      colorText: textPrimary,
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20));
  }

  List<Map<String, dynamic>> get _filteredPosts {
    if (_selectedFilter == 'All') return _posts;
    if (_selectedFilter == 'Insights') return _posts.where((p) => p['type'] == 'verified').toList();
    if (_selectedFilter == 'Sources') return _posts.where((p) => p['type'] == 'source').toList();
    return _posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Signal Filters
          _buildSignalFilters(),
          
          // Discussion List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filteredPosts.length + 1,
              itemBuilder: (context, index) {
                if (index == _filteredPosts.length) {
                  return const SizedBox(height: 80); // Bottom padding
                }
                
                final post = _filteredPosts[index];
                if (post['type'] == 'verified') {
                  return _buildVerifiedPost(
                    name: post['name'],
                    role: post['role'],
                    time: post['time'],
                    tag: post['tag'],
                    content: post['content'],
                    reputation: post['reputation'],
                    agreements: post['agreements'],
                    avatar: post['avatar'],
                  );
                } else if (post['type'] == 'source') {
                  return _buildSourcePost(
                    name: post['name'],
                    role: post['role'],
                    time: post['time'],
                    tag: post['tag'],
                    content: post['content'],
                    link: post['link'],
                    avatar: post['avatar'],
                  );
                } else {
                  return _buildContributorPost(
                    name: post['name'],
                    role: post['role'],
                    time: post['time'],
                    tag: post['tag'],
                    content: post['content'],
                    hearts: post['hearts'],
                    avatar: post['avatar'],
                    image: post['image'],
                  );
                }
              },
            ),
          ),
          
          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.topic.title,
                style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 6),
              if (widget.topic.isVerified)
                const Icon(Icons.verified_user_outlined, color: Colors.blue, size: 16),
            ],
          ),
          const SizedBox(height: 2),
            Row(
            children: [
                Icon(Icons.people_alt_rounded, size: 12, color: textSecondary),
                const SizedBox(width: 4),
                Text(
                '${widget.topic.liveUsers} live',
                style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                const SizedBox(width: 8),
                Text(
                '•',
                style: TextStyle(color: textSecondary, fontSize: 12),
                ),
                const SizedBox(width: 8),
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                    widget.topic.category,
                    style: TextStyle(color: textSecondary, fontSize: 10, fontWeight: FontWeight.bold),
                ),
                ),
            ],
            ),
        ],
      ),
      actions: [
        IconButton(
          icon: Container(
             padding: const EdgeInsets.all(2),
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               border: Border.all(color: Colors.white, width: 1.5),
             ),
            child: const Icon(Icons.more_horiz, color: Colors.white, size: 20)
          ),
          onPressed: () {
            Get.bottomSheet(
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.notifications_off_outlined, color: Colors.white),
                        title: const Text('Mute Topic', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Get.back();
                          Get.snackbar('Muted', 'You will no longer receive notifications for this topic.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: cardColor,
                              colorText: textPrimary,
                              margin: const EdgeInsets.all(20));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.share_outlined, color: Colors.white),
                         title: const Text('Share Topic', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Get.back();
                          _showShareOptions();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.report_outlined, color: Colors.red),
                        title: const Text('Report', style: TextStyle(color: Colors.red)),
                         onTap: () {
                           Get.back();
                           _showReportDialog();
                         },
                      ),
                    ],
                  ),
                )
            );
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  void _showShareOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share to', style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildShareIcon(Icons.copy, 'Copy Link', Colors.grey),
                _buildShareIcon(Icons.chat_bubble, 'WhatsApp', Colors.green),
                _buildShareIcon(Icons.send, 'Telegram', Colors.blue),
                _buildShareIcon(Icons.alternate_email, 'Twitter', Colors.lightBlue),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildShareIcon(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        Get.back();
        Get.snackbar('Shared', 'Shared to $label',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: cardColor,
            colorText: textPrimary,
            margin: const EdgeInsets.all(20));
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  void _showReportDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: cardColor,
        title: Text('Report Topic', style: TextStyle(color: textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildReportOption('Spam or misleading'),
            _buildReportOption('Harassment or hate speech'),
            _buildReportOption('Inappropriate content'),
            _buildReportOption('Other'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildReportOption(String reason) {
    return ListTile(
      title: Text(reason, style: TextStyle(color: textSecondary)),
      onTap: () {
        Get.back();
        Get.snackbar('Report Received', 'Thanks for letting us know.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: cardColor,
            colorText: textPrimary,
            margin: const EdgeInsets.all(20));
      },
    );
  }

  Widget _buildSignalFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Text('SIGNAL FILTER:', style: TextStyle(color: textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(width: 12),
          _buildFilterChip('All', Icons.local_fire_department_rounded, _selectedFilter == 'All'),
          const SizedBox(width: 8),
          _buildFilterChip('Insights', Icons.psychology_outlined, _selectedFilter == 'Insights'),
          const SizedBox(width: 8),
          _buildFilterChip('Sources', Icons.article_outlined, _selectedFilter == 'Sources'),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.defaultDialog(
              title: 'Signal Filters',
              middleText: 'Use filters to focus on verified expert insights or cited sources.',
              backgroundColor: cardColor,
              titleStyle: const TextStyle(color: Colors.white),
              middleTextStyle: const TextStyle(color: Colors.white70),
              confirm: TextButton(onPressed: () => Get.back(), child: const Text('Got it')),
            ),
            child: Icon(Icons.help_outline, color: textSecondary, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2235) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? accentBlue.withOpacity(0.5) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isSelected ? accentBlue : textSecondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? accentBlue : textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifiedPost({
    required String name,
    required String role,
    required String time,
    required String tag,
    required String content,
    required int reputation,
    required int agreements,
     required String avatar,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text(name, style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 15), overflow: TextOverflow.ellipsis)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(role, style: TextStyle(color: textSecondary, fontSize: 10)),
                    ),
                    const SizedBox(width: 8),
                    Text('• $time', style: TextStyle(color: textSecondary, fontSize: 12)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: verifiedColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: verifiedColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.psychology, size: 12, color: verifiedColor),
                          const SizedBox(width: 4),
                          Text(tag, style: TextStyle(color: verifiedColor, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(content, style: TextStyle(color: textPrimary.withOpacity(0.9), fontSize: 14, height: 1.5)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.all_inclusive, size: 14, color: textSecondary),
                    const SizedBox(width: 6),
                    Text('$reputation', style: TextStyle(color: textSecondary, fontSize: 12)),
                    const SizedBox(width: 16),
                    Icon(Icons.sentiment_satisfied_alt, size: 14, color: textSecondary),
                    const SizedBox(width: 6),
                    Text('$agreements', style: TextStyle(color: textSecondary, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContributorPost({
    required String name,
    required String role,
    required String time,
    required String tag,
    required String content,
    required int hearts,
     required String avatar,
     String? image,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text(name, style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 15), overflow: TextOverflow.ellipsis)),
                    const SizedBox(width: 8),
                     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(role, style: TextStyle(color: textSecondary, fontSize: 10)),
                    ),
                    const SizedBox(width: 8),
                    Text('• $time', style: TextStyle(color: textSecondary, fontSize: 12)),
                    const Spacer(),
                     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: contributorColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: contributorColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.help_outline, size: 12, color: contributorColor),
                          const SizedBox(width: 4),
                          Text(tag, style: TextStyle(color: contributorColor, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(content, style: TextStyle(color: textPrimary.withOpacity(0.9), fontSize: 14, height: 1.5)),
                if (image != null) ...[
                   const SizedBox(height: 12),
                   ClipRRect(
                     borderRadius: BorderRadius.circular(8),
                     child: Image.asset(image, width: double.infinity, height: 150, fit: BoxFit.cover),
                   ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.favorite_border, size: 14, color: textSecondary),
                    const SizedBox(width: 6),
                    Text('$hearts', style: TextStyle(color: textSecondary, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourcePost({
    required String name,
    required String role,
    required String time,
    required String tag,
    required String content,
    required String link,
     required String avatar,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text(name, style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 15), overflow: TextOverflow.ellipsis)),
                    const SizedBox(width: 8),
                     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(role, style: TextStyle(color: textSecondary, fontSize: 10)),
                    ),
                    const SizedBox(width: 8),
                    Text('• $time', style: TextStyle(color: textSecondary, fontSize: 12)),
                    const Spacer(),
                     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: sourceColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: sourceColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                         const Icon(Icons.description_outlined, size: 12, color: Color(0xFF1565C0)), // Hardcoded for const
                          const SizedBox(width: 4),
                          Text(tag, style: TextStyle(color: sourceColor, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(content, style: TextStyle(color: textPrimary.withOpacity(0.9), fontSize: 14, height: 1.5)),
                const SizedBox(height: 4),
                Text('Link: $link', style: TextStyle(color: textSecondary, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _selectedLanguage = 'English';
  
  String get _hintText {
    switch (_selectedLanguage) {
      case 'Hindi': return 'बातचीत में योगदान करें...';
      case 'Spanish': return 'Contribuir a la conversación...';
      case 'French': return 'Contribuer à la conversation...';
      case 'German': return 'Tragen Sie zum Gespräch bei...';
      case 'Chinese': return '为对话做出贡献...';
      case 'Japanese': return '会話に貢献する...';
      default: return 'Contribute to the conversation...';
    }
  }

  void _handleLanguage() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Language', style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['English', 'Hindi', 'Spanish', 'French', 'German', 'Chinese', 'Japanese'].map((lang) {
                final isSelected = _selectedLanguage == lang;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedLanguage = lang);
                    Get.back();
                    Get.snackbar('Language Selected', 'Switched to $lang', 
                        snackPosition: SnackPosition.BOTTOM, 
                        backgroundColor: cardColor, 
                        colorText: textPrimary,
                        margin: const EdgeInsets.all(20));
                  },
                  child: Chip(
                    label: Text(lang),
                    backgroundColor: isSelected ? accentBlue : bgColor,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : textSecondary),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _handleAttachment() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text('Attach', style: TextStyle(color: textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
             const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAttachmentOption(Icons.image, 'Gallery', () {
                    Get.back();
                    _openMockGallery();
                }),
                _buildAttachmentOption(Icons.camera_alt, 'Camera', () {
                    Get.back();
                    _openMockCamera();
                }),
                _buildAttachmentOption(Icons.insert_drive_file, 'File', () {
                    Get.back();
                     _openMockFilePicker();
                }),
                _buildAttachmentOption(Icons.link, 'Link', () {
                    Get.back();
                    // Simulating link paste
                    setState(() {
                       _messageController.text = "https://omre.app/share/ref=123";
                    });
                }),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _openMockGallery() {
    Get.bottomSheet(
      Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Select Image', style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
             const SizedBox(height: 16),
             Expanded(
               child: GridView.count(
                 crossAxisCount: 3,
                 crossAxisSpacing: 8,
                 mainAxisSpacing: 8,
                 children: [
                   _buildMockImageTile(AppAssets.post1),
                   _buildMockImageTile(AppAssets.post2),
                   _buildMockImageTile(AppAssets.post3),
                   _buildMockImageTile(AppAssets.post1),
                   _buildMockImageTile(AppAssets.post2),
                   _buildMockImageTile(AppAssets.post3),
                 ],
               ),
             )
          ],
        ),
      ),
    );
  }

  Widget _buildMockImageTile(String assetPath) {
    return GestureDetector(
      onTap: () {
        Get.back();
        _addAttachmentPost(assetPath, 'Shared an image from Gallery');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(assetPath, fit: BoxFit.cover),
      ),
    );
  }

  void _openMockCamera() {
    Get.dialog(
      AlertDialog(
        backgroundColor: cardColor,
        title: Text('Camera', style: TextStyle(color: textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.camera_alt, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 16),
             GestureDetector(
                onTap: () {
                  Get.back();
                  _addAttachmentPost(AppAssets.post2, 'Shared a captured photo');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: accentBlue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text('Capture', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _openMockFilePicker() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select File', style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text('Project_Report.pdf', style: TextStyle(color: textPrimary)),
              subtitle: Text('2.5 MB', style: TextStyle(color: textSecondary)),
              onTap: () {
                Get.back();
                _addAttachmentPost(AppAssets.post3, 'Shared a document: Project_Report.pdf');
              },
            ),
             ListTile(
              leading: const Icon(Icons.description, color: Colors.blue),
              title: Text('Meeting_Notes.docx', style: TextStyle(color: textPrimary)),
              subtitle: Text('1.2 MB', style: TextStyle(color: textSecondary)),
              onTap: () {
                Get.back();
                _addAttachmentPost(AppAssets.post1, 'Shared a document: Meeting_Notes.docx');
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _addAttachmentPost(String imagePath, String caption) {
      final newPost = {
      'type': 'contributor',
      'name': 'You',
      'role': 'Explorer',
      'time': 'Just now',
      'tag': 'ATTACHMENT',
      'content': caption,
      'hearts': 0,
      'avatar': AppAssets.avatar1,
      'image': imagePath, 
    };

    setState(() {
      _posts.add(newPost);
    });
  }

  Widget _buildAttachmentOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: bgColor,
            child: Icon(icon, color: accentBlue),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  void _handleVoice() {
    Get.dialog(
      AlertDialog(
        backgroundColor: cardColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.mic, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text('Listening...', style: TextStyle(color: textPrimary)),
          ],
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
      setState(() {
         _messageController.text += " (Voice transcription)";
      });
    });
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F12),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E24),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(color: textPrimary),
                    decoration: InputDecoration(
                      hintText: _hintText,
                      hintStyle: TextStyle(color: textSecondary.withOpacity(0.5)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
           const SizedBox(height: 12),
          Row(
            children: [
              IconButton(onPressed: _handleLanguage, icon: Icon(Icons.language, color: textSecondary, size: 20)),
              const SizedBox(width: 8),
              IconButton(onPressed: _handleAttachment, icon: Icon(Icons.library_books_outlined, color: textSecondary, size: 20)),
               const SizedBox(width: 8),
              IconButton(onPressed: _handleVoice, icon: Icon(Icons.mic_none, color: textSecondary, size: 20)),
              const Spacer(),
              GestureDetector(
                onTap: _handlePost,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: accentBlue,
                    borderRadius: BorderRadius.circular(20),
                     boxShadow: [
                       BoxShadow(color: accentBlue.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2)),
                     ]
                  ),
                  child: Row(
                    children: [
                      const Text('Post', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      const Icon(Icons.send_rounded, size: 14, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 12, color: textSecondary),
              const SizedBox(width: 4),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: textSecondary, fontSize: 10),
                  children: [
                    const TextSpan(text: 'Your reputation in '),
                    TextSpan(text: widget.topic.category, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    const TextSpan(text: ' influences visibility.'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
