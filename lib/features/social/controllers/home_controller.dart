import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:omre/core/constants/app_assets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:omre/core/theme/palette.dart';
import '../models/social_models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeController extends GetxController {
  final stories = <UserStoryGroup>[].obs;
  final posts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  void _loadMockData() {
    // Mock user story groups
    stories.assignAll([
      UserStoryGroup(
        username: 'Your Story',
        avatarUrl: AppAssets.avatar1,
        stories: [],
      ),
      UserStoryGroup(
        username: 'marcus_dev',
        avatarUrl: AppAssets.avatar2,
        stories: [
          StoryModel(
            id: 's1',
            username: 'marcus_dev',
            avatarUrl: AppAssets.avatar2,
            imageUrl: AppAssets.post1,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          ),
        ],
      ),
      UserStoryGroup(
        username: 'elena_design',
        avatarUrl: AppAssets.avatar3,
        stories: [
          StoryModel(
            id: 's2',
            username: 'elena_design',
            avatarUrl: AppAssets.avatar3,
            imageUrl: AppAssets.post2,
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          ),
          StoryModel(
            id: 's3',
            username: 'elena_design',
            avatarUrl: AppAssets.avatar3,
            imageUrl: AppAssets.post3,
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          ),
        ],
      ),
       UserStoryGroup(
        username: 'dummy_user',
        avatarUrl: AppAssets.avatar4,
        stories: [
          StoryModel(
            id: 's4',
            username: 'dummy_user',
            avatarUrl: AppAssets.avatar4,
            imageUrl: AppAssets.dummyStory,
            timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          ),
        ],
      ),
      UserStoryGroup(
        username: 'travel_lover',
        avatarUrl: AppAssets.avatar5,
        stories: [
          StoryModel(
            id: 's5',
            username: 'travel_lover',
            avatarUrl: AppAssets.avatar5,
            imageUrl: AppAssets.post4,
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          ),
        ],
      ),
       UserStoryGroup(
        username: 'tech_guru',
        avatarUrl: AppAssets.avatar1,
        stories: [
           StoryModel(
            id: 's6',
            username: 'tech_guru',
            avatarUrl: AppAssets.avatar1,
            imageUrl: AppAssets.post5,
             timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          ),
        ],
      ),
    ]);

    // Mock posts
    posts.assignAll([
      PostModel(
        id: 'p1',
        username: 'alex_r',
        avatarUrl: AppAssets.avatar1,
        imageUrl: AppAssets.post1,
        caption: 'Building the future of mobile apps with OMRE! 🚀 #flutter #getx',
        likes: 124,
        timestamp: '1h ago',
      ),
      PostModel(
        id: 'p2',
        username: 'sarah_j',
        avatarUrl: AppAssets.avatar2,
        imageUrl: AppAssets.post2,
        caption: 'Beautiful morning vibes from the mountains ⛰️✨',
        likes: 89,
        timestamp: '3h ago',
      ),
      PostModel(
        id: 'p3',
        username: 'tech_insider',
        avatarUrl: AppAssets.avatar3,
        imageUrl: AppAssets.post3,
        caption: 'Sustainable energy solutions are taking over the market. What do you think?',
        likes: 245,
        timestamp: '5h ago',
      ),
      PostModel(
        id: 'p4',
        username: 'marcus_dev',
        avatarUrl: AppAssets.avatar4,
        imageUrl: AppAssets.post4,
        caption: 'Just landed in Tokyo! The tech scene here is insane 🇯🇵💻 #travel #tech',
        likes: 15,
        timestamp: '10m ago',
      ),
      PostModel(
        id: 'p5',
        username: 'elena_design',
        avatarUrl: AppAssets.avatar5,
        imageUrl: AppAssets.post5,
        caption: 'New UI kit for OMRE is almost ready. Sleek, dark and premium! 🔥 #uidesign',
        likes: 312,
        timestamp: '30m ago',
      ),
      PostModel(
        id: 'p6',
        username: 'flutter_fan',
        avatarUrl: AppAssets.getRandomAvatar(),
        imageUrl: AppAssets.getRandomPost(),
        caption: 'Can we appreciate how smooth Flutter animations are? OMRE is a prime example!',
        likes: 56,
        timestamp: '2h ago',
      ),
      PostModel(
        id: 'p7',
        username: 'design_pro',
        avatarUrl: AppAssets.avatar4,
        imageUrl: AppAssets.post3,
        caption: 'Minimalist setups are the best! 🖥️✨ #setup #workspace',
        likes: 189,
        timestamp: '4h ago',
      ),
      PostModel(
        id: 'p8',
        username: 'nature_explorer',
        avatarUrl: AppAssets.avatar5,
        imageUrl: AppAssets.post2,
        caption: 'Lost in the woods... 🌲🍃',
        likes: 76,
        timestamp: '6h ago',
      ),
    ]);
  }

  final postTextController = TextEditingController();
  final selectedImage = Rxn<File>();
  final selectedVideo = Rxn<File>();
  final selectedFeeling = RxnString();
  final isPosting = false.obs;
  final currentFeedIndex = 1.obs; // 0=Following, 1=For You, 2=Trending, 3=Latest, 4=Near You

  List<PostModel> get displayPosts {
    switch (currentFeedIndex.value) {
      case 0: // Following
        return posts.where((p) => p.username == 'alex_r' || p.username == 'sarah_j' || p.username == 'marcus_dev').toList();
      case 1: // For You
        return posts;
      case 2: // Trending
        return posts.where((p) => p.likes.value > 100).toList();
      case 3: // Latest
        return [posts[3], posts[4]]; // Recently added (Tokyo post, UI kit post)
      case 4: // Near You
        return posts.where((p) => p.username == 'tech_insider' || p.username == 'flutter_fan').toList();
      default:
        return posts;
    }
  }

  final _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      selectedVideo.value = null; // Clear video if image selected
    }
  }

  Future<void> pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      selectedVideo.value = File(video.path);
      selectedImage.value = null; // Clear image if video selected
    }
  }
  
  void selectFeeling() {
    Get.bottomSheet(
      Container(
        color: Get.theme.scaffoldBackgroundColor,
        child: Wrap(
          children: [
            ListTile(
              leading: const Text('😀', style: TextStyle(fontSize: 24)),
              title: const Text('Happy'),
              onTap: () { selectedFeeling.value = 'Happy'; Get.back(); },
            ),
            ListTile(
              leading: const Text('🤩', style: TextStyle(fontSize: 24)),
              title: const Text('Excited'),
              onTap: () { selectedFeeling.value = 'Excited'; Get.back(); },
            ),
            ListTile(
              leading: const Text('😎', style: TextStyle(fontSize: 24)),
              title: const Text('Cool'),
              onTap: () { selectedFeeling.value = 'Cool'; Get.back(); },
            ),
          ],
        ),
      ),
    );
  }

  void createPost() async {
    if (postTextController.text.isEmpty && selectedImage.value == null && selectedVideo.value == null) {
      Get.snackbar('Error', 'Please enter text or select media');
      return;
    }

    isPosting.value = true;
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final newPost = PostModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: 'omre_user', // Current user
      avatarUrl: AppAssets.avatar1,
      imageUrl: selectedImage.value != null 
          ? AppAssets.post1 // Placeholder for local file
          : AppAssets.post1,
      caption: postTextController.text + (selectedFeeling.value != null ? ' - feeling ${selectedFeeling.value}' : ''),
      timestamp: 'Just now',
      likes: 0,
    );

    posts.insert(0, newPost);
    
    // Reset state
    postTextController.clear();
    selectedImage.value = null;
    selectedVideo.value = null;
    selectedFeeling.value = null;
    isPosting.value = false;
    
    Get.snackbar('Success', 'Post created successfully!');
  }

  @override
  void onClose() {
    postTextController.dispose();
    super.onClose();
  }

  void addStory(StoryModel story) {
    if (stories.isNotEmpty && stories[0].username == 'Your Story') {
      stories[0].stories.insert(0, story);
      stories.refresh();
    }
  }

  void toggleLike(String postId) {
    final post = posts.firstWhere((p) => p.id == postId);
    if (post.isLiked.value) {
      post.likes.value--;
      post.isLiked.value = false;
    } else {
      post.likes.value++;
      post.isLiked.value = true;
    }
  }

  void toggleSave(String postId) {
    final post = posts.firstWhere((p) => p.id == postId);
    post.isSaved.toggle();
    if (post.isSaved.value) {
      Get.snackbar(
        'Saved',
        'Post saved to your collection',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void commentOnPost(String postId) {
    final post = posts.firstWhere((p) => p.id == postId);
    final commentController = TextEditingController();

    Get.bottomSheet(
      DraggableScrollableSheet(
        initialChildSize: 0.7, // Taller default for comments
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Handle
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Text(
                  'Comments',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                // Comments List
                Expanded(
                  child: Obx(() {
                    if (post.comments.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.comment_outlined, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text('No comments yet.', style: TextStyle(color: Colors.grey[600])),
                            const Text('Start the conversation.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: post.comments.length,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemBuilder: (context, index) {
                        final comment = post.comments[index];
                        // Parsing "username: comment" format or just showing text
                        // For this simple string list, we'll assume it's just the comment text and mock a user
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage(AppAssets.avatar1), // Current user avatar
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('omre_user', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                        const SizedBox(width: 8),
                                        Text('now', style: TextStyle(color: Colors.grey[600], fontSize: 11)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(comment),
                                  ],
                                ),
                              ),
                              Icon(Icons.favorite_border, size: 16, color: Colors.grey[600]),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
                // Input Area
                Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 16,
                    left: 16,
                    right: 16,
                    top: 12
                  ),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
                    color: Get.theme.scaffoldBackgroundColor,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(AppAssets.avatar1),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            isDense: true,
                          ),
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          if (commentController.text.trim().isNotEmpty) {
                            post.comments.add(commentController.text.trim());
                            commentController.clear();
                            // Scroll to bottom logic could be added here
                          }
                        },
                        icon: const Icon(Icons.arrow_upward, color: AppPalette.accentBlue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void sharePost(String postId) {
    // Collect unique users from posts to mock "friends"
    final friends = posts.map((p) => {'name': p.username, 'avatar': p.avatarUrl}).toSet().toList();
    // Track sent status for this specific session
    final Set<String> sentUsers = {};

    Get.bottomSheet(
      DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Handle
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Get.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Friends Grid
                    Expanded(
                      child: GridView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.6, // Taller for name + button
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: friends.length,
                        itemBuilder: (context, index) {
                          final friend = friends[index];
                          final username = friend['name']!;
                          final isSent = sentUsers.contains(username);
  
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(friend['avatar']!),
                                  ),
                                  if (!isSent) // Show online indicator only if not sent involved? actually keep it
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.green, // Online indicator mock
                                        shape: BoxShape.circle,
                                        border: Border(), 
                                      ),
                                      child: const SizedBox(width: 4, height: 4), 
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                username,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 28,
                                width: 70,
                                child: ElevatedButton(
                                  onPressed: isSent ? null : () {
                                    setState(() {
                                      sentUsers.add(username);
                                    });
                                    // Optional toast/snackbar could go here but UI update is sufficient
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: isSent ? Colors.grey[800] : AppPalette.accentBlue,
                                    disabledBackgroundColor: Colors.grey.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    isSent ? 'Sent' : 'Send',
                                    style: TextStyle(
                                      fontSize: 11, 
                                      color: isSent ? Colors.grey : Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // Bottom Actions Divider
                    const Divider(height: 1),
                    // Bottom Actions
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildShareOption(Icons.share, 'Share to...', () {
                            // Don't close sheet immediately to allow system share over it, or close then share
                             Get.back(); 
                             // Using a slight delay to allow sheet close animation
                             Future.delayed(const Duration(milliseconds: 200), () {
                                Share.share('Check out this post on OMRE!');
                             });
                          }),
                          _buildShareOption(Icons.copy, 'Copy link', () {
                            Get.back();
                            Get.snackbar('Copied', 'Link copied to clipboard');
                          }),
                          _buildShareOption(Icons.message_outlined, 'SMS', () {
                             Get.back();
                             // Use url_launcher for actual SMS if willing, but mock is fine
                             Get.snackbar('SMS', 'Opening Messages...');
                          }),
                          _buildShareOption(Icons.more_horiz, 'More', () {}),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          );
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildShareOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.grey[200],
            child: Icon(icon, color: Get.isDarkMode ? Colors.white : Colors.black, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  void showPostOptions(String postId) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.report_gmailerrorred, color: Colors.red),
              title: const Text('Report', style: TextStyle(color: Colors.red)),
              onTap: () {
                Get.back();
                Get.defaultDialog(
                  title: 'Report Post',
                  middleText: 'Are you sure you want to report this post?',
                  textCancel: 'Cancel',
                  textConfirm: 'Report',
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.back(); // Close dialog
                    Get.snackbar('Reported', 'Thanks for letting us know. We will review this post.',
                        snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 2));
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.visibility_off_outlined),
              title: const Text('Not interested'),
              onTap: () {
                Get.back();
                // Remove post locally
                posts.removeWhere((p) => p.id == postId);
                Get.snackbar('Hidden', 'We will show fewer posts like this.',
                    snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 2));
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Copy link'),
              onTap: () {
                Get.back();
                Get.snackbar('Copied', 'Link copied to clipboard.', 
                    snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1));
              },
            ),
          ],
        ),
      ),
    );
  }
}
