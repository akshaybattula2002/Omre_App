import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsSearchScreen extends StatefulWidget {
  const NewsSearchScreen({super.key});

  @override
  State<NewsSearchScreen> createState() => _NewsSearchScreenState();
}

class _NewsSearchScreenState extends State<NewsSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [
    'Flutter 3.19 updates',
    'SpaceX launch',
    'AI advancements 2026',
    'Global market trends',
    'Climate change summit',
  ];

  final List<Map<String, String>> _dummyResults = [
    {
      'title': 'The Future of AI in Mobile Development',
      'source': 'TechDaily',
      'time': '2h ago',
      'category': 'Technology',
    },
    {
      'title': 'New Sustainable Energy Solutions Unveiled',
      'source': 'GreenEarth',
      'time': '4h ago',
      'category': 'Environment',
    },
    {
      'title': 'Global Economic Outlook for 2026',
      'source': 'FinanceToday',
      'time': '5h ago',
      'category': 'Business',
    },
  ];

  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            hintText: 'Search news, topics, or sources...',
            hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _isSearching = value.isNotEmpty;
            });
          },
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _isSearching = false;
                });
              },
            ),
        ],
      ),
      body: _isSearching ? _buildSearchResults(isDark) : _buildRecentSearches(isDark),
    );
  }

  Widget _buildRecentSearches(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Recent Searches',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        ..._recentSearches.map((search) => ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.history, color: Colors.grey),
          title: Text(search, style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)),
          trailing: const Icon(Icons.north_west, size: 16, color: Colors.grey),
          onTap: () {
            _searchController.text = search;
            setState(() {
              _isSearching = true;
            });
          },
        )).toList(),
      ],
    );
  }

  Widget _buildSearchResults(bool isDark) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _dummyResults.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = _dummyResults[index];
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E222B) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.article, color: isDark ? Colors.white70 : Colors.blue),
            ),
            title: Text(
              item['title']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item['category']!,
                        style: const TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${item['source']} • ${item['time']}',
                      style: TextStyle(fontSize: 12, color: isDark ? Colors.white54 : Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
