import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';

class OrbitTopic {
  final String title;
  final String description;
  final String category;
  final String status; // 'Trending', 'Active', 'Quiet'
  final int liveUsers;
  final List<String> languages;
  final bool isVerified;

  OrbitTopic({
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.liveUsers,
    required this.languages,
    this.isVerified = false,
  });
}

class OrbitController extends GetxController {
  final searchQuery = ''.obs;
  final selectedCategory = 'All'.obs;
  final joinedCommunities = <String>[].obs;
  final bookmarkedTopics = <String>[
    'AI Ethics & Safety',
    'Mars Colonization',
    'Global Climate Action',
  ].obs;
  
  final categories = <String>[
    'All', 'Trending', 'Tech', 'Science', 'Politics', 'Finance', 'Arts', 'Sports'
  ];

  final allTopics = <OrbitTopic>[
    OrbitTopic(
      title: 'AI Ethics & Safety',
      description: 'Debating the moral implications of AGI development and safety protocols.',
      category: 'Tech',
      status: 'Trending',
      liveUsers: 1420,
      languages: ['EN', 'DE', 'JP'],
      isVerified: true,
    ),
    OrbitTopic(
      title: 'Global Climate Action',
      description: 'Coordinating local initiatives for global impact effectively.',
      category: 'Science',
      status: 'Active',
      liveUsers: 850,
      languages: ['EN', 'FR', 'ES'],
    ),
    OrbitTopic(
      title: 'Mars Colonization',
      description: 'Technical challenges of sustainable habitats on the Red Planet.',
      category: 'Science',
      status: 'Active',
      liveUsers: 560,
      languages: ['EN', 'RU'],
      isVerified: true,
    ),
    OrbitTopic(
      title: '2026 Market Outlook',
      description: 'Analyzing crypto trends and traditional market shifts for Q3.',
      category: 'Finance',
      status: 'Trending',
      liveUsers: 2100,
      languages: ['EN', 'CN'],
    ),
    OrbitTopic(
      title: 'Modern Architecture',
      description: 'Minimalism vs Brutalism in the new age of sustainable design.',
      category: 'Arts',
      status: 'Quiet',
      liveUsers: 120,
      languages: ['EN', 'IT'],
    ),
    OrbitTopic(
      title: 'Premier League Tactics',
      description: 'Post-match analysis of the weekend derby and tactical breakdowns.',
      category: 'Sports',
      status: 'Trending',
      liveUsers: 3400,
      languages: ['EN'],
    ),
    OrbitTopic(
      title: 'Quantum Computing',
      description: 'Recent breakthroughs in error correction and qubits.',
      category: 'Tech',
      status: 'Active',
      liveUsers: 300,
      languages: ['EN', 'DE'],
    ),
    OrbitTopic(
      title: 'Oil Painting Techniques',
      description: 'Sharing tips for wet-on-wet style landscapes.',
      category: 'Arts',
      status: 'Quiet',
      liveUsers: 45,
      languages: ['EN'],
    ),
  ].obs;

  List<OrbitTopic> get filteredTopics {
    return allTopics.where((topic) {
      final matchesSearch = topic.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          topic.description.toLowerCase().contains(searchQuery.value.toLowerCase());
      
      final matchesCategory = selectedCategory.value == 'All' || 
          topic.category == selectedCategory.value ||
          (selectedCategory.value == 'Trending' && topic.status == 'Trending');

      return matchesSearch && matchesCategory;
    }).toList();
  }



  // Dynamic Post Data
  List<Map<String, dynamic>> getPostsForTopic(String title) {
    switch (title) {
      case 'AI Ethics & Safety':
        return [
          {
            'type': 'verified',
            'name': 'Dr. Sarah Chen',
            'role': 'Verified Expert',
            'time': '2m ago',
            'tag': 'INSIGHT',
            'content': "We need to distinguish between 'AGI alignment' and 'short-term bias mitigation'. Focusing only on the apocalypse scenario distracts from current algorithmic discrimination issues.",
            'reputation': 42,
            'agreements': 15,
            'avatar': AppAssets.avatar1,
          },
          {
            'type': 'contributor',
            'name': 'Marcus Neo',
            'role': 'Contributor',
            'time': '5m ago',
            'tag': 'QUESTION',
            'content': "Has anyone read the latest EU AI Act draft? It seems to heavily penalize open-source models.",
            'hearts': 8,
            'avatar': AppAssets.avatar2,
          },
          {
            'type': 'source',
            'name': 'TechWatch',
            'role': 'Source',
            'time': '12m ago',
            'tag': 'SOURCE',
            'content': "New paper published: 'Scalable Oversight for Large Language Models' by Anthropic.",
            'link': 'arxiv.org/abs/2211.03540',
            'avatar': AppAssets.avatar3,
          },
        ];
      case 'Global Climate Action':
        return [
          {
            'type': 'verified',
            'name': 'Prof. Elena Rostova',
            'role': 'Climate Scientist',
            'time': '10m ago',
            'tag': 'DATA',
            'content': "Recent satellite data confirms accelerated ice sheet loss in Greenland. We are approaching a tipping point faster than predicted.",
            'reputation': 89,
            'agreements': 120,
            'avatar': AppAssets.avatar2,
          },
          {
            'type': 'contributor',
            'name': 'GreenWarrior',
            'role': 'Activist',
            'time': '15m ago',
            'tag': 'ACTION',
            'content': "Organizing a beach cleanup this Saturday in Santa Monica. Who's in?",
            'hearts': 45,
            'avatar': AppAssets.avatar1,
          },
        ];
      case 'Premier League Tactics':
        return [
           {
            'type': 'verified',
            'name': 'TacticsTim',
            'role': 'Analyst',
            'time': '5m ago',
            'tag': 'ANALYSIS',
            'content': "The inverted full-back role completely dismantled the low block today. Creating overloads in midfield was key.",
            'reputation': 210,
            'agreements': 56,
            'avatar': AppAssets.avatar3,
          },
          {
            'type': 'contributor',
            'name': 'FootyFan99',
            'role': 'Fan',
            'time': '1m ago',
            'tag': 'OPINION',
            'content': "VAR is ruining the flow of the game. That offside call was marginal at best.",
            'hearts': 12,
            'avatar': AppAssets.avatar2,
          },
        ];
      default:
        return [
          {
            'type': 'contributor',
            'name': 'OrbitUser',
            'role': 'Explorer',
            'time': 'Just now',
            'tag': 'HELLO',
            'content': "This topic is heating up! What are everyone's thoughts on the latest developments?",
            'hearts': 0,
            'avatar': AppAssets.avatar1,
          },
        ];
    }
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void addTopic(OrbitTopic topic) {
    allTopics.insert(0, topic);
  }

  void toggleCommunity(String name) {
    if (joinedCommunities.contains(name)) {
      joinedCommunities.remove(name);
    } else {
      joinedCommunities.add(name);
    }
  }

  void toggleBookmark(String title) {
    if (bookmarkedTopics.contains(title)) {
      bookmarkedTopics.remove(title);
    } else {
      bookmarkedTopics.add(title);
    }
  }
}
