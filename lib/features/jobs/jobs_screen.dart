import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';
import 'package:intl/intl.dart';
import 'gig_detail_screen.dart';
import 'category_services_screen.dart';

// --- Models ---
class CategoryModel {
  final String name;
  final int jobCount;
  final IconData icon;
  final String? assetPath;
  CategoryModel({required this.name, required this.jobCount, required this.icon, this.assetPath});
}

class JobModel {
  final String title;
  final String company;
  final String location;
  final String jobType;
  final String salary;
  final bool easyApply;
  final DateTime postedAt;
  final String logoUrl;

  JobModel({
    required this.title,
    required this.company,
    required this.location,
    required this.jobType,
    required this.salary,
    required this.easyApply,
    required this.postedAt,
    required this.logoUrl,
  });
}

class GigModel {
  final String title;
  final String sellerName;
  final String sellerLevel;
  final String sellerAvatarUrl;
  final double rating;
  final int reviewsCount;
  final String price;
  final String thumbnailUrl;

  GigModel({
    required this.title,
    required this.sellerName,
    required this.sellerLevel,
    required this.sellerAvatarUrl,
    required this.rating,
    required this.reviewsCount,
    required this.price,
    required this.thumbnailUrl,
  });
}

// --- Controller ---
class JobsController extends GetxController {
  final isMarketplace = false.obs;
  final selectedCategory = 'All'.obs;
  final selectedTrending = 'Remote'.obs;

  final searchController = TextEditingController();
  final locationController = TextEditingController();

  final categories = <CategoryModel>[
    CategoryModel(name: 'Engineering', jobCount: 234, icon: Icons.code, assetPath: 'assets/images/link_icon_3d.png'),
    CategoryModel(name: 'Design', jobCount: 89, icon: Icons.palette_outlined, assetPath: 'assets/images/studio_icon_3d.png'),
    CategoryModel(name: 'Marketing', jobCount: 156, icon: Icons.campaign_outlined),
    CategoryModel(name: 'Sales', jobCount: 123, icon: Icons.trending_up),
    CategoryModel(name: 'Product', jobCount: 67, icon: Icons.inventory_2_outlined),
    CategoryModel(name: 'HR', jobCount: 45, icon: Icons.people_outline),
    CategoryModel(name: 'Operations', jobCount: 78, icon: Icons.settings_outlined),
    CategoryModel(name: 'Education', jobCount: 92, icon: Icons.school_outlined, assetPath: 'assets/images/learn_icon_3d.png'),
  ].obs;

  final allJobs = <JobModel>[
    JobModel(
      title: 'Senior Frontend Engineer',
      company: 'TechFlow',
      location: 'Remote',
      jobType: 'Full-time',
      salary: r'$140k - $180k',
      easyApply: true,
      postedAt: DateTime.now().subtract(const Duration(hours: 2)),
      logoUrl: AppAssets.getRandomThumbnail(),
    ),
    JobModel(
      title: 'Product Designer',
      company: 'Creative Studio',
      location: 'New York, NY',
      jobType: 'Contract',
      salary: r'$60 - $90 /hr',
      easyApply: false,
      postedAt: DateTime.now().subtract(const Duration(days: 1)),
      logoUrl: AppAssets.getRandomThumbnail(),
    ),
    JobModel(
      title: 'Marketing Manager',
      company: 'GrowthUp',
      location: 'San Francisco, CA',
      jobType: 'Full-time',
      salary: r'$110k - $130k',
      easyApply: true,
      postedAt: DateTime.now().subtract(const Duration(hours: 5)),
      logoUrl: AppAssets.getRandomThumbnail(),
    ),
  ].obs;

  final trendingGigs = <GigModel>[
    GigModel(
      title: 'I will design a modern minimal logo',
      sellerName: 'John Doe',
      sellerLevel: 'Level 2',
      sellerAvatarUrl: AppAssets.avatar1,
      rating: 4.9,
      reviewsCount: 230,
      price: r'$50',
      thumbnailUrl: AppAssets.thumbnail1,
    ),
    GigModel(
      title: 'I will build a responsive Flutter app',
      sellerName: 'Jane Smith',
      sellerLevel: 'Top Rated',
      sellerAvatarUrl: AppAssets.avatar2,
      rating: 5.0,
      reviewsCount: 156,
      price: r'$120',
      thumbnailUrl: AppAssets.thumbnail2,
    ),
    GigModel(
      title: 'I will write high-quality technical blogs',
      sellerName: 'Alex Johnson',
      sellerLevel: 'Level 1',
      sellerAvatarUrl: AppAssets.avatar3,
      rating: 4.8,
      reviewsCount: 89,
      price: r'$35',
      thumbnailUrl: AppAssets.thumbnail3,
    ),
  ].obs;

