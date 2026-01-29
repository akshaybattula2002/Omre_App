import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';

class FriendProfileScreen extends StatelessWidget {
  final String name;
  final String image;
  final String cover;
  final bool isFriend;

  const FriendProfileScreen({
    super.key,
    required this.name,
    required this.image,
    required this.cover,
    this.isFriend = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(cover, fit: BoxFit.cover),
            ),
             leading: IconButton(
              icon: const CircleAvatar(backgroundColor: Colors.black45, child: Icon(Icons.arrow_back, color: Colors.white)),
              onPressed: () => Get.back(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              transform: Matrix4.translationValues(0, -40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   CircleAvatar(
                     radius: 50,
                     backgroundColor: theme.scaffoldBackgroundColor,
                     child: CircleAvatar(radius: 46, backgroundImage: AssetImage(image)),
                   ),
                   const SizedBox(height: 12),
                   Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                   const Text('Live, Laugh, Code 💻', style: TextStyle(fontSize: 16, color: Colors.grey)),
                   const SizedBox(height: 24),
                   Row(
                     children: [
                       Expanded(
                         child: ElevatedButton.icon(
                           onPressed: () {
                              Get.snackbar(isFriend ? 'Friend Removed' : 'Request Sent', isFriend ? 'You unadded $name' : 'Friend request sent to $name', backgroundColor: Colors.blue, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
                           },
                           icon: Icon(isFriend ? Icons.person_remove : Icons.person_add),
                           label: Text(isFriend ? 'Unfriend' : 'Add Friend'),
                           style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                         ),
                       ),
                       const SizedBox(width: 8),
                       Expanded(
                         child: ElevatedButton.icon(
                           onPressed: () {},
                           icon: const Icon(Icons.message),
                           label: const Text('Message'),
                           style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.withOpacity(0.2), 
                              foregroundColor: isDark ? Colors.white : Colors.black,
                              elevation: 0
                           ),
                         ),
                       ),
                       IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
                     ],
                   ),
                   const SizedBox(height: 24),
                   const Text('Photos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 12),
                   GridView.builder(
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 3,
                       crossAxisSpacing: 8,
                       mainAxisSpacing: 8,
                     ),
                     itemCount: 6,
                     itemBuilder: (context, index) {
                       return ClipRRect(
                         borderRadius: BorderRadius.circular(8),
                         child: Image.asset(
                           [AppAssets.post1, AppAssets.post2, AppAssets.post3, AppAssets.post4, AppAssets.post5, AppAssets.cover1][index],
                           fit: BoxFit.cover,
                         ),
                       );
                     },
                   )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
