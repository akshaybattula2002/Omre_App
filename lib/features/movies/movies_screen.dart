import 'package:flutter/material.dart';
import 'package:omre/core/constants/app_assets.dart';
import 'package:get/get.dart';
import 'screens/movie_detail_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Movies', style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () => Get.snackbar('Search', 'Search for movies coming soon')),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeaturedCarousel(isDark),
            const SizedBox(height: 32),
            _buildSectionTitle('Trending Now', isDark),
            _buildMovieRow(),
            const SizedBox(height: 24),
            _buildSectionTitle('New Releases', isDark),
            _buildMovieRow(reverse: true),
            const SizedBox(height: 24),
            _buildSectionTitle('Action & Adventure', isDark),
            _buildMovieRow(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCarousel(bool isDark) {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          final movies = [
             {'title': 'Inception', 'img': AppAssets.cover1, 'genre': 'Sci-Fi'},
             {'title': 'The Dark Knight', 'img': AppAssets.cover2, 'genre': 'Action'},
             {'title': 'Interstellar', 'img': AppAssets.cover3, 'genre': 'Sci-Fi'},
          ];
          final movie = movies[index];
          
          return GestureDetector(
            onTap: () {
               Get.to(() => MovieDetailScreen(
                 title: movie['title']!,
                 genre: movie['genre']!,
                 rating: '8.8',
                 image: movie['img']!,
               ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(movie['img']!),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
                ]
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.5, 1.0],
                  ),
                ),
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomLeft,
                // Text inside the card should ALWAYS be white because it's on top of an image/dark gradient
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                       decoration: BoxDecoration(
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(8),
                       ),
                       child: const Text('Top 10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                     ),
                     const SizedBox(height: 12),
                     Text(
                       movie['title']!,
                       style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(height: 8),
                     Row(
                       children: [
                         Text('2024 • ${movie['genre']} • 2h 28m', style: const TextStyle(color: Colors.white70)),
                         const SizedBox(width: 16),
                         const Icon(Icons.star, color: Colors.amber, size: 16),
                         const SizedBox(width: 4),
                         const Text('8.8', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                       ],
                     ),
                     const SizedBox(height: 16),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => Get.snackbar('Movies', 'Starting stream for ${movie['title']}...'),
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Watch Now'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            onPressed: () => Get.snackbar('Movies', '${movie['title']} added to your list'),
                            icon: const Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Text(
        title,
        style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMovieRow({bool reverse = false}) {
    final images = [
      AppAssets.cover1,
      AppAssets.cover2,
      AppAssets.cover3,
      AppAssets.post1,
    ];
    final displayImages = reverse ? images.reversed.toList() : images;

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: displayImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
               Get.to(() => MovieDetailScreen(
                 title: 'Movie Title $index', 
                 genre: 'Action', 
                 rating: '7.5', 
                 image: displayImages[index]
               ));
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(displayImages[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
