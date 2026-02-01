import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/social_marketplace_controller.dart';
import '../../core/theme/palette.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_assets.dart';
import '../../core/services/state_providers.dart';

class SocialMarketplaceScreen extends StatelessWidget {
  const SocialMarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SocialMarketplaceController());
    final appController = Get.find<AppController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF101010) : Colors.grey[50], // Dark theme background
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 2. Search & Action Row (App Bar part of body due to requirement)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[900] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.withOpacity(0.1)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                            const SizedBox(width: 12),
                            Expanded(
                                child: TextField(
                                  focusNode: controller.searchFocusNode,
                                  style: const TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    hintText: 'Search product or service',
                                    hintStyle: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey[400]),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  onChanged: (val) => controller.searchQuery.value = val,
                                ),
                            ),
                            Icon(Icons.mic_none, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: controller.postRequest,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppPalette.accentBlue, Colors.blueAccent],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Post Req',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Location Indicator
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: AppPalette.accentBlue),
                    const SizedBox(width: 4),
                    Text(
                      'New York, USA',
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey[800],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset('assets/images/mart_icon_3d.png', width: 14, height: 14),
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down, size: 14, color: isDark ? Colors.white54 : Colors.grey[600]),
                  ],
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // 3. Explore Categories
             SliverToBoxAdapter(
              child: Column(
                children: [
                   _buildSectionHeader('Explore Categories', 'View All', isDark, onActionTap: () => appController.isMartServicesView.value = true),
                   const SizedBox(height: 12),
                   Obx(() {
                     return GridView.builder(
                       shrinkWrap: true,
                       physics: const NeverScrollableScrollPhysics(),
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 3,
                         childAspectRatio: 1.1,
                         crossAxisSpacing: 12,
                         mainAxisSpacing: 12,
                       ),
                       itemCount: controller.categories.length,
                       itemBuilder: (context, index) {
                         final category = controller.categories[index];
                         return _buildCategoryCard(category.name, category.icon, isDark, controller);
                       },
                     );
                   }),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // 4. Exclusive Deals
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Exclusive Deals',
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        color: isDark ? Colors.white : Colors.black
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: Obx(() => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.deals.length,
                      itemBuilder: (context, index) {
                        return _buildDealCard(controller.deals[index], isDark, controller);
                      },
                    )),
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // 5. Top Services
             SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildSectionHeader('Top Services', 'See All', isDark),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 140,
                     child: Obx(() => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.services.length,
                      itemBuilder: (context, index) {
                        return _buildServiceCard(controller.services[index], isDark, controller);
                      },
                    )),
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // 6. Popular Services Near You
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildSectionHeader('Popular Near You', 'See All', isDark),
                  const SizedBox(height: 16),
                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.popularServices.length,
                    itemBuilder: (context, index) {
                      return _buildPopularServiceCard(controller.popularServices[index], isDark, controller);
                    },
                  )),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

             // 7. Trending B2B Products
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildSectionHeader('Trending B2B Products', 'See All', isDark),
                  const SizedBox(height: 16),
                  Obx(() => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(controller.products[index], isDark, controller);
                    },
                  )),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action, bool isDark, {VoidCallback? onActionTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          InkWell(
            onTap: onActionTap,
            child: Text(action, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppPalette.accentBlue)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String name, String iconPath, bool isDark, SocialMarketplaceController controller) {
    // Mapping string names to Icons for demo purposes since we don't have all assets
    IconData getIconData(String name) {
        switch(name) {
            case 'Home Services': return Icons.cleaning_services_outlined;
            case 'Repair': return Icons.build_outlined;
            case 'Health': return Icons.medical_services_outlined;
            case 'Education': return Icons.school_outlined;
            case 'Events': return Icons.event_outlined;
            case 'Logistics': return Icons.local_shipping_outlined;
            case 'Baby Care': return Icons.child_care_outlined;
            case 'Travel': return Icons.flight_outlined;
            case 'Pets': return Icons.pets_outlined;
            default: return Icons.category_outlined;
        }
    }

    return GestureDetector(
      onTap: () => controller.filterByCategory(name),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          gradient: isDark 
            ? LinearGradient(colors: [Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.02)], begin: Alignment.topLeft, end: Alignment.bottomRight)
            : null,
          boxShadow: isDark ? null : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppPalette.accentBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                ),
                child: name == 'Education'
                    ? Image.asset('assets/images/learn_icon_3d.png', width: 28, height: 28)
                    : Icon(getIconData(name), color: AppPalette.accentBlue, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDealCard(dynamic deal, bool isDark, SocialMarketplaceController controller) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark 
            ? [const Color(0xFF6A11CB), const Color(0xFF2575FC)] 
            : [AppPalette.accentBlue, Colors.blueAccent], 
          begin: Alignment.topLeft, 
          end: Alignment.bottomRight
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (isDark ? const Color(0xFF2575FC) : AppPalette.accentBlue).withOpacity(0.3), 
            blurRadius: 10, 
            offset: const Offset(0, 5)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
            child: const Text('EXCLUSIVE DEAL', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          Text(deal.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(deal.description, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          const Spacer(),
          ElevatedButton(
            onPressed: () => controller.grabOffer(deal.title),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppPalette.accentBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('Grab Offer'),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(dynamic service, bool isDark, SocialMarketplaceController controller) {
     return GestureDetector(
       onTap: () => controller.filterByCategory(service.name),
       child: Container(
         width: 140,
         margin: const EdgeInsets.only(right: 12),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(service.image, height: 90, width: 140, fit: BoxFit.cover),
              ),
              const SizedBox(height: 8),
              Text(service.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black)),
              const SizedBox(height: 4),
              Row(
                  children: [
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${service.rating}', style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                  ],
              ),
           ],
         ),
       ),
     );
  }

  Widget _buildPopularServiceCard(dynamic service, bool isDark, SocialMarketplaceController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(service.image, width: 100, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (service.fastResponse)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        margin: const EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: const Text('FAST', style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                    Text(service.distance, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(service.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text('${service.rating} (${service.reviews})', style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                    const SizedBox(width: 8),
                    Icon(Icons.verified, size: 14, color: AppPalette.accentBlue),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => controller.callService(service.name),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isDark ? Colors.white : Colors.black,
                          side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          minimumSize: const Size(0, 32),
                        ),
                        child: const Text('Call', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => controller.chatService(service.name),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPalette.accentBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          minimumSize: const Size(0, 32),
                        ),
                        child: const Text('Chat', style: TextStyle(fontSize: 12)),
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

  Widget _buildProductCard(dynamic product, bool isDark, SocialMarketplaceController controller) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(product.image, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                    top: 8, left: 8,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                        child: Text('MOQ: ${product.minOrder}', style: const TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black)),
                const SizedBox(height: 4),
                Text(product.price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppPalette.accentBlue)),
                const SizedBox(height: 2),
                Text(product.supplier, style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                const SizedBox(height: 8),
                SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => controller.getBestPrice(product.name),
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppPalette.accentBlue),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Text('Get Best Price', style: TextStyle(fontSize: 12, color: AppPalette.accentBlue)),
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
