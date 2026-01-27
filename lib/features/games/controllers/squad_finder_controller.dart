import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SquadFinderController extends GetxController {
  final searchQuery = ''.obs;
  final selectedRegion = 'Global'.obs;
  final selectedRank = 'Any Rank'.obs;

  final regions = ['Global', 'North America', 'Europe', 'Asia', 'South America'];
  final ranks = ['Any Rank', 'Bronze', 'Silver', 'Gold', 'Platinum', 'Diamond', 'Master'];

  final allSquads = <Map<String, dynamic>>[
    {
      'game': '8 Ball Pool',
      'title': 'Pro Players Only',
      'postedTime': '5m ago',
      'needed': '2',
      'description': 'Looking for skilled players for high-stakes matches. Mic is a must.',
      'rank': 'Gold',
      'region': 'Global',
      'mic': true,
    },
    {
      'game': 'Hero Wars',
      'title': 'Guild Raid Tonight',
      'postedTime': '12m ago',
      'needed': '1',
      'description': 'Need a strong tank for the upcoming guild raid. Let\'s conquer!',
      'rank': 'Platinum',
      'region': 'Europe',
      'mic': true,
    },
    {
      'game': 'UNO',
      'title': 'Casual Fun',
      'postedTime': '20m ago',
      'needed': '3',
      'description': 'Playing some chill UNO. Anyone can join, just for fun.',
      'rank': 'Any Rank',
      'region': 'North America',
      'mic': false,
    },
    {
      'game': 'Ludo Club',
      'title': 'Serious Ludo',
      'postedTime': '30m ago',
      'needed': '1',
      'description': 'Competitive Ludo players, come join. No quitters.',
      'rank': 'Silver',
      'region': 'Asia',
      'mic': false,
    },
    {
      'game': 'PUBG Mobile',
      'title': 'Rank Push Squad',
      'postedTime': '1h ago',
      'needed': '2',
      'description': 'Pushing to Ace. Need experienced teammates with good comms.',
      'rank': 'Diamond',
      'region': 'Global',
      'mic': true,
    },
  ].obs;

  List<Map<String, dynamic>> get filteredSquads {
    return allSquads.where((squad) {
      final matchesSearch = squad['game'].toString().toLowerCase().contains(searchQuery.value.toLowerCase()) ||
                            squad['title'].toString().toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesRegion = selectedRegion.value == 'Global' || squad['region'] == selectedRegion.value;
      final matchesRank = selectedRank.value == 'Any Rank' || squad['rank'] == selectedRank.value;
      
      return matchesSearch && matchesRegion && matchesRank;
    }).toList();
  }

  void joinSquad(String title) {
    Get.snackbar(
      'Request Sent',
      'Joining squad: $title...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void createPost() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Squad Post',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            // Placeholder fields
            _buildPlaceholderField('Game Name'),
            const SizedBox(height: 16),
            _buildPlaceholderField('Needed Players'),
            const SizedBox(height: 16),
            _buildPlaceholderField('Description'),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Post Squad', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderField(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const Icon(Icons.edit, color: Colors.grey, size: 16),
        ],
      ),
    );
  }
}
