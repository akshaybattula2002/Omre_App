import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:omre/core/constants/app_assets.dart';
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
    Get.bottomSheet(
      Container(
        height: 600,
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Comments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            Expanded(
              child: Center(
                child: Text('No comments yet.',
                    style: TextStyle(color: Colors.grey[600])),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 16,
                  left: 16,
                  right: 16,
                  top: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void sharePost(String postId) {
    Get.bottomSheet(
      Container(
        height: 200,
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Share to',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShareOption(Icons.copy, 'Copy Link'),
                _buildShareOption(Icons.message, 'Message'),
                _buildShareOption(Icons.share, 'Share via'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  void showPostOptions(String postId) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.report_gmailerrorred, color: Colors.red),
              title:
                  const Text('Report', style: TextStyle(color: Colors.red)),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: const Icon(Icons.visibility_off_outlined),
              title: const Text('Not interested'),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Copy link'),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
