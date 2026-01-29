import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/marketplace_category_controller.dart';
import '../../core/theme/palette.dart';

class MarketplaceListingScreen extends StatelessWidget {
  final String categoryName;
  
  const MarketplaceListingScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MarketplaceCategoryController(), tag: categoryName);
    controller.initCategory(categoryName);
    
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final bgColor = isDark ? const Color(0xFF101010) : Colors.grey[50];
    final cardColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Bar Area
            _buildAppBar(context, controller, isDark, textColor),
            
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Page Header
                    _buildPageHeader(categoryName, textColor),
                    
                    const SizedBox(height: 16),
                    
                    // 3. Service Provider List
                    _buildProviderList(controller, isDark, textColor, cardColor),
                    
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

  Widget _buildAppBar(BuildContext context, MarketplaceCategoryController controller, bool isDark, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: textColor),
            onPressed: () => Get.back(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                   Icon(Icons.search, color: textColor.withOpacity(0.4), size: 18),
                   const SizedBox(width: 8),
                   Expanded(
                     child: TextField(
                       onChanged: (val) => controller.searchQuery.value = val,
                       style: TextStyle(color: textColor, fontSize: 13),
                       decoration: InputDecoration(
                         hintText: 'Search product',
                         hintStyle: TextStyle(color: textColor.withOpacity(0.3)),
                         border: InputBorder.none,
                         isDense: true,
                       ),
                     ),
                   ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(Icons.location_on_outlined, color: textColor.withOpacity(0.7), size: 22),
          const SizedBox(width: 8),
          Icon(Icons.notifications_none, color: textColor.withOpacity(0.7), size: 22),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: controller.postRequirement,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppPalette.accentBlue, Colors.blueAccent]),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: const Text(
                'Post Req',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            'Professional $title services including cleaning, repairs, and more.',
            style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderList(MarketplaceCategoryController controller, bool isDark, Color textColor, Color cardColor) {
    return Obx(() {
      final filteredProviders = controller.filteredProviders;
      if (filteredProviders.isEmpty) {
        return _buildEmptyState(textColor);
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filteredProviders.length,
        itemBuilder: (context, index) {
          return _buildProviderCard(context, filteredProviders[index], controller, isDark, textColor, cardColor);
        },
      );
    });
  }

  Widget _buildEmptyState(Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.search_off_outlined, size: 64, color: textColor.withOpacity(0.1)),
            const SizedBox(height: 16),
            Text(
              'No providers found in your area',
              style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Try changing location or search',
              style: TextStyle(color: textColor.withOpacity(0.3), fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderCard(BuildContext context, Map<String, dynamic> provider, MarketplaceCategoryController controller, bool isDark, Color textColor, Color cardColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(provider['image'], width: double.infinity, height: 140, fit: BoxFit.cover),
              ),
              if (provider['fastResponse'])
                Positioned(
                  top: 12, right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFF22C55E), borderRadius: BorderRadius.circular(6)),
                    child: const Text('Fast Response', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(provider['name'], style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
                          if (provider['verified']) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.verified, color: AppPalette.accentBlue, size: 16),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert, color: textColor.withOpacity(0.5), size: 20),
                      onPressed: () => _showCardMenu(context, provider['name'], controller),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text('${provider['rating']}', style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    Text('(${provider['reviews']} reviews)', style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 12)),
                  ],
                ),
                
                const SizedBox(height: 6),
                
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: textColor.withOpacity(0.4), size: 14),
                    const SizedBox(width: 4),
                    Text('${provider['location']} • ${provider['distance']}', style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 12)),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.call, size: 18),
                        label: const Text('Call'),
                        onPressed: () => controller.callProvider(provider['name']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF22C55E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.chat_bubble_outline, size: 18),
                        label: const Text('Chat'),
                        onPressed: () => controller.chatProvider(provider['name']),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: textColor,
                          side: BorderSide(color: textColor.withOpacity(0.2)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCardMenu(BuildContext context, String name, MarketplaceCategoryController controller) {
     final theme = Theme.of(context);
     final isDark = theme.brightness == Brightness.dark;
     final sheetBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
     final textColor = isDark ? Colors.white : Colors.black;

     Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: sheetBg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.bookmark_border, color: textColor),
              title: Text('Save provider', style: TextStyle(color: textColor)),
              onTap: () { controller.saveProvider(name); Get.back(); },
            ),
            ListTile(
              leading: const Icon(Icons.report_gmailerrorred, color: Colors.redAccent),
              title: const Text('Report', style: TextStyle(color: Colors.redAccent)),
              onTap: () { controller.reportProvider(name); Get.back(); },
            ),
            ListTile(
              leading: Icon(Icons.share_outlined, color: textColor),
              title: Text('Share', style: TextStyle(color: textColor)),
              onTap: () { controller.shareProvider(name); Get.back(); },
            ),
          ],
        ),
      ),
    );
  }
}
