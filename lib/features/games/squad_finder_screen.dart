import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/squad_finder_controller.dart';
import '../../../core/constants/app_assets.dart';

class SquadFinderScreen extends StatelessWidget {
  const SquadFinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SquadFinderController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentGreen = Color(0xFF22C55E);
    final bgColor = isDark ? const Color(0xFF0D0D0D) : Colors.grey[50];
    final cardColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
            _buildHeader(context, controller, textColor, accentGreen),
            
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Sticky-style Filter Bar
                    _buildFilterSection(controller, isDark, textColor, cardColor, accentGreen),
                    
                    const SizedBox(height: 16),
                    
                    // Squad Post List
                    _buildSquadList(controller, isDark, textColor, cardColor, accentGreen),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, SquadFinderController controller, Color textColor, Color accentGreen) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 16, color: textColor),
                    const SizedBox(width: 4),
                    Text('Back to GameVerse', 
                      style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 14)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: controller.createPost,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: accentGreen,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: accentGreen.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 20),
                      SizedBox(width: 4),
                      Text('Create Post', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Squad Finder', 
            style: TextStyle(color: textColor, fontSize: 28, fontWeight: FontWeight.bold)),
          Text('Find players and level up together', 
            style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildFilterSection(SquadFinderController controller, bool isDark, Color textColor, Color cardColor, Color accentGreen) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          // Search Input
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: textColor.withOpacity(0.4), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onChanged: (val) => controller.searchQuery.value = val,
                    style: TextStyle(color: textColor, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Filter by game...',
                      hintStyle: TextStyle(color: textColor.withOpacity(0.3)),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(controller.selectedRegion, controller.regions, Icons.public, isDark, textColor, accentGreen, assetPath: AppAssets.languageIcon3d),
                const SizedBox(width: 8),
                _buildFilterChip(controller.selectedRank, controller.ranks, Icons.emoji_events, isDark, textColor, accentGreen),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.tune, color: textColor.withOpacity(0.4), size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(RxString selectedValue, List<String> options, IconData icon, bool isDark, Color textColor, Color accentGreen, {String? assetPath}) {
    return Obx(() => GestureDetector(
      onTap: () => _showFilterOptions(selectedValue, options, isDark, textColor),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selectedValue.value != options[0] ? accentGreen.withOpacity(0.1) : (isDark ? Colors.black.withOpacity(0.3) : Colors.grey[100]),
          borderRadius: BorderRadius.circular(12),
          border: selectedValue.value != options[0] ? Border.all(color: accentGreen.withOpacity(0.3)) : null,
        ),
        child: Row(
          children: [
            assetPath != null 
                ? Image.asset(assetPath, width: 16, height: 16)
                : Icon(icon, color: selectedValue.value != options[0] ? accentGreen : textColor.withOpacity(0.4), size: 16),
            const SizedBox(width: 8),
            Text(selectedValue.value, style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, color: textColor.withOpacity(0.3), size: 16),
          ],
        ),
      ),
    ));
  }

  void _showFilterOptions(RxString selectedValue, List<String> options, bool isDark, Color textColor) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return ListTile(
              title: Text(option, style: TextStyle(color: textColor)),
              trailing: selectedValue.value == option ? const Icon(Icons.check, color: Color(0xFF22C55E)) : null,
              onTap: () {
                selectedValue.value = option;
                Get.back();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSquadList(SquadFinderController controller, bool isDark, Color textColor, Color cardColor, Color accentGreen) {
    return Obx(() {
      final squads = controller.filteredSquads;
      if (squads.isEmpty) {
        return _buildEmptyState(textColor);
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: squads.length,
        itemBuilder: (context, index) {
          return _buildSquadCard(squads[index], controller, isDark, textColor, cardColor, accentGreen);
        },
      );
    });
  }

  Widget _buildEmptyState(Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        children: [
          Icon(Icons.group_off_outlined, size: 64, color: textColor.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text('No squads found', style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 16)),
          Text('Try adjusting your filters', style: TextStyle(color: textColor.withOpacity(0.3), fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildSquadCard(Map<String, dynamic> squad, SquadFinderController controller, bool isDark, Color textColor, Color cardColor, Color accentGreen) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: accentGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.groups, color: accentGreen, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(squad['game'], style: TextStyle(color: accentGreen, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    Text(squad['title'], style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: accentGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Text('${squad['needed']} needed', style: TextStyle(color: accentGreen, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(squad['description'], style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 14, height: 1.4)),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildMetaItem(Icons.emoji_events, squad['rank'], Colors.amber),
              const SizedBox(width: 16),
              _buildMetaItem(Icons.public, squad['region'], Colors.blueAccent, assetPath: AppAssets.languageIcon3d),
              const SizedBox(width: 16),
              if (squad['mic']) _buildMetaItem(Icons.mic, 'Mic Req', Colors.redAccent),
              const Spacer(),
              Text(squad['postedTime'], style: TextStyle(color: textColor.withOpacity(0.3), fontSize: 12)),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.joinSquad(squad['title']),
              style: ElevatedButton.styleFrom(
                backgroundColor: accentGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 4,
                shadowColor: accentGreen.withOpacity(0.4),
              ),
              child: const Text('Join Squad', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(IconData icon, String label, Color color, {String? assetPath}) {
    return Row(
      children: [
        assetPath != null 
            ? Image.asset(assetPath, width: 14, height: 14)
            : Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
