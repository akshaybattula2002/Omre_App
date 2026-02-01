import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';
import 'controllers/link_controller.dart';
import 'screens/job_details_screen.dart';
import 'screens/engineering_jobs_screen.dart';
import 'screens/design_jobs_screen.dart';
import 'screens/service_details_screen.dart';
import 'screens/category_jobs_screen.dart';
import 'screens/post_job_screen.dart';

class LinkHomeScreen extends StatelessWidget {
  const LinkHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LinkController>()) {
      Get.put(LinkController());
    }
    final controller = Get.find<LinkController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Obx(() => Column(
        children: [
          // Header / Tabs
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            color: isDark ? Colors.grey[900] : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 _buildTabButton('Jobs', controller.isJobsSelected.value, () {
                   controller.switchTab(true);
                 }, isDark),
                 const SizedBox(width: 16),
                 _buildTabButton('Marketplace', !controller.isJobsSelected.value, () {
                   controller.switchTab(false);
                 }, isDark),
              ],
            ),
          ),
          
          Expanded(
            child: controller.isJobsSelected.value 
              ? _buildJobsTab(controller, isDark, theme)
              : _buildMarketplaceTab(isDark, theme),
          ),
        ],
      )),
      floatingActionButton: Obx(() => controller.isJobsSelected.value
          ? FloatingActionButton.extended(
              onPressed: () => Get.to(() => const PostJobScreen()),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Post Job', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: AppPalette.accentBlue,
            )
          : const SizedBox.shrink()),
    );
  }

  Widget _buildJobsTab(LinkController controller, bool isDark, ThemeData theme) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              Container(
                 padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                 decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark 
                      ? [Colors.grey[900]!, const Color(0xFF121212)]
                      : [const Color(0xFFF0F4FF), Colors.white],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find your next\ndream job',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => Text(
                      'Discover ${controller.filteredJobs.length} opportunities.',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    )),
                    const SizedBox(height: 24),

                    // Search Section
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (val) {
                              controller.searchQuery.value = val;
                              controller.searchJobs();
                            },
                            decoration: InputDecoration(
                              hintText: 'Job title, keywords, or company',
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset('assets/images/search_icon_3d.png', width: 20, height: 20),
                              ),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                          ),
                          const Divider(height: 24),
                          TextField(
                            onChanged: (val) {
                              controller.locationQuery.value = val;
                              controller.searchJobs();
                            },
                            decoration: InputDecoration(
                              hintText: 'City, state, or remote',
                              prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () => controller.searchJobs(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4F46E5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                              ),
                              child: const Text('Search Jobs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Trending Filter Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    'Remote', 'Frontend', 'Design', 'Marketing', 'Sales', 'Product', 'Engineering'
                  ].map((filter) {
                    return Obx(() {
                      final isActive = controller.searchQuery.value == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: FilterChip(
                          label: Text(filter),
                          selected: isActive,
                          onSelected: (selected) {
                            controller.filterByTag(selected ? filter : '');
                          },
                          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
                          selectedColor: const Color(0xFF4F46E5),
                          labelStyle: TextStyle(
                            color: isActive ? Colors.white : (isDark ? Colors.grey[300] : Colors.grey[700]),
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), 
                            side: BorderSide(color: isActive ? Colors.transparent : (isDark ? Colors.grey[800]! : Colors.grey[300]!))
                          ),
                          showCheckmark: false,
                        ),
                      );
                    });
                  }).toList(),
                ),
              ),
              
              const SizedBox(height: 24),

              // Stats Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(() => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildStatCard('Active Jobs', '${controller.activeJobsCount}', Icons.work_outline, const Color(0xFF4F46E5), isDark, assetPath: 'assets/images/link_icon_3d.png')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard('Companies', '${controller.companiesCount}', Icons.business, const Color(0xFF10B981), isDark, assetPath: 'assets/images/biz_icon_3d.png')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildStatCard('Remote', '${controller.remoteJobsCount}', Icons.public, const Color(0xFFEC4899), isDark, assetPath: AppAssets.languageIcon3d)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard('Avg Salary', controller.avgSalary, Icons.attach_money, const Color(0xFFFF9800), isDark)),
                      ],
                    ),
                  ],
                )),
              ),

              const SizedBox(height: 32),

              // Explore by Category
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Explore by Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  children: [
                    _buildCategoryCard('Engineering', '210 jobs', Icons.code_rounded, const Color(0xFF6366F1), isDark),
                    _buildCategoryCard('Design', '85 jobs', Icons.brush_outlined, const Color(0xFFEC4899), isDark),
                    _buildCategoryCard('Marketing', '156 jobs', Icons.campaign, const Color(0xFF4F46E5), isDark, assetPath: AppAssets.adsIcon3d),
                    _buildCategoryCard('Sales', '123 jobs', Icons.trending_up, const Color(0xFF10B981), isDark),
                    _buildCategoryCard('Product', '67 jobs', Icons.inventory_2_outlined, const Color(0xFFFF9800), isDark, assetPath: AppAssets.catalogIcon3d),
                    _buildCategoryCard('Operations', '78 jobs', Icons.settings_outlined, const Color(0xFF00BCD4), isDark),
                    _buildCategoryCard('HR', '45 jobs', Icons.groups_outlined, const Color(0xFFF43F5E), isDark, assetPath: AppAssets.groupsIcon3d),
                    _buildCategoryCard('Education', '92 jobs', Icons.school_outlined, const Color(0xFF8B5CF6), isDark, assetPath: 'assets/images/learn_icon_3d.png'),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Recommended for You
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommended for you',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('View All', style: TextStyle(color: Color(0xFF4F46E5))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // List of Jobs
        Obx(() {
          if (controller.filteredJobs.isEmpty) {
            return SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text("No jobs found matching your criteria.", style: TextStyle(color: Colors.grey[500])),
                  ],
                ),
              ),
            );
          }
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildJobCard(controller.filteredJobs[index], isDark);
                },
                childCount: controller.filteredJobs.length,
              ),
            ),
          );
        }),
        
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color, bool isDark, {String? assetPath}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: assetPath != null 
                ? Image.asset(assetPath, width: 20, height: 20)
                : Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketplaceTab(bool isDark, ThemeData theme) {
    final controller = Get.find<LinkController>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Marketplace Hero
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark 
                  ? [Colors.grey[900]!, Colors.black]
                  : [const Color(0xFFFFF0F5), Colors.white],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Freelance Services',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Find the perfect freelance services for your business',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                // Search Bar for Marketplace
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (val) {
                      controller.marketplaceSearchQuery.value = val;
                      controller.searchServices();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for any service...',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset('assets/images/search_icon_3d.png', width: 20, height: 20),
                      ),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Design', 'Development', 'Marketing', 'Writing', 'Video'
                ].map((cat) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    onSelected: (selected) => controller.filterServiceByCategory(cat),
                    backgroundColor: isDark ? Colors.grey[800] : Colors.grey[100],
                    labelStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
                  ),
                )).toList(),
              ),
            ),
          ),

          // Services List
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() => controller.filteredServices.isEmpty
              ? const Center(child: Text('No services found'))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.filteredServices.length,
                  itemBuilder: (context, index) {
                    return _buildServiceCard(controller.filteredServices[index], isDark);
                  },
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(ServiceModel service, bool isDark) {
    return GestureDetector(
      onTap: () => Get.to(() => ServiceDetailsScreen(service: service)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: service.themeColor.withOpacity(0.2),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(
                child: Icon(Icons.image, size: 50, color: service.themeColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: service.themeColor,
                        child: Text(
                          service.provider[0],
                          style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        service.provider,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Icon(Icons.star, color: Colors.amber[700], size: 16),
                      Text(
                        service.rating,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    service.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        service.category,
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                      Text(
                        service.price,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2555C8)),
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

  Widget _buildTabButton(String label, bool isSelected, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? (isDark ? Colors.grey[800] : Colors.white) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))] : [],
        ),
        child: Row(
          children: [
             Icon(
               label == 'Jobs' ? Icons.work_outline : Icons.shopping_cart_outlined,
               size: 18,
               color: isSelected ? (isDark ? Colors.white : Colors.black) : (isDark ? Colors.grey[400] : Colors.grey),
             ),
             const SizedBox(width: 8),
             Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? (isDark ? Colors.white : Colors.black) : (isDark ? Colors.grey[400] : Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTag(String label, bool isDark, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[300] : Colors.grey[800])),
      ),
    );
  }
  
  Widget _buildJobCard(JobModel job, bool isDark) {
    return GestureDetector(
      onTap: () => Get.to(() => JobDetailsScreen(job: job)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: job.themeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.business, color: job.themeColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${job.company} • ${job.location}',
                        style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  final controller = Get.find<LinkController>();
                  final isSaved = controller.savedJobIds.contains(job.id);
                  return GestureDetector(
                    onTap: () => controller.toggleSaveJob(job.id),
                    child: Image.asset(
                      AppAssets.savedIcon3d,
                      width: 24,
                      height: 24,
                      color: isSaved ? AppPalette.accentBlue : (isDark ? Colors.grey[400] : Colors.grey[600])
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildMiniTag(job.type, isDark),
                const SizedBox(width: 8),
                _buildMiniTag(job.salary, isDark, color: Colors.green),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Posted ${job.postedAgo}',
                  style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[600] : Colors.grey[500]),
                ),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () => Get.snackbar('Applied', 'You have applied to ${job.company}', snackPosition: SnackPosition.BOTTOM),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2555C8),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Easy Apply', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniTag(String label, bool isDark, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (color ?? (isDark ? Colors.grey.shade800 : Colors.grey.shade100)).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11, 
          fontWeight: FontWeight.bold,
          color: color ?? (isDark ? Colors.grey.shade400 : Colors.grey.shade700),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String count, IconData icon, Color color, bool isDark, {String? assetPath}) {
    return GestureDetector(
      onTap: () => _handleCategoryTap(title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161B22) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: assetPath != null
                  ? Image.asset(assetPath, width: 20, height: 20)
                  : Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    count,
                    style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[500] : Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleCategoryTap(String category) {
    IconData icon;
    Color color;

    switch (category.toLowerCase()) {
      case 'marketing':
        icon = Icons.campaign;
        color = const Color(0xFF4F46E5);
        break;
      case 'sales':
        icon = Icons.trending_up;
        color = const Color(0xFF10B981);
        break;
      case 'engineering':
        icon = Icons.code_rounded;
        color = const Color(0xFF6366F1);
        break;
      case 'design':
        icon = Icons.brush_outlined;
        color = const Color(0xFFEC4899);
        break;
      case 'product':
        icon = Icons.inventory_2_outlined;
        color = const Color(0xFFFF9800);
        break;
      case 'hr':
        icon = Icons.groups_outlined;
        color = const Color(0xFFF43F5E);
        break;
      case 'operations':
        icon = Icons.settings_outlined;
        color = const Color(0xFF00BCD4);
        break;
      case 'education':
        icon = Icons.school_outlined;
        color = const Color(0xFF8B5CF6);
        break;
      default:
        icon = Icons.work;
        color = const Color(0xFF4F46E5);
    }

    Get.to(() => CategoryJobsScreen(
          category: category,
          icon: icon,
          themeColor: color,
        ));
  }

  Widget _buildCategoryItem(IconData icon, String label, Color color, bool isDark, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey[300] : Colors.grey[800],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
