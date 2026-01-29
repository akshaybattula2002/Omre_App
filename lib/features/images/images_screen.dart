import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../core/constants/app_assets.dart';
import '../explore/image_detail_screen.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Photos', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
            onPressed: () => Get.back(),
          ),
          bottom: TabBar(
            labelColor: isDark ? Colors.blue : Colors.blue[700],
            unselectedLabelColor: Colors.grey,
            indicatorColor: isDark ? Colors.blue : Colors.blue[700],
            tabs: const [
              Tab(text: 'Photos'),
              Tab(text: 'Albums'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                 Get.bottomSheet(
                   Container(
                     color: isDark ? Colors.grey[900] : Colors.white,
                     child: Wrap(
                       children: [
                         ListTile(leading: const Icon(Icons.camera_alt), title: const Text('Take Photo'), onTap: () => Get.back()),
                         ListTile(leading: const Icon(Icons.photo_library), title: const Text('Upload from Gallery'), onTap: () => Get.back()),
                       ],
                     ),
                   ),
                 );
              },
              child: const Text('Add', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildPhotosTab(isDark),
            _buildAlbumsTab(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotosTab(bool isDark) {
    final List<String> images = [
      AppAssets.thumbnail1,
      AppAssets.thumbnail2,
      AppAssets.thumbnail3,
      AppAssets.post1,
      AppAssets.post2,
      AppAssets.cover1,
      AppAssets.cover2,
    ];

    return MasonryGridView.count(
      padding: const EdgeInsets.all(4),
      crossAxisCount: 3,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: images.length,
      itemBuilder: (context, index) {
        final img = images[index % images.length];
        return GestureDetector(
          onTap: () {
            Get.to(() => ImageDetailScreen(imageUrl: img));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0), // Facebook uses square tiles often
            child: Hero(
              tag: img,
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAlbumsTab(bool isDark) {
    final albums = [
      {'title': 'Profile Pictures', 'count': '12', 'image': AppAssets.avatar1},
      {'title': 'Cover Photos', 'count': '5', 'image': AppAssets.cover1},
      {'title': 'Mobile Uploads', 'count': '128', 'image': AppAssets.post1},
      {'title': 'Timeline Photos', 'count': '45', 'image': AppAssets.post2},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return GestureDetector(
          onTap: () {
            Get.snackbar('Album', 'Opening ${album['title']}...', snackPosition: SnackPosition.BOTTOM);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(album['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                album['title']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                '${album['count']} items',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
