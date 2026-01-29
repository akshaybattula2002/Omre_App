import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';

// --- Shared Widgets ---
class VideoListItem extends StatelessWidget {
  final String title;
  final String channel;
  final String views;
  final String time;
  final String thumbnail;
  final Widget? trailing;

  const VideoListItem({
    super.key,
    required this.title,
    required this.channel,
    required this.views,
    required this.time,
    required this.thumbnail,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  thumbnail,
                  width: 140,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.8), borderRadius: BorderRadius.circular(4)),
                  child: const Text('10:45', style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '$channel • $views • $time',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                if (trailing != null) ...[
                  const SizedBox(height: 8),
                  trailing!,
                ],
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 16),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// --- Screens ---

class VideoSubscriptionsScreen extends StatelessWidget {
  const VideoSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscriptions')),
      body: Column(
        children: [
          // Story-like avatars for recent updates
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              itemCount: 8,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(AppAssets.avatar1), // You might want to rotate avatars
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 12, height: 12,
                            decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle, border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2))),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Channel $index', style: const TextStyle(fontSize: 10)),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('Recent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                 VideoListItem(title: 'Flutter Tutorial for Beginners', channel: 'CodeMaster', views: '20k views', time: '2 hours ago', thumbnail: AppAssets.thumbnail1),
                 VideoListItem(title: 'Exploring the Metaverse', channel: 'TechDaily', views: '1.5M views', time: '5 hours ago', thumbnail: AppAssets.thumbnail2),
                 VideoListItem(title: 'New Game Release Review', channel: 'GamerZone', views: '500k views', time: '1 day ago', thumbnail: AppAssets.thumbnail3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoLibraryScreen extends StatelessWidget {
  const VideoLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLibraryItem(context, Icons.history, 'History', '120 videos'),
          _buildLibraryItem(context, Icons.play_circle_outline, 'Your Videos', '5 videos'),
          _buildLibraryItem(context, Icons.download_done_outlined, 'Downloads', '12 videos'),
          _buildLibraryItem(context, Icons.movie_creation_outlined, 'Your Movies', '2 movies'),
          const Divider(height: 32),
          const Text('Playlists', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          _buildPlaylistItem('Liked Videos', '520 videos', Icons.thumb_up),
          _buildPlaylistItem('Flutter Learning', '15 videos', Icons.playlist_play),
          _buildPlaylistItem('Chill Music', '50 videos', Icons.music_note),
        ],
      ),
    );
  }

  Widget _buildLibraryItem(BuildContext context, IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      onTap: () {},
    );
  }

  Widget _buildPlaylistItem(String title, String count, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 140,
            height: 80,
            decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(8)),
            child: Center(child: Icon(icon, color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(count, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class VideoHistoryScreen extends StatelessWidget {
  const VideoHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History'), actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Today', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          VideoListItem(
            title: 'Advanced State Management', 
            channel: 'Flutter Dev', 
            views: '12k views', 
            time: '2h ago', 
            thumbnail: AppAssets.thumbnail1,
            trailing: LinearProgressIndicator(value: 0.8, backgroundColor: Colors.grey, color: Colors.red, minHeight: 2),
          ),
          VideoListItem(
            title: 'Funny Cat Compilation 2026', 
            channel: 'MeowTube', 
            views: '2M views', 
            time: '5h ago', 
            thumbnail: AppAssets.thumbnail2,
            trailing: LinearProgressIndicator(value: 0.1, backgroundColor: Colors.grey, color: Colors.red, minHeight: 2),
          ),
          SizedBox(height: 16),
          Text('Yesterday', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          VideoListItem(
            title: 'Podcast: Future of Tech', 
            channel: 'Tech Talk', 
            views: '500k views', 
            time: '1d ago', 
            thumbnail: AppAssets.thumbnail3,
             trailing: LinearProgressIndicator(value: 1.0, backgroundColor: Colors.grey, color: Colors.red, minHeight: 2),
          ),
        ],
      ),
    );
  }
}

class VideoWatchLaterScreen extends StatelessWidget {
  const VideoWatchLaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch Later')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play All'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
              ),
            ),
          ),
          const VideoListItem(title: 'Documentary: Deep Ocean', channel: 'NatGeo', views: '1M views', time: '4 days ago', thumbnail: AppAssets.thumbnail1),
          const VideoListItem(title: 'Speedrun: Elden Ring 2', channel: 'SpeedGamer', views: '300k views', time: '1 week ago', thumbnail: AppAssets.thumbnail2),
        ],
      ),
    );
  }
}

class VideoLikedVideosScreen extends StatelessWidget {
  const VideoLikedVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liked Videos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          VideoListItem(title: 'Top 10 Goals of the Season', channel: 'SportsCentral', views: '5M views', time: '2 months ago', thumbnail: AppAssets.thumbnail3),
          VideoListItem(title: 'How to Bake: Perfect Cake', channel: 'ChefAnna', views: '800k views', time: '5 months ago', thumbnail: AppAssets.thumbnail1),
          VideoListItem(title: 'Music Video: Summer Vibes', channel: 'MusicVevo', views: '100M views', time: '1 year ago', thumbnail: AppAssets.thumbnail2),
        ],
      ),
    );
  }
}

class VideoTrendingScreen extends StatelessWidget {
  const VideoTrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trending'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Now'),
              Tab(text: 'Music'),
              Tab(text: 'Gaming'),
              Tab(text: 'Movies'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTrendingList('Now'),
            _buildTrendingList('Music'),
            _buildTrendingList('Gaming'),
            _buildTrendingList('Movies'),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingList(String category) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        VideoListItem(title: 'Trending #1 in $category', channel: 'TopChannel', views: '5M views', time: '10 hours ago', thumbnail: AppAssets.thumbnail1),
        VideoListItem(title: 'Viral Video Alert!', channel: 'BuzzFeed', views: '3M views', time: '12 hours ago', thumbnail: AppAssets.thumbnail2),
         VideoListItem(title: 'Must Watch: $category Special', channel: 'Influencer', views: '1M views', time: '1 day ago', thumbnail: AppAssets.thumbnail3),
      ],
    );
  }
}
