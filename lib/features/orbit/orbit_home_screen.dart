import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import 'controllers/orbit_controller.dart';
import 'orbit_topic_detail_screen.dart';
import 'orbit_create_topic_screen.dart';

class OrbitHomeScreen extends StatelessWidget {
  const OrbitHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject Controller
    final controller = Get.put(OrbitController());
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Theme-aware colors
    final bgColor = theme.scaffoldBackgroundColor;
    final cardColor = isDark ? const Color(0xFF1A1A1D) : Colors.white;
    final accentBlue = isDark ? const Color(0xFF2962FF) : theme.primaryColor;
    final textPrimary = theme.textTheme.bodyLarge?.color ?? (isDark ? Colors.white : Colors.black);
    final textSecondary = theme.textTheme.bodyMedium?.color?.withOpacity(0.7) ?? (isDark ? const Color(0xFFB0BEC5) : Colors.black54);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Header & Search
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find your signal.',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Join real-time, structured conversations organized by topic, not clout.',
                    style: TextStyle(
                      fontSize: 15,
                      color: textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Search Field
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(color: textPrimary),
                      onChanged: controller.updateSearch,
                      decoration: InputDecoration(
                        hintText: 'Search topics, not people...',
                        hintStyle: TextStyle(color: textSecondary.withOpacity(0.5)),
                        prefixIcon: Icon(Icons.search, color: textSecondary),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Explore Section Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flash_on_rounded, color: Colors.amber, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Explore Topics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.tune_rounded, color: textSecondary),
                    onPressed: () {
                      Get.snackbar('Filters', 'Advanced filters coming soon', 
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: cardColor,
                        colorText: textPrimary,
                      );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // 🔹 Category Chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final cat = controller.categories[index];
                  return Obx(() {
                    final isSelected = controller.selectedCategory.value == cat;
                    return GestureDetector(
                      onTap: () => controller.setCategory(cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? accentBlue : cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? accentBlue : (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: isSelected ? Colors.white : textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Topic List & Create Button
            Expanded(
              child: Obx(() {
                final topics = controller.filteredTopics;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  physics: const BouncingScrollPhysics(),
                  itemCount: topics.length + 1, // +1 for Create Card
                  itemBuilder: (context, index) {
                    if (index == topics.length) {
                      return _buildCreateTopicCard(textSecondary, cardColor);
                    }
                    return _buildTopicCard(topics[index], cardColor, textPrimary, textSecondary, accentBlue, isDark);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard(OrbitTopic topic, Color cardColor, Color textPrimary, Color textSecondary, Color accent, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cardColor,
            isDark ? Color.lerp(cardColor, Colors.white, 0.03)! : cardColor,
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Get.to(() => OrbitTopicDetailScreen(topic: topic));
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Category & Status
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        topic.category.toUpperCase(),
                        style: TextStyle(
                          color: textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusBadge(topic.status),
                    const Spacer(),
                    if (topic.isVerified)
                      const Icon(Icons.verified, color: Colors.blue, size: 16),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Title
                Text(
                  topic.title,
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                
                // Description
                Text(
                  topic.description,
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                
                // Stats Row
                Row(
                  children: [
                    Image.asset(AppAssets.friendsIcon3d, width: 16, height: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${topic.liveUsers} live',
                      style: TextStyle(
                        color: accent,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ...topic.languages.map((lang) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: textSecondary.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          lang,
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    IconData icon;
    
    switch (status) {
      case 'Trending':
        color = const Color(0xFFFF6D00); // Orange
        icon = Icons.local_fire_department_rounded;
        break;
      case 'Active':
        color = const Color(0xFF00E676); // Green
        icon = Icons.fiber_manual_record_rounded;
        break;
      default:
        color = const Color(0xFF78909C); // Muted
        icon = Icons.nightlight_round;
    }

    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          status,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCreateTopicCard(Color textSecondary, Color cardColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32, top: 8),
      height: 80,
      decoration: BoxDecoration(
        color: cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textSecondary.withOpacity(0.2)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
             Get.to(() => const OrbitCreateTopicScreen());
          },
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_circle_outline_rounded, color: textSecondary),
                const SizedBox(width: 12),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Topic',
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Start a new conversation',
                      style: TextStyle(
                        color: textSecondary.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
