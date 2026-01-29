import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../video/video_player_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final String title;
  final String genre;
  final String rating;
  final String image;
  
  const MovieDetailScreen({
    super.key,
    required this.title,
    required this.genre,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(image, height: 500, width: double.infinity, fit: BoxFit.cover),
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, theme.scaffoldBackgroundColor],
                      stops: const [0.3, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  top: 40, left: 16,
                  child: IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.black45, 
                      child: Icon(Icons.arrow_back, color: Colors.white)
                    ), 
                    onPressed: () => Get.back()
                  ),
                ),
                Positioned(
                  bottom: 20, left: 16, right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title, 
                        textAlign: TextAlign.center, 
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$genre • 2h 30m', 
                        style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            rating, 
                            style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Get.to(() => VideoPlayerScreen(
                                title: title,
                                channel: 'Universal Pictures',
                                views: '1M',
                                time: '2 days ago',
                                thumbnailUrl: image,
                                avatarColor: Colors.blue,
                                videoUrl: AppAssets.sampleVideo,
                              ));
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Watch Trailer'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(onPressed: () {}, icon: Icon(Icons.add, color: isDark ? Colors.white : Colors.black)),
                          IconButton(onPressed: () {}, icon: Icon(Icons.share, color: isDark ? Colors.white : Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Synopsis', style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    'In a future where humanity struggles to survive, a group of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.', 
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[700], height: 1.5)
                  ),
                  const SizedBox(height: 24),
                  Text('Cast', style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: Column(
                            children: [
                              CircleAvatar(radius: 30, backgroundColor: isDark ? Colors.white24 : Colors.grey[300]),
                              const SizedBox(height: 8),
                              Text(
                                'Actor $index', 
                                style: TextStyle(color: isDark ? Colors.white70 : Colors.black87, fontSize: 12)
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