  List<JobModel> get filteredJobs {
    if (selectedCategory.value == 'All') return allJobs;
    return allJobs.where((job) => job.title.contains(selectedCategory.value)).toList();
  }

  void applyForJob(JobModel job) {
    Get.bottomSheet(
      Builder(builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Apply for Position',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 12),
              Text(
                'You are applying to ${job.company} for the ${job.title} role.',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      'Application Sent',
                      'Good luck with your application!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.accentBlue,
                      padding: const EdgeInsets.all(16)),
                  child: const Text('Confirm Application',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      }),
    );
  }

  void showCompleteProfile() {
    Get.dialog(
      Builder(builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.stars, color: Colors.amber, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Level Up Your Search',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  'Users with a complete profile are 4x more likely to be noticed by recruiters.',
                  style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppPalette.accentBlue),
                    child: const Text('Complete Profile',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Maybe later',
                      style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  final marketplaceSearchQuery = ''.obs;

  List<GigModel> get filteredGigs {
    if (marketplaceSearchQuery.value.isEmpty) return trendingGigs;
    return trendingGigs.where((gig) => 
      gig.title.toLowerCase().contains(marketplaceSearchQuery.value.toLowerCase()) ||
      gig.sellerName.toLowerCase().contains(marketplaceSearchQuery.value.toLowerCase())
    ).toList();
  }

  @override
  void onClose() {
    searchController.dispose();
    locationController.dispose();
    super.onClose();
  }
}

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobsController());
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF07090C) : theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // JOBS MODE Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0A0C10) : Colors.grey[100],
                border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
              ),
              child: const Text(
                'JOBS MODE',
                style: TextStyle(
                  color: AppPalette.accentBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            // Toggle Switch
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Obx(() => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildToggleButton(
                        'Jobs', 
                        Icons.work_outline, 
                        !controller.isMarketplace.value,
                        () => controller.isMarketplace.value = false,
                        isDark,
                      ),
                      _buildToggleButton(
                        'Marketplace', 
                        Icons.shopping_cart_outlined, 
                        controller.isMarketplace.value,
                        () => controller.isMarketplace.value = true,
                        isDark,
                      ),
                    ],
                  )),
                ),
              ),
            ),

            // Content
            Expanded(
              child: Obx(() => controller.isMarketplace.value 
                  ? _buildMarketplaceView(context, isDark, controller) 
                  : _buildJobsDetailedView(context, isDark, controller)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, IconData icon, bool isActive, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? (isDark ? Colors.grey[800] : Colors.white) : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
          boxShadow: isActive && !isDark ? [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
          ] : null,
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isActive ? AppPalette.accentBlue : Colors.grey),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: isActive ? (isDark ? Colors.white : Colors.black) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- JOBS DETAILED VIEW ---
  Widget _buildJobsDetailedView(BuildContext context, bool isDark, JobsController controller) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildJobsHero(isDark, controller),
          _buildTrendingChips(isDark, controller),
          _buildStatsGrid(isDark),
          _buildCategoriesSection(isDark, controller),
          _buildRecommendedSection(isDark, controller),
          _buildJobListings(isDark, controller),
          _buildCTABanner(isDark, controller),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildJobsHero(bool isDark, JobsController controller) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Over 16 new opportunities today',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, height: 1.1),
              children: [
                TextSpan(text: 'Find your next\n', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                WidgetSpan(
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppPalette.accentBlue, Colors.purpleAccent],
                    ).createShader(bounds),
                    child: const Text(
                      'dream job',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Discover thousands of career opportunities from world-class companies.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          // Search box
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF151921) : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                _buildSearchInput(Image.asset('assets/images/search_icon_3d.png', width: 20, height: 20), 'Job title / keywords / company', controller.searchController, isDark),
                const Divider(height: 1, indent: 48),
                _buildSearchInput(Icon(Icons.location_on_outlined, color: Colors.grey, size: 20), 'City, state, or remote', controller.locationController, isDark),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.accentBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Search Jobs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput(Widget iconWidget, String hint, TextEditingController textController, bool isDark) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: iconWidget,
        ),
        Expanded(
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingChips(bool isDark, JobsController controller) {
    final chips = ['Remote', 'Frontend', 'Design', 'Marketing', 'Product Manager'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text('Trending', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: chips.map((chip) {
              return Obx(() {
                final isSelected = controller.selectedTrending.value == chip;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(chip),
                    selected: isSelected,
                    onSelected: (val) => controller.selectedTrending.value = chip,
                    backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
                    selectedColor: AppPalette.accentBlue,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[700]),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
                  ),
                );
              });
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(bool isDark) {
    final stats = [
      {'val': '240+', 'label': 'Active Jobs'},
      {'val': '1.2k', 'label': 'Companies'},
      {'val': '850', 'label': 'Remote Jobs'},
      {'val': '\$120k', 'label': 'Avg Salary'},
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.5,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) {
          final stat = stats[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.03) : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stat['val']!, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: AppPalette.accentBlue)),
                Text(stat['label']!, style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection(bool isDark, JobsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text('Explore by Category', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: Text('Browse jobs by your area of expertise', style: TextStyle(color: Colors.grey, fontSize: 14)),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.8,
          ),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final cat = controller.categories[index];
            return InkWell(
              onTap: () => controller.selectedCategory.value = cat.name,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF11141B) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppPalette.accentBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(cat.icon, color: AppPalette.accentBlue, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cat.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text('${cat.jobCount} jobs', style: TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecommendedSection(bool isDark, JobsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Recommended for you', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                  Text('Based on your profile and search history', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              TextButton(onPressed: () {}, child: const Text('View All', style: TextStyle(color: AppPalette.accentBlue))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJobListings(bool isDark, JobsController controller) {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      itemCount: controller.filteredJobs.length,
      itemBuilder: (context, index) {
        final job = controller.filteredJobs[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF11141B) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
            boxShadow: !isDark ? [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
            ] : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(job.logoUrl, width: 48, height: 48, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text('${job.company} • ${job.location}', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ),
                  const Icon(Icons.bookmark_border, color: Colors.grey, size: 20),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildJobTag(job.jobType, isDark),
                  const SizedBox(width: 8),
                  _buildJobTag(job.salary, isDark, color: Colors.green),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Posted ${DateFormat.jm().format(job.postedAt)}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  ElevatedButton(
                    onPressed: () => controller.applyForJob(job),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: job.easyApply ? AppPalette.accentBlue : Colors.grey[800],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: Text(job.easyApply ? 'Easy Apply' : 'Apply Now', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ));
  }

  Widget _buildJobTag(String label, bool isDark, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (color ?? Colors.grey).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: TextStyle(color: color ?? (isDark ? Colors.grey[400] : Colors.grey[700]), fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCTABanner(bool isDark, JobsController controller) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2430) : AppPalette.accentBlue,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Get noticed faster', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 10)),
              ),
              const SizedBox(height: 16),
              const Text('Stand out to recruiters', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              const Text('Complete your profile to unlock personalized recommendations and priority applications.', 
                style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 24),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => controller.showCompleteProfile(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppPalette.accentBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Complete Profile', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  TextButton(onPressed: () {}, child: const Text('Learn More', style: TextStyle(color: Colors.white))),
                ],
              ),
            ],
          ),
          const Positioned(
            right: 0,
            top: 0,
            child: Icon(Icons.star, color: Colors.amber, size: 40),
          ),
        ],
      ),
    );
  }

  // --- MARKETPLACE VIEW (MODIFIED FROM PREVIOUS VERSION TO USE SAME CONTROLLER) ---
  Widget _buildMarketplaceView(BuildContext context, bool isDark, JobsController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppPalette.accentBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.auto_awesome, size: 14, color: AppPalette.accentBlue),
                      const SizedBox(width: 6),
                      Text(
                        'The #1 Marketplace for Tech Talent',
                        style: TextStyle(color: AppPalette.accentBlue, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Find the perfect\nfreelance services for\nyour business',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Work with talented experts on your own\nterms. From quick fixes to main projects.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Search Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF151921) : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset('assets/images/search_icon_3d.png', width: 24, height: 24),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (val) => controller.marketplaceSearchQuery.value = val,
                      decoration: const InputDecoration(
                        hintText: 'What service are',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: AppPalette.accentBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Popular Keywords
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('Popular:', style: TextStyle(color: Colors.grey, fontSize: 13)),
                _buildTag('Website Design', isDark),
                _buildTag('WordPress', isDark),
                _buildTag('Logo Design', isDark),
                _buildTag('SEO', isDark),
              ],
            ),
          ),

          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 24),

          // Categories Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Categories',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Text('View All', style: TextStyle(color: AppPalette.accentBlue, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 16, color: AppPalette.accentBlue),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

    GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: [
        _buildCategoryCard('Web Dev', Icons.code, const Color(0xFFE8F1FF), const Color(0xFF2B7FFF), isDark, assetPath: 'assets/images/link_icon_3d.png'),
        _buildCategoryCard('Design', Icons.palette_outlined, const Color(0xFFF6EEFF), const Color(0xFF9B51E0), isDark, assetPath: 'assets/images/studio_icon_3d.png'),
        _buildCategoryCard('Marketing', Icons.campaign_outlined, const Color(0xFFFFF0F5), const Color(0xFFFF4D94), isDark, assetPath: AppAssets.adsIcon3d),
        _buildCategoryCard('Writing', Icons.edit_note, const Color(0xFFFFF7EB), const Color(0xFFF2994A), isDark),
        _buildCategoryCard('Video', Icons.videocam_outlined, const Color(0xFFEFFFF7), const Color(0xFF27AE60), isDark),
      ],
    ),
          const SizedBox(height: 32),
          _buildTrendingServices(context, isDark),
          _buildFeaturesSection(isDark),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildTag(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCategoryCard(String label, IconData icon, Color bgColor, Color iconColor, bool isDark, {String? assetPath}) {
    return GestureDetector(
      onTap: () => Get.to(() => CategoryServicesScreen(categoryName: label)),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[100]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? bgColor.withOpacity(0.05) : bgColor,
                shape: BoxShape.circle,
              ),
              child: assetPath != null
                  ? Image.asset(assetPath, width: 32, height: 32)
                  : Icon(icon, size: 32, color: iconColor),
            ),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingServices(BuildContext context, bool isDark) {
    final controller = Get.find<JobsController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.trending_up, color: AppPalette.accentBlue, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Trending Services',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Most popular gigs this week',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Obx(() => SizedBox(
          height: 390,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: controller.filteredGigs.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildGigCard(controller.filteredGigs[index], isDark);
            },
          ),
        )),
      ],
    );
  }

  Widget _buildGigCard(GigModel gig, bool isDark) {
    return GestureDetector(
      onTap: () => Get.to(() => GigDetailScreen(gig: gig)),
      child: Container(
        width: 300,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF11141B) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: !isDark ? [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
          ] : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Stack(
              children: [
                Image.asset(
                  gig.thumbnailUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${gig.rating}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${gig.reviewsCount})',
                          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
  
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seller info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: AssetImage(gig.sellerAvatarUrl),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              gig.sellerName, 
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('Top Rated', style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          gig.sellerLevel,
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Gig title
                  Text(
                    gig.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
  
                  // Pricing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'STARTING AT',
                        style: TextStyle(color: Colors.grey[500], fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      ),
                      Text(
                        gig.price,
                        style: const TextStyle(
                          color: AppPalette.accentBlue,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The best part? Everything.',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 32),
          _buildFeatureItem(
            'Stick to your budget',
            'Find the right service for every price point. No hourly rates, just project-based pricing.',
            isDark,
          ),
          _buildFeatureItem(
            'Get quality work done quickly',
            'Hand your project over to a talented freelancer in minutes, get long-lasting results.',
            isDark,
          ),
          _buildFeatureItem(
            'Pay when you\'re happy',
            'Upfront quotes mean no surprises. Payments only get released when you approve.',
            isDark,
          ),
          _buildFeatureItem(
            'Count on 24/7 support',
            'Our round-the-clock support team is available to help anytime, anywhere.',
            isDark,
          ),
          const SizedBox(height: 40),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              AppAssets.cover1,
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          const Opacity(
            opacity: 0.5,
            child: Icon(Icons.blur_on, color: Colors.grey, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String desc, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: AppPalette.accentBlue, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
