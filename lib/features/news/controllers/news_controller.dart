import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';

class NewsController extends GetxController {
  final selectedCategory = 'India'.obs;
  
  final categories = [
    'For You', 
    'Following', 
    'India', 
    'World', 
    'Local', 
    'Business', 
    'Technology', 
    'Entertainment', 
    'Sports', 
    'Science'
  ];

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  Map<String, String> getFeaturedStory() {
    final category = selectedCategory.value;
    if (category == 'India') {
      return {
        'title': 'India Launches New Space Mission to Mars',
        'summary': 'ISRO confirms the successful launch of Mangalyaan 2, aiming for deeper exploration.',
        'source': 'ISRO News',
        'time': '1h ago',
        'image': AppAssets.post1,
      };
    } else if (category == 'World') {
      return {
        'title': 'Global Climate Summit Reaches Historic Agreement',
        'summary': 'Leaders from 190 countries sign the new pact to reduce carbon emissions by 50%.',
        'source': 'World News',
        'time': '30m ago',
        'image': AppAssets.post2,
      };
    } else if (category == 'Local') {
      return {
        'title': 'City Marathon Draws Record Crowds This Weekend',
        'summary': 'Over 50,000 participants joined the annual city run, raising millions for charity.',
        'source': 'City Daily',
        'time': '2h ago',
        'image': AppAssets.post3,
      };
    } else if (category == 'Following') {
      return {
        'title': 'Your Favorite Tech Reviewer Just Dropped a New Video',
        'summary': 'Check out the detailed review of the latest flagship smartphone.',
        'source': 'TechRadar',
        'time': '15m ago',
        'image': AppAssets.thumbnail1,
      };
    } else if (category == 'For You') {
       return {
        'title': 'Top 10 Things You Need to Know Today',
        'summary': 'A curated list of the most important stories tailored just for you.',
        'source': 'Curated',
        'time': '10m ago',
        'image': AppAssets.thumbnail2,
      };
    }
    else {
      return {
         'title': 'Breaking News in $category',
         'summary': 'The latest updates from the world of $category.',
         'source': '$category Central',
         'time': 'Now',
         'image': AppAssets.thumbnail3,
      };
    }
  }

  List<Map<String, String>> getStories() {
    final category = selectedCategory.value;
    if (category == 'India') {
      return [
        {'title': 'Bangalore Tech Summit 2026 Kicks Off', 'source': 'Tech India', 'time': '4h ago', 'image': AppAssets.thumbnail1},
         {'title': 'New Metro Lines Operational in Major Cities', 'source': 'Urban Infra', 'time': '6h ago', 'image': AppAssets.thumbnail2},
         {'title': 'Cricket: India Wins Series Decider', 'source': 'Sports Today', 'time': '8h ago', 'image': AppAssets.thumbnail3},
      ];
    } else if (category == 'World') {
      return [
         {'title': 'European Union Passes New AI Regulations', 'source': 'EU Herald', 'time': '2h ago', 'image': AppAssets.thumbnail1},
         {'title': 'Electric Vehicle Sales Surpass Gas Cars in Nordic Region', 'source': 'Auto World', 'time': '5h ago', 'image': AppAssets.thumbnail2},
      ];
    } else if (category == 'For You') {
       return [
         {'title': 'Tech Trends To Watch in 2026', 'source': 'Tech Weekly', 'time': '2h ago', 'image': AppAssets.post1},
         {'title': 'Healthy Habits for a Better Life', 'source': 'Lifestyle', 'time': '5h ago', 'image': AppAssets.post2},
         {'title': 'Hidden Gems in Your City', 'source': 'Travel Guide', 'time': '1d ago', 'image': AppAssets.post3},
      ];
    }
    else {
       return [
         {'title': 'Latest trends in $category', 'source': '$category Weekly', 'time': '3h ago', 'image': AppAssets.thumbnail2},
         {'title': 'Top 10 moments in $category this week', 'source': 'Daily $category', 'time': '6h ago', 'image': AppAssets.thumbnail3},
      ];
    }
  }
}
